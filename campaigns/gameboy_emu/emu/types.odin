package gameboy_emu

// --- Distinct Types for Safety ---
// Prevents mixing up different hardware data units
U8_Reg :: distinct u8
U16_Reg :: distinct u16
Addr_Reg :: distinct u16


// --- The CPU Flag Register Definitions ---
// The Gameboy uses only the top 4 bits of the F register.
// We map them explicity to their hardware significance.
Cpu_Flag :: enum u8 {
    Carry       = 4, // Bit 4
    Half_Carry  = 5, // Bit 5
    Subtract    = 6, // Bit 6
    Zero        = 7, // Bit 7
}

// Force a type-safe bit set backed by an underlying 8-bit unsigned integer
Cpu_Flags :: bit_set[Cpu_Flag; u8]


// --- CPU State Machine ---
// Sharp LR35902 CPU Register Configuration
Cpu :: struct {
    // 8-bit General Purpose Registers
    a, b, c, d, e, h, l: U8_Reg,

    // The Flag Register
    // Bit 7: Zero (Z)
    // Bit 6: Subtract (N)
    // Bit 5: Half-Carry (H)
    // Bit 4: Carry (C)
    f: Cpu_Flags,

    // 16-bit Pointer Registers
    sp: U16_Reg,    // Stack Pointer
    pc: Addr_Reg,   // Program Counter (Points to next instruction)

    // Clock Tracking
    cycles: u64,    // Total CPU clock cycles executed
}


// --- The Memory Bus ---
// Complete 64 Kilobyte address space map
Memory :: struct #raw_union {
    bus: [64 * 1024]u8,                 // Explicit flat 64KB memory viewport
    using regions: Memory_Partitions,   // Injects named field directly into Memory space
}


Memory_Partitions :: struct #packed {
    rom: [32 * 1024]u8,
    vram: [8 * 1024]u8,
    eram: [8 * 1024]u8,
    wram: [8 * 1024]u8,

    _echo: [0xfdff - 0xe000 + 1]u8, // Echo RAM - prohibited
    oam: [0xfe9f - 0xfe00 + 1]u8,
    _pad0: [0xfeff - 0xfea0 + 1]u8,

    io_regs: [0xff7f - 0xff00 + 1]u8,
    hram: [0xfffe - 0xff80 + 1]u8,
    ie: u8
}

#assert(size_of(Memory) == 64 * 1024)
#assert(size_of(Memory) == size_of(Memory_Partitions))

// --- System Core ---
Emulator :: struct {
    cpu: Cpu,
    memory: Memory,
}