setlocal EnableDelayedExpansion
setlocal enableextensions

REM As long as we use a custom msvc in conda_build_config.yaml
set CXX=
set CC=

cmake ^
	-B build ^
	-G "Ninja" ^
	-D CMAKE_BUILD_TYPE=Release ^
	-D VCPKG_DEVELOPMENT_WARNINGS=OFF ^
	%CMAKE_ARGS%
if errorlevel 1 exit 1

cmake --build build --parallel %CPU_COUNT%
if errorlevel 1 exit 1

cmake -E copy build\vcpkg.exe %LIBRARY_PREFIX%\bin\vcpkg.exe
if errorlevel 1 exit 1
