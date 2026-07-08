package act2_quest11

import "core:fmt"

Direction :: enum u8 { // underlyting type is u8
    North, East, South, West
}

Direction_Set :: bit_set[Direction; u8] // Flags are Direction, underlying type is u8

idStr :: struct {
    data: []u8,
    len: u32,
    can_n_flags: bit_field (u32 when true else u16) {  // underlying required as integer or fixed-length array
        cap: u32 | 24,
        flags: u8 | 8,
    }
}

// bit_field are not limited in size
Big_Big_Bit_Fields :: bit_field [64]u8 {

}

is_dir_valid :: proc(dir: Direction_Set) -> bool {
    if .North in dir do return .South not_in dir
    if .South in dir do return .North not_in dir
    if .West in dir do return .East not_in dir
    if .East in dir do return .West not_in dir

    return true
}

is_dir_45deg :: proc(dir: Direction_Set) -> bool {
    if !is_dir_valid(dir) do return false

    hor := (.East in dir) || (.West in dir)
    ver := (.North in dir) || (.South in dir)
    return hor && ver
}

main :: proc() {
    fmt.printfln(`
        bit_set work exactly like an integer number, operators:
            &       - AND
            |       - OR
            ~       - XOR
            +       - Like OR
            -       - Like &~
            &~      - Difference of two set
            ==      - Equal
            !=      - Not equal
            <       - Less
            >       - Great
            <=      - Less or equal
            >=      - Great or equal
            in      - Check if set have this member (e in A)
                    - Technical: set membership
            not_in  - Check if set not have this membere (e not_in A)
                    - Technical: not set membership

            card    - Builin procedure: get the number of elements in set
    `)

    fmt.printfln("is_dir_45deg: %v", is_dir_45deg({ .North, .West }))
    fmt.printfln("is_dir_45deg: %v", is_dir_45deg({ .South, .East }))
    fmt.printfln("is_dir_45deg: %v", is_dir_45deg({ .South, .North }))

    dir: Direction_Set = { .North } + { .West }
    fmt.printfln("is_dir_valid: %v", is_dir_valid(dir))
}