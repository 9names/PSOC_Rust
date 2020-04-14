@REM UPDATE THIS TO YOUR INSTALL PATH!
@set GNUPATH=C:\Cypress\PSoC Creator\4.3\PSoC Creator\import\gnu\arm\5.4.1
@bindgen bindgen_wrappers.h --ctypes-prefix "cty" --use-core -o rust_project/src/bindings.rs -- --target=arm -mfloat-abi=soft -mcpu=cortex-m3 -mthumb -Icodegentemp -IGenerated_Source/PSoC5 -I"%GNUPATH%\arm-none-eabi\include"
@pushd rust_project
@cargo build
@popd
