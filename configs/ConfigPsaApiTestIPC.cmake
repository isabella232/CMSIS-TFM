#-------------------------------------------------------------------------------
# Copyright (c) 2019-2020, Arm Limited. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#
#-------------------------------------------------------------------------------

#This file holds information of a specific build configuration of this project.

if(NOT DEFINED TFM_ROOT_DIR)
	message(FATAL_ERROR "Variable TFM_ROOT_DIR is not set!")
endif()

#Include board specific config (CPU, etc...), select platform specific build
#system settings file
if(NOT DEFINED TARGET_PLATFORM)
	message(FATAL_ERROR "ERROR: TARGET_PLATFORM is not set in command line")
elseif(${TARGET_PLATFORM} STREQUAL "AN521")
	set(PLATFORM_CMAKE_FILE "${TFM_ROOT_DIR}/platform/ext/Mps2AN521.cmake")
elseif(${TARGET_PLATFORM} STREQUAL "AN519")
	set(PLATFORM_CMAKE_FILE "${TFM_ROOT_DIR}/platform/ext/Mps2AN519.cmake")
elseif(${TARGET_PLATFORM} STREQUAL "MUSCA_A")
	set(PLATFORM_CMAKE_FILE "${TFM_ROOT_DIR}/platform/ext/musca_a.cmake")
elseif(${TARGET_PLATFORM} STREQUAL "MUSCA_B1")
	set(PLATFORM_CMAKE_FILE "${TFM_ROOT_DIR}/platform/ext/musca_b1.cmake")
elseif(${TARGET_PLATFORM} STREQUAL "AN524")
	set(PLATFORM_CMAKE_FILE "${TFM_ROOT_DIR}/platform/ext/Mps3AN524.cmake")
elseif(${TARGET_PLATFORM} STREQUAL "psoc64")
	set(PLATFORM_CMAKE_FILE "${TFM_ROOT_DIR}/platform/ext/psoc64.cmake")
else()
	message(FATAL_ERROR "ERROR: Target \"${TARGET_PLATFORM}\" is not supported.")
endif()

#These variables select how the projects are built. Each project will set
#various project specific settings (e.g. what files to build, macro
#definitions) based on these.
set (REGRESSION False)
set (CORE_TEST False)
set (CORE_IPC True)
set (PSA_API_TEST True)

#TF-M isolation level: 1, 2
set (TFM_LVL 1)

#BL2 bootloader(MCUBoot) related settings
if(NOT DEFINED BL2)
	set(BL2 True)
endif()

if(NOT DEFINED MCUBOOT_NO_SWAP)
	set(MCUBOOT_NO_SWAP False)
endif()

if(NOT DEFINED MCUBOOT_RAM_LOADING)
	set(MCUBOOT_RAM_LOADING False)
endif()

#Service specific configuration for the PSA API Compliance test requirements
if(PSA_API_TEST_CRYPTO)
	set(CRYPTO_ENGINE_BUF_SIZE 20480)
endif()

if(PSA_API_TEST_IPC)
	set (CONFIG_TFM_ENABLE_MEMORY_PROTECT ON)
endif()

include ("${TFM_ROOT_DIR}/CommonConfig.cmake")
