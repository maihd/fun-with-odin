package error_handling

import "core:fmt"

fake_failed :: proc() -> (i32, bool) {
    return 10, false
}

main :: proc() {
    value := fake_failed() or_else 11
    fmt.printf("value: %v\n", value) // this should print 11
}