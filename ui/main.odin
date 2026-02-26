package ui

import clay "clay/bindings/odin/clay-odin"
import rl "vendor:raylib"
import "core:strings"
import "core:math"

Font :: struct {
    id: u16,
    font: rl.Font
}

Render_State :: struct {
    fonts: [dynamic]Font
}

FONT_ID_ALL :: 0

main :: proc() {
    rl.InitWindow(800, 600, "UI Clay + Raylib")
    defer rl.CloseWindow()

    min_memory_size := clay.MinMemorySize()
    memory := make([^]u8, min_memory_size)

    render_state := Render_State {}
    defer delete(render_state.fonts)

    arena := clay.CreateArenaWithCapacityAndMemory(auto_cast min_memory_size, memory)
    clay.Initialize(arena, { f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight())}, { handler = error_handler })
    clay.SetMeasureTextFunction(measure_text, &render_state)

    load_font(&render_state, FONT_ID_ALL, 16, "ui/clay/bindings/odin/examples/clay-official-website/resources/Quicksand-Semibold.ttf")

    for !rl.WindowShouldClose() {
        defer free_all(context.temp_allocator)
        
        clay.SetPointerState(transmute(clay.Vector2)rl.GetMousePosition(), rl.IsMouseButtonDown(.LEFT))
        clay.UpdateScrollContainers(false, transmute(clay.Vector2)rl.GetMouseWheelMoveV(), rl.GetFrameTime())
        clay.SetLayoutDimensions({ f32(rl.GetScreenWidth()), f32(rl.GetScreenHeight())})

        clay.BeginLayout()

        clay.Text("Hello world!", clay.TextConfig({
            textColor = { 0, 0, 0, 255 },
            fontId = FONT_ID_ALL,
            fontSize = 16,
        }))

        if clay.UI(clay.ID("ButtonClick"))({ 
            layout = { padding = { 16, 16, 6, 6 } }, 
            backgroundColor = {240, 213, 137, 255},
            cornerRadius = clay.CornerRadiusAll(10)
        }) {
            clay.Text("Click Me!", clay.TextConfig({
                textColor = { 0, 0, 0, 255 },
                fontId = FONT_ID_ALL,
                fontSize = 16,
            }))

            if clay.PointerOver(clay.ID("ButtonClick")) && rl.IsMouseButtonPressed(.LEFT) {
                rl.TraceLog(.INFO, "Clicked!")
            }
        }

        render_commands := clay.EndLayout()

        rl.BeginDrawing()
        
        rl.ClearBackground(rl.RAYWHITE)
        clay_raylib_render(render_state, &render_commands)

        rl.EndDrawing()
    }
}

load_font :: proc(render_state: ^Render_State, id: u16, font_size: i32, path: string) {
    path_cstr := strings.clone_to_cstring(path)
    defer delete(path_cstr)
    
    assign_at(&render_state.fonts, id, Font {
        id = id,
        font = rl.LoadFontEx(path_cstr, font_size * 2, nil, 0)
    })
    rl.SetTextureFilter(render_state.fonts[id].font.texture, .TRILINEAR)
}

error_handler :: proc "c" (error_data: clay.ErrorData) {
    #partial switch error_data.errorType {

    }
}

measure_text :: proc "c" (text: clay.StringSlice, config: ^clay.TextElementConfig, user_data: rawptr) -> clay.Dimensions {
    line_width := f32(0)

    render_state := (^Render_State)(user_data)

    font := render_state.fonts[config.fontId].font
    text_str := string(text.chars[:text.length])

    for i in 0..<len(text_str) {
        glyph_index := text_str[i] - 32
        glyph := font.glyphs[glyph_index]

        if glyph.advanceX != 0 {
            line_width += f32(glyph.advanceX)
        } else {
            line_width += font.recs[glyph_index].width + f32(font.glyphs[glyph_index].offsetX)
        }
    }

    scale_factor := f32(config.fontSize) / f32(font.baseSize)

    total_spacing := f32(len(text_str)) * f32(config.letterSpacing)

    return {
        width = line_width * scale_factor + total_spacing,
        height = f32(config.fontSize)
    }
}

clay_color_to_rl_color :: proc(color: clay.Color) -> rl.Color {
    return { u8(color.r), u8(color.g), u8(color.b), u8(color.a) }
}

clay_raylib_render :: proc(render_state: Render_State, render_commands: ^clay.ClayArray(clay.RenderCommand), allocator := context.temp_allocator) {
    for i in 0..<render_commands.length {
        render_command := clay.RenderCommandArray_Get(render_commands, i)
        bounds := render_command.boundingBox

        switch render_command.commandType {
        case .None:
            // no fallthrough

        case .Text:
            config := render_command.renderData.text

            // Simple cast, no allocations
            text := string(config.stringContents.chars[:config.stringContents.length])

            cstr_text := strings.clone_to_cstring(text)

            font := render_state.fonts[config.fontId].font
            rl.DrawTextEx(font, cstr_text, {bounds.x, bounds.y}, f32(config.fontSize), f32(config.letterSpacing), clay_color_to_rl_color(config.textColor))

        case .Image:

        case .ScissorStart:
            rl.BeginScissorMode(i32(math.round(bounds.x)), i32(math.round(bounds.y)), i32(math.round(bounds.width)), i32(math.round(bounds.height)))

        case .ScissorEnd:
            rl.EndScissorMode()

        case .Rectangle:
            config := render_command.renderData.rectangle
            if config.cornerRadius.topLeft > 0 {
                radius := (config.cornerRadius.topLeft * 2) / min(bounds.width, bounds.height)
                draw_rect_rounded(bounds.x, bounds.y, bounds.width, bounds.height, radius, config.backgroundColor)
            } else {
                draw_rect(bounds.x, bounds.y, bounds.width, bounds.height, config.backgroundColor)
            }

        case .Border:

        case .Custom:

        }
    }
}

draw_rect :: proc(x, y, width, height: f32, color: clay.Color) {
    rl.DrawRectangleV(
        { x, y },
        { width, height },
        clay_color_to_rl_color(color)
    )
}

draw_rect_rounded :: proc(x, y, width, height: f32, radius: f32, color: clay.Color) {
    rl.DrawRectangleRounded(
        { x, y, width, height},
        radius,
        8,
        clay_color_to_rl_color(color)
    )
}