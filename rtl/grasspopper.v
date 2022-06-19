`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
// 
// Create Date: 19.06.2022 19:21:15
// Design Name: Grasspopper
// Module Name: grasspopper
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//   sync module
//   module implements grasspopper encoding (State Standart of Russian
//   Federation 34.12-2015)
//
// Parameters:
//   rst   - reset signal
//   clk   - clock signal
//   ra1      - 5 bit address of first register to read
//   ra2   - 5 bit address of second register to read
//   wa    - 5 bit address for register to write
//   we    - flag that allows writing to register
//   rd1   - 32 bit return value that stores in register with address `ra1`
//   rd2   - 32 bit return value that stores in register with address `ra2`
//
// Dependencies: None
// 
// Revision: v1.0
//   v0.1 - file Created
//   v1.0 - done for stage-2
//
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module grasspopper();

input               clk;
/*

*/

input               reset;
/*

*/

input       [255:0]  data_i;
/*

*/

output reg  [255:0]  data_o;
/*

*/

output reg  busy;
/*

*/

reg         [255:0]  xor_stage_data;
/*

*/

reg         [255:0]  linear_stage_data;
/*

*/

reg         [255:0]  round_1_data;
reg         [255:0]  round_2_data;
reg         [255:0]  round_3_data;
reg         [255:0]  round_4_data;
reg         [255:0]  round_5_data;
reg         [255:0]  round_6_data;
reg         [255:0]  round_7_data;
reg         [255:0]  round_8_data;
reg         [255:0]  round_9_data;
reg         [255:0]  round_A_data;
reg         [255:0]  round_B_data;
reg         [255:0]  round_C_data;
reg         [255:0]  round_D_data;
reg         [255:0]  round_E_data;
reg         [255:0]  round_F_data;
/*

*/

reg         [8:0]   round_1_extra;
reg         [8:0]   round_2_extra;
reg         [8:0]   round_3_extra;
reg         [8:0]   round_4_extra;
reg         [8:0]   round_5_extra;
reg         [8:0]   round_6_extra;
reg         [8:0]   round_7_extra;
reg         [8:0]   round_8_extra;
reg         [8:0]   round_9_extra;
reg         [8:0]   round_A_extra;
reg         [8:0]   round_B_extra;
reg         [8:0]   round_C_extra;
reg         [8:0]   round_D_extra;
reg         [8:0]   round_E_extra;
reg         [8:0]   round_F_extra;
/*

*/

reg         [255:0] KEYS    [0:9];
/*

*/

reg         [255:0] GALOIS_TABLE [0:6];
/*

*/


stage stage_1 (
    .clk            (),
    .rst            (),
    .last_stage_i   (),
    .data_i         (),
    .data_o         (),
);





endmodule
