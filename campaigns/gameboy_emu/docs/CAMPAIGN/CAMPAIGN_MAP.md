# Chronicles of Odin: The DMG Rescurrection

## Act 1. The Silicon Awakening (CPU & Memory)
Your journey begins in the void. You must forge the core consciousness of the machine.
- Quest 1: The Void Container. Create the 64KB memory map layout and register structures in Odin.
- Quest 2: Fetch and Decode. Implement the basic fetch-decode-execute loop that reads a single byte from memory and matches it to an instruction.
- Boss: Sir Blargg's Gaunlet (The Instruction Set). Implement all 244 core CPU opcodes and pass Blargg's basic CPU instruction test ROM. He will relentlessly strike you down with subtle flag logic bugs if you math if off.


## Act 2. The Gateway of Sight (SDL3 & GPU)
Your emulator can think, but is blind. You must connect it to the physical world.
- Quest 3: The Astral Window. Initialize SDL3 and open a stable window scaled up from the native 160x144 resolution.
- Quest 4: The Tile Weaver. Read the Gameboy's VRAM tiles from memory and render static backgrounds onto your SDL3 texture buffer.
- Boss: The Sync Beast (H-Blank & V-Blank). Synchronize the PPU cycles with the CPU cycles perfertly. If you timing is off, this boss strikes back by tearing your screen layout, corrupting your grpahics, or freezing your game loop.


## Act 3. The World Beyond (Joypad & Cartidges)
Your machine can think and see, but it cannot feel the user's touch or load larger realities.
- Quest 5: The Tactile Link. Map SDL3 keyboard inputs over to the hardware's 0xFF00 joypad register so the machine registers button presses.
- Quest 6: The Memory Bank. Implement MBC1 (Memory Bank Controller 1) logic to allow the emulator to swap out memory banks.
- Boss: The Great Keeper (The Nintendo Logo Boot). You must correctly parse the encrypted Nintendo logo stored inside the cartidge header. If you pass the internal checksum validation check, the legendary scrolling animation will trigger.


## The Final Boss: The Title Screen of Legend
To beat the game and roll the credits, you must conquer the ultimate entity:
- The Final Boss: The Brick-Stacker (Tetris). Load the raw Tetris ROM. You win the game when you can sit back, press start on your keyboard, and play a flawless, glitch-free match of Tetris on an emulator you built entirely from scratch.