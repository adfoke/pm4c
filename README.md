# pm4c (Package Manager for C)

A lightweight, CMake-based package manager for C projects. `pm4c` makes it incredibly easy to include dependencies from GitHub directly into your CMake build.

## Features

- **Zero Installation**: Just include a single CMake file.
- **GitHub Integration**: Fetch packages directly from GitHub repositories.
- **CMake Native**: Built on top of CMake's `FetchContent` module.
- **Simple API**: One function to rule them all.

## Usage

1.  Copy `pm4c.cmake` to your project (or add this repo as a submodule).
2.  In your `CMakeLists.txt`:

```cmake
include(pm4c.cmake)

# Add a package from GitHub
pm4c_add_package(
    NAME log4c
    GITHUB adfoke/log4c
)

# Link your target against the package
add_executable(my_app main.c)
target_link_libraries(my_app PRIVATE log4c)
# Note: Some packages might need manual include directory setup if they don't export it properly
target_include_directories(my_app PRIVATE ${log4c_SOURCE_DIR}/include)
```

## API Reference

### `pm4c_add_package`

Adds a dependency to your project.

```cmake
pm4c_add_package(
    NAME <package_name>
    GITHUB <user/repo>
    [TAG <git_tag_or_commit>]
)
```

-   `NAME`: The name of the package. This is usually the name of the CMake target provided by the library (e.g., `cjson`, `log4c`).
-   `GITHUB`: The GitHub repository in `user/repo` format.
-   `TAG`: (Optional) The Git tag, branch, or commit hash to checkout. Defaults to `HEAD`.

## Example

See the `example/` directory for a complete working example using `log4c`.

## License

MIT
