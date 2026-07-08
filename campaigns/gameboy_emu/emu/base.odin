package gameboy_emu

Emu_Specs :: struct {
    cpu: string,
    cpu_arch: string,
    cpu_clock: f32,
    work_ram: u32,
    video_ram: u32,
    resolution: [2]u32,
}

get_specs :: proc() -> Emu_Specs {
    return Emu_Specs {
        cpu = "8-bit 8080-like Sharp CPU (SM83 Core)",
        cpu_arch= "Z80",
        cpu_clock = 4.19,
        work_ram = 8,
        video_ram = 8,
        resolution = {160, 144},
    }
}