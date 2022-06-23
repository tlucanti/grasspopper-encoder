`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
// 
// Create Date: 19.06.2022 13:07:40
// Design Name: Grasspopper
// Module Name: non_linear
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//   sync module
//   module implements non_linear action in one stage for grasspopper encoding
//
// Parameters:
//   rst            - reset signal
//   clk            - clock signal
//   data_i         - 255 bit (16 bytes) data to be encoded
//   data_o         - 255 bit (16 bytes) encoded data
//
// Dependencies: None
// 
// Revision: v0.1
//   v0.1 - file Created
//
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////


module non_linear();

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

reg [7:0] extra_byte;

always @(posedge clk) begin
	if (rst) begin

	end else begin
        extra_byte <=
            galois_lookup_148(data_i[007:000]) ^
            galois_lookup_032(data_i[015:008]) ^
            galois_lookup_133(data_i[023:016]) ^
            galois_lookup_016(data_i[031:024]) ^
            galois_lookup_194(data_i[039:032]) ^
            galois_lookup_192(data_i[047:040]) ^
                              data_i[055:048]  ^
            galois_lookup_251(data_i[063:056]) ^
                              data_i[071:064]  ^
            galois_lookup_192(data_i[079:072]) ^
            galois_lookup_016(data_i[087:080]) ^
            galois_lookup_194(data_i[095:088]) ^
            galois_lookup_133(data_i[103:096]) ^
            galois_lookup_032(data_i[111:104]) ^
            galois_lookup_148(data_i[119:112]) ^
                              data_i[127:120];

        data_o <= {extra_byte, data_i[119:0]};
	end
end

// -----------------------------------------------------------------------------
function automatic [7:0] xor_reduce;
/*

*/
    input   [255:0] data;

    begin
        xor_reduce <=   data[015:008] ^ data[023:016] ^ data[031:024] ^
                        data[039:032] ^ data[047:040] ^ data[055:048] ^
                        data[063:056] ^ data[071:064] ^ data[079:072] ^
                        data[087:080] ^ data[095:088] ^ data[103:096] ^
                        data[111:104] ^ data[119:112] ^ data[127:120];
    end
endfunction

endmodule
