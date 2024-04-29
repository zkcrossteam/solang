(module
  (type (;0;) (func (param i32 i32) (result i32)))
  (type (;1;) (func (param i32 i32 i32 i32) (result i32)))
  (type (;2;) (func (param i32 i32 i32)))
  (type (;3;) (func (param i32 i32 i32 i32)))
  (type (;4;) (func (param i32 i32)))
  (type (;5;) (func (result i32)))
  (type (;6;) (func (param i32) (result i64)))
  (import "env" "wasm_input" (func $wasm_input (type 6)))
  (func $clear_storage (type 0) (param i32 i32) (result i32)
    (local i32)
    i32.const 1)
  (func $hash_keccak_256 (type 2) (param i32 i32 i32)
    (local i32))
  (func $deposit_event (type 3) (param i32 i32 i32 i32)
    (local i32))
  (func $caller (type 4) (param i32 i32)
    (local i32))
  (func $input (type 4) (param i32 i32)
    (local i32))
  (func $value_transferred (type 4) (param i32 i32)
    (local i32))
  (func $set_storage (type 1) (param i32 i32 i32 i32) (result i32)
    (local i32)
    i32.const 1)
  (func $seal_return (type 2) (param i32 i32 i32)
    (local i32))
  (func $debug_message (type 0) (param i32 i32) (result i32)
    (local i32)
    i32.const 1)
  (func $get_storage (type 1) (param i32 i32 i32 i32) (result i32)
    (local i32)
    i32.const 1)
  (func $temp (type 5) (result i32)
    i32.const 1
    call $wasm_input
    i32.wrap_i64)
  (func $zkmain (type 5) (result i32)
    i32.const 1))