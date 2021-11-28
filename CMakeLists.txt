cmake_minimum_required(VERSION 3.13)

set(CMAKE_TOOLCHAIN_FILE cmake/toolchain-xtensa-esp32-gcc.cmake)

get_filename_component(CURRENT_DIRNAME "${CMAKE_CURRENT_LIST_DIR}" NAME)
project(${CURRENT_DIRNAME} C CXX ASM)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)

add_compile_options(
    $<$<NOT:$<COMPILE_LANGUAGE:ASM>>:-mlongcalls>
    -ffunction-sections
    -fdata-sections
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>
)

add_subdirectory(drivers)
add_subdirectory(periph)

add_subdirectory(third_party/FatFs)
add_subdirectory(third_party/printf)

add_subdirectory(utilities/freertos_wrappers)
add_subdirectory(utilities/syslog)

add_executable(${CMAKE_PROJECT_NAME} main.cpp assert.c)

# Build esp-idf
execute_process(COMMAND git -C third_party/esp-idf apply ../../esp-idf.patch ERROR_QUIET)
include(third_party/esp-idf/tools/cmake/idf.cmake)
idf_build_process(esp32
    COMPONENTS esp32 freertos nvs_flash esptool_py
    SDKCONFIG ${CMAKE_BINARY_DIR}/sdkconfig
)
idf_build_executable(${CMAKE_PROJECT_NAME})

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    drivers
    periph
    idf::esp32
    idf::freertos
    idf::nvs_flash
)

target_link_options(${CMAKE_PROJECT_NAME} PRIVATE
    -nostdlib
    -Wl,--gc-sections
    -Wl,-Map=${CMAKE_PROJECT_NAME}.map,--cref
)

add_custom_command(TARGET ${CMAKE_PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_SIZE} ${CMAKE_PROJECT_NAME}
)

# Add targets for flashing, erasing, resetting and debugging
set(ESPTOOL_PARAMS --chip esp32 --port COM4)
include(cmake/debug-probes/esptool-esp32.cmake)
