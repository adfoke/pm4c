cmake_minimum_required(VERSION 3.14)
project(pm4c LANGUAGES C)

# If this is the main project, build the example
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    add_subdirectory(example)
endif()