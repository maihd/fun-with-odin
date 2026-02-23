# Error handling in Odin

## Topics
- Multiple returns
- Named return variables
- `#optional_ok`
- `Maybe(T)`
- `#optional_allocation_error`
- `or_return`: if false, return
- `or_break`: if false, break loop
- `or_continue`: if false, continue loop
- `or_else`: if false, use the value of expression after this operator
- `?`: use for Maybe(T) or type inference (only worked for typed variable)
- `or_x` operators are mostly for simplified control flow, avoid nested if and redundancy variables (too much `ok`)