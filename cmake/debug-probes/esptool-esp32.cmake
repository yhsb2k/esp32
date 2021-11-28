if(NOT DEFINED ESPTOOL_PARAMS)
    message(FATAL_ERROR "ESPTOOL_PARAMS is not defined.\n"
        "Example: \"set(ESPTOOL_PARAMS --chip esp32 --port COM4)\"")
endif()

add_custom_target(flash
    COMMENT "Programming ${CMAKE_PROJECT_NAME}.bin"
    COMMAND python ${IDF_PATH}/components/esptool_py/esptool/esptool.py
        ${ESPTOOL_PARAMS} --baud 921600 --before default_reset --after hard_reset write_flash
        0x1000 ${CMAKE_BINARY_DIR}/bootloader/bootloader.bin
        0x8000 ${CMAKE_BINARY_DIR}/partition_table/partition-table.bin
        0x10000 ${CMAKE_BINARY_DIR}/${CMAKE_PROJECT_NAME}.bin
)

add_custom_target(erase
    COMMENT "Erasing"
    COMMAND python ${IDF_PATH}/components/esptool_py/esptool/esptool.py
        ${ESPTOOL_PARAMS} --baud 921600 --before default_reset --after hard_reset erase_flash
)

add_custom_target(reset
    COMMENT "Resetting NOT IMPLEMENTED"
)

add_custom_target(debug DEPENDS flash
    COMMENT "Debugging NOT IMPLEMENTED"
)
