// Copyright 2020 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

// Generated by occamygen.py

#pragma once

#define DEBUG_BASE_ADDR 0x00000000
#define SOC_CTRL_BASE_ADDR 0x02000000
#define FLL_SYSTEM_BASE_ADDR 0x02001000
#define FLL_PERIPH_BASE_ADDR 0x02001400
#define FLL_HBM2E_BASE_ADDR 0x02001800
#define UART_BASE_ADDR 0x02002000
#define GPIO_BASE_ADDR 0x02003000
#define I2C_BASE_ADDR 0x02004000
#define CHIP_CTRL_BASE_ADDR 0x02005000
#define TIMER_BASE_ADDR 0x02006000
#define HBM_XBAR_CFG_BASE_ADDR 0x02007000
#define SPIM_BASE_ADDR 0x03000000
#define PCIE_CFG_BASE_ADDR 0x05000000
#define HBI_WIDE_CFG_BASE_ADDR 0x06000000
#define HBI_NARROW_CFG_BASE_ADDR 0x07000000
#define PLIC_BASE_ADDR 0x0C000000
#define BOOTROM_BASE_ADDR 0x01000000
#define CLINT_BASE_ADDR 0x04000000
#define PCIE0_BASE_ADDR 0x20000000
#define PCIE1_BASE_ADDR 0x48000000
#define SPM_NARROW_BASE_ADDR 0x70000000
#define SPM_WIDE_BASE_ADDR 0x71000000
#define WIDE_ZERO_MEM_BASE_ADDR 0x100000000
#define SYS_IDMA_CFG_BASE_ADDR 0x11000000
#define HBI_BASE_ADDR 0x10000000000
#define HBM_00_BASE_ADDR 0x80000000
#define HBM_01_BASE_ADDR 0x1000000000
#define HBM_10_BASE_ADDR 0xC0000000
#define HBM_11_BASE_ADDR 0x1040000000
#define HBM_2_BASE_ADDR 0x1080000000
#define HBM_3_BASE_ADDR 0x10C0000000
#define HBM_4_BASE_ADDR 0x1100000000
#define HBM_5_BASE_ADDR 0x1140000000
#define HBM_6_BASE_ADDR 0x1180000000
#define HBM_7_BASE_ADDR 0x11C0000000
#define QUADRANT_0_CLUSTER_0_TCDM_BASE_ADDR 0x10000000
#define QUADRANT_0_CLUSTER_0_PERIPH_BASE_ADDR 0x10020000
#define QUADRANT_0_CLUSTER_0_ZERO_MEM_BASE_ADDR 0x10030000
#define QUADRANT_0_CLUSTER_1_TCDM_BASE_ADDR 0x10040000
#define QUADRANT_0_CLUSTER_1_PERIPH_BASE_ADDR 0x10060000
#define QUADRANT_0_CLUSTER_1_ZERO_MEM_BASE_ADDR 0x10070000
#define QUADRANT_0_CLUSTER_2_TCDM_BASE_ADDR 0x10080000
#define QUADRANT_0_CLUSTER_2_PERIPH_BASE_ADDR 0x100A0000
#define QUADRANT_0_CLUSTER_2_ZERO_MEM_BASE_ADDR 0x100B0000
#define QUADRANT_0_CLUSTER_3_TCDM_BASE_ADDR 0x100C0000
#define QUADRANT_0_CLUSTER_3_PERIPH_BASE_ADDR 0x100E0000
#define QUADRANT_0_CLUSTER_3_ZERO_MEM_BASE_ADDR 0x100F0000
#define QUAD_0_CFG_BASE_ADDR 0x0B000000
#define QUADRANT_1_CLUSTER_0_TCDM_BASE_ADDR 0x10100000
#define QUADRANT_1_CLUSTER_0_PERIPH_BASE_ADDR 0x10120000
#define QUADRANT_1_CLUSTER_0_ZERO_MEM_BASE_ADDR 0x10130000
#define QUADRANT_1_CLUSTER_1_TCDM_BASE_ADDR 0x10140000
#define QUADRANT_1_CLUSTER_1_PERIPH_BASE_ADDR 0x10160000
#define QUADRANT_1_CLUSTER_1_ZERO_MEM_BASE_ADDR 0x10170000
#define QUADRANT_1_CLUSTER_2_TCDM_BASE_ADDR 0x10180000
#define QUADRANT_1_CLUSTER_2_PERIPH_BASE_ADDR 0x101A0000
#define QUADRANT_1_CLUSTER_2_ZERO_MEM_BASE_ADDR 0x101B0000
#define QUADRANT_1_CLUSTER_3_TCDM_BASE_ADDR 0x101C0000
#define QUADRANT_1_CLUSTER_3_PERIPH_BASE_ADDR 0x101E0000
#define QUADRANT_1_CLUSTER_3_ZERO_MEM_BASE_ADDR 0x101F0000
#define QUAD_1_CFG_BASE_ADDR 0x0B010000
#define QUADRANT_2_CLUSTER_0_TCDM_BASE_ADDR 0x10200000
#define QUADRANT_2_CLUSTER_0_PERIPH_BASE_ADDR 0x10220000
#define QUADRANT_2_CLUSTER_0_ZERO_MEM_BASE_ADDR 0x10230000
#define QUADRANT_2_CLUSTER_1_TCDM_BASE_ADDR 0x10240000
#define QUADRANT_2_CLUSTER_1_PERIPH_BASE_ADDR 0x10260000
#define QUADRANT_2_CLUSTER_1_ZERO_MEM_BASE_ADDR 0x10270000
#define QUADRANT_2_CLUSTER_2_TCDM_BASE_ADDR 0x10280000
#define QUADRANT_2_CLUSTER_2_PERIPH_BASE_ADDR 0x102A0000
#define QUADRANT_2_CLUSTER_2_ZERO_MEM_BASE_ADDR 0x102B0000
#define QUADRANT_2_CLUSTER_3_TCDM_BASE_ADDR 0x102C0000
#define QUADRANT_2_CLUSTER_3_PERIPH_BASE_ADDR 0x102E0000
#define QUADRANT_2_CLUSTER_3_ZERO_MEM_BASE_ADDR 0x102F0000
#define QUAD_2_CFG_BASE_ADDR 0x0B020000
#define QUADRANT_3_CLUSTER_0_TCDM_BASE_ADDR 0x10300000
#define QUADRANT_3_CLUSTER_0_PERIPH_BASE_ADDR 0x10320000
#define QUADRANT_3_CLUSTER_0_ZERO_MEM_BASE_ADDR 0x10330000
#define QUADRANT_3_CLUSTER_1_TCDM_BASE_ADDR 0x10340000
#define QUADRANT_3_CLUSTER_1_PERIPH_BASE_ADDR 0x10360000
#define QUADRANT_3_CLUSTER_1_ZERO_MEM_BASE_ADDR 0x10370000
#define QUADRANT_3_CLUSTER_2_TCDM_BASE_ADDR 0x10380000
#define QUADRANT_3_CLUSTER_2_PERIPH_BASE_ADDR 0x103A0000
#define QUADRANT_3_CLUSTER_2_ZERO_MEM_BASE_ADDR 0x103B0000
#define QUADRANT_3_CLUSTER_3_TCDM_BASE_ADDR 0x103C0000
#define QUADRANT_3_CLUSTER_3_PERIPH_BASE_ADDR 0x103E0000
#define QUADRANT_3_CLUSTER_3_ZERO_MEM_BASE_ADDR 0x103F0000
#define QUAD_3_CFG_BASE_ADDR 0x0B030000
#define QUADRANT_4_CLUSTER_0_TCDM_BASE_ADDR 0x10400000
#define QUADRANT_4_CLUSTER_0_PERIPH_BASE_ADDR 0x10420000
#define QUADRANT_4_CLUSTER_0_ZERO_MEM_BASE_ADDR 0x10430000
#define QUADRANT_4_CLUSTER_1_TCDM_BASE_ADDR 0x10440000
#define QUADRANT_4_CLUSTER_1_PERIPH_BASE_ADDR 0x10460000
#define QUADRANT_4_CLUSTER_1_ZERO_MEM_BASE_ADDR 0x10470000
#define QUADRANT_4_CLUSTER_2_TCDM_BASE_ADDR 0x10480000
#define QUADRANT_4_CLUSTER_2_PERIPH_BASE_ADDR 0x104A0000
#define QUADRANT_4_CLUSTER_2_ZERO_MEM_BASE_ADDR 0x104B0000
#define QUADRANT_4_CLUSTER_3_TCDM_BASE_ADDR 0x104C0000
#define QUADRANT_4_CLUSTER_3_PERIPH_BASE_ADDR 0x104E0000
#define QUADRANT_4_CLUSTER_3_ZERO_MEM_BASE_ADDR 0x104F0000
#define QUAD_4_CFG_BASE_ADDR 0x0B040000
#define QUADRANT_5_CLUSTER_0_TCDM_BASE_ADDR 0x10500000
#define QUADRANT_5_CLUSTER_0_PERIPH_BASE_ADDR 0x10520000
#define QUADRANT_5_CLUSTER_0_ZERO_MEM_BASE_ADDR 0x10530000
#define QUADRANT_5_CLUSTER_1_TCDM_BASE_ADDR 0x10540000
#define QUADRANT_5_CLUSTER_1_PERIPH_BASE_ADDR 0x10560000
#define QUADRANT_5_CLUSTER_1_ZERO_MEM_BASE_ADDR 0x10570000
#define QUADRANT_5_CLUSTER_2_TCDM_BASE_ADDR 0x10580000
#define QUADRANT_5_CLUSTER_2_PERIPH_BASE_ADDR 0x105A0000
#define QUADRANT_5_CLUSTER_2_ZERO_MEM_BASE_ADDR 0x105B0000
#define QUADRANT_5_CLUSTER_3_TCDM_BASE_ADDR 0x105C0000
#define QUADRANT_5_CLUSTER_3_PERIPH_BASE_ADDR 0x105E0000
#define QUADRANT_5_CLUSTER_3_ZERO_MEM_BASE_ADDR 0x105F0000
#define QUAD_5_CFG_BASE_ADDR 0x0B050000
#define HBM_CFG_TOP_BASE_ADDR 0x08000000
#define HBM_CFG_PHY_BASE_ADDR 0x09000000
#define HBM_CFG_SEQ_BASE_ADDR 0x0A000000
#define HBM_CFG_CTRL_BASE_ADDR 0x0A800000
