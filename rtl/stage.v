
module linear();

input clk;
/*

*/

input rst;
/*

*/

input last_stage_i;
/*

*/

input [255:0] data_i;
/*

*/

output reg [255:0] data_o;
/*

*/

key_xor xor_stage (
    .clk            (),
    .rst            (),
    .stage_num		(),
    .last_stage_i   (),
    .data_i         (),
    .data_o         ()
);

linear linear_stage (
    .clk            (),
    .rst            (),
    .last_stage_i   (),
    .data_i         (),
    .data_o         ()
);

non_linear non_linear (
    .clk            (),
    .rst            (),
    .last_stage_i   (),
    .data_i         (),
    .data_o         ()
);
