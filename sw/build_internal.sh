cd $1 && mkdir -p build && cd build && cmake .. -DCMAKE_TOOLCHAIN_FILE=toolchain-llvm && make -j`nproc`
