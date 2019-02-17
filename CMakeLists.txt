cmake_minimum_required(VERSION 3.2)

set(PROJECT_NAME
        xmregcore)

project(${PROJECT_NAME})

set(CMAKE_CXX_STANDARD 14)
set(CXX_STANDARD_REQUIRED ON)

if (NOT ARQMA_DIR)
    set(ARQMA_DIR ~/arqma)
endif()

option(BUILD_XMREGCORE_TESTS "Build tests for the project" OFF)

message(STATUS ARQMA_DIR ": ${ARQMA_DIR}")

set(ARQMA_SOURCE_DIR ${ARQMA_DIR}
        CACHE PATH "Path to the root directory for Arqma")

# set location of Arqma build tree
set(ARQMA_BUILD_DIR ${ARQMA_SOURCE_DIR}/build/Linux/release-v0.2.2
        CACHE PATH "Path to the build directory for Arqma")

set(MY_CMAKE_DIR "${CMAKE_CURRENT_LIST_DIR}/cmake"
        CACHE PATH "The path to the cmake directory of the current project")

list(APPEND CMAKE_MODULE_PATH "${MY_CMAKE_DIR}")

set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "${ARQMA_BUILD_DIR}"
        CACHE PATH "Add Arqma directory for library searching")

include(MyUtils)

#include(CodeCoverage)
#APPEND_COVERAGE_COMPILER_FLAGS()
#set(COVERAGE_EXCLUDES
#       '${CMAKE_SOURCE_DIR}/ext/*'
#       '${ARQMA_SOURCE_DIR}/*'
#       '${CMAKE_SOURCE_DIR}/tests/*')


find_package(Arqma)

# find boost
find_package(Boost COMPONENTS
        system
        filesystem
        thread
        date_time
        chrono
        regex
        serialization
        program_options
        REQUIRED)


# add src/ subfolder
add_subdirectory(src/)


set(SOURCE_FILES
        main.cpp)

add_executable(${PROJECT_NAME}
        ${SOURCE_FILES})


# include boost headers
target_include_directories(${PROJECT_NAME}
    PRIVATE ${Boost_INCLUDE_DIRS})

target_include_directories(${PROJECT_NAME}
    PRIVATE ${ARQMA_SOURCE_DIR}/build)

# include Arqma headers
target_include_arqma_directories(${PROJECT_NAME})

set(LIBRARIES
        myxrmcore
        ${Arqma_LIBRARIES}
        ${Boost_LIBRARIES}
        sodium
        pthread
        unbound
        curl
        ssl
        crypto)

if(APPLE)
    set(LIBRARIES ${LIBRARIES} "-framework IOKit -framework Foundation")
else()
    set(LIBRARIES ${LIBRARIES} atomic)
endif()

if(NOT ${CMAKE_SYSTEM_NAME} MATCHES "Darwin" AND NOT WIN32)
    set(LIBRARIES ${LIBRARIES} unwind)
endif()


if (WIN32)
    set(LIBRARIES ${LIBRARIES}
            wsock32
            ntdll
            ws2_32
            Iphlpapi)
else()
    set(LIBRARIES ${LIBRARIES} dl)
endif()

find_package(HIDAPI)
set(LIBRARIES ${LIBRARIES} ${HIDAPI_LIBRARIES})

target_link_libraries(${PROJECT_NAME}
    PRIVATE ${LIBRARIES})

if (BUILD_XMREGCORE_TESTS)
    enable_testing()
    add_subdirectory(ext/googletest)
    add_subdirectory(tests)
endif()
