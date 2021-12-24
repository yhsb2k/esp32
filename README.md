# esp32 submodule of [mcu-framework](https://github.com/yhsb2k/mcu-framework)

[![build](https://github.com/yhsb2k/esp32/workflows/build/badge.svg)](https://github.com/yhsb2k/esp32/actions?workflow=build)
[![license](https://img.shields.io/github/license/yhsb2k/esp32?color=blue)](https://github.com/yhsb2k/esp32/blob/master/LICENSE)

## How to build
```
git clone --recursive https://github.com/yhsb2k/esp32.git
cd esp32
make
```
**Other targets:**
```
make flash - Upload firmware to the target
make erase - Erase all memory on the target
make reset - Reset the target
```

## Requirements
* [GNU Xtensa (ESP32) Embedded Toolchain](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/tools/idf-tools.html#xtensa-esp32-elf)
* [CMake](https://cmake.org/download)
* [Make](https://winlibs.com)
* [Ninja](https://ninja-build.org)
* [Python3](https://www.python.org/downloads) with installed [requirements](https://github.com/espressif/esp-idf/blob/master/requirements.txt)
