set(CMAKE_CUDA_COMPILER "/trinity/shared/pkg/devel/cuda/12.1/bin/nvcc")
set(CMAKE_CUDA_HOST_COMPILER "/trinity/shared/pkg/compiler/gcc/12.2.0/bin/g++")
set(CMAKE_CUDA_HOST_LINK_LAUNCHER "/trinity/shared/pkg/compiler/gcc/12.2.0/bin/g++")
set(CMAKE_CUDA_COMPILER_ID "NVIDIA")
set(CMAKE_CUDA_COMPILER_VERSION "12.1.105")
set(CMAKE_CUDA_DEVICE_LINKER "/trinity/shared/pkg/devel/cuda/12.1/bin/nvlink")
set(CMAKE_CUDA_FATBINARY "/trinity/shared/pkg/devel/cuda/12.1/bin/fatbinary")
set(CMAKE_CUDA_STANDARD_COMPUTED_DEFAULT "17")
set(CMAKE_CUDA_EXTENSIONS_COMPUTED_DEFAULT "ON")
set(CMAKE_CUDA_COMPILE_FEATURES "cuda_std_03;cuda_std_11;cuda_std_14;cuda_std_17;cuda_std_20")
set(CMAKE_CUDA03_COMPILE_FEATURES "cuda_std_03")
set(CMAKE_CUDA11_COMPILE_FEATURES "cuda_std_11")
set(CMAKE_CUDA14_COMPILE_FEATURES "cuda_std_14")
set(CMAKE_CUDA17_COMPILE_FEATURES "cuda_std_17")
set(CMAKE_CUDA20_COMPILE_FEATURES "cuda_std_20")
set(CMAKE_CUDA23_COMPILE_FEATURES "")

set(CMAKE_CUDA_PLATFORM_ID "Linux")
set(CMAKE_CUDA_SIMULATE_ID "GNU")
set(CMAKE_CUDA_COMPILER_FRONTEND_VARIANT "")
set(CMAKE_CUDA_SIMULATE_VERSION "12.2")



set(CMAKE_CUDA_COMPILER_ENV_VAR "CUDACXX")
set(CMAKE_CUDA_HOST_COMPILER_ENV_VAR "CUDAHOSTCXX")

set(CMAKE_CUDA_COMPILER_LOADED 1)
set(CMAKE_CUDA_COMPILER_ID_RUN 1)
set(CMAKE_CUDA_SOURCE_FILE_EXTENSIONS cu)
set(CMAKE_CUDA_LINKER_PREFERENCE 15)
set(CMAKE_CUDA_LINKER_PREFERENCE_PROPAGATES 1)

set(CMAKE_CUDA_SIZEOF_DATA_PTR "8")
set(CMAKE_CUDA_COMPILER_ABI "ELF")
set(CMAKE_CUDA_BYTE_ORDER "LITTLE_ENDIAN")
set(CMAKE_CUDA_LIBRARY_ARCHITECTURE "")

if(CMAKE_CUDA_SIZEOF_DATA_PTR)
  set(CMAKE_SIZEOF_VOID_P "${CMAKE_CUDA_SIZEOF_DATA_PTR}")
endif()

if(CMAKE_CUDA_COMPILER_ABI)
  set(CMAKE_INTERNAL_PLATFORM_ABI "${CMAKE_CUDA_COMPILER_ABI}")
endif()

if(CMAKE_CUDA_LIBRARY_ARCHITECTURE)
  set(CMAKE_LIBRARY_ARCHITECTURE "")
endif()

set(CMAKE_CUDA_COMPILER_TOOLKIT_ROOT "/trinity/shared/pkg/devel/cuda/12.1")
set(CMAKE_CUDA_COMPILER_TOOLKIT_LIBRARY_ROOT "/trinity/shared/pkg/devel/cuda/12.1")
set(CMAKE_CUDA_COMPILER_TOOLKIT_VERSION "12.1.105")
set(CMAKE_CUDA_COMPILER_LIBRARY_ROOT "/trinity/shared/pkg/devel/cuda/12.1")

set(CMAKE_CUDA_ARCHITECTURES_ALL "50-real;52-real;53-real;60-real;61-real;62-real;70-real;72-real;75-real;80-real;86-real;87-real;89-real;90")
set(CMAKE_CUDA_ARCHITECTURES_ALL_MAJOR "50-real;60-real;70-real;80-real;90")
set(CMAKE_CUDA_ARCHITECTURES_NATIVE "")

set(CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES "/trinity/shared/pkg/devel/cuda/12.1/targets/x86_64-linux/include")

