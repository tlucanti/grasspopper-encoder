`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
// 
// Create Date: 19.06.2022 13:07:40
// Design Name: Grasspopper
// Module Name: linear
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//   sync module
//   module implements linear action in one stage for grasspopper encoding
//
// Parameters:
//   rst            - reset signal
//   clk            - clock signal
//   data_i - 255 bit (16 bytes) data to be encoded
//   data_o - 255 bit (16 bytes) encoded data
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

input clk;
/*

*/

input rst;
/*

*/

input [255:0] data_i;
/*

*/

output reg [255:0] data_o;
/*

*/

always @(posedge clk) begin
	if (rst) begin

	end else begin
        data_o[007:000] <= sbox_lookup(data_i[007:000]);
        data_o[015:008] <= sbox_lookup(data_i[015:008]);
        data_o[023:016] <= sbox_lookup(data_i[023:016]);
        data_o[031:024] <= sbox_lookup(data_i[031:024]);
        data_o[039:032] <= sbox_lookup(data_i[039:032]);
        data_o[047:040] <= sbox_lookup(data_i[047:040]);
        data_o[055:048] <= sbox_lookup(data_i[055:048]);
        data_o[063:056] <= sbox_lookup(data_i[063:056]);
        data_o[071:064] <= sbox_lookup(data_i[071:064]);
        data_o[079:072] <= sbox_lookup(data_i[079:072]);
        data_o[087:080] <= sbox_lookup(data_i[087:080]);
        data_o[095:088] <= sbox_lookup(data_i[095:088]);
        data_o[103:096] <= sbox_lookup(data_i[103:096]);
        data_o[111:104] <= sbox_lookup(data_i[111:104]);
        data_o[119:112] <= sbox_lookup(data_i[119:112]);
        data_o[127:120] <= sbox_lookup(data_i[127:120]);
    end
end

endmodule