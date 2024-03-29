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
//   rst    - reset   signal
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


module grasspopper(clk, rst, data_i, request_i, ack_i, data_o, valid_o, busy_o);

input               clk;
/*
    clock
*/

input               rst;
/*
    reset
*/

input       [127:0]  data_i;
/*
    16 bytes of input data
*/

input               request_i;
/*
    request signal
*/

input               ack_i;
/*
    acknowledgement signal (ignored)
*/

output      [127:0]  data_o;
/*
    16 bytes of chiphered data
*/

output              busy_o;
/*
    busy sugnal
*/

output              valid_o;
/*
    valid data signal
*/

wire        [127:0]  stage_01;
wire        [127:0]  stage_12;
wire        [127:0]  stage_23;
wire        [127:0]  stage_34;
wire        [127:0]  stage_45;
wire        [127:0]  stage_56;
wire        [127:0]  stage_67;
wire        [127:0]  stage_78;
wire        [127:0]  stage_89;

reg         [127:0]  round_0_data;
reg         [127:0]  round_1_data;
reg         [127:0]  round_2_data;
reg         [127:0]  round_3_data;
reg         [127:0]  round_4_data;
reg         [127:0]  round_5_data;
reg         [127:0]  round_6_data;
reg         [127:0]  round_7_data;
reg         [127:0]  round_8_data;
/*

*/

localparam  STAGE_NUMBER = 162;
reg         [STAGE_NUMBER - 1:0]  valid_bitmap;

stage stage_0 (
    .clk            (clk          ),
    .stage_num_i    (4'h0         ),
    .data_i         (data_i       ),
    .data_o         (stage_01     )
);

stage stage_1 (
    .clk            (clk          ),
    .stage_num_i    (4'h1         ),
    .data_i         (round_0_data ),
    .data_o         (stage_12     )
);

stage stage_2 (
    .clk            (clk          ),
    .stage_num_i    (4'h2         ),
    .data_i         (round_1_data ),
    .data_o         (stage_23     )
);

stage stage_3 (
    .clk            (clk          ),
    .stage_num_i    (4'h3         ),
    .data_i         (round_2_data ),
    .data_o         (stage_34     )
);

stage stage_4 (
    .clk            (clk          ),
    .stage_num_i    (4'h4         ),
    .data_i         (round_3_data ),
    .data_o         (stage_45     )
);

stage stage_5 (
    .clk            (clk          ),
    .stage_num_i    (4'h5         ),
    .data_i         (round_4_data ),
    .data_o         (stage_56     )
);

stage stage_6 (
    .clk            (clk          ),
    .stage_num_i    (4'h6         ),
    .data_i         (round_5_data ),
    .data_o         (stage_67     )
);

stage stage_7 (
    .clk            (clk          ),
    .stage_num_i    (4'h7         ),
    .data_i         (round_6_data ),
    .data_o         (stage_78     )
);

stage stage_8 (
    .clk            (clk          ),
    .stage_num_i    (4'h8         ),
    .data_i         (round_7_data ),
    .data_o         (stage_89     )
);

key_xor stage_9 (
    .stage_num      (4'h9         ),
    .data_i         (round_8_data ),
    .data_o         (data_o       )
);

assign valid_o = valid_bitmap[0];
assign busy_o = 1'b0;

always @(posedge clk) begin
    if (rst) begin
        valid_bitmap <= 'b0;
    end else begin
        valid_bitmap <= {request_i, valid_bitmap[STAGE_NUMBER - 1:1]};
    end
    round_0_data <= stage_01;
    round_1_data <= stage_12;
    round_2_data <= stage_23;
    round_3_data <= stage_34;
    round_4_data <= stage_45;
    round_5_data <= stage_56;
    round_6_data <= stage_67;
    round_7_data <= stage_78;
    round_8_data <= stage_89;
end

endmodule
