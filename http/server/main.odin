package http_server

import "core:fmt"
import "core:net"
import "core:log"
import http "../odin-http"

main :: proc() {
    context.logger = log.create_console_logger()
    
    log.infof("Http server example")

    s: http.Server
    http.server_shutdown_on_interrupt(&s)

    router: http.Router
    http.router_init(&router)
    defer http.router_destroy(&router)

    host := net.IP4_Loopback
    port := 5000
    log.infof("Listening on http://%v:%v", host, port)

    http.route_get(&router, "/api/hello_world", http.handler(proc(req: ^http.Request, res: ^http.Response) {
        http.respond_plain(res, "Hello world!", http.Status.OK)
    }))

    http.route_get(&router, "(.*)", http.handler(proc(req: ^http.Request, res: ^http.Response) {
        http.respond_plain(res, "Not Found!", .Not_Found)
    }))

    routed := http.router_handler(&router)

    err := http.listen_and_serve(&s, routed, net.Endpoint{ address = host, port = port })
    fmt.assertf(err == nil, "Server stopped with error: %v", err)
}