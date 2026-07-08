# The Skill Tree (What You Unlock)


## Hardware Engineering (The Physical Mind)
- Level 1. Register Mapping: Understanding how 8-bit registers (A, B, C, ...) pair up into 16-bit registers (BC, DE, HL).
- Level 2. The Flags Matrix: Mastering how operations mutate Zero (Z), Subtract (N), Half-Carry (H), Carry (C) status flags.
- Level 3. Interruption Logic: Crafting the Interrupt Service Routines (IME, IE, IF flags) that halt the CPU to handle V-Blank or timer updates.


## Binary Mathematics (The Mystics Runes)
- Level 1. Bitmasking: Using `&`(AND), `|` (OR), `~` (XOR) to isolate specific bits (e.g., checking if bit `4` of the Joypad register is pressed).
- Level 2. The Half-Carry Hex: Mastering 4-bit nibble addition to detect carries from bit 3 to bit 4 (essential for the Gameboy's `DAA` instruction).
- Level 3. Twos-Complement: Handling signed 8-bit integers for relative CPU jumps (JR), allowing the execution pointer to jump backward or forward in memory.


## Odin Architecture (The Forging Language)
- Level 1. Distinct Types: Utilizing Odin's `distinct` keyword to make sure you never accidentally mix up 16-bit Address with 16-bit Register value.
- Level 2. Swizzling & Transmute: Using Odin's explicit memory casting to seamlessly view two `u8` bytes as a single `u16` word.
- Level 3. Custom Allocators: Managing memory allocations without garbage collection, ensuring maximum performance for rendering loop.