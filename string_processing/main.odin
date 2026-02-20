package string_processing

import "core:mem"
import "core:fmt"
import "core:strings"

main :: proc() {
    fmt.printf("String processing\n")

    sample := "hello world!"

    tokens := strings.split(sample, " ")
    defer delete(tokens)

    for token in tokens {
        fmt.printf("Token = %v\n", token)
    }
}