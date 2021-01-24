from cffi import FFI
import sys


def call_func01():
    ffi = FFI()
    ffi.cdef("""
        void func01();
    """)
    rustlib = ffi.dlopen("/example-rust-ffi-lib/libexample_rust_ffi_lib.so")
    rustlib.func01()


def call_func02():
    ffi = FFI()
    ffi.cdef('''
        const char *func02();
    ''')
    rustlib = ffi.dlopen("/example-rust-ffi-lib/libexample_rust_ffi_lib.so")
    ret_string = rustlib.func02()
    print(f'ret_string: "{ret_string}"')


if __name__ == '__main__':
    print('-------------------')
    print('Hello World (python)')
    print('sys.argv:', sys.argv)
    func_name = sys.argv[1] if len(sys.argv) == 2 else 'call_func01'
    print('func_name:', func_name)
    print("", flush=True)
    wrapper_func = getattr(sys.modules[__name__], func_name)
    wrapper_func()
