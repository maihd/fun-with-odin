# The Equipment Inventory (Self-Created Tools)


## Weapon: The Custom Logging Engine (Self-Created)
- What it is: A text-writer tool you will build in Odin that dump the CPU state to text file after every instruction.
- In-game Effect: If your emulator crashes at instruction #50000, you can compare your log line-by-line with a known perfect emulator log to find exact opcode that failed.


## Accessory: The Memory Inspector Viewport (Self-Created)
- What it is: A temporary SDL3 window or console overlay that print out live hexadecimal values of the VRAM (0x8000-0x9FFF)
- In-game Effect: Grants "True Sight." It lets you visually see if Nintendo tiles are actually loading into memory before you even write the graphics rendering engine.


## Potion: Unit Testing Framework (Self-Created)
- What it is: A collection of small Odin test scripts (#test blocks) built right into your code.
- In-game Effect: Instantly restores sanity. Every time you write a CPU instruction (like `ADD A, B`), you write a quick test for it. If you break the instruction later while rewriting code, the test suite instantly alerts you.