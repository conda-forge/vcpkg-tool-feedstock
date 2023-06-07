setlocal EnableDelayedExpansion
setlocal enableextensions

echo "--------------------"
echo %%CXX%%
echo %%CC%%

REM As long as we use a custom msvc in conda_build_config.yaml
for /f "delims=" %%i in ('where "%CC%"') do set "CC=%%i"
if errorlevel 1 exit 1
for /f "delims=" %%i in ('where "%CXX%"') do set "CXX=%%i"
if errorlevel 1 exit 1
echo %%CXX%%
echo %%CC%%

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
