
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
        extra_byte <= galois_lookup_001(data_i[127:120]);

        data_o[015:008] <= galois_lookup_148(data_i[007:000]);
        data_o[023:016] <= galois_lookup_032(data_i[015:008]);
        data_o[031:024] <= galois_lookup_133(data_i[023:016]);
        data_o[039:032] <= galois_lookup_016(data_i[031:024]);
        data_o[047:040] <= galois_lookup_194(data_i[039:032]);
        data_o[055:048] <=                   data_i[047:040];
        data_o[063:056] <= galois_lookup_001(data_i[055:048]);
        data_o[071:064] <=                   data_i[063:056];
        data_o[079:072] <= galois_lookup_001(data_i[071:064]);
        data_o[087:080] <= galois_lookup_192(data_i[079:072]);
        data_o[095:088] <= galois_lookup_194(data_i[087:080]);
        data_o[103:096] <= galois_lookup_016(data_i[095:088]);
        data_o[111:104] <= galois_lookup_133(data_i[103:096]);
        data_o[119:112] <= galois_lookup_032(data_i[111:104]);
        data_o[127:120] <=                   data_i[119:112];

        data_o[007:000] <= xor_reduce(data_o) ^ extra_byte;
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
