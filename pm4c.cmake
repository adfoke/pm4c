cmake_minimum_required(VERSION 3.14)

include(FetchContent)

# pm4c_add_package
#
# Usage:
#   pm4c_add_package(
#     NAME <package_name>
#     GITHUB <user/repo>
#     [TAG <git_tag_or_commit>]
#     [SYSTEM]
#     [INCLUDE_DIRS <dirs...>]
#   )
#
# Example:
#   pm4c_add_package(
#     NAME cjson
#     GITHUB DaveGamble/cJSON
#     TAG v1.7.15
#     SYSTEM
#   )
function(pm4c_add_package)
    set(options SYSTEM)
    set(oneValueArgs NAME GITHUB TAG)
    set(multiValueArgs INCLUDE_DIRS)
    cmake_parse_arguments(PM4C "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT PM4C_NAME)
        message(FATAL_ERROR "pm4c_add_package requires a NAME argument")
    endif()

    if(NOT PM4C_GITHUB)
        message(FATAL_ERROR "pm4c_add_package requires a GITHUB argument (user/repo)")
    endif()

    if(NOT PM4C_TAG)
        set(PM4C_TAG "HEAD")
    endif()

    # Try to find system package first if requested
    if(PM4C_SYSTEM)
        find_package(${PM4C_NAME} QUIET)
        if(${PM4C_NAME}_FOUND)
            message(STATUS "pm4c: Found system package ${PM4C_NAME}")
            return()
        endif()
    endif()

    message(STATUS "pm4c: Adding package ${PM4C_NAME} from github.com/${PM4C_GITHUB} @ ${PM4C_TAG}")

    FetchContent_Declare(
        ${PM4C_NAME}
        GIT_REPOSITORY https://github.com/${PM4C_GITHUB}.git
        GIT_TAG        ${PM4C_TAG}
        GIT_SHALLOW    TRUE
        GIT_PROGRESS   TRUE
    )

    FetchContent_MakeAvailable(${PM4C_NAME})

    # Handle manual include directories if specified
    if(PM4C_INCLUDE_DIRS)
        if(TARGET ${PM4C_NAME})
            string(TOLOWER ${PM4C_NAME} lower_name)
            foreach(dir ${PM4C_INCLUDE_DIRS})
                if(IS_ABSOLUTE "${dir}")
                    target_include_directories(${PM4C_NAME} INTERFACE "${dir}")
                else()
                    target_include_directories(${PM4C_NAME} INTERFACE "${${lower_name}_SOURCE_DIR}/${dir}")
                endif()
            endforeach()
        else()
            message(WARNING "pm4c: Target ${PM4C_NAME} not found. Cannot add include directories.")
        endif()
    endif()
endfunction()
