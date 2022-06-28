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

// `include "lookups.v"

module linear(data_i, data_o);

input   [255:0] data_i;
/*

*/

output  [255:0] data_o;
/*

*/

assign data_o[007:000] = sb_lookup(data_i[007:000]);
assign data_o[015:008] = sb_lookup(data_i[015:008]);
assign data_o[023:016] = sb_lookup(data_i[023:016]);
assign data_o[031:024] = sb_lookup(data_i[031:024]);
assign data_o[039:032] = sb_lookup(data_i[039:032]);
assign data_o[047:040] = sb_lookup(data_i[047:040]);
assign data_o[055:048] = sb_lookup(data_i[055:048]);
assign data_o[063:056] = sb_lookup(data_i[063:056]);
assign data_o[071:064] = sb_lookup(data_i[071:064]);
assign data_o[079:072] = sb_lookup(data_i[079:072]);
assign data_o[087:080] = sb_lookup(data_i[087:080]);
assign data_o[095:088] = sb_lookup(data_i[095:088]);
assign data_o[103:096] = sb_lookup(data_i[103:096]);
assign data_o[111:104] = sb_lookup(data_i[111:104]);
assign data_o[119:112] = sb_lookup(data_i[119:112]);
assign data_o[127:120] = sb_lookup(data_i[127:120]);

// -----------------------------------------------------------------------------
function automatic [7:0] sb_lookup;
/*

*/
    input   [7:0]   bt;

    begin case (bt)
        8'd000: sb_lookup = 8'hFC;
        8'd001: sb_lookup = 8'hEE;
        8'd002: sb_lookup = 8'hDD;
    endcase end
endfunction

endmodule
