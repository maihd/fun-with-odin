package act1

import "core:fmt"

// Most common procedure that use for example
fibonacci :: proc(n: int) -> int {
    if n < 1 {
        return 0
    } else if n == 1 {
        return 1
    }

    return fibonacci(n - 1) + fibonacci(n - 2)
}

// But fibonacci don't make any memory allocation, we don't need context or allocator
// Let make contextless, and pure function
fibonacci_context :: proc "contextless" (n: int) -> int {
    if n < 1 {
        return 0
    } else if n == 1 {
        return 1
    }

    return fibonacci_context(n - 1) + fibonacci_context(n - 2)
}

// One good thing that parameter type declarations can be shortened like variables
multiply :: proc(x, y: int) -> int {
    return x * y
}

// Remember, parameters are immutable
// Your need to shadowing to able to change the value
foo :: proc(x: int) {
    x := x // explicit mutation
    x -= 1 // Now compiler is happy
}

// Odin have good variadic parameter compare with C
// Variadic parameters is type safe
// Variadic parameters is group into a slice of given type
// Belove example is also showing how to use named results
sum :: proc(nums: ..int) -> (result: int) { // result is ZII, which is a feature of Odin
    fmt.printfln("type_of(nums) = %v", typeid_of(type_of(nums))) // This will print []int, which mean a slice of int
    for num in nums {
        result += num
    }
    return // Naked return
}


sum_int :: proc(nums: ..int) -> (result: int) { // result is ZII, which is a feature of Odin
    for num in nums {
        result += num
    }
    return // Naked return
}


sum_uint :: proc(nums: ..uint) -> (result: uint) { // result is ZII, which is a feature of Odin
    for num in nums {
        result += num
    }
    return // Naked return
}

// Explicitly procedure overloading
// Commonly for grouping many procedures with common usage, but have different parameters 
sum_all :: proc{ sum_int, sum_uint }

// main is still a procedure
// but main are default the entry point of a program (like many others system-language)
main :: proc() {
    fmt.printfln("sum(1, 2, 3) = %d", sum(1, 2, 3))

    nums := make([]int, 1, allocator = context.allocator)   // named argument, which is allocator, this is idiom when you need specified allocator for memory allocation
                                                            // commonly, we declare allocator parameter with idiom `allocator := context.allocator`, this is default value for parameter feature of Odin
    defer delete(nums)
}