package act2_quest11

import "base:runtime"
import "core:fmt"

// Any proc() without {} or --- is a proc type
Callback :: proc()

// In practice, we should add #type for better readibility
Callback_W_Type_Prefix :: #type proc()

// Distinct for callback
Distinct_Callback :: distinct Callback

// Contextless procedures have no auto `context` parameter as last
contextless_greeting :: proc "contextless" () {
    // Belove code cannot compile, because fmt.printf() have default argument allocator := context.temp_allocator
    // fmt.printf("Hellope!")

    // But this code will work
    context = runtime.default_context()
    fmt.printf("Hellope!")
}

// `context` is a keyword, so we cannot have explicit context procedure
// Even though, this is not a good practice to do explicit context in parameter=))
// contextless_greeting_explicit_context :: proc "contextless" (context: runtime.Context) {
//
// }

// The advantages of contextless procedure
//  - Is mostly have all features of a Odin procedure (default "odin" callconv)
//  - Default params
//  - Multiple returns
contextless_advantages :: proc "contextless" (def_arg := 1) -> (x: int, y: int) {
    return 0, 1
}

// "c" or "cdecl" callconv are both tell me one thing: C ABI function calling convention
cdecl_proc :: proc "c" (def_arg := 1) {

}

// Surprisely, we can have multiple return in cdecl proc
cdecl_proc_multireturn :: proc "c" () -> (x: int, y: int) {
    return 0, 1
}

// Let deep dive into foreign language
foreign {
    // Even in foreign function can have multiple return=))
    // Let a exercise to explore more in foreign language act
    external_c_proc :: proc "c" () -> (x: int, y: int) ---
}

// main can has any callconv
// but, only work with ols? when compiling, we will have this message from compiler:
//  Error: Procedure 'main' cannot have a custom calling convention
// main :: proc "c" () {
//     // But we need set create context manually
//     context = runtime.default_context() // note here, we assign, not declare new var named 'context'

main :: proc() {
    // Variable have type of a proc() will be procedure pointer (like C function pointer, but without annoying syntax)
    cb: Callback = proc() { fmt.printf("Hellope! This is from a callback (proc pointer)\n") }

    // Calling procedure pointer are just like calling a proc() (still like C)
    cb()

    // `distinct` is not work procedure type (this is reasonable)
    dist_cb: Distinct_Callback = cb

    // Checking type of cb, it's will be printing `Callback`, because cb is a var have type of Callback
    fmt.printf("type_of(cb) = %v\n", typeid_of(type_of(cb)))

    // Checking type of dist_cb, it's will be printing `Distinct_Callback`, because dist_cb is a var have type of Distinct_Callback
    fmt.printf("type_of(dist_cb) = %v\n", typeid_of(type_of(dist_cb)))

    // Checking type of an anounymous procedure, it's will be printing `proc()`, because use literals of procedure
    fmt.printf("type_of(proc(){{}}}) = %v\n", typeid_of(type_of(proc(){})))

    // Checking type of an anounymous procedure with "c" callconv specified, it's will be printing `proc()`, I don't know why?
    fmt.printf("type_of(proc \"c\" (){{}}) = %v\n", typeid_of(type_of(proc "c" (){})))

    // Checking type of an anounymous procedure with "contextless" callconv specified, it's will be printing `proc()`, I don't know why?
    fmt.printf("type_of(proc \"contextless\" (){{}}) = %v\n", typeid_of(type_of(proc "contextless" (){})))

    // Checking type of an anounymous procedure with "odin" callconv specified, it's will be printing `proc()`, I don't know why?
    fmt.printf("type_of(proc \"odin\" (){{}}) = %v\n", typeid_of(type_of(proc "odin" (){})))

    // For conclusion of why this will print proc() for most procedures with callconv, maybe this is a bug of fmt?, but this bug is not a big deal!
    // Let try assign proc with different callconv to others
    // Yes! different callconv cannot assign, that good and what we need!
    // cb = proc "c" () {}

    // I final thing we should care, what type of var have anounymous proc value
    ano_cb := proc() {}
    fmt.printf("type_of(ano_cb) = %v\n", typeid_of(type_of(ano_cb))) // it's will proc()

    // Finally we can know for sure, how procedure types and callconv works
}
