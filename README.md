# file-windows

Windows build of the Unix [file](https://github.com/file/file) utility (version 5.47).

Forked from [julian-r/file-windows](https://github.com/julian-r/file-windows). 5.47 update based on [ember91/file-windows](https://github.com/ember91/file-windows).

## What's different from julian-r's fork

- Updated to file 5.47 (was 5.44)
- Static build (no separate libmagic.dll)
- Added `file_standalone.exe` with embedded magic database (single-file deployment)

## Checkout with submodules

```sh
git submodule update --init --recursive
```

## Build

```cmd
mkdir build && cd build
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
```

## Output

| File | Description |
|------|-------------|
| `file.exe` | Requires `magic.mgc` alongside it |
| `file_standalone.exe` | Single file, magic database embedded |
| `magic.mgc` | Magic database (10 MB) |
