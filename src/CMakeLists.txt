cmake_minimum_required(VERSION 2.8)

project(myull)

set(SOURCE_HEADERS
        MicroCore.h
		tools.h
		unprll_headers.h
		CurrentBlockchainStatus.h)

set(SOURCE_FILES
		MicroCore.cpp
		tools.cpp
		CmdLineOptions.cpp
		page.h
		rpccalls.cpp rpccalls.h
		version.h.in CurrentBlockchainStatus.cpp MempoolStatus.cpp MempoolStatus.h)

# make static library called libmyull
# that we are going to link to
# in the root CMakeLists.txt file
add_library(myull
		STATIC
		${SOURCE_FILES})
