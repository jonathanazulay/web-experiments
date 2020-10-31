(module 
  (func $add
    (param $n i32)
    (param $n1 i32)
    (result i32)
    local.get $n
    local.get $n1
    i32.add
  )
  (export "add" (func $add))
)