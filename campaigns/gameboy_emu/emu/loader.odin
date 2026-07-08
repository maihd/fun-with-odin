package gameboy_emu

import "core:os"
import "core:fmt"

load_rom :: proc(mem: ^Memory, path: string, allocator := context.temp_allocator) -> bool {
    data, err := os.read_entire_file(path, allocator)
    if err != nil {
        fmt.eprintfln("[!] Loader error: Could not find or open ROM file: %s. Error: %v\n", path, err)
        return false
    }
    defer delete(data, allocator)

    bytes_to_copy := min(len(data), len(mem.rom))
    load_rom_from_memory(mem, data)

    fmt.printfln("[+] Successfully loaded %d bytes from `%s` into ROM container.", bytes_to_copy, path)
    return true
}


load_rom_from_memory :: proc(mem: ^Memory, data: []u8) {
    bytes_to_copy := min(len(data), len(mem.rom))
    copy(mem.rom[:bytes_to_copy], data[:bytes_to_copy])
}