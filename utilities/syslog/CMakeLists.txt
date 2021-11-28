add_library(syslog STATIC
    syslog.cpp
)

target_include_directories(syslog
    PUBLIC
        .
)

target_link_libraries(syslog
    PUBLIC
        idf::freertos
    PRIVATE
        printf
)
