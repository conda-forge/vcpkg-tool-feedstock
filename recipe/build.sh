set -exuo pipefail

export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

cmake \
	-B build \
	-G "Ninja" \
	-DCMAKE_BUILD_TYPE=Release \
	-DVCPKG_DEVELOPMENT_WARNINGS=OFF \
	${CMAKE_ARGS}

cmake --build build --parallel ${CPU_COUNT}

cmake -E copy build/vcpkg "${PREFIX}/bin/vcpkg"
