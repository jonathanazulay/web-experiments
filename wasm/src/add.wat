(module
  (memory (import "memory" "memory") 1)
  (func $add
    (param $n i32)
    (param $n1 i32)
    (result i32)
    local.get $n
    local.get $n1
    i32.add
  )
  (export "add" (func $add))
  (func $processImage
    (param $pointer i32)
    (param $length i32)
    (result i32)
    (local $colorByte i32)
    (loop
      ;; Load color at current memory location and store in $colorByte  
      (i32.load (local.get $pointer))
      (local.set $colorByte)

      ;; Mask everything except RED channel
      (i32.and (local.get $colorByte) (i32.const 0xffffff00))
      (local.set $colorByte)

      ;; Write new color to memory
      (i32.store (local.get $pointer) (local.get $colorByte))      

      ;; Move pointer 4 bytes (next color)
      (i32.add (local.get $pointer) (i32.const 4))
      (local.set $pointer)

      ;; Loop if pointer not at the end
      (br_if 0 (i32.le_s (local.get $pointer) (local.get $length)))
    )
    i32.const 0
  )
  (export "processImage" (func $processImage))
)
