# Copyright 2020 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.13)

# Allow snRuntime to be built as a standalone library.
if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    # Read SnitchUtilities
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
    include(SnitchUtilities)
    # Create snRuntime project
    project(snRuntime LANGUAGES C ASM)
    add_compile_options(-O3 -g -ffunction-sections)
else()
    # Export package information to includer.
    set(SNRUNTIME_DIR ${CMAKE_CURRENT_BINARY_DIR} PARENT_SCOPE)
    set(SNRUNTIME_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)
    set(SNRUNTIME_INCLUDE_DIRS
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        ${CMAKE_CURRENT_SOURCE_DIR}/vendor
        ${CMAKE_CURRENT_SOURCE_DIR}/vendor/riscv-opcodes
        PARENT_SCOPE)
endif()

# Default memory regions
if(SNITCH_RUNTIME STREQUAL "snRuntime-cluster")
    set(MEM_DRAM_ORIGIN "0x80000000" CACHE STRING "Base address of external memory")
    set(MEM_DRAM_SIZE "0x80000000" CACHE STRING "Size of external memory")
else()
    set(MEM_DRAM_ORIGIN "0x80000000" CACHE STRING "Base address of external memory")
    set(MEM_DRAM_SIZE "256M" CACHE STRING "Size of external memory")
endif()
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/link/common.ld.in common.ld @ONLY)
set(LINKER_SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/common.ld CACHE PATH "")

# provide linker script
# set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/link/common.ld" CACHE PATH "")
message(STATUS "Using common linker script: ${LINKER_SCRIPT}")
# set(TARGET_LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/link/banshee.ld" CACHE FILEPATH "Linker Script")
# message(STATUS "Using target linker script: ${TARGET_LINKER_SCRIPT}")

# OpenMP
set(OMPSTATIC_NUMTHREADS "0" CACHE STRING "If set to a non-zero value the OpenMP runtime is optimized to the number of cores")

if(RUNTIME_TRACE)
    # Enable runtime tracing
    add_compile_definitions(__SNRT_USE_TRACE)
endif()

include_directories(
    include
    vendor
    vendor/riscv-opcodes
)

# Common sources
set(sources
    src/barrier.c
    src/dma.c
    src/memcpy.c
    src/printf.c
    src/team.c
    src/ssr.c
    src/alloc.c
    src/interrupt.c
    src/perf_cnt.c
)

# platform specific sources
set(banshee_snitch_sources
    src/platforms/banshee/start_snitch.S
    src/platforms/banshee/putchar.c
)
set(rtl_snitch_sources
    src/platforms/rtl/start_snitch.S
    src/platforms/rtl/putchar.c
)

# Sources only compatible with the LLVM toolchain
if (CMAKE_C_COMPILER_ID STREQUAL "Clang")
    set(sources
        ${sources}
        # OpenMP support
        src/omp/omp.c
        src/omp/kmp.c
        src/omp/eu.c
        src/dm.c
    )
    # Check if static OpenMP runtime is requested
    if(OMPSTATIC_NUMTHREADS GREATER 0)
        message(STATUS "Using ${OMPSTATIC_NUMTHREADS} threads for optimized OpenMP runtime")
        add_compile_definitions(OMPSTATIC_NUMTHREADS=${OMPSTATIC_NUMTHREADS})
    else()
        message(STATUS "Generic OpenMP runtime")
    endif()
endif()

