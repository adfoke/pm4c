cmake_minimum_required(VERSION 3.14)
project(pm4c_example LANGUAGES C)

# Include pm4c from the parent directory
include(${CMAKE_CURRENT_SOURCE_DIR}/../pm4c.cmake)

# Use pm4c to add log4c
pm4c_add_package(
    NAME log4c
    GITHUB adfoke/log4c
)

add_executable(pm4c_example main.c)

# Link against the library provided by the package
target_link_libraries(pm4c_example PRIVATE log4c)

# Since log4c doesn't export its include directory properly, we add it manually.
# FetchContent sets <name>_SOURCE_DIR.
target_include_directories(pm4c_example PRIVATE ${log4c_SOURCE_DIR}/include)
