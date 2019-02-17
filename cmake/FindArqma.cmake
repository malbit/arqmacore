#------------------------------------------------------------------------------
# CMake helper for the majority of the cpp-ethereum modules.
#
# This module defines
#     Monero_XXX_LIBRARIES, the libraries needed to use ethereum.
#     Monero_FOUND, If false, do not try to use ethereum.
#
# File addetped from cpp-ethereum
#
# The documentation for cpp-ethereum is hosted at http://cpp-ethereum.org
#
# ------------------------------------------------------------------------------
# This file is part of cpp-ethereum.
#
# cpp-ethereum is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cpp-ethereum is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cpp-ethereum.  If not, see <http://www.gnu.org/licenses/>
#
# (c) 2014-2016 cpp-ethereum contributors.
#------------------------------------------------------------------------------

#set(LIBS        common;cryptonote_basic;cryptonote_core;
#		             cryptonote_protocol;daemonizer;mnemonics;epee;lmdb;device;
#                blockchain_db;ringct;wallet;cncrypto;easylogging;version;checkpoints;
#                ringct_basic)

set(LIBS  cryptonote_core
          blockchain_db
          cryptonote_protocol
          cryptonote_basic
          daemonizer
          lmdb
          ringct
          ringct_basic
          common
          mnemonics
          easylogging
          device
          epee
          checkpoints
          version
          cncrypto)

set(Arqma_INCLUDE_DIRS "${CPP_ARQMA_DIR}")

# if the project is a subset of main cpp-ethereum project
# use same pattern for variables as Boost uses

set(Arqma_LIBRARIES "")

foreach (l ${LIBS})

	string(TOUPPER ${l} L)

	find_library(Arqma_${L}_LIBRARY
			NAMES ${l}
			PATHS ${CMAKE_LIBRARY_PATH}
                        PATH_SUFFIXES "/src/${l}"
                                      "/src/"
                                      "/external/db_drivers/lib${l}"
                                      "/lib" "/src/crypto"
                                      "/contrib/epee/src"
                                      "/external/easylogging++/"
                                      "/src/ringct/"
			NO_DEFAULT_PATH
			)

	set(Arqma_${L}_LIBRARIES ${Arqma_${L}_LIBRARY})

	message(STATUS FindArqma " Arqma_${L}_LIBRARIES ${Arqma_${L}_LIBRARY}")

        add_library(${l} STATIC IMPORTED GLOBAL)
	set_property(TARGET ${l} PROPERTY IMPORTED_LOCATION ${Arqma_${L}_LIBRARIES})

        set(Arqma_LIBRARIES ${Arqma_LIBRARIES} ${l} CACHE INTERNAL "Arqma LIBRARIES")

endforeach()


message("FOUND Arqma_LIBRARIES: ${Arqma_LIBRARIES}")

message(STATUS ${ARQMA_SOURCE_DIR}/build/Linux/release-v0.2.2)

macro(target_include_arqma_directories target_name)

    target_include_directories(${target_name}
        PRIVATE
        ${ARQMA_SOURCE_DIR}/src
        ${ARQMA_SOURCE_DIR}/external
        ${ARQMA_SOURCE_DIR}/build/Linux/release-v0.2.2
        ${ARQMA_SOURCE_DIR}/external/easylogging++
        ${ARQMA_SOURCE_DIR}/contrib/epee/include
        ${ARQMA_SOURCE_DIR}/external/db_drivers/liblmdb)

endmacro(target_include_arqma_directories)
