# GameboyEmu with Odin
Gamified Emu Dev to learn Gameboy Hardware and Odin.


## Status
- Progress: Act 1 - Quest 2


## Earning
- Hardware Architecture: Level 2
    - Basic CPU architecture: Registers, Flags (State Machine), Stack Pointer, Program Counter, Cycles Tracking
    - Memory: 
        - BUS: Simple block of bytes, supporting direct access
        - Partitions: Support view memory map

- Binary Mathematics Skills: Level 2
    - Bit flags
    - Bit fields
    - Union

- Odin Architecture Skills: Level 2
    - `bit_set`
    - `bit_field`
    - `#packed`/`#raw_union`


## Source code organization
- From starting point: 
    - Type should be in `types.odin`
    - Constant should be in `constants.odin`
    - Basic procedures should be in `base.odin`

- When code start to having shape:
    - Identify the scope and module of code
    - Create new file or even directory (package) for it
    - E.g., cpu.odin, memory.odin

- File architecture:
    - Declaration group:
        - Declaration group is declarations as top-level
        - Seperating declaration groups by 2 empty lines
        - Each group have at least one declarations
        - Examples:
            - Simplest group have 1 procedure, or 1 type definition, or even 1 constant/variable
            - Or a type with single procedure
            - Or a procedure requiring specified utils
            - Or procedures overloading
    - Theses above rules lead to better visual for reading
    - Other than that, using Odin's idioms are safe and sound
    - Avoid using odinfmt, because we are learning Odin coding, doing manually formatting are better option