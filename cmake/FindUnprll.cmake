#------------------------------------------------------------------------------
# CMake helper for the majority of the cpp-ethereum modules.
#
# This module defines
#     Unprll_XXX_LIBRARIES, the libraries needed to use unprll.
#     Unprll_FOUND, If false, do not try to use unprll.
#
# File adapted from cpp-ethereum
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

set(LIBS common;
    cryptonote_basic;
    cryptonote_core;
    multisig;
    cryptonote_protocol;
    daemonizer;
    mnemonics;
    epee;
    lmdb;
    device;
    blockchain_db;
    ringct;
    wallet;
    cncrypto;
    easylogging;
    version;
    checkpoints)

set(ULL_INCLUDE_DIRS "${CPP_UNPRLL_DIR}")

# if the project is a subset of main cpp-ethereum project
# use same pattern for variables as Boost uses

foreach (l ${LIBS})

	string(TOUPPER ${l} L)

	find_library(ULL_${L}_LIBRARY
		NAMES ${l}
		PATHS ${CMAKE_LIBRARY_PATH}
		PATH_SUFFIXES "/src/${l}" "/src/" "/external/db_drivers/lib${l}" "/lib" "/src/crypto" "/contrib/epee/src" "/external/easylogging++/"
		NO_DEFAULT_PATH
	)

	set(ULL_${L}_LIBRARIES ${ULL_${L}_LIBRARY})

	message(STATUS FindUnprll " ULL_${L}_LIBRARIES ${ULL_${L}_LIBRARY}")

	add_library(${l} STATIC IMPORTED)
	set_property(TARGET ${l} PROPERTY IMPORTED_LOCATION ${ULL_${L}_LIBRARIES})

endforeach()

if (EXISTS ${UNPRLL_BUILD_DIR}/src/ringct/libringct_basic.a)
	message(STATUS FindUnprll " found libringct_basic.a")
	add_library(ringct_basic STATIC IMPORTED)
	set_property(TARGET ringct_basic
			PROPERTY IMPORTED_LOCATION ${UNPRLL_BUILD_DIR}/src/ringct/libringct_basic.a)
endif()


message(STATUS ${UNPRLL_SOURCE_DIR}/build)

# Include Unprll headers
include_directories(
		${UNPRLL_SOURCE_DIR}/src
		${UNPRLL_SOURCE_DIR}/external
		${UNPRLL_SOURCE_DIR}/build
		${UNPRLL_SOURCE_DIR}/external/easylogging++
		${UNPRLL_SOURCE_DIR}/contrib/epee/include
		${UNPRLL_SOURCE_DIR}/external/db_drivers/liblmdb)
