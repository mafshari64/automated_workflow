# Install script for directory: /home/afshar87/afshari/simulation/simulation_auto/picongpu/include/picongpu

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2/.build/alpaka/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2/.build/build_cuda_memtest/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2/.build/build_mpiInfo/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2/.build/build_nlohmann_json/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu"
         RPATH "\$ORIGIN:/trinity/shared/pkg/devel/zlib/1.2.11/lib:/trinity/shared/pkg/devel/boost/1.82.0/gcc/12.2.0/lib:/trinity/shared/pkg/mpi/openmpi/4.1.5-cuda121-gdr/gcc/12.2.0/lib:/trinity/shared/pkg/devel/cuda/12.1/lib64")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2/.build/picongpu")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu"
         OLD_RPATH "/trinity/shared/pkg/devel/zlib/1.2.11/lib:/trinity/shared/pkg/devel/boost/1.82.0/gcc/12.2.0/lib:/trinity/shared/pkg/mpi/openmpi/4.1.5-cuda121-gdr/gcc/12.2.0/lib:/trinity/shared/pkg/devel/cuda/12.1/lib64::::::::"
         NEW_RPATH "\$ORIGIN:/trinity/shared/pkg/devel/zlib/1.2.11/lib:/trinity/shared/pkg/devel/boost/1.82.0/gcc/12.2.0/lib:/trinity/shared/pkg/mpi/openmpi/4.1.5-cuda121-gdr/gcc/12.2.0/lib:/trinity/shared/pkg/devel/cuda/12.1/lib64")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/picongpu")
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE DIRECTORY FILES "/home/afshar87/afshari/simulation/simulation_auto/picongpu/include/picongpu/../../bin/" FILES_MATCHING REGEX "/[^/]*$" PERMISSIONS OWNER_EXECUTE OWNER_READ OWNER_WRITE GROUP_READ GROUP_EXECUTE REGEX "/\\.svn$" EXCLUDE)
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/afshar87/afshari/simulation/simulation_auto/testPICMI-v2/lwfa_ionization_v2/.build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
