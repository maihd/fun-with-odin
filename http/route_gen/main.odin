package router_gen

import "core:os"
import "core:strings"
import "core:fmt"
import "core:odin/ast"
import "core:odin/parser"
import "core:slice"

Route :: struct {
    method: string,
    path: string,
    proc_name: string,
}

main :: proc() {
    p, ok := parser.collect_package("http/server")
    if !ok {
        fmt.eprintf("Failed to find package from http/server\n")
        return
    }

    if !parser.parse_package(p) {
        fmt.eprintf("Failed to parse package http/server\n")
        return
    }

    routes := make([dynamic]Route)

    for file_path, file in p.files {
        // if file_path != "main.odin" {
        //     continue
        // }

        for decl in file.decls {
            if value_decl, ok := decl.derived.(^ast.Value_Decl); ok {
                is_route := false
                route := Route {}

                for attribute in value_decl.attributes {
                    field_value := attribute.elems[0].derived.(^ast.Field_Value) or_continue

                    intent := field_value.field.derived_expr.(^ast.Ident)
                    comp_lit := field_value.value.derived_expr.(^ast.Comp_Lit) or_continue

                    name := intent.name
                    if name == "route" {
                        is_route = true
                    } else {
                        continue
                    }

                    if len(comp_lit.elems) != 2 {
                        continue
                    }

                    api_method := comp_lit.elems[0].derived.(^ast.Basic_Lit) or_continue
                    api_path := comp_lit.elems[1].derived.(^ast.Basic_Lit) or_continue

                    if api_method.tok.kind != .String {
                        continue
                    }

                    if api_path.tok.kind != .String {
                        continue
                    }

                    api_method_str := strings.trim(strings.to_lower(api_method.tok.text), "\"")
                    switch api_method_str {
                        case "get":
                        case "post":
                        case "put":
                        case "delete":
                        case "update":

                        case:
                            fmt.eprintf("Invalid api method: %s\n", api_method.tok.text)
                            return
                    }

                    api_path_str := strings.trim(strings.to_lower(api_path.tok.text), "\"")

                    route.method = api_method_str
                    route.path = api_path_str
                }

                if proc_lit, ok := value_decl.values[0].derived.(^ast.Proc_Lit); is_route && ok {
                    proc_ident := value_decl.names[0].derived.(^ast.Ident)
                    proc_name := proc_ident.name
                    route.proc_name = proc_name

                    append(&routes, route)
                }
            }
        }
    }

    route_register_calls := slice.mapper(routes[:], proc(x: Route) -> string {
        return fmt.tprintf("http.route_%s(router, %q, http.handler(%s))", x.method, x.path, x.proc_name)
    })
    
    file_template := `
// THIS FILE IS GENERATED, DO NOT EDIT!

package http_server

import http "../odin-http"

register_routes :: proc(router: ^http.Router) {{
    %s
}}
`

    file_text := fmt.tprintf(file_template, strings.join(route_register_calls, "\n    "))
    write_ok := os.write_entire_file("http/server/register_routes.odin", transmute([]byte)file_text[:])
    if !write_ok {
        fmt.eprintf("Failed to write text to file http/server/register_routes.odin")
    }
}