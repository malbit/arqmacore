cmake_minimum_required(VERSION 3.2)

project(arqmacore)

set(SOURCE_FILES
        MicroCore.h
        MicroCore.cpp
        tools.h
        tools.cpp
        UniversalIdentifier.hpp
        UniversalIdentifier.cpp
        Account.h
        Account.cpp)

# make static library called libmyxrm
# that we are going to link to
# in the root CMakeLists.txt file
add_library(arqmacore
            STATIC
            ${SOURCE_FILES})

# include Arqma headers
target_include_arqma_directories(arqmacore)
