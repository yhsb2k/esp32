add_library(drivers STATIC
    #src/dataflash.cpp
    #src/dht.cpp
    src/di.cpp
    #src/ds18b20.cpp
    src/enc.cpp
    #src/hd44780.cpp
    #src/nrf24l01.cpp
    #src/onewire.cpp
    #src/sd.cpp
    #src/sd_spi.cpp
    #src/singlewire.cpp
)

target_include_directories(drivers
    PUBLIC
        include
)

target_link_libraries(drivers
    PUBLIC
        periph
        idf::freertos
    PRIVATE
        printf
        freertos_wrappers
)
