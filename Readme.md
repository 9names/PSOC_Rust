# PSOC Rust LED toggler 

It's the Cypress PSOC DigitalPins example project, but using swapping out C for bindgen and Rust

Basically, it's blinky but a push-button instead of a timer.

There's also a CMakeLists.txt, so you can build/run with other editors, IDEs and debuggers.

--- 

The pins are set up for the
[CY8CKIT-059 PSoC® 5LP Prototyping Kit](https://www.cypress.com/documentation/development-kitsboards/cy8ckit-059-psoc-5lp-prototyping-kit-onboard-programmer-and),
but it should work on any Cortex-M3 based PSOC's (5/6) without any changes to the rust code

You could get it going on PSOC4(M0/M0+) as well, if you change the target in rust_project/.cargo/config to thumbv6m-none-eabi


### Prerequisites

* PSOC Creator 3.4

* Rustup

If you're going to use CMake to do the build:

* A newish CMake

* [ninja-build](https://ninja-build.org/)

* An arm toolchain, if you want to use something other than the IDE bundled GCC

Installing Rust prerequisites using Cargo:
```
Install the thumbv7m-none-eabi Rust toolchain
> rustup target add thumbv7m-none-eabi

Install bindgen, fmt
> cargo install bindgen
> rustup component add rustfmt
```


## Running the project

First thing to do: **update the path to GCC in the batch files** so Bindgen can find the headers it needs.

PSOC Creator
```
Open the project
Do a build, so that code-generated files are built.
If everything worked first go (no way), you should get a successful build
Otherwise:
    Open a command prompt, and run rustbuild.bat to ensure that bindgen and cargo are working properly.
    You probably skipped updating the GCC path in the batch files :D
```
Once the rust project is building correctly, you should be able to press the build or debug buttons to deploy the project.

If you're using CMake
```
  Do the above
  run cmakebuild.bat
  Check out the batch file to find out how to invoke with a different toolchain, etc.
```


## What next?
Add more components, rebuild, write more rust :D

## License

This project is licensed under the 0BSD license

Exclusions to this licence apply to 
  * Example C code from Cypress Semiconductor - licence is distributed in with PSOC Creator, open the help to see the licence.
  * toolchain-arm-none-eabi.cmake from Johannes Bruder - MIT Licence, source was https://github.com/jobroe/cmake-arm-embedded