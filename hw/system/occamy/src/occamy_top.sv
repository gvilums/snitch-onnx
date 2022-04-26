// Copyright 2020 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>
// Author: Fabian Schuiki <fschuiki@iis.ee.ethz.ch>
//
// AUTOMATICALLY GENERATED by genoccamy.py; edit the script instead.

`include "common_cells/registers.svh"

module occamy_top
  import occamy_pkg::*;
(
    input  logic             clk_i,
    input  logic             rst_ni,
    /// Peripheral clock
    input  logic             clk_periph_i,
    input  logic             rst_periph_ni,
    /// Real-time clock (for time keeping)
    input  logic             rtc_i,
    input  logic             test_mode_i,
    input  logic [ 1:0]      chip_id_i,
    input  logic [ 1:0]      boot_mode_i,
    // pad cfg
    output logic [31:0]      pad_slw_o,
    output logic [31:0]      pad_smt_o,
    output logic [31:0][1:0] pad_drv_o,
    // `uart` Interface
    output logic             uart_tx_o,
    input  logic             uart_rx_i,
    // `gpio` Interface
    input  logic [31:0]      gpio_d_i,
    output logic [31:0]      gpio_d_o,
    output logic [31:0]      gpio_oe_o,
    output logic [31:0]      gpio_puen_o,
    output logic [31:0]      gpio_pden_o,
    // `jtag` Interface
    input  logic             jtag_trst_ni,
    input  logic             jtag_tck_i,
    input  logic             jtag_tms_i,
    input  logic             jtag_tdi_i,
    output logic             jtag_tdo_o,
    // `i2c` Interface
    output logic             i2c_sda_o,
    input  logic             i2c_sda_i,
    output logic             i2c_sda_en_o,
    output logic             i2c_scl_o,
    input  logic             i2c_scl_i,
    output logic             i2c_scl_en_o,
    // `SPI Host` Interface
    output logic             spim_sck_o,
    output logic             spim_sck_en_o,
    output logic [ 1:0]      spim_csb_o,
    output logic [ 1:0]      spim_csb_en_o,
    output logic [ 3:0]      spim_sd_o,
    output logic [ 3:0]      spim_sd_en_o,
    input        [ 3:0]      spim_sd_i,

    /// Boot ROM
    output reg_a48_d32_req_t bootrom_req_o,
    input  reg_a48_d32_rsp_t bootrom_rsp_i,

    /// FLLs
    output reg_a48_d32_req_t fll_system_req_o,
    input  reg_a48_d32_rsp_t fll_system_rsp_i,
    output reg_a48_d32_req_t fll_periph_req_o,
    input  reg_a48_d32_rsp_t fll_periph_rsp_i,
    output reg_a48_d32_req_t fll_hbm2e_req_o,
    input  reg_a48_d32_rsp_t fll_hbm2e_rsp_i,

    /// HBI Config and APB Control
    output reg_a48_d32_req_t hbi_wide_cfg_req_o,
    input reg_a48_d32_rsp_t hbi_wide_cfg_rsp_i,
    output reg_a48_d32_req_t hbi_narrow_cfg_req_o,
    input reg_a48_d32_rsp_t hbi_narrow_cfg_rsp_i,
    /// HBM Config
    output reg_a48_d32_req_t hbm_cfg_req_o,
    input reg_a48_d32_rsp_t hbm_cfg_rsp_i,
    /// PCIe/DDR Config
    output reg_a48_d32_req_t pcie_cfg_req_o,
    input reg_a48_d32_rsp_t pcie_cfg_rsp_i,
    /// Chip specific control registers
    output reg_a48_d32_req_t chip_ctrl_req_o,
    input reg_a48_d32_rsp_t chip_ctrl_rsp_i,
    // "external interrupts from uncore - "programmable"
    input logic [11:0] ext_irq_i,

    /// HBM2e Ports
    output axi_a48_d512_i7_u0_req_t  hbm_0_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_0_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_1_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_1_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_2_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_2_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_3_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_3_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_4_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_4_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_5_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_5_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_6_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_6_rsp_i,
    output axi_a48_d512_i7_u0_req_t  hbm_7_req_o,
    input  axi_a48_d512_i7_u0_resp_t hbm_7_rsp_i,

    /// HBI Ports
    input  axi_a48_d512_i4_u0_req_t  hbi_wide_req_i,
    output axi_a48_d512_i4_u0_resp_t hbi_wide_rsp_o,
    output axi_a48_d512_i6_u0_req_t  hbi_wide_req_o,
    input  axi_a48_d512_i6_u0_resp_t hbi_wide_rsp_i,

    input  axi_a48_d64_i4_u0_req_t  hbi_narrow_req_i,
    output axi_a48_d64_i4_u0_resp_t hbi_narrow_rsp_o,
    output axi_a48_d64_i8_u0_req_t  hbi_narrow_req_o,
    input  axi_a48_d64_i8_u0_resp_t hbi_narrow_rsp_i,

    /// PCIe Ports
    output axi_a48_d64_i8_u0_req_t  pcie_axi_req_o,
    input  axi_a48_d64_i8_u0_resp_t pcie_axi_rsp_i,

    input  axi_a48_d64_i4_u0_req_t  pcie_axi_req_i,
    output axi_a48_d64_i4_u0_resp_t pcie_axi_rsp_o,


    /// SRAM configuration
    input sram_cfgs_t sram_cfgs_i
);

  occamy_soc_reg_pkg::occamy_soc_reg2hw_t soc_ctrl_out;
  occamy_soc_reg_pkg::occamy_soc_hw2reg_t soc_ctrl_in;
  logic [1:0] spm_narrow_rerror;
  logic [1:0] spm_wide_rerror;

  always_comb begin
    soc_ctrl_in = '0;
    soc_ctrl_in.boot_mode.d = boot_mode_i;
    soc_ctrl_in.chip_id.d = chip_id_i;
  end

  // Machine timer and machine software interrupt pending.
  logic [216:0] mtip, msip;
  // Supervisor and machine-mode external interrupt pending.
  logic [1:0] eip;
  logic [0:0] debug_req;
  occamy_interrupt_t irq;

  assign irq.ext_irq = ext_irq_i;

  //////////////////////////
  //   Peripheral Xbars   //
  //////////////////////////


  /// Address map of the `soc_axi_lite_periph_xbar` crossbar.
  xbar_rule_48_t [1:0] SocAxiLitePeriphXbarAddrmap;
  assign SocAxiLitePeriphXbarAddrmap = '{
  '{ idx: 0, start_addr: 48'h01000000, end_addr: 48'h20000000000 },
  '{ idx: 1, start_addr: 48'h00000000, end_addr: 48'h00001000 }
};

  axi_lite_a48_d64_req_t [1:0] soc_axi_lite_periph_xbar_in_req;
  axi_lite_a48_d64_rsp_t [1:0] soc_axi_lite_periph_xbar_in_rsp;
  axi_lite_a48_d64_req_t [1:0] soc_axi_lite_periph_xbar_out_req;
  axi_lite_a48_d64_rsp_t [1:0] soc_axi_lite_periph_xbar_out_rsp;

  // The `soc_axi_lite_periph_xbar` crossbar.
  axi_lite_xbar #(
      .Cfg       (SocAxiLitePeriphXbarCfg),
      .aw_chan_t (axi_lite_a48_d64_aw_chan_t),
      .w_chan_t  (axi_lite_a48_d64_w_chan_t),
      .b_chan_t  (axi_lite_a48_d64_b_chan_t),
      .ar_chan_t (axi_lite_a48_d64_ar_chan_t),
      .r_chan_t  (axi_lite_a48_d64_r_chan_t),
      .axi_req_t (axi_lite_a48_d64_req_t),
      .axi_resp_t(axi_lite_a48_d64_rsp_t),
      .rule_t    (xbar_rule_48_t)
  ) i_soc_axi_lite_periph_xbar (
      .clk_i                (clk_periph_i),
      .rst_ni               (rst_periph_ni),
      .test_i               (test_mode_i),
      .slv_ports_req_i      (soc_axi_lite_periph_xbar_in_req),
      .slv_ports_resp_o     (soc_axi_lite_periph_xbar_in_rsp),
      .mst_ports_req_o      (soc_axi_lite_periph_xbar_out_req),
      .mst_ports_resp_i     (soc_axi_lite_periph_xbar_out_rsp),
      .addr_map_i           (SocAxiLitePeriphXbarAddrmap),
      .en_default_mst_port_i('1),
      .default_mst_port_i   ('0)
  );

  reg_a48_d32_req_t [0:0] soc_regbus_periph_xbar_in_req;
  reg_a48_d32_rsp_t [0:0] soc_regbus_periph_xbar_in_rsp;
  reg_a48_d32_req_t [17:0] soc_regbus_periph_xbar_out_req;
  reg_a48_d32_rsp_t [17:0] soc_regbus_periph_xbar_out_rsp;

  logic [cf_math_pkg::idx_width(
SOC_REGBUS_PERIPH_XBAR_NUM_OUTPUTS
)-1:0] soc_regbus_periph_xbar_select;

  // The `soc_regbus_periph_xbar` crossbar.
  reg_demux #(
      .NoPorts(SOC_REGBUS_PERIPH_XBAR_NUM_OUTPUTS),
      .req_t  (reg_a48_d32_req_t),
      .rsp_t  (reg_a48_d32_rsp_t)
  ) i_soc_regbus_periph_xbar (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .in_select_i(soc_regbus_periph_xbar_select),
      .in_req_i(soc_regbus_periph_xbar_in_req),
      .in_rsp_o(soc_regbus_periph_xbar_in_rsp),
      .out_req_o(soc_regbus_periph_xbar_out_req),
      .out_rsp_i(soc_regbus_periph_xbar_out_rsp)
  );

  addr_decode #(
      .NoIndices(SOC_REGBUS_PERIPH_XBAR_NUM_OUTPUTS),
      .NoRules(18),
      .addr_t(logic [47:0]),
      .rule_t(xbar_rule_48_t)
  ) i_addr_decode_soc_regbus_periph_xbar (
      .addr_i(soc_regbus_periph_xbar_in_req[0].addr),
      .addr_map_i(SocRegbusPeriphXbarAddrmap),
      .idx_o(soc_regbus_periph_xbar_select),
      .dec_valid_o(),
      .dec_error_o(),
      .en_default_idx_i('0),
      .default_idx_i('0)
  );


  //////////////////////////
  //   HBM XBAR CFG       //
  //////////////////////////

  reg_a48_d32_req_t reg_hbm_xbar_cfg_req;
  reg_a48_d32_rsp_t reg_hbm_xbar_cfg_rsp;

  occamy_hbm_xbar_reg_pkg::occamy_hbm_xbar_reg2hw_t hbm_xbar_reg2hw;

  reg_cdc #(
      .req_t(reg_a48_d32_req_t),
      .rsp_t(reg_a48_d32_rsp_t)
  ) i_reg_cdc_hbm_xbar_cfg (
      .src_clk_i (clk_periph_i),
      .src_rst_ni(rst_periph_ni),
      .src_req_i (soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_HBM_XBAR_CFG]),
      .src_rsp_o (soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_HBM_XBAR_CFG]),

      .dst_clk_i (clk_i),
      .dst_rst_ni(rst_ni),
      .dst_req_o (reg_hbm_xbar_cfg_req),
      .dst_rsp_i (reg_hbm_xbar_cfg_rsp)
  );

  occamy_hbm_xbar_reg_top #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_occamy_hbm_xbar_reg_top (
      .clk_i    (clk_i),
      .rst_ni   (rst_ni),
      .reg_req_i(reg_hbm_xbar_cfg_req),
      .reg_rsp_o(reg_hbm_xbar_cfg_rsp),
      .reg2hw   (hbm_xbar_reg2hw),
`ifndef SYNTHESIS
      .devmode_i(1'b1)
`else
      .devmode_i(1'b0)
`endif
  );

  ///////////////////////////////
  //   Synchronous top level   //
  ///////////////////////////////

  // Peripheral Xbar connections
  axi_a48_d64_i8_u0_req_t  periph_axi_lite_soc2per_req;
  axi_a48_d64_i8_u0_resp_t periph_axi_lite_soc2per_rsp;

  axi_a48_d64_i4_u0_req_t  periph_axi_lite_per2soc_req;
  axi_a48_d64_i4_u0_resp_t periph_axi_lite_per2soc_rsp;

  axi_a48_d64_i8_u0_req_t  periph_regbus_soc2per_req;
  axi_a48_d64_i8_u0_resp_t periph_regbus_soc2per_rsp;

  occamy_soc i_occamy_soc (
      .clk_i,
      .rst_ni,
      .test_mode_i,
      .hbm_0_req_o,
      .hbm_0_rsp_i,
      .hbm_1_req_o,
      .hbm_1_rsp_i,
      .hbm_2_req_o,
      .hbm_2_rsp_i,
      .hbm_3_req_o,
      .hbm_3_rsp_i,
      .hbm_4_req_o,
      .hbm_4_rsp_i,
      .hbm_5_req_o,
      .hbm_5_rsp_i,
      .hbm_6_req_o,
      .hbm_6_rsp_i,
      .hbm_7_req_o,
      .hbm_7_rsp_i,
      .hbi_wide_req_i,
      .hbi_wide_rsp_o,
      .hbi_wide_req_o,
      .hbi_wide_rsp_i,
      .hbi_narrow_req_i,
      .hbi_narrow_rsp_o,
      .hbi_narrow_req_o,
      .hbi_narrow_rsp_i,
      .pcie_axi_req_o,
      .pcie_axi_rsp_i,
      .pcie_axi_req_i,
      .pcie_axi_rsp_o,
      .periph_axi_lite_req_o(periph_axi_lite_soc2per_req),
      .periph_axi_lite_rsp_i(periph_axi_lite_soc2per_rsp),
      .periph_axi_lite_req_i(periph_axi_lite_per2soc_req),
      .periph_axi_lite_rsp_o(periph_axi_lite_per2soc_rsp),
      .periph_regbus_req_o(periph_regbus_soc2per_req),
      .periph_regbus_rsp_i(periph_regbus_soc2per_rsp),
      .spm_narrow_rerror_o(spm_narrow_rerror),
      .spm_wide_rerror_o(spm_wide_rerror),
      .mtip_i(mtip),
      .msip_i(msip),
      .eip_i(eip),
      .debug_req_i(debug_req),
      .sram_cfgs_i,
      .hbm_xbar_interleaved_mode_ena_i(hbm_xbar_reg2hw.interleaved_ena.q)
  );

  // Connect AXI-lite master
  axi_a48_d64_i8_u0_req_t  axi_lite_from_soc_cdc_req;
  axi_a48_d64_i8_u0_resp_t axi_lite_from_soc_cdc_rsp;

  axi_cdc #(
      .aw_chan_t (axi_a48_d64_i8_u0_aw_chan_t),
      .w_chan_t  (axi_a48_d64_i8_u0_w_chan_t),
      .b_chan_t  (axi_a48_d64_i8_u0_b_chan_t),
      .ar_chan_t (axi_a48_d64_i8_u0_ar_chan_t),
      .r_chan_t  (axi_a48_d64_i8_u0_r_chan_t),
      .axi_req_t (axi_a48_d64_i8_u0_req_t),
      .axi_resp_t(axi_a48_d64_i8_u0_resp_t),
      .LogDepth  (2)
  ) i_axi_lite_from_soc_cdc (
      .src_clk_i (clk_i),
      .src_rst_ni(rst_ni),
      .src_req_i (periph_axi_lite_soc2per_req),
      .src_resp_o(periph_axi_lite_soc2per_rsp),
      .dst_clk_i (clk_periph_i),
      .dst_rst_ni(rst_periph_ni),
      .dst_req_o (axi_lite_from_soc_cdc_req),
      .dst_resp_i(axi_lite_from_soc_cdc_rsp)
  );

  axi_to_axi_lite #(
      .AxiAddrWidth(48),
      .AxiDataWidth(64),
      .AxiIdWidth(8),
      .AxiUserWidth(1),
      .AxiMaxWriteTxns(4),
      .AxiMaxReadTxns(4),
      .FallThrough(0),
      .full_req_t(axi_a48_d64_i8_u0_req_t),
      .full_resp_t(axi_a48_d64_i8_u0_resp_t),
      .lite_req_t(axi_lite_a48_d64_req_t),
      .lite_resp_t(axi_lite_a48_d64_rsp_t)
  ) i_axi_to_axi_lite_periph_pc (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .test_i(test_mode_i),
      .slv_req_i(axi_lite_from_soc_cdc_req),
      .slv_resp_o(axi_lite_from_soc_cdc_rsp),
      .mst_req_o(soc_axi_lite_periph_xbar_in_req[SOC_AXI_LITE_PERIPH_XBAR_IN_SOC]),
      .mst_resp_i(soc_axi_lite_periph_xbar_in_rsp[SOC_AXI_LITE_PERIPH_XBAR_IN_SOC])
  );

  // Connect AXI-lite slave
  axi_lite_a48_d64_req_t axi_lite_to_soc_cdc_req;
  axi_lite_a48_d64_rsp_t axi_lite_to_soc_cdc_rsp;

  axi_cdc #(
      .aw_chan_t (axi_lite_a48_d64_aw_chan_t),
      .w_chan_t  (axi_lite_a48_d64_w_chan_t),
      .b_chan_t  (axi_lite_a48_d64_b_chan_t),
      .ar_chan_t (axi_lite_a48_d64_ar_chan_t),
      .r_chan_t  (axi_lite_a48_d64_r_chan_t),
      .axi_req_t (axi_lite_a48_d64_req_t),
      .axi_resp_t(axi_lite_a48_d64_rsp_t),
      .LogDepth  (2)
  ) i_axi_lite_to_soc_cdc (
      .src_clk_i (clk_periph_i),
      .src_rst_ni(rst_periph_ni),
      .src_req_i (soc_axi_lite_periph_xbar_out_req[SOC_AXI_LITE_PERIPH_XBAR_OUT_SOC]),
      .src_resp_o(soc_axi_lite_periph_xbar_out_rsp[SOC_AXI_LITE_PERIPH_XBAR_OUT_SOC]),
      .dst_clk_i (clk_i),
      .dst_rst_ni(rst_ni),
      .dst_req_o (axi_lite_to_soc_cdc_req),
      .dst_resp_i(axi_lite_to_soc_cdc_rsp)
  );

  axi_lite_to_axi #(
      .AxiDataWidth(64),
      .req_lite_t  (axi_lite_a48_d64_req_t),
      .resp_lite_t (axi_lite_a48_d64_rsp_t),
      .axi_req_t   (axi_a48_d64_i4_u0_req_t),
      .axi_resp_t  (axi_a48_d64_i4_u0_resp_t)
  ) i_axi_lite_to_axi_periph_pc (
      .slv_req_lite_i (axi_lite_to_soc_cdc_req),
      .slv_resp_lite_o(axi_lite_to_soc_cdc_rsp),
      .slv_aw_cache_i (axi_pkg::CACHE_MODIFIABLE),
      .slv_ar_cache_i (axi_pkg::CACHE_MODIFIABLE),
      .mst_req_o      (periph_axi_lite_per2soc_req),
      .mst_resp_i     (periph_axi_lite_per2soc_rsp)
  );

  // Connect Regbus master
  axi_a48_d64_i8_u0_req_t  periph_cdc_req;
  axi_a48_d64_i8_u0_resp_t periph_cdc_rsp;

  axi_cdc #(
      .aw_chan_t (axi_a48_d64_i8_u0_aw_chan_t),
      .w_chan_t  (axi_a48_d64_i8_u0_w_chan_t),
      .b_chan_t  (axi_a48_d64_i8_u0_b_chan_t),
      .ar_chan_t (axi_a48_d64_i8_u0_ar_chan_t),
      .r_chan_t  (axi_a48_d64_i8_u0_r_chan_t),
      .axi_req_t (axi_a48_d64_i8_u0_req_t),
      .axi_resp_t(axi_a48_d64_i8_u0_resp_t),
      .LogDepth  (2)
  ) i_periph_cdc (
      .src_clk_i (clk_i),
      .src_rst_ni(rst_ni),
      .src_req_i (periph_regbus_soc2per_req),
      .src_resp_o(periph_regbus_soc2per_rsp),
      .dst_clk_i (clk_periph_i),
      .dst_rst_ni(rst_periph_ni),
      .dst_req_o (periph_cdc_req),
      .dst_resp_i(periph_cdc_rsp)
  );

  axi_a48_d32_i8_u0_req_t  axi_to_axi_lite_dw_req;
  axi_a48_d32_i8_u0_resp_t axi_to_axi_lite_dw_rsp;

  axi_dw_converter #(
      .AxiSlvPortDataWidth(64),
      .AxiMstPortDataWidth(32),
      .AxiAddrWidth(48),
      .AxiIdWidth(8),
      .aw_chan_t(axi_a48_d32_i8_u0_aw_chan_t),
      .mst_w_chan_t(axi_a48_d32_i8_u0_w_chan_t),
      .slv_w_chan_t(axi_a48_d64_i8_u0_w_chan_t),
      .b_chan_t(axi_a48_d32_i8_u0_b_chan_t),
      .ar_chan_t(axi_a48_d32_i8_u0_ar_chan_t),
      .mst_r_chan_t(axi_a48_d32_i8_u0_r_chan_t),
      .slv_r_chan_t(axi_a48_d64_i8_u0_r_chan_t),
      .axi_mst_req_t(axi_a48_d32_i8_u0_req_t),
      .axi_mst_resp_t(axi_a48_d32_i8_u0_resp_t),
      .axi_slv_req_t(axi_a48_d64_i8_u0_req_t),
      .axi_slv_resp_t(axi_a48_d64_i8_u0_resp_t)
  ) i_axi_to_axi_lite_dw (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .slv_req_i(periph_cdc_req),
      .slv_resp_o(periph_cdc_rsp),
      .mst_req_o(axi_to_axi_lite_dw_req),
      .mst_resp_i(axi_to_axi_lite_dw_rsp)
  );

  axi_lite_a48_d32_req_t axi_to_axi_lite_regbus_periph_req;
  axi_lite_a48_d32_rsp_t axi_to_axi_lite_regbus_periph_rsp;

  axi_to_axi_lite #(
      .AxiAddrWidth(48),
      .AxiDataWidth(32),
      .AxiIdWidth(8),
      .AxiUserWidth(1),
      .AxiMaxWriteTxns(4),
      .AxiMaxReadTxns(4),
      .FallThrough(0),
      .full_req_t(axi_a48_d32_i8_u0_req_t),
      .full_resp_t(axi_a48_d32_i8_u0_resp_t),
      .lite_req_t(axi_lite_a48_d32_req_t),
      .lite_resp_t(axi_lite_a48_d32_rsp_t)
  ) i_axi_to_axi_lite_regbus_periph_pc (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .test_i(test_mode_i),
      .slv_req_i(axi_to_axi_lite_dw_req),
      .slv_resp_o(axi_to_axi_lite_dw_rsp),
      .mst_req_o(axi_to_axi_lite_regbus_periph_req),
      .mst_resp_i(axi_to_axi_lite_regbus_periph_rsp)
  );

  axi_lite_to_reg #(
      .ADDR_WIDTH    (48),
      .DATA_WIDTH    (32),
      .axi_lite_req_t(axi_lite_a48_d32_req_t),
      .axi_lite_rsp_t(axi_lite_a48_d32_rsp_t),
      .reg_req_t     (reg_a48_d32_req_t),
      .reg_rsp_t     (reg_a48_d32_rsp_t)
  ) i_axi_lite_to_regbus_periph_pc (
      .clk_i         (clk_periph_i),
      .rst_ni        (rst_periph_ni),
      .axi_lite_req_i(axi_to_axi_lite_regbus_periph_req),
      .axi_lite_rsp_o(axi_to_axi_lite_regbus_periph_rsp),
      .reg_req_o     (soc_regbus_periph_xbar_in_req[SOC_REGBUS_PERIPH_XBAR_IN_SOC]),
      .reg_rsp_i     (soc_regbus_periph_xbar_in_rsp[SOC_REGBUS_PERIPH_XBAR_IN_SOC])
  );


  /////////////////////////////
  // HBI & HBM & PCIE Config //
  /////////////////////////////

  // RegBus port for HBI
  assign hbi_wide_cfg_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_HBI_WIDE_CFG];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_HBI_WIDE_CFG] = hbi_wide_cfg_rsp_i;
  assign hbi_narrow_cfg_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_HBI_NARROW_CFG];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_HBI_NARROW_CFG] = hbi_narrow_cfg_rsp_i;

  // RegBus port for PCIE
  assign pcie_cfg_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_PCIE_CFG];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_PCIE_CFG] = pcie_cfg_rsp_i;

  // APB port for HBM
  assign hbm_cfg_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_HBM_CFG];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_HBM_CFG] = hbm_cfg_rsp_i;

  ///////////
  // Debug //
  ///////////
  reg_a48_d64_req_t axi_lite_to_reg_debug_req;
  reg_a48_d64_rsp_t axi_lite_to_reg_debug_rsp;

  axi_lite_to_reg #(
      .ADDR_WIDTH    (48),
      .DATA_WIDTH    (64),
      .axi_lite_req_t(axi_lite_a48_d64_req_t),
      .axi_lite_rsp_t(axi_lite_a48_d64_rsp_t),
      .reg_req_t     (reg_a48_d64_req_t),
      .reg_rsp_t     (reg_a48_d64_rsp_t)
  ) i_axi_lite_to_reg_debug_pc (
      .clk_i         (clk_periph_i),
      .rst_ni        (rst_periph_ni),
      .axi_lite_req_i(soc_axi_lite_periph_xbar_out_req[SOC_AXI_LITE_PERIPH_XBAR_OUT_DEBUG]),
      .axi_lite_rsp_o(soc_axi_lite_periph_xbar_out_rsp[SOC_AXI_LITE_PERIPH_XBAR_OUT_DEBUG]),
      .reg_req_o     (axi_lite_to_reg_debug_req),
      .reg_rsp_i     (axi_lite_to_reg_debug_rsp)
  );


  dm::hartinfo_t [0:0] hartinfo;
  assign hartinfo[0] = ariane_pkg::DebugHartInfo;

  logic                 dmi_rst_n;
  dm::dmi_req_t         dmi_req;
  logic                 dmi_req_valid;
  logic                 dmi_req_ready;
  dm::dmi_resp_t        dmi_resp;
  logic                 dmi_resp_ready;
  logic                 dmi_resp_valid;

  logic                 dbg_req;
  logic                 dbg_we;
  logic          [47:0] dbg_addr;
  logic          [63:0] dbg_wdata;
  logic          [ 7:0] dbg_wstrb;
  logic          [63:0] dbg_rdata;
  logic                 dbg_rvalid;

  reg_to_mem #(
      .AW(48),
      .DW(64),
      .req_t(reg_a48_d64_req_t),
      .rsp_t(reg_a48_d64_rsp_t)
  ) i_reg_to_mem_dbg (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .reg_req_i(axi_lite_to_reg_debug_req),
      .reg_rsp_o(axi_lite_to_reg_debug_rsp),
      .req_o(dbg_req),
      .gnt_i(dbg_req),
      .we_o(dbg_we),
      .addr_o(dbg_addr),
      .wdata_o(dbg_wdata),
      .wstrb_o(dbg_wstrb),
      .rdata_i(dbg_rdata),
      .rvalid_i(dbg_rvalid),
      .rerror_i(1'b0)
  );

  `FFARN(dbg_rvalid, dbg_req, 1'b0, clk_periph_i, rst_periph_ni)

  logic        sba_req;
  logic [47:0] sba_addr;
  logic        sba_we;
  logic [63:0] sba_wdata;
  logic [ 7:0] sba_strb;
  logic        sba_gnt;

  logic [63:0] sba_rdata;
  logic        sba_rvalid;
  logic        sba_err;

  logic [63:0] sba_addr_long;

  dm_top #(
      // .NrHarts (217),
      .NrHarts(1),
      .BusWidth(64),
      .DmBaseAddress('h0)
  ) i_dm_top (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .testmode_i(1'b0),
      .ndmreset_o(),
      .dmactive_o(),
      .debug_req_o(debug_req),
      .unavailable_i('0),
      .hartinfo_i(hartinfo),
      .slave_req_i(dbg_req),
      .slave_we_i(dbg_we),
      .slave_addr_i({16'b0, dbg_addr}),
      .slave_be_i(dbg_wstrb),
      .slave_wdata_i(dbg_wdata),
      .slave_rdata_o(dbg_rdata),
      .master_req_o(sba_req),
      .master_add_o(sba_addr_long),
      .master_we_o(sba_we),
      .master_wdata_o(sba_wdata),
      .master_be_o(sba_strb),
      .master_gnt_i(sba_gnt),
      .master_r_valid_i(sba_rvalid),
      .master_r_rdata_i(sba_rdata),
      .master_r_err_i(sba_err),
      .master_r_other_err_i(1'b0),
      .dmi_rst_ni(dmi_rst_n),
      .dmi_req_valid_i(dmi_req_valid),
      .dmi_req_ready_o(dmi_req_ready),
      .dmi_req_i(dmi_req),
      .dmi_resp_valid_o(dmi_resp_valid),
      .dmi_resp_ready_i(dmi_resp_ready),
      .dmi_resp_o(dmi_resp)
  );

  assign sba_addr = sba_addr_long[47:0];

  mem_to_axi_lite #(
      .MemAddrWidth(48),
      .AxiAddrWidth(48),
      .DataWidth(64),
      .MaxRequests(2),
      .AxiProt('0),
      .axi_req_t(axi_lite_a48_d64_req_t),
      .axi_rsp_t(axi_lite_a48_d64_rsp_t)
  ) i_mem_to_axi_lite (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .mem_req_i(sba_req),
      .mem_addr_i(sba_addr),
      .mem_we_i(sba_we),
      .mem_wdata_i(sba_wdata),
      .mem_be_i(sba_strb),
      .mem_gnt_o(sba_gnt),
      .mem_rsp_valid_o(sba_rvalid),
      .mem_rsp_rdata_o(sba_rdata),
      .mem_rsp_error_o(sba_err),
      .axi_req_o(soc_axi_lite_periph_xbar_in_req[SOC_AXI_LITE_PERIPH_XBAR_IN_DEBUG]),
      .axi_rsp_i(soc_axi_lite_periph_xbar_in_rsp[SOC_AXI_LITE_PERIPH_XBAR_IN_DEBUG])

  );

  dmi_jtag #(
      .IdcodeValue(occamy_pkg::IDCode)
  ) i_dmi_jtag (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .testmode_i(1'b0),
      .dmi_rst_no(dmi_rst_n),
      .dmi_req_o(dmi_req),
      .dmi_req_valid_o(dmi_req_valid),
      .dmi_req_ready_i(dmi_req_ready),
      .dmi_resp_i(dmi_resp),
      .dmi_resp_ready_o(dmi_resp_ready),
      .dmi_resp_valid_i(dmi_resp_valid),
      .tck_i(jtag_tck_i),
      .tms_i(jtag_tms_i),
      .trst_ni(jtag_trst_ni),
      .td_i(jtag_tdi_i),
      .td_o(jtag_tdo_o),
      .tdo_oe_o()
  );


  ///////////////
  //   CLINT   //
  ///////////////
  clint #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_clint (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .testmode_i(1'b0),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_CLINT]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_CLINT]),
      .rtc_i(rtc_i),
      .timer_irq_o(mtip),
      .ipi_o(msip)
  );

  /////////////////////
  //   SOC CONTROL   //
  /////////////////////
  occamy_soc_ctrl #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_soc_ctrl (
      .clk_i(clk_i),
      .rst_ni(rst_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_SOC_CTRL]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_SOC_CTRL]),
      .reg2hw_o(soc_ctrl_out),
      .hw2reg_i(soc_ctrl_in),
      .event_ecc_rerror_narrow_i(spm_narrow_rerror),
      .event_ecc_rerror_wide_i(spm_wide_rerror),
      .intr_ecc_narrow_uncorrectable_o(irq.ecc_narrow_uncorrectable),
      .intr_ecc_narrow_correctable_o(irq.ecc_narrow_correctable),
      .intr_ecc_wide_uncorrectable_o(irq.ecc_wide_uncorrectable),
      .intr_ecc_wide_correctable_o(irq.ecc_wide_correctable)
  );

  //////////////////////
  //   CHIP CONTROL   //
  //////////////////////
  // Contains NDA and chip specific information.
  assign chip_ctrl_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_CHIP_CTRL];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_CHIP_CTRL] = chip_ctrl_rsp_i;

  //////////////
  //   UART   //
  //////////////

  apb_a48_d32_req_t uart_apb_req;
  apb_a48_d32_rsp_t uart_apb_rsp;

  reg_to_apb #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t),
      .apb_req_t(apb_a48_d32_req_t),
      .apb_rsp_t(apb_a48_d32_rsp_t)
  ) i_uart_apb_pc (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_UART]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_UART]),
      .apb_req_o(uart_apb_req),
      .apb_rsp_i(uart_apb_rsp)
  );

  apb_uart_wrap #(
      .apb_req_t(apb_a48_d32_req_t),
      .apb_rsp_t(apb_a48_d32_rsp_t)
  ) i_uart (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .apb_req_i(uart_apb_req),
      .apb_rsp_o(uart_apb_rsp),
      .intr_o(irq.uart),
      .out1_no(),  // keep open
      .out2_no(),  // keep open
      .rts_no(),  // no flow control
      .dtr_no(),  // no flow control
      .cts_ni(1'b0),  // no flow control
      .dsr_ni(1'b0),  // no flow control
      .dcd_ni(1'b0),  // no flow control
      .rin_ni(1'b0),
      .sin_i(uart_rx_i),
      .sout_o(uart_tx_o)
  );

  /////////////
  //   ROM   //
  /////////////

  // This is very system specific, so we might be better off
  // placing it outside the top-level.
  assign bootrom_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_BOOTROM];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_BOOTROM] = bootrom_rsp_i;

  /////////////////
  //   Clk Mgr   //
  /////////////////

  assign fll_system_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_FLL_SYSTEM];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_FLL_SYSTEM] = fll_system_rsp_i;
  assign fll_periph_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_FLL_PERIPH];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_FLL_PERIPH] = fll_periph_rsp_i;
  assign fll_hbm2e_req_o = soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_FLL_HBM2E];
  assign soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_FLL_HBM2E] = fll_hbm2e_rsp_i;

  //////////////
  //   PLIC   //
  //////////////
  rv_plic #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_rv_plic (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_PLIC]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_PLIC]),
      .intr_src_i(irq),
      .irq_o(eip),
      .irq_id_o(),
      .msip_o()
  );

  assign irq.zero = 1'b0;

  //////////////////
  //   SPI Host   //
  //////////////////
  spi_host #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_spi_host (
      // TODO(zarubaf): Fix clock assignment
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .clk_core_i(clk_periph_i),
      .rst_core_ni(rst_periph_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_SPIM]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_SPIM]),
      .cio_sck_o(spim_sck_o),
      .cio_sck_en_o(spim_sck_en_o),
      .cio_csb_o(spim_csb_o),
      .cio_csb_en_o(spim_csb_en_o),
      .cio_sd_o(spim_sd_o),
      .cio_sd_en_o(spim_sd_en_o),
      .cio_sd_i(spim_sd_i),
      .intr_error_o(irq.spim_error),
      .intr_spi_event_o(irq.spim_spi_event)
  );

  //////////////
  //   GPIO   //
  //////////////
  gpio #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_gpio (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_GPIO]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_GPIO]),
      .cio_gpio_i(gpio_d_i),
      .cio_gpio_o(gpio_d_o),
      .cio_gpio_en_o(gpio_oe_o),
      .intr_gpio_o(irq.gpio)
  );

  /////////////
  //   I2C   //
  /////////////
  i2c #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t)
  ) i_i2c (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_I2C]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_I2C]),
      .cio_scl_i(i2c_scl_i),
      .cio_scl_o(i2c_scl_o),
      .cio_scl_en_o(i2c_scl_en_o),
      .cio_sda_i(i2c_sda_i),
      .cio_sda_o(i2c_sda_o),
      .cio_sda_en_o(i2c_sda_en_o),
      .intr_fmt_watermark_o(irq.i2c_fmt_watermark),
      .intr_rx_watermark_o(irq.i2c_rx_watermark),
      .intr_fmt_overflow_o(irq.i2c_fmt_overflow),
      .intr_rx_overflow_o(irq.i2c_rx_overflow),
      .intr_nak_o(irq.i2c_nak),
      .intr_scl_interference_o(irq.i2c_scl_interference),
      .intr_sda_interference_o(irq.i2c_sda_interference),
      .intr_stretch_timeout_o(irq.i2c_stretch_timeout),
      .intr_sda_unstable_o(irq.i2c_sda_unstable),
      .intr_trans_complete_o(irq.i2c_trans_complete),
      .intr_tx_empty_o(irq.i2c_tx_empty),
      .intr_tx_nonempty_o(irq.i2c_tx_nonempty),
      .intr_tx_overflow_o(irq.i2c_tx_overflow),
      .intr_acq_overflow_o(irq.i2c_acq_overflow),
      .intr_ack_stop_o(irq.i2c_ack_stop),
      .intr_host_timeout_o(irq.i2c_host_timeout)
  );

  /////////////
  //  Timer  //
  /////////////
  apb_a48_d32_req_t apb_timer_req;
  apb_a48_d32_rsp_t apb_timer_rsp;

  reg_to_apb #(
      .reg_req_t(reg_a48_d32_req_t),
      .reg_rsp_t(reg_a48_d32_rsp_t),
      .apb_req_t(apb_a48_d32_req_t),
      .apb_rsp_t(apb_a48_d32_rsp_t)
  ) i_apb_timer_pc (
      .clk_i(clk_periph_i),
      .rst_ni(rst_periph_ni),
      .reg_req_i(soc_regbus_periph_xbar_out_req[SOC_REGBUS_PERIPH_XBAR_OUT_TIMER]),
      .reg_rsp_o(soc_regbus_periph_xbar_out_rsp[SOC_REGBUS_PERIPH_XBAR_OUT_TIMER]),
      .apb_req_o(apb_timer_req),
      .apb_rsp_i(apb_timer_rsp)
  );

  apb_timer #(
      .APB_ADDR_WIDTH(48),
      .TIMER_CNT(2)
  ) i_apb_timer (
      .HCLK(clk_periph_i),
      .HRESETn(rst_periph_ni),
      .PADDR(apb_timer_req.paddr),
      .PWDATA(apb_timer_req.pwdata),
      .PWRITE(apb_timer_req.pwrite),
      .PSEL(apb_timer_req.psel),
      .PENABLE(apb_timer_req.penable),
      .PRDATA(apb_timer_rsp.prdata),
      .PREADY(apb_timer_rsp.pready),
      .PSLVERR(apb_timer_rsp.pslverr),
      .irq_o(irq.timer)
  );

endmodule
