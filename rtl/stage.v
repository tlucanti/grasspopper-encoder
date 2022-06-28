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

// `include "lookups.v"

module stage(clk, rst, stage_num_i, data_i, data_o, busy);

// -------------------------

input           clk;
/*

*/

input           rst;
/*

*/

input   [3:0]   stage_num_i;
/*

*/

input   [255:0] data_i;
/*

*/

output  [255:0] data_o;
/*

*/

output          busy;
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

wire [255:0] stage_xor_linear;
wire [255:0] stage_nl_0;
wire [255:0] stage_01;
wire [255:0] stage_12;
wire [255:0] stage_23;
wire [255:0] stage_34;
wire [255:0] stage_45;
wire [255:0] stage_56;
wire [255:0] stage_67;
wire [255:0] stage_78;
wire [255:0] stage_89;
wire [255:0] stage_9A;
wire [255:0] stage_AB;
wire [255:0] stage_BC;
wire [255:0] stage_CD;
wire [255:0] stage_DE;
wire [255:0] stage_EF;
/*

*/

reg  [255:0] xor_buffer;
reg  [255:0] linear_buffer;
reg  [255:0] non_linear_buffer_0;
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
/*

*/

// ----------------------------------- ASSIGNS ----

assign linear_data_i        = xor_to_linear_buffer;
assign non_linear_data_i    = linear_to_non_linear_buffer;
assign busy                 = 1'd0;

key_xor xor_stage (
    .stage_num      (stage_num_i     ),
    .data_i         (data_i          ),
    .data_o         (stage_xor_linear)
);

linear linear_stage (
    .data_i         (xor_buffer   ),
    .data_o         (stage_nl_0   )
);

non_linear non_linear_0 (
    .data_i         (linear_buffer       ),
    .data_o         (stage_01            )
);

non_linear non_linear_1 (
    .data_i         (non_linear_buffer_0 ),
    .data_o         (stage_12            )
);

non_linear non_linear_2 (
    .data_i         (non_linear_buffer_1 ),
    .data_o         (stage_23            )
);

non_linear non_linear_3 (
    .data_i         (non_linear_buffer_2 ),
    .data_o         (stage_34            )
);

non_linear non_linear_4 (
    .data_i         (non_linear_buffer_3 ),
    .data_o         (stage_45            )
);

non_linear non_linear_5 (
    .data_i         (non_linear_buffer_4 ),
    .data_o         (stage_56            )
);

non_linear non_linear_6 (
    .data_i         (non_linear_buffer_5 ),
    .data_o         (stage_67            )
);

non_linear non_linear_7 (
    .data_i         (non_linear_buffer_6 ),
    .data_o         (stage_78            )
);

non_linear non_linear_8 (
    .data_i         (non_linear_buffer_7 ),
    .data_o         (stage_89            )
);

non_linear non_linear_9 (
    .data_i         (non_linear_buffer_8 ),
    .data_o         (stage_9A            )
);

non_linear non_linear_A (
    .data_i         (non_linear_buffer_9 ),
    .data_o         (stage_AB            )
);

non_linear non_linear_B (
    .data_i         (non_linear_buffer_A ),
    .data_o         (stage_BC            )
);

non_linear non_linear_C (
    .data_i         (non_linear_buffer_B ),
    .data_o         (stage_CD            )
);

non_linear non_linear_D (
    .data_i         (non_linear_buffer_C ),
    .data_o         (stage_DE            )
);

non_linear non_linear_E (
    .data_i         (non_linear_buffer_D ),
    .data_o         (stage_EF            )
);

non_linear non_linear_F (
    .data_i         (non_linear_buffer_E ),
    .data_o         (data_o              )
);

always @(posedge clk) begin
    if (rst) begin
        xor_buffer          <= 256'h0;
        linear_buffer       <= 256'h0;
        non_linear_buffer_0 <= 256'h0;
        non_linear_buffer_1 <= 256'h0;
        non_linear_buffer_2 <= 256'h0;
        non_linear_buffer_3 <= 256'h0;
        non_linear_buffer_4 <= 256'h0;
        non_linear_buffer_5 <= 256'h0;
        non_linear_buffer_6 <= 256'h0;
        non_linear_buffer_7 <= 256'h0;
        non_linear_buffer_8 <= 256'h0;
        non_linear_buffer_9 <= 256'h0;
        non_linear_buffer_A <= 256'h0;
        non_linear_buffer_B <= 256'h0;
        non_linear_buffer_C <= 256'h0;
        non_linear_buffer_D <= 256'h0;
        non_linear_buffer_E <= 256'h0;
    end else begin
        xor_buffer          <= stage_xor_linear;
        linear_buffer       <= stage_nl_0;
        non_linear_buffer_0 <= stage_01;
        non_linear_buffer_1 <= stage_12;
        non_linear_buffer_2 <= stage_23;
        non_linear_buffer_3 <= stage_34;
        non_linear_buffer_4 <= stage_45;
        non_linear_buffer_5 <= stage_56;
        non_linear_buffer_6 <= stage_67;
        non_linear_buffer_7 <= stage_78;
        non_linear_buffer_8 <= stage_89;
        non_linear_buffer_9 <= stage_9A;
        non_linear_buffer_A <= stage_AB;
        non_linear_buffer_B <= stage_BC;
        non_linear_buffer_C <= stage_CD;
        non_linear_buffer_D <= stage_DE;
        non_linear_buffer_E <= stage_EF;
    end
end

endmodule
