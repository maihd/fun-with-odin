package act4

import "base:intrinsics"
import "base:runtime"
import "core:fmt"

// Parametric polymorphism
// Shorthand are "parapoly"
// Commonly referred as "generics", but parapoly have some differences with other generics systems of other languages
// Let deep dive

// Parapoly parameters must have prefix '$'
// Parapoly arguments required expressions must be compile-time computable
// note: I mark "contextless" to see if we need allocator to create "res" or not
//      And it worked as expected
make_f32_array :: #force_inline proc "contextless" ($N: int, $val: f32) -> (res: [N]f32) {
    // Note here: res are ZII, so we can access the res elements
    for &elm in res {
        elm = val * val
    }
    return // naked return
}

// Let reimplement `new` procedure
custom_new :: proc($T: typeid) -> ^T { 
    bytes, err := runtime.mem_alloc(size_of(T), align_of(T)) // cannot use `or_return` here, because or_return will use second result as return result
    if err != nil {
        return nil
    }

    return transmute(^T)raw_data(bytes)
}

// Data types can have parapoly, like other languages
// Parameters syntaxes still follow procedure parameter syntax, with some restrictions
Table_Slot :: struct($Key, $Value: typeid) {

}

Table :: struct($Key, $Value: typeid) {

}

Custom_Maybe :: union($T: typeid) { T }

// More generic make_f32_array
make_array :: proc($N: $I, $T: typeid) -> (res: [N]T) 
    where intrinsics.type_is_integer(I) // where clause, to make sure N is a constant integer value
{
    // `N` is constant value, number of elements
    // `I` is type of `N`
    // `T` is type of element

    for i in 0..<N {
        res[i] = i * i
    }
    return // naked return
}

// Specialization
//  - Sometime work like where clause in shortened version
//  - what more?
find_value :: proc(table: ^Table($Key, $Value), key: Key) -> (Value, bool) {
    return {}, true // {} can use for default of $Value
}

main :: proc() {
    f32_arr := make_f32_array(10, 1)
    fmt.printfln("f32_arr: %v", f32_arr) // will printing [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

    int_ptr := custom_new(int)
    fmt.printfln("int_ptr value = %v", int_ptr^) // will print 0

    int_ptr^ = 10
    fmt.printfln("int_ptr value after = %v", int_ptr^) // will print 10

    t: Table(int, int)
    val, _ := find_value(&t, 1)
    fmt.printfln("val = %v (must be 0)", val)
}