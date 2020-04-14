@REM Update this folder to match your install path
@set TOOLCHAIN_PREFIX="C:/Cypress/PSoC Creator/4.3/PSoC Creator/import/gnu/arm/5.4.1"
@REM Run bindgen and cargo build first
@rustbuild.bat
@REM Clear out our build folder, if it exists
@rmdir build /Q /S
@mkdir build
@REM Do the build!
@pushd build
@cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_TOOLCHAIN_FILE=../toolchain-arm-none-eabi.cmake -DTOOLCHAIN_PREFIX="%TOOLCHAIN_PREFIX%"
@ninja
@popd