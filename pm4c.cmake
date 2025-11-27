cmake_minimum_required(VERSION 3.14)

include(FetchContent)

# pm4c_add_package
#
# Usage:
#   pm4c_add_package(
#     NAME <package_name>
#     GITHUB <user/repo>
#     [TAG <git_tag_or_commit>]
#   )
#
# Example:
#   pm4c_add_package(
#     NAME cjson
#     GITHUB DaveGamble/cJSON
#     TAG v1.7.15
#   )
function(pm4c_add_package)
    set(options)
    set(oneValueArgs NAME GITHUB TAG)
    set(multiValueArgs)
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

    message(STATUS "pm4c: Adding package ${PM4C_NAME} from github.com/${PM4C_GITHUB} @ ${PM4C_TAG}")

    FetchContent_Declare(
        ${PM4C_NAME}
        GIT_REPOSITORY https://github.com/${PM4C_GITHUB}.git
        GIT_TAG        ${PM4C_TAG}
    )

    # Workaround for legacy CMake projects
    set(CMAKE_POLICY_VERSION_MINIMUM 3.5)
    FetchContent_MakeAvailable(${PM4C_NAME})
endfunction()
