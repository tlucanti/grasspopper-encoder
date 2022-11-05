
`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
//
// Create Date: 19.06.2022 11:14:33
// Design Name: Grasspopper
// Module Name: grasspopper-module
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//
// Parameters:
//
// Dependencies: None
//
// Revision: v0.1
//   v0.1 - file Created
//
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////


module grasspopper_module(clk, reset, data_i, data_o, busy);

input               PCLK;
/*

*/

input               PRESETN;
/*

*/

input       [31:0]  PADDR;
/*

*/

input               PPROT;
/*

*/

input               PSELX;
/*

*/

input               PENABLE;
/*

*/

input               PWRITE;
/*

*/

input       [127:0] PWDATA;
/*

*/

input               PSTRB;
/*

*/

output              PREADY;
/*

*/

output      [127:0] PRDATA;
/*

*/

output              PSLVERR;
/*

*/

grasspopper gp (
    .clk        (PCLK),
    .reset      (~PRESETN),
    .data_i     (PWDATA),
    .data_o     (PRDATA),
    .busy       (PREADY)
);

endmodule

