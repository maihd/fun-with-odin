package callback_and_interfaces

import "core:fmt"

Callback :: #type proc(data: rawptr)

Interface :: struct {
    data: rawptr,
    callback: Callback
}

interface_invoke :: proc(iface: Interface) {
    iface.callback(iface.data);
}

Params :: struct {
    value: int
}

print_params :: proc(params: ^Params) {
    fmt.printf("params.value: %v\n", params.value)
}

get_params_iface :: proc(params: ^Params) -> Interface {
    return Interface {
        data = params,
        callback = Callback(print_params),
    }
}

main :: proc() {
    params := Params {
        value = 10
    }

    iface := get_params_iface(&params)

    interface_invoke(iface)
}