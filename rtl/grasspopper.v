`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
// 
// Create Date: 19.06.2022 11:14:33
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
//   clk    - clock signal
//   rst    - reset signal
//   data_i - 255 bit (16 bytes) data to be encoded
//   data_o - 255 bit (16 bytes) encoded data
//
// Dependencies: None
// 
// Revision: v0.2
//   v0.1 - file Created
//   v0.2 - module architecture done
//
// Additional Comments:
//   encoding makes 10 stages, each stage contains 3 actions:
//    - xor with stage key
//    - linear transformation (done by sbox table lookup)
//    - non linear transformation (done by 16 rounds of Galois multiplication
//        between data and one of the number in array)
//
//  module implemented as pipeline to get max speed
// 
////////////////////////////////////////////////////////////////////////////////


module grasspopper(clk, reset, data_i, data_o, busy);

input               clk;
/*

*/

input               reset;
/*

*/

input       [255:0]  data_i;
/*

*/

output      [255:0]  data_o;
/*

*/

output busy;
/*

*/

reg         [255:0]  round_0_data;
reg         [255:0]  round_1_data;
reg         [255:0]  round_2_data;
reg         [255:0]  round_3_data;
reg         [255:0]  round_4_data;
reg         [255:0]  round_5_data;
reg         [255:0]  round_6_data;
reg         [255:0]  round_7_data;
reg         [255:0]  round_8_data;
/*

*/

wire        [8:0]  stage_busy;

stage stage_0 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h0         ),
    .data_i         (data_i       ),
    .data_o         (round_0_data ),
    .busy           (stage_busy[0])
);

stage stage_1 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h1         ),
    .data_i         (data_i       ),
    .data_o         (round_1_data ),
    .busy           (stage_busy[1])
);

stage stage_2 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h2         ),
    .data_i         (data_i       ),
    .data_o         (round_2_data ),
    .busy           (stage_busy[2])
);

stage stage_3 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h3         ),
    .data_i         (data_i       ),
    .data_o         (round_3_data ),
    .busy           (stage_busy[3])
);

stage stage_4 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h4         ),
    .data_i         (data_i       ),
    .data_o         (round_4_data ),
    .busy           (stage_busy[4])
);

stage stage_5 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h5         ),
    .data_i         (data_i       ),
    .data_o         (round_5_data ),
    .busy           (stage_busy[5])
);

stage stage_6 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h6         ),
    .data_i         (data_i       ),
    .data_o         (round_6_data ),
    .busy           (stage_busy[6])
);

stage stage_7 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h7         ),
    .data_i         (data_i       ),
    .data_o         (round_7_data ),
    .busy           (stage_busy[7])
);

stage stage_8 (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num_i    (4'h8         ),
    .data_i         (data_i       ),
    .data_o         (round_8_data ),
    .busy           (stage_busy[8])
);

key_xor stage_9 (
    .stage_num      (4'h9         ),
    .data_i         (round_8_data ),
    .data_o         (data_o       )
);

assign busy = 1'h0;

endmodule
