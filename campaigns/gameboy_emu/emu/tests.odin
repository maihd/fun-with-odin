package gameboy_emu 

import "core:testing"

@test
test_memory_union_alignment :: proc(t: ^testing.T) {
    mem := Memory{}

    mem.bus[0x8000] = 0xde 
    mem.bus[0x8001] = 0xad

    testing.expect_value(t, mem.vram[0], 0xde)
    testing.expect_value(t, mem.vram[1], 0xad)
}


// @test
// test_cpu_register_unions :: proc(t: ^testing.T) {
//     cpu := Cpu{}

//     cpu.b = 0xaa
//     cpu.c = 0xbb
// }


@test
test_rom_loading_from_memory :: proc(t: ^testing.T) {
    mem := Memory{}

    mock_rom_data := [8]u8{0x00, 0xC3, 0x50, 0x01, 0xCE, 0xED, 0x66, 0x66}
    load_rom_from_memory(&mem, mock_rom_data[:])
    
    testing.expect_value(t, mem.rom[0], 0x00)
    testing.expect_value(t, mem.rom[1], 0xc3)
    testing.expect_value(t, mem.rom[4], 0xce)

    testing.expect_value(t, mem.rom[5], 0xed)
    testing.expect_value(t, mem.rom[6], 0x66)
}


@test
test_rom_loading_from_file :: proc(t: ^testing.T) {
    defer free_all(context.temp_allocator)
    
    mem := Memory{}

    load_success := load_rom(&mem, "assets/gb-test-roms/cpu_instrs/cpu_instrs.gb") // If file too big, use context.allocator
    
    testing.expect_value(t, load_success, true)
}