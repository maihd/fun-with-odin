
// THIS FILE IS GENERATED, DO NOT EDIT!

package http_server

import http "../odin-http"

register_routes :: proc(router: ^http.Router) {
    http.route_get(router, "/api/greeting", http.handler(handle_greeting))
}
