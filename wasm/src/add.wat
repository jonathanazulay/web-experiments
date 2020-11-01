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
      (local.get $pointer)
      (local.get $colorByte)
      (i32.store)

      ;; Move pointer 4 bytes (next color)
      (i32.add (local.get $pointer) (i32.const 4))
      (local.set $pointer)

      ;; Loop if pointer not at the end
      (br_if 0 (i32.le_s (local.get $pointer) (local.get $length)))
    )
    i32.const 0
  )
  (export "processImage" (func $processImage))
    (func $processImageBrightness
    (param $pointer i32)
    (param $length i32)
    (param $brightness i32)
    (result i32)
    (local $colorByte i32)
    (loop
      ;; Load color at current memory location and store in $colorByte
      (local.get $pointer)
      (i32.load (local.get $pointer))
      (local.set $colorByte)

      ;; Red channel

      ;; Mask not needed bits
      (i32.and (local.get $colorByte) (i32.const 0x000000ff))
      ;; Multiple by brightness
      (i32.mul (local.get $brightness))
      (i32.div_u (i32.const 100))
      ;;Clamp to 255
      (call $clampByte)
      
      ;; Green channel

      (i32.and (local.get $colorByte) (i32.const 0x0000ff00))
      (i32.shr_u (i32.const 8))
      (i32.mul (local.get $brightness))
      (i32.div_u (i32.const 100))
      (call $clampByte)
      (i32.shl (i32.const 8))
      (i32.or)

      ;; B channel multiply
      (i32.and (local.get $colorByte) (i32.const 0x00ff0000))
      (i32.shr_u (i32.const 16))
      (i32.mul (local.get $brightness))
      (i32.div_u (i32.const 100))
      (call $clampByte)
      (i32.shl (i32.const 16))
      (i32.or)

      ;; Set alpha channel to 255
      (i32.or (i32.const 0xff000000))

      ;; Write new color to memory
      (i32.store)

      ;; Move pointer 4 bytes (next color)
      (i32.add (local.get $pointer) (i32.const 4))
      (local.set $pointer)

      ;; Loop if pointer not at the end
      (br_if 0 (i32.le_s (local.get $pointer) (local.get $length)))
    )
    i32.const 0
  )
  (export "processImageBrightness" (func $processImageBrightness))
  (func $clampByte
    (param $byte i32)
    (result i32)
    (select
      (i32.const 255)
      (local.get $byte)
      (i32.gt_u (local.get $byte) (i32.const 255))
    )
  )
)
