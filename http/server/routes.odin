package http_server

import http "../odin-http"

@(route = { "GET", "/api/greeting" })
handle_greeting :: proc(res: ^http.Request, req: ^http.Response) {
    http.respond_plain(req, "Hello World!", .OK)
}