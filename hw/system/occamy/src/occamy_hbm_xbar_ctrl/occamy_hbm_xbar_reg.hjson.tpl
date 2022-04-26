// Copyright 2020 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51
// Licensed under Solderpad Hardware License, Version 0.51, see LICENSE for details.
{
  name: "${name}_HBM_xbar"
  clock_primary: "clk_i"
  bus_interfaces: [
    { protocol: "reg_iface", direction: "device" }
  ],
  regwidth: 32
  registers: [
    { name: "INTERLEAVED_ENA"
      desc: "Interleaved mode of the x-bar is enabled."
      swaccess: "rw"
      hwaccess: "hro"
      fields: [
        {
          bits: "0:0"
          resval: "0"
          name: "INTERLEAVED_ENA"
          desc: '''
                Interleaved mode of the x-bar is enabled.
                '''
        }
      ]
    }
  ]
}
