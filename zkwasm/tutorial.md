## Execute solang compiled solidity on zkwasm

### Generate zkwasm compatiable wasm (use example of ERC20 from OpenZeppellin-contracts)
1. Git clone https://github.com/OpenZeppelin/openzeppelin-contracts.git
2. cd openzeppelin-contracts/contracts/token/ERC20/
3. Create contract that use ERC20 and name it as `test.sol`. (Reference: https://www.youtube.com/watch?v=CtZ60FUeSpc)
```
pragma solidity ^0.8.4;

import "./ERC20.sol";

contract PlutoToken is ERC20 {
    constructor() ERC20("PlutoToken", "PTK") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}
```
4. Compile test.sol with solang: solang compile --target polkadot test.sol -v

### Edit the generated wasm file to resolve zkwasm compatibility
5. wasm2wat test.wasm -o test.wat
6. Remove the dependencies of the polkadot target:
```
...
  (func $set_storage(type 1) (param i32 i32 i32 i32) (result i32)
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
...
```
7. Add zkwasm entry function:
```
(func $zkmain (result i32)
const.i32 1
const.i32 1
call $PlutoToken::ERC20::constructor::5247b27
)
(memory (;0;) 2)
(export "memory" (memory 0))
```
4. wat2wasm test.wat -o test_zk.wasm

### Execute generated wasm with zkwasm
8. mkdir test_dir & cd test_dir
9. cp $path_to/test_zk.wasm test_dir/
10. mkdir params
11. cp $path_to/zkwasm/crates/cli/params/*.params test_dir/params/
12. RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm test_zk.wasm setup
13. RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm test_zk.wasm checksum
14. RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm test_zk.wasm single-prove --public 12:i64 #--public 2:i64
15. RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm test_zk.wasm single-verify
