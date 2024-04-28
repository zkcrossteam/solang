## Transform solang compiled contract to be zkwasm compatiable
1. Generate wasm with solang   
2. Use zkwasm transformer to convert the wasm file:
   ```bash 
   bash zkwasm_transformer.sh test/PlutoToken.wasm PlutoToken::ERC20::constructor::52472b27
   ```
4. The generated wasm file can be executed in the zkwasm:
   ```bash
   mkdir test_dir & cd test_dir   
   cp $path_to/PlutoToken_zk.wasm test_dir/   
   mkdir params   
   cp $path_to/zkwasm/crates/cli/params/*.params test_dir/params/   
   RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm PlutoToken_zk.wasm setup   
   RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm PlutoToken_zk.wasm checksum   
   RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm PlutoToken_zk.wasm single-prove --public 12:i64 #--public 2:i64   
   RUST_LOG=info cargo run --release --features cuda -- --host default -k 18 --function zkmain --param ./params --output ./output --wasm PlutoToken_zk.wasm single-verify
   ```
   
 
