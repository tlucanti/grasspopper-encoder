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

input   [127:0] data_i;
/*

*/

output  [127:0] data_o;
/*

*/

assign data_o[007:000] = sbox_lookup(data_i[007:000]);
assign data_o[015:008] = sbox_lookup(data_i[015:008]);
assign data_o[023:016] = sbox_lookup(data_i[023:016]);
assign data_o[031:024] = sbox_lookup(data_i[031:024]);
assign data_o[039:032] = sbox_lookup(data_i[039:032]);
assign data_o[047:040] = sbox_lookup(data_i[047:040]);
assign data_o[055:048] = sbox_lookup(data_i[055:048]);
assign data_o[063:056] = sbox_lookup(data_i[063:056]);
assign data_o[071:064] = sbox_lookup(data_i[071:064]);
assign data_o[079:072] = sbox_lookup(data_i[079:072]);
assign data_o[087:080] = sbox_lookup(data_i[087:080]);
assign data_o[095:088] = sbox_lookup(data_i[095:088]);
assign data_o[103:096] = sbox_lookup(data_i[103:096]);
assign data_o[111:104] = sbox_lookup(data_i[111:104]);
assign data_o[119:112] = sbox_lookup(data_i[119:112]);
assign data_o[127:120] = sbox_lookup(data_i[127:120]);

