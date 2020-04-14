@REM UPDATE THIS TO YOUR INSTALL PATH!
@set GNUPATH=C:\Cypress\PSoC Creator\4.3\PSoC Creator\import\gnu\arm\5.4.1
@REM TODO: work out how to use build.rs to invoke bindgen so we can skip this step. I didn't feel like learning a new DSL tonight.
@bindgen bindgen_wrappers.h --ctypes-prefix "cty" --use-core -o rust_project/src/bindings.rs -- --target=arm -mfloat-abi=soft -mcpu=cortex-m3 -mthumb -Icodegentemp -IGenerated_Source/PSoC5 -I"%GNUPATH%\arm-none-eabi\include"
@REM Build the project! (currently always does a debug build)
@pushd rust_project
@cargo build
@popd
