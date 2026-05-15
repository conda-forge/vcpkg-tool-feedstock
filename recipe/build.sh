set -exuo pipefail

if [[ "${target_platform}" == osx-* ]]; then
    export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi
if [[ "${target_platform}" == osx-* ]]; then
    LIBRARY_PREFIX="${PREFIX}/Library"
else
    LIBRARY_PREFIX="${PREFIX}"
fi

cmake \
	-B build \
	-G "Ninja" \
	-DCMAKE_BUILD_TYPE=Release \
	-DVCPKG_DEVELOPMENT_WARNINGS=OFF \
	${CMAKE_ARGS}

cmake --build build/ --parallel ${CPU_COUNT}

cmake -E copy build/vcpkg "${LIBRARY_PREFIX}/bin/vcpkg"
