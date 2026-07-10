package act3 

import "core:fmt"

when ODIN_OS == .Linux {
    foreign import libc "./lib.so"
} else when ODIN_OS == .Windows {
    foreign import libc "./lib.dll"
}

Result :: struct {
    value: int,
    ok: bool,
}

foreign libc {
    parse_int :: proc "c" (str: string) -> (value: int, ok: bool) ---

    // @(link_name="parse_int")
    // parse_int_result :: proc "c" (str: string) -> Result ---
}

main :: proc() {
    value, ok := parse_int("1234")
    fmt.printfln("value = %v, ok = %v", value, ok) // should be 1234

    // result := parse_int_result("1234")
    // fmt.printfln("result.value = %v", result.value) // should be 1234
}