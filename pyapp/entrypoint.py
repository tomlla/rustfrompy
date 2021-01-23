from cffi import FFI

print('-------------------')
print('Hello World (python)')
print('-------------------')
print("", flush=True)

def call_func01():
    ffi = FFI()
    ffi.cdef("""
        void func01();
    """)
    rustlib = ffi.dlopen("/example-rust-ffi-lib/libexample_rust_ffi_lib.so")
    rustlib.func01()

def call_func02():
    ffi.cdef("""
        *const char func02();
    """)
    rustlib = ffi.dlopen("/example-rust-ffi-lib/libexample_rust_ffi_lib.so")
    ret_string = rustlib.func02()
    print(f'ret_string: "{ret_string}"')

call_func01()
