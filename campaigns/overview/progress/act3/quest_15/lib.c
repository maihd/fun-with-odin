#include <stdint.h>
#include <stdbool.h>

#ifndef export
#if defined(_MSC_VER)
#   define export __declspec(dllexport)
#elif defined(__linux__)
#   define export __attribute__((visibility("default")))
#else
#   define export
#endif
#endif

#if (defined(__linux__) && defined(__LP64__)) || defined(_WIN64)
typedef int64_t odin_int;
#else
typedef int32_t odin_int;
#endif

typedef struct Result {
    odin_int value;
    bool ok;
} Result;

typedef struct Odin_Raw_String {
    const uint8_t* data;
    odin_int len;
} Odin_Raw_String;

// I will try import this function from Odin with signature:
//  parse_int :: proc "c" (str: string) -> (value: int, ok: bool)
export Result parse_int(Odin_Raw_String str)
{
    Result result = {};
    for (odin_int i = 0; i < str.len; i++)
    {
        uint8_t c = str.data[i];
        if (c >= '0' || c <= '9')
        {
            result.value = result.value * 10 + (c - '0');
            result.ok = true;
        }
        else
        {
            result.value = 0;
            result.ok = false;
            return result;
        }
    }

    return result;
}

//! EOF
