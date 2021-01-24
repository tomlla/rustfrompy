use std::ffi::CString;
use std::os::raw::c_char;

#[no_mangle]
pub extern "C" fn func01() {
    println!("func01() was called.")
}

/*
Compiling example-rust-ffi-lib v0.1.0 (/example-rust-ffi-lib)
warning: `extern` fn uses type `String`, which is not FFI-safe
6 | pub extern "C" fn func02() -> String {
  |                               ^^^^^^ not FFI-safe
  = note: `#[warn(improper_ctypes_definitions)]` on by default
  = help: consider adding a `#[repr(C)]` or `#[repr(transparent)]` attribute to this struct
  = note: this struct has unspecified layout
pub extern "C" fn func02() -> String {
    return "return-string".to_string();
}
*/

#[no_mangle]
pub extern "C" fn func02() -> *const c_char {
    let cstring = CString::new("return-string").unwrap();
    return cstring.as_ptr();
}

/*
- About #[repr(C)]
  https://doc.rust-jp.rs/rust-nomicon-ja/other-reprs.html
- https://bheisler.github.io/post/calling-rust-in-python
*/
