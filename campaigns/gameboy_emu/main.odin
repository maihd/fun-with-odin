package gameboy_emu_main

import "core:fmt"

import "emu"

main :: proc() {
    fmt.println("Initializing Gameboy Core...")

    // Allocate the emulator environment onto the stack
    emulator := emu.Emulator{}

    // Set the bootloader starting execution address
    emulator.cpu.pc = 0x0000

    fmt.printf("Initialization Complete! Program Counter at: 0x%04X\n", emulator.cpu.pc)
    // fmt.printf("Max memory bus: %v", 0x7fff)

    specs := emu.get_specs()
    fmt.println("Gameboy Specs:")
    fmt.printfln("   - CPU: %s", specs.cpu)
    fmt.printfln("   - CPU Architecture: %s", specs.cpu_arch)
    fmt.printfln("   - System Clock: %f MHz", specs.cpu_clock)
    fmt.printfln("   - Work RAM: %vKB", specs.work_ram)
    fmt.printfln("   - Video RAM: %vKB", specs.video_ram)
    fmt.printfln("   - Resolution: %vx%v", specs.resolution.x, specs.resolution.y)

    // 1. Inititialize systems (SDL3)
    // 2. Create window
    // 3. Create renderers
    // 4. Main loop (events and rendering)
}