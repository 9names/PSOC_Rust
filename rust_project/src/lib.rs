#![allow(non_upper_case_globals)]
#![allow(non_camel_case_types)]
#![allow(non_snake_case)]
#![no_std]

// Forever loop on panic
use core::panic::PanicInfo;
#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

include!("bindings.rs");

// This is the C interrupt handle for handling pin inputs
// It's all touching peripheral memory directly, so it's unsafe 
#[no_mangle]
pub unsafe extern "C" fn SWPin_Control() -> () {
    if InputPin_Read() == 1 {
        OutputPinSW_Write(0);
    } else {
        OutputPinSW_Write(1);
    }

    InputPin_ClearInterrupt();
}


// This will be called instead of the C main function, so we don't have to
// mess with the startup / init code
#[no_mangle]
pub extern "C" fn main() -> () {
    // Init code, asm and direct memory access, obviously unsafe
    unsafe {
        // Set SWPin_Control as the interrupt function for the Input peripheral
        InputInterrupt_StartEx(core::prelude::v1::Some(SWPin_Control));
        // Enable interrupts
        CyGlobalIntEnable();
    }
  loop {
    // Safe, happy Rust code :D
  }
}

