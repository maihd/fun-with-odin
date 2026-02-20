package nbio_fun

import "core:nbio"
import "core:log"
import "core:strings"

import RL "vendor:raylib"

Texture :: struct {
    path: cstring,
    width: int,
    height: int,
    data: RL.Texture
}

Texture_Names :: enum {
    Default,
    Raylib_Logo
}

g_textures := [Texture_Names]Texture{
    .Default = {#directory + "/missing.png", 32, 32, {}},
    .Raylib_Logo = {#directory + "/raylib_logo.png", 256, 256, {}}
}

main :: proc() {
    context.logger = log.create_console_logger()

    nbio.acquire_thread_event_loop()
    defer nbio.release_thread_event_loop()

    RL.InitWindow(800, 600, "nbio")
    defer RL.CloseWindow()

    load_texture(&g_textures[.Default])

    RL.SetTargetFPS(60)

    for !RL.WindowShouldClose() {
        if err := nbio.tick(timeout = 0); err != nil {
            log.errorf("nbio.tick: %v", err)
        }

        w, h := f32(RL.GetScreenWidth()), f32(RL.GetScreenHeight())
        {
            RL.BeginDrawing()
            defer RL.EndDrawing()

            RL.ClearBackground(RL.RAYWHITE)

            txt := &g_textures[.Raylib_Logo]
            draw_texture(txt^, { w * 0.5 - f32(txt.width) * 0.5, h * 0.5 - f32(txt.height) * 0.5, f32(txt.width), f32(txt.height)}, RL.WHITE)

            if RL.GuiButton({w * 0.5 - f32(txt.width) * 0.5, h * 0.5 - f32(txt.height) * 0.5, f32(txt.width), 50}, "Load Texture") {
                if RL.IsTextureReady(txt.data) {
                    RL.UnloadTexture(txt.data)
                    txt.data = {}
                } else {
                    load_texture(txt)
                }
            }
        }
    }
}

draw_texture :: proc(txt: Texture, dest: RL.Rectangle, tint: RL.Color) {
    txt := txt // Make a readwrite var clone
    if !RL.IsTextureReady(txt.data) {
        txt.data = g_textures[.Default].data
    }

    RL.DrawTexturePro(
        txt.data,
        { 0, 0, f32(txt.data.width), f32(txt.data.height)},
        dest,
        {},
        0,
        RL.WHITE
    )
}

load_texture :: proc(txt: ^Texture) {
    assert(txt.width > 0)
    assert(txt.height > 0)
    assert(txt.path != nil)
    txt.data = g_textures[.Default].data 

    nbio.read_entire_file(string(txt.path), txt, on_read)

    on_read :: proc(txt: rawptr, buf: []byte, err: nbio.Read_Entire_File_Error) {
        txt := transmute(^Texture)txt
        if err.value != nil {
            log.errorf("load_texture(%q): %v: %v", txt.path, err.operation, err.value)
            return
        }

        spath := string(txt.path)
        i := strings.last_index(spath, ".")
        assert(i > 0)

        ext := spath[i:]

        image := RL.LoadImageFromMemory(cstring(raw_data(ext)), raw_data(buf), i32(len(buf)))
        txt.data = RL.LoadTextureFromImage(image)

        RL.UnloadImage(image)
        delete(buf)

        log.infof("load_texure: %q loaded", txt.path)
    }
}