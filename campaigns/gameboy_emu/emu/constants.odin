package gameboy_emu

// --- Address Bounds Configuration ---
// Explicit boundary locations mapped directly from the Pan Docs specifications
ADDR_ROM_START  :: 0x0000
ADDR_ROM_END    :: 0x7fff
ADDR_VRAM_START :: 0x8000
ADDR_VRAM_END   :: 0x9fff
ADDR_ERAM_START :: 0xa000
ADDR_ERAM_END   :: 0xbfff
ADDR_WRAM_START :: 0xc000
ADDR_WRAM_END   :: 0xdfff


ADDR_CARTIDGE_HEADER_START  :: 0x0100
ADDR_CARTIDGE_HEADER_END    :: 0x014f