// -----------------------------------------------------------------------------
function automatic [7:0] sbox_lookup;
/*

*/
    input   [7:0]   byte;

    begin case (byte)
        8'd000: sbox_lookup = 8'hFC;
        8'd001: sbox_lookup = 8'hEE;
        8'd002: sbox_lookup = 8'hDD;
        8'd003: sbox_lookup = 8'h11;
        8'd004: sbox_lookup = 8'hCF;
        8'd005: sbox_lookup = 8'h6E;
        8'd006: sbox_lookup = 8'h31;
        8'd007: sbox_lookup = 8'h16;
        8'd008: sbox_lookup = 8'hFB;
        8'd009: sbox_lookup = 8'hC4;
        8'd010: sbox_lookup = 8'hFA;
        8'd011: sbox_lookup = 8'hDA;
        8'd012: sbox_lookup = 8'h23;
        8'd013: sbox_lookup = 8'hC5;
        8'd014: sbox_lookup = 8'h04;
        8'd015: sbox_lookup = 8'h4D;
        8'd016: sbox_lookup = 8'hE9;
        8'd017: sbox_lookup = 8'h77;
        8'd018: sbox_lookup = 8'hF0;
        8'd019: sbox_lookup = 8'hDB;
        8'd020: sbox_lookup = 8'h93;
        8'd021: sbox_lookup = 8'h2E;
        8'd022: sbox_lookup = 8'h99;
        8'd023: sbox_lookup = 8'hBA;
        8'd024: sbox_lookup = 8'h17;
        8'd025: sbox_lookup = 8'h36;
        8'd026: sbox_lookup = 8'hF1;
        8'd027: sbox_lookup = 8'hBB;
        8'd028: sbox_lookup = 8'h14;
        8'd029: sbox_lookup = 8'hCD;
        8'd030: sbox_lookup = 8'h5F;
        8'd031: sbox_lookup = 8'hC1;
        8'd032: sbox_lookup = 8'hF9;
        8'd033: sbox_lookup = 8'h18;
        8'd034: sbox_lookup = 8'h65;
        8'd035: sbox_lookup = 8'h5A;
        8'd036: sbox_lookup = 8'hE2;
        8'd037: sbox_lookup = 8'h5C;
        8'd038: sbox_lookup = 8'hEF;
        8'd039: sbox_lookup = 8'h21;
        8'd040: sbox_lookup = 8'h81;
        8'd041: sbox_lookup = 8'h1C;
        8'd042: sbox_lookup = 8'h3C;
        8'd043: sbox_lookup = 8'h42;
        8'd044: sbox_lookup = 8'h8B;
        8'd045: sbox_lookup = 8'h01;
        8'd046: sbox_lookup = 8'h8E;
        8'd047: sbox_lookup = 8'h4F;
        8'd048: sbox_lookup = 8'h05;
        8'd049: sbox_lookup = 8'h84;
        8'd050: sbox_lookup = 8'h02;
        8'd051: sbox_lookup = 8'hAE;
        8'd052: sbox_lookup = 8'hE3;
        8'd053: sbox_lookup = 8'h6A;
        8'd054: sbox_lookup = 8'h8F;
        8'd055: sbox_lookup = 8'hA0;
        8'd056: sbox_lookup = 8'h06;
        8'd057: sbox_lookup = 8'h0B;
        8'd058: sbox_lookup = 8'hED;
        8'd059: sbox_lookup = 8'h98;
        8'd060: sbox_lookup = 8'h7F;
        8'd061: sbox_lookup = 8'hD4;
        8'd062: sbox_lookup = 8'hD3;
        8'd063: sbox_lookup = 8'h1F;
        8'd064: sbox_lookup = 8'hEB;
        8'd065: sbox_lookup = 8'h34;
        8'd066: sbox_lookup = 8'h2C;
        8'd067: sbox_lookup = 8'h51;
        8'd068: sbox_lookup = 8'hEA;
        8'd069: sbox_lookup = 8'hC8;
        8'd070: sbox_lookup = 8'h48;
        8'd071: sbox_lookup = 8'hAB;
        8'd072: sbox_lookup = 8'hF2;
        8'd073: sbox_lookup = 8'h2A;
        8'd074: sbox_lookup = 8'h68;
        8'd075: sbox_lookup = 8'hA2;
        8'd076: sbox_lookup = 8'hFD;
        8'd077: sbox_lookup = 8'h3A;
        8'd078: sbox_lookup = 8'hCE;
        8'd079: sbox_lookup = 8'hCC;
        8'd080: sbox_lookup = 8'hB5;
        8'd081: sbox_lookup = 8'h70;
        8'd082: sbox_lookup = 8'h0E;
        8'd083: sbox_lookup = 8'h56;
        8'd084: sbox_lookup = 8'h08;
        8'd085: sbox_lookup = 8'h0C;
        8'd086: sbox_lookup = 8'h76;
        8'd087: sbox_lookup = 8'h12;
        8'd088: sbox_lookup = 8'hBF;
        8'd089: sbox_lookup = 8'h72;
        8'd090: sbox_lookup = 8'h13;
        8'd091: sbox_lookup = 8'h47;
        8'd092: sbox_lookup = 8'h9C;
        8'd093: sbox_lookup = 8'hB7;
        8'd094: sbox_lookup = 8'h5D;
        8'd095: sbox_lookup = 8'h87;
        8'd096: sbox_lookup = 8'h15;
        8'd097: sbox_lookup = 8'hA1;
        8'd098: sbox_lookup = 8'h96;
        8'd099: sbox_lookup = 8'h29;
        8'd100: sbox_lookup = 8'h10;
        8'd101: sbox_lookup = 8'h7B;
        8'd102: sbox_lookup = 8'h9A;
        8'd103: sbox_lookup = 8'hC7;
        8'd104: sbox_lookup = 8'hF3;
        8'd105: sbox_lookup = 8'h91;
        8'd106: sbox_lookup = 8'h78;
        8'd107: sbox_lookup = 8'h6F;
        8'd108: sbox_lookup = 8'h9D;
        8'd109: sbox_lookup = 8'h9E;
        8'd110: sbox_lookup = 8'hB2;
        8'd111: sbox_lookup = 8'hB1;
        8'd112: sbox_lookup = 8'h32;
        8'd113: sbox_lookup = 8'h75;
        8'd114: sbox_lookup = 8'h19;
        8'd115: sbox_lookup = 8'h3D;
        8'd116: sbox_lookup = 8'hFF;
        8'd117: sbox_lookup = 8'h35;
        8'd118: sbox_lookup = 8'h8A;
        8'd119: sbox_lookup = 8'h7E;
        8'd120: sbox_lookup = 8'h6D;
        8'd121: sbox_lookup = 8'h54;
        8'd122: sbox_lookup = 8'hC6;
        8'd123: sbox_lookup = 8'h80;
        8'd124: sbox_lookup = 8'hC3;
        8'd125: sbox_lookup = 8'hBD;
        8'd126: sbox_lookup = 8'h0D;
        8'd127: sbox_lookup = 8'h57;
        8'd128: sbox_lookup = 8'hDF;
        8'd129: sbox_lookup = 8'hF5;
        8'd130: sbox_lookup = 8'h24;
        8'd131: sbox_lookup = 8'hA9;
        8'd132: sbox_lookup = 8'h3E;
        8'd133: sbox_lookup = 8'hA8;
        8'd134: sbox_lookup = 8'h43;
        8'd135: sbox_lookup = 8'hC9;
        8'd136: sbox_lookup = 8'hD7;
        8'd137: sbox_lookup = 8'h79;
        8'd138: sbox_lookup = 8'hD6;
        8'd139: sbox_lookup = 8'hF6;
        8'd140: sbox_lookup = 8'h7C;
        8'd141: sbox_lookup = 8'h22;
        8'd142: sbox_lookup = 8'hB9;
        8'd143: sbox_lookup = 8'h03;
        8'd144: sbox_lookup = 8'hE0;
        8'd145: sbox_lookup = 8'h0F;
        8'd146: sbox_lookup = 8'hEC;
        8'd147: sbox_lookup = 8'hDE;
        8'd148: sbox_lookup = 8'h7A;
        8'd149: sbox_lookup = 8'h94;
        8'd150: sbox_lookup = 8'hB0;
        8'd151: sbox_lookup = 8'hBC;
        8'd152: sbox_lookup = 8'hDC;
        8'd153: sbox_lookup = 8'hE8;
        8'd154: sbox_lookup = 8'h28;
        8'd155: sbox_lookup = 8'h50;
        8'd156: sbox_lookup = 8'h4E;
        8'd157: sbox_lookup = 8'h33;
        8'd158: sbox_lookup = 8'h0A;
        8'd159: sbox_lookup = 8'h4A;
        8'd160: sbox_lookup = 8'hA7;
        8'd161: sbox_lookup = 8'h97;
        8'd162: sbox_lookup = 8'h60;
        8'd163: sbox_lookup = 8'h73;
        8'd164: sbox_lookup = 8'h1E;
        8'd165: sbox_lookup = 8'h00;
        8'd166: sbox_lookup = 8'h62;
        8'd167: sbox_lookup = 8'h44;
        8'd168: sbox_lookup = 8'h1A;
        8'd169: sbox_lookup = 8'hB8;
        8'd170: sbox_lookup = 8'h38;
        8'd171: sbox_lookup = 8'h82;
        8'd172: sbox_lookup = 8'h64;
        8'd173: sbox_lookup = 8'h9F;
        8'd174: sbox_lookup = 8'h26;
        8'd175: sbox_lookup = 8'h41;
        8'd176: sbox_lookup = 8'hAD;
        8'd177: sbox_lookup = 8'h45;
        8'd178: sbox_lookup = 8'h46;
        8'd179: sbox_lookup = 8'h92;
        8'd180: sbox_lookup = 8'h27;
        8'd181: sbox_lookup = 8'h5E;
        8'd182: sbox_lookup = 8'h55;
        8'd183: sbox_lookup = 8'h2F;
        8'd184: sbox_lookup = 8'h8C;
        8'd185: sbox_lookup = 8'hA3;
        8'd186: sbox_lookup = 8'hA5;
        8'd187: sbox_lookup = 8'h7D;
        8'd188: sbox_lookup = 8'h69;
        8'd189: sbox_lookup = 8'hD5;
        8'd190: sbox_lookup = 8'h95;
        8'd191: sbox_lookup = 8'h3B;
        8'd192: sbox_lookup = 8'h07;
        8'd193: sbox_lookup = 8'h58;
        8'd194: sbox_lookup = 8'hB3;
        8'd195: sbox_lookup = 8'h40;
        8'd196: sbox_lookup = 8'h86;
        8'd197: sbox_lookup = 8'hAC;
        8'd198: sbox_lookup = 8'h1D;
        8'd199: sbox_lookup = 8'hF7;
        8'd200: sbox_lookup = 8'h30;
        8'd201: sbox_lookup = 8'h37;
        8'd202: sbox_lookup = 8'h6B;
        8'd203: sbox_lookup = 8'hE4;
        8'd204: sbox_lookup = 8'h88;
        8'd205: sbox_lookup = 8'hD9;
        8'd206: sbox_lookup = 8'hE7;
        8'd207: sbox_lookup = 8'h89;
        8'd208: sbox_lookup = 8'hE1;
        8'd209: sbox_lookup = 8'h1B;
        8'd210: sbox_lookup = 8'h83;
        8'd211: sbox_lookup = 8'h49;
        8'd212: sbox_lookup = 8'h4C;
        8'd213: sbox_lookup = 8'h3F;
        8'd214: sbox_lookup = 8'hF8;
        8'd215: sbox_lookup = 8'hFE;
        8'd216: sbox_lookup = 8'h8D;
        8'd217: sbox_lookup = 8'h53;
        8'd218: sbox_lookup = 8'hAA;
        8'd219: sbox_lookup = 8'h90;
        8'd220: sbox_lookup = 8'hCA;
        8'd221: sbox_lookup = 8'hD8;
        8'd222: sbox_lookup = 8'h85;
        8'd223: sbox_lookup = 8'h61;
        8'd224: sbox_lookup = 8'h20;
        8'd225: sbox_lookup = 8'h71;
        8'd226: sbox_lookup = 8'h67;
        8'd227: sbox_lookup = 8'hA4;
        8'd228: sbox_lookup = 8'h2D;
        8'd229: sbox_lookup = 8'h2B;
        8'd230: sbox_lookup = 8'h09;
        8'd231: sbox_lookup = 8'h5B;
        8'd232: sbox_lookup = 8'hCB;
        8'd233: sbox_lookup = 8'h9B;
        8'd234: sbox_lookup = 8'h25;
        8'd235: sbox_lookup = 8'hD0;
        8'd236: sbox_lookup = 8'hBE;
        8'd237: sbox_lookup = 8'hE5;
        8'd238: sbox_lookup = 8'h6C;
        8'd239: sbox_lookup = 8'h52;
        8'd240: sbox_lookup = 8'h59;
        8'd241: sbox_lookup = 8'hA6;
        8'd242: sbox_lookup = 8'h74;
        8'd243: sbox_lookup = 8'hD2;
        8'd244: sbox_lookup = 8'hE6;
        8'd245: sbox_lookup = 8'hF4;
        8'd246: sbox_lookup = 8'hB4;
        8'd247: sbox_lookup = 8'hC0;
        8'd248: sbox_lookup = 8'hD1;
        8'd249: sbox_lookup = 8'h66;
        8'd250: sbox_lookup = 8'hAF;
        8'd251: sbox_lookup = 8'hC2;
        8'd252: sbox_lookup = 8'h39;
        8'd253: sbox_lookup = 8'h4B;
        8'd254: sbox_lookup = 8'h63;
        8'd255: sbox_lookup = 8'hB6;
    endcase end
endfunction

endmodule
