package lua_scripting

import lua "vendor:lua/5.2"

main :: proc() {
    L := lua.L_newstate()
    defer lua.close(L)

    lua.L_openlibs(L)
    lua.L_dostring(L, "print('Hellope, Lua!')")
}