set(CMAKE_CUDA_HOST_IMPLICIT_LINK_LIBRARIES "")
set(CMAKE_CUDA_HOST_IMPLICIT_LINK_DIRECTORIES "/trinity/shared/pkg/devel/cuda/12.1/targets/x86_64-linux/lib/stubs;/trinity/shared/pkg/devel/cuda/12.1/targets/x86_64-linux/lib")
set(CMAKE_CUDA_HOST_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CUDA_IMPLICIT_INCLUDE_DIRECTORIES "/trinity/shared/pkg/numlib/fftw/3.3.10/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/include;/trinity/shared/pkg/mpi/openmpi/4.1.5-cuda121-gdr/gcc/12.2.0/include;/trinity/shared/pkg/mpi/ucx/1.14.0-gdr/gcc/12.2.0/include;/trinity/shared/pkg/filelib/pngwriter/0.7.0/gcc/12.2.0/include;/trinity/shared/pkg/filelib/libpng/1.6.39/gcc/12.2.0/include;/trinity/shared/pkg/filelib/openpmd/0.15.2-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/include;/trinity/shared/pkg/filelib/adios/2.9.2-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/include;/trinity/shared/pkg/devel/c-blosc/1.21.4/gcc/12.2.0/include;/trinity/shared/pkg/filelib/hdf5-parallel/1.12.0-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/include;/trinity/shared/pkg/devel/zlib/1.2.11/include;/trinity/shared/pkg/devel/boost/1.82.0/gcc/12.2.0/include;/trinity/shared/pkg/devel/python/3.10.4/lib/python3.10/site-packages/numpy/core/include;/trinity/shared/pkg/devel/python/3.10.4/include/python3.10;/trinity/shared/pkg/devel/python/3.10.4/include;/trinity/shared/pkg/tools/libfabric/1.17.0-2/include;/trinity/shared/pkg/compiler/gcc/12.2.0/include;/trinity/shared/pkg/compiler/gcc/12.2.0/include/c++/12;/trinity/shared/pkg/compiler/gcc/12.2.0/include/c++/12/x86_64-pc-linux-gnu;/trinity/shared/pkg/compiler/gcc/12.2.0/include/c++/12/backward;/trinity/shared/pkg/compiler/gcc/12.2.0/lib/gcc/x86_64-pc-linux-gnu/12/include;/usr/local/include;/trinity/shared/pkg/compiler/gcc/12.2.0/lib/gcc/x86_64-pc-linux-gnu/12/include-fixed;/usr/include")
set(CMAKE_CUDA_IMPLICIT_LINK_LIBRARIES "stdc++;m;gcc_s;gcc;c;gcc_s;gcc")
set(CMAKE_CUDA_IMPLICIT_LINK_DIRECTORIES "/trinity/shared/pkg/devel/cuda/12.1/targets/x86_64-linux/lib/stubs;/trinity/shared/pkg/devel/cuda/12.1/targets/x86_64-linux/lib;/trinity/shared/pkg/compiler/gcc/12.2.0/lib64;/trinity/shared/pkg/filelib/openpmd/0.15.2-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/lib64;/trinity/shared/pkg/filelib/adios/2.9.2-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/lib64;/trinity/shared/pkg/compiler/gcc/12.2.0/lib/gcc/x86_64-pc-linux-gnu/12;/lib64;/usr/lib64;/trinity/shared/pkg/numlib/fftw/3.3.10/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/lib;/trinity/shared/pkg/mpi/ucx/1.14.0-gdr/gcc/12.2.0/lib;/trinity/shared/pkg/compiler/gcc/12.2.0/lib;/trinity/shared/pkg/filelib/pngwriter/0.7.0/gcc/12.2.0/lib;/trinity/shared/pkg/filelib/libpng/1.6.39/gcc/12.2.0/lib;/trinity/shared/pkg/filelib/adios/2.9.2-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/lib;/trinity/shared/pkg/filelib/hdf5-parallel/1.12.0-cuda121/gcc/12.2.0/openmpi/4.1.5-cuda121-gdr/lib;/trinity/shared/pkg/tools/libfabric/1.17.0-2/lib")
set(CMAKE_CUDA_IMPLICIT_LINK_FRAMEWORK_DIRECTORIES "")

set(CMAKE_CUDA_RUNTIME_LIBRARY_DEFAULT "STATIC")

set(CMAKE_LINKER "/usr/bin/ld")
set(CMAKE_AR "/usr/bin/ar")
set(CMAKE_MT "")