if (CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
    # Build all runtimes

    # Generic Runtime (requiring bootloader/OS)
    add_snitch_library(snRuntime src/start.S ${sources} src/ssr_v2.c)

    # Bare Runtimes (with startup code)
    add_snitch_library(snRuntime-banshee src/platforms/shared/start.c ${banshee_snitch_sources} ${sources} src/ssr_v1.c)
    add_snitch_library(snRuntime-cluster src/platforms/shared/start.c ${rtl_snitch_sources} ${sources} src/ssr_v2.c)


else()
    # snRuntime is added externally, only build required runtime
    if(SNITCH_RUNTIME STREQUAL "snRuntime")
        # Generic Runtime (requiring bootloader/OS)
        add_snitch_library(snRuntime src/platforms/shared/start.c src/start.S ${sources} src/ssr_v2.c)
    # Bare Runtimes (with startup code)
    elseif(SNITCH_RUNTIME STREQUAL "snRuntime-banshee")
        add_snitch_library(snRuntime-banshee src/platforms/shared/start.c ${banshee_snitch_sources} ${sources} src/ssr_v1.c)
    elseif(SNITCH_RUNTIME STREQUAL "snRuntime-cluster")
        add_snitch_library(snRuntime-cluster src/platforms/shared/start.c ${rtl_snitch_sources} ${sources} src/ssr_v2.c)
    else()
        message(FATAL_ERROR "Requested runtime not implemented: ${SNITCH_RUNTIME}")
    endif()
endif()

# Tests
enable_testing()
set(SNITCH_TEST_PREFIX snRuntime-)

# General snRuntime tests
add_snitch_test(tls tests/tls.c)
add_snitch_test(simple tests/simple.c)
add_snitch_test(varargs_1 tests/varargs_1.c)
add_snitch_test(varargs_2 tests/varargs_2.c)
add_snitch_test(barrier tests/barrier.c)
add_snitch_test(fence_i tests/fence_i.c)
add_snitch_test(lto tests/lto.c tests/lto_a.c)
add_snitch_test(interrupt tests/interrupt.c)
add_snitch_test(interrupt-local tests/interrupt-local.c)
add_snitch_test(printf_fmtint tests/printf_fmtint.c)
add_snitch_test(printf_simple tests/printf_simple.c)
add_snitch_test(zero_mem tests/zero_mem.c)
add_snitch_test(team_global tests/team_global.c)

# RTL only tests
if(SNITCH_RUNTIME STREQUAL "snRuntime-cluster")

    add_snitch_test_executable(dma_simple tests/dma_simple.c)
    add_snitch_test_rtl(dma_simple)

    add_snitch_test_executable(perf_cnt tests/perf_cnt.c)
    add_snitch_test_rtl(perf_cnt)

    add_snitch_test_executable(multi_cluster tests/multi_cluster.c)
    add_snitch_test_rtl(multi_cluster)

    add_snitch_test_executable(atomics tests/atomics.c)
    add_snitch_test_rtl(atomics)

    # Tests exclusive to LLVM
    if (CMAKE_C_COMPILER_ID STREQUAL "Clang")
        add_snitch_test_executable(data_mover tests/data_mover.c)
        add_snitch_test_rtl(data_mover)
        add_snitch_test_args(data_mover data_mover --base-hartid=3 --num-cores=9 --num-clusters=1)

        add_snitch_test_executable(event_unit tests/event_unit.c)
        add_snitch_test_rtl(event_unit)
        add_snitch_test_args(event_unit event_unit --base-hartid=3 --num-cores=9 --num-clusters=1)
        add_snitch_test_executable(openmp tests/openmp.c)
        add_snitch_test_rtl(openmp)
        add_snitch_test_args(openmp openmp --base-hartid=3 --num-cores=9 --num-clusters=1)

        # FP8 tests
        add_snitch_test_executable(fp8_comparison_vector tests/fp8_comparison_vector.c)
        add_snitch_test_executable(fp8_comparison_scalar tests/fp8_comparison_scalar.c)
        add_snitch_test_executable(fp8_computation_scalar tests/fp8_computation_scalar.c)
        add_snitch_test_executable(fp8_computation_vector tests/fp8_computation_vector.c)

        add_snitch_test_rtl(fp8_comparison_vector tests/fp8_comparison_vector.c)
        add_snitch_test_rtl(fp8_comparison_scalar tests/fp8_comparison_scalar.c)
        add_snitch_test_rtl(fp8_computation_scalar tests/fp8_computation_scalar.c)
        add_snitch_test_rtl(fp8_computation_vector tests/fp8_computation_vector.c)

        # FP8ALT tests
        add_snitch_test_executable(fp8alt_comparison_vector tests/fp8alt_comparison_vector.c)
        add_snitch_test_executable(fp8alt_comparison_scalar tests/fp8alt_comparison_scalar.c)
        add_snitch_test_executable(fp8alt_computation_scalar tests/fp8alt_computation_scalar.c)
        add_snitch_test_executable(fp8alt_computation_vector tests/fp8alt_computation_vector.c)

        add_snitch_test_rtl(fp8alt_comparison_vector tests/fp8alt_comparison_vector.c)
        add_snitch_test_rtl(fp8alt_comparison_scalar tests/fp8alt_comparison_scalar.c)
        add_snitch_test_rtl(fp8alt_computation_scalar tests/fp8alt_computation_scalar.c)
        add_snitch_test_rtl(fp8alt_computation_vector tests/fp8alt_computation_vector.c)

        # FP16 tests
        add_snitch_test_executable(fp16_comparison_vector tests/fp16_comparison_vector.c)
        add_snitch_test_executable(fp16_comparison_scalar tests/fp16_comparison_scalar.c)
        add_snitch_test_executable(fp16_computation_scalar tests/fp16_computation_scalar.c)
        add_snitch_test_executable(fp16_computation_vector tests/fp16_computation_vector.c)

        add_snitch_test_rtl(fp16_comparison_vector tests/fp16_comparison_vector.c)
        add_snitch_test_rtl(fp16_comparison_scalar tests/fp16_comparison_scalar.c)
        add_snitch_test_rtl(fp16_computation_scalar tests/fp16_computation_scalar.c)
        add_snitch_test_rtl(fp16_computation_vector tests/fp16_computation_vector.c)

        # FP16ALT tests
        add_snitch_test_executable(fp16alt_comparison_vector tests/fp16alt_comparison_vector.c)
        add_snitch_test_executable(fp16alt_comparison_scalar tests/fp16alt_comparison_scalar.c)
        add_snitch_test_executable(fp16alt_computation_scalar tests/fp16alt_computation_scalar.c)
        add_snitch_test_executable(fp16alt_computation_vector tests/fp16alt_computation_vector.c)

        add_snitch_test_rtl(fp16alt_comparison_vector tests/fp16alt_comparison_vector.c)
        add_snitch_test_rtl(fp16alt_comparison_scalar tests/fp16alt_comparison_scalar.c)
        add_snitch_test_rtl(fp16alt_computation_scalar tests/fp16alt_computation_scalar.c)
        add_snitch_test_rtl(fp16alt_computation_vector tests/fp16alt_computation_vector.c)

        # FP32 tests
        add_snitch_test_executable(fp32_comparison_vector tests/fp32_comparison_vector.c)
        add_snitch_test_executable(fp32_comparison_scalar tests/fp32_comparison_scalar.c)
        add_snitch_test_executable(fp32_computation_scalar tests/fp32_computation_scalar.c)
        add_snitch_test_executable(fp32_computation_vector tests/fp32_computation_vector.c)

        add_snitch_test_rtl(fp32_comparison_vector tests/fp32_comparison_vector.c)
        add_snitch_test_rtl(fp32_comparison_scalar tests/fp32_comparison_scalar.c)
        add_snitch_test_rtl(fp32_computation_scalar tests/fp32_computation_scalar.c)
        add_snitch_test_rtl(fp32_computation_vector tests/fp32_computation_vector.c)

        # FP conversion tests
        add_snitch_test_executable(fp32_conversions_scalar tests/fp32_conversions_scalar.c)
        add_snitch_test_executable(fp64_conversions_scalar tests/fp64_conversions_scalar.c)

        add_snitch_test_rtl(fp32_conversions_scalar tests/fp32_conversions_scalar.c)
        add_snitch_test_rtl(fp64_conversions_scalar tests/fp64_conversions_scalar.c)
    endif()
endif()
