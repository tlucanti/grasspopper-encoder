`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
// 
// Create Date: 19.06.2022 13:16:47
// Design Name: Grasspopper
// Module Name: stage
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//   sync module
//   module implements one stage for grasspopper encoding (State Standart of
//   Russian Federation 34.12-2015)
//
// Parameters:
//   rst            - reset signal
//   clk            - clock signal
//   stage_num_i    - 4 bit number of current stage
//   data_i         - 255 bit (16 bytes) data to be encoded
//   data_o         - 255 bit (16 bytes) encoded data
//   bisy           - flag indicating that the module is busy (encoding in
//                      progress)
//
// Dependencies: None
// 
// Revision: v0.1
//   v0.1 - file Created
//
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////


module linear();

// -------------------------

input clk;
/*

*/

input rst;
/*

*/

input [3:0] stage_num_i;
/*

*/

input [255:0] data_i;
/*

*/

output [255:0] data_o;
/*

*/

output busy;
/*

*/

// ----------------------------------- WIRES -----------------------------------
wire last_stage = stage_num_i == 10;
/*

*/

// ----------------------------------- XOR WIRES ------
wire [255:0] xor_data_o;
/*

*/

// ----------------------------------- LINEAR WIRES
wire [255:0] linear_data_i;
/*

*/

wire [255:0] linead_data_o;
/*

*/

// ----------------------------------- NON LINEAR WIRES
wire [255:0] non_linear_data_i;
/*

*/


// ----------------------------------- REGISTERS -----
reg  [255:0] xor_to_linear_buffer;
/*

*/

reg  [255:0] linear_to_non_linear_buffer;
/*

*/

reg  [255:0] non_linear_buffer_1;
reg  [255:0] non_linear_buffer_2;
reg  [255:0] non_linear_buffer_3;
reg  [255:0] non_linear_buffer_4;
reg  [255:0] non_linear_buffer_5;
reg  [255:0] non_linear_buffer_6;
reg  [255:0] non_linear_buffer_7;
reg  [255:0] non_linear_buffer_8;
reg  [255:0] non_linear_buffer_9;
reg  [255:0] non_linear_buffer_A;
reg  [255:0] non_linear_buffer_B;
reg  [255:0] non_linear_buffer_C;
reg  [255:0] non_linear_buffer_D;
reg  [255:0] non_linear_buffer_E;
reg  [255:0] non_linear_buffer_F;
/*

*/

// ----------------------------------- ASSIGNS ----

assign linear_data_i        = xor_to_linear_buffer;
assign non_linear_data_i    = linear_to_non_linear_buffer;


key_xor xor_stage (
    .clk            (clk          ),
    .rst            (rst          ),
    .stage_num      (stage_num_i  ),
    .data_i         (data_i       ),
    .data_o         (xor_data_o   )
);

linear linear_stage (
    .clk            (clk          ),
    .rst            (rst          ),
    .data_i         (linear_data_i),
    .data_o         (linear_data_o)
);

non_linear non_linear_0 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_data_i   ),
    .data_o         (non_linear_buffer_1 )
);

non_linear non_linear_1 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_1 ),
    .data_o         (non_linear_buffer_2 )
);

non_linear non_linear_2 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_2 ),
    .data_o         (non_linear_buffer_3 )
);

non_linear non_linear_3 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_3 ),
    .data_o         (non_linear_buffer_4 )
);

non_linear non_linear_4 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_4 ),
    .data_o         (non_linear_buffer_5 )
);

non_linear non_linear_5 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_5 ),
    .data_o         (non_linear_buffer_6 )
);

non_linear non_linear_6 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_6 ),
    .data_o         (non_linear_buffer_7 )
);

non_linear non_linear_7 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_7 ),
    .data_o         (non_linear_buffer_8 )
);

non_linear non_linear_8 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_8 ),
    .data_o         (non_linear_buffer_9 )
);

non_linear non_linear_9 (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_9 ),
    .data_o         (non_linear_buffer_A )
);

non_linear non_linear_A (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_A ),
    .data_o         (non_linear_buffer_B )
);

non_linear non_linear_B (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_B ),
    .data_o         (non_linear_buffer_C )
);

non_linear non_linear_C (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_C ),
    .data_o         (non_linear_buffer_D )
);

non_linear non_linear_D (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_D ),
    .data_o         (non_linear_buffer_E )
);

non_linear non_linear_E (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_E ),
    .data_o         (non_linear_buffer_F )
);

non_linear non_linear_F (
    .clk            (clk                 ),
    .rst            (rst                 ),
    .data_i         (non_linear_buffer_F ),
    .data_o         (data_o              )
);

always @(posedge clk) begin
    xor_to_linear_buffer        <= xor_data_o;
    linear_to_non_linear_buffer <= linear_data_o;
    busy                        <= 1'b0;
end

endmodule