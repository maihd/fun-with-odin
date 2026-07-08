## Estimated timelines
### Minimal working emulator (20 to 60 Hours)
- What you get: A system that passes basic CPU tests and runs early, simple games (like Tetris or Dr. Mario) without sound or advanced cartidge features.
- Breakdown:
    - 15 hours setting up the CPU instruction parsing loop and memory management.
    - 10 hours writing the basic pixel rendering routines for background layers.
    - 5 hours handling player keyboard inputs and file loading.


### Fully featured Emulator (80 to 165+ Hours)
- What you get: A polished app that runs popular games (like Pokémon Red/Blue or The Legend of Zelda: Link's Awakening) smoothly, complete with audio, save states, and color support.
- Breakdown: 
    - 25 hours tracking down bugs in memory bank controllers (MBC1, MBC3) for larger game files.
    - 30 hours handling complex pixel timings, window layers, and sprite piorities.
    - 25 hours generating audio samples and syncing the audio wave channels to SDL3.


## Tips to save Development Time
- Use community CPU Tests First: Do not try to load a commercial game right away.
    - Use Blargg's CPU Test ROMs. They output text error codes that tell you exactly which CPU instruction is broken, saving you days of manual debugging.
- Postpone the Audio Engine: Sound requires strict timing synchronization. Leave audio completely out of your code until your CPU and graphics systems are perfectly stable.
- Stick to DMG (Monochrome) initially: Avoid Gameboy Color features at the start. Mastering the original monochrome system simplifies your data layers and rendering pipeline.