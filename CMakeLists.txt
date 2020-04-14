# Generic GNU Make driver file.
cmake_minimum_required(VERSION 3.9)
project(PSOC_Rust_LED_Button C ASM)

include(CheckIPOSupported)

option(CYELF_TOOL "Run ELF output through Cypress' post-processors to generate a HEX file to use with their programmer, bootloader, etc" OFF)

# Path for auto-generated source/header code for compiler from IDE
set (GEN_SOURCE_DIR Generated_Source/PSoC5)

# Path for auto-generated files for everything else (linker, etc)
# This needs to be absolute, as it's going to be passed to the linker.
set (GEN_SOURCE_TEMP_DIR ${PROJECT_SOURCE_DIR}/codegentemp)

set(PSOC_GENERATED_C_SRC
    ${GEN_SOURCE_DIR}/CyScBoostClk.c
    ${GEN_SOURCE_DIR}/OutputPinHW.c
    ${GEN_SOURCE_DIR}/InputPin.c
    ${GEN_SOURCE_DIR}/OutputPinSW.c
    ${GEN_SOURCE_DIR}/InputInterrupt.c
    ${GEN_SOURCE_DIR}/CyDmac.c
    ${GEN_SOURCE_DIR}/CyFlash.c
    ${GEN_SOURCE_DIR}/CyLib.c
    ${GEN_SOURCE_DIR}/cyPm.c
    ${GEN_SOURCE_DIR}/CySpc.c
    ${GEN_SOURCE_DIR}/cyutils.c
    ${GEN_SOURCE_DIR}/cy_em_eeprom.c
)

set(PSOC_GENERATED_SEP_SRC
    ${GEN_SOURCE_DIR}/cyfitter_cfg.c
    ${GEN_SOURCE_DIR}/cymetadata.c
    ${GEN_SOURCE_DIR}/Cm3Start.c
)

set(USER_SRC
    ${PROJECT_SOURCE_DIR}/main.c
    ${PROJECT_SOURCE_DIR}/bindgen_wrappers.c
)

target_include_directories(PSOC_GENERATED_C PRIVATE
    .
    ${GEN_SOURCE_DIR}
)

# Compile asm file(s) seperately
# CMake will silently fail if you forget to add ASM to your project type
# Keeping them seperate means we at least get an error when this happens
add_library(PSOC_GENERATED_ASM STATIC
    ${GEN_SOURCE_DIR}/CyBootAsmGnu.s
)

target_include_directories(PSOC_GENERATED_ASM PUBLIC
  ${PROJECT_SOURCE_DIR}/codegentemp
)

# Build all in one project
# Could do this as separate libraries, 
add_executable(PSOC_Rust_LED_Button
    ${PSOC_GENERATED_C_SRC}
    ${PSOC_GENERATED_SEP_SRC}
    ${PSOC_GENERATED_SEP_SRC}
)

target_link_libraries(PSOC_Rust_LED_Button
    ${PROJECT_SOURCE_DIR}/rust/build/thumbv7m-none-eabi/debug/librust_src.a
    ${PROJECT_SOURCE_DIR}/Export/ARM_GCC_Generic/CyComponentLibrary.a
    PSOC_GENERATED_ASM
)

target_include_directories(PSOC_Rust_LED_Button
    .
    ${GEN_SOURCE_DIR}
)

# We need to specify our linker file
# This linker file includes other files, so we need to specify linker include path as well.
set_target_properties(PSOC_Rust_LED_Button PROPERTIES 
    LINK_DEPENDS ${PROJECT_SOURCE_DIR}/codegentemp/cm3gcc.ld
    LINK_FLAGS "-T cm3gcc.ld -L \"${GEN_SOURCE_TEMP_DIR}\""
    INTERPROCEDURAL_OPTIMIZATION TRUE
    OUTPUT_NAME "PSOC_Rust_LED_Button.elf"
)

# This is a Cypress tool for putting extra metadata in the ELF file at certain memory addresses
# If you're building for their tools/programmer, you want to run this
# If you're using a third-party debugger (eg JLink) they will try to program these addresses, and fail
if(CYELF_TOOL)
add_custom_command(TARGET PSOC_Rust_LED_Button
    POST_BUILD
    COMMAND ${PROJECT_SOURCE_DIR}/Export/cyelftool.exe -C "PSOC_Rust_LED_Button.elf" --flash_row_size 256 --flash_size 262144 --flash_offset 0x00000000
)
endif()