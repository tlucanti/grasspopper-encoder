`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
// 
// Create Date: 19.06.2022 13:19:27
// Design Name: Grasspopper
// Module Name: key_xor
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//   sync module
//   module implements xor encoding action in one stage for grasspopper encoding
//
// Parameters:
//   rst            - reset signal
//   clk            - clock signal
//   stage_num_i    - 4 bit number of current stage
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


module key_xor(stage_num, data_i, data_o);

input [3:0]     stage_num;
/*

*/

input [127:0]   data_i;
/*

*/

output [127:0] data_o;
/*

*/

assign data_o = key_switcher(stage_num, data_i);

// -----------------------------------------------------------------------------
function automatic [127:0] key_switcher;
/*

*/
    input   [7:0]   stage_num;
    input   [127:0] data;

    begin
        case (stage_num)
            4'h0: key_switcher = data ^ 256'hC7DB5C958C8807843A94F27C81B18E7A;
            4'h1: key_switcher = data ^ 256'h7E09FCD1B3315D0597CAB1BE78E69B9B;
            4'h2: key_switcher = data ^ 256'hB8E138A1509521DC9AAF044645FA8A7D;
            4'h3: key_switcher = data ^ 256'hF1C22EA0A81BEC652A4348F7C48F4A8C;
            4'h4: key_switcher = data ^ 256'h9A30FD14B4764A65373D4A526B66666A;
            4'h5: key_switcher = data ^ 256'hC35C1192F7061952D483C3C1F6B88B98;
            4'h6: key_switcher = data ^ 256'hC5ADF5A722F6A73AE03E86CAEADF2641;
            4'h7: key_switcher = data ^ 256'h18F3D7A3E4DE63A16541D103E786DB9C;
            4'h8: key_switcher = data ^ 256'h173D53BE74D68AE778E7994FD7FA5FD5;
            4'h9: key_switcher = data ^ 256'hDF8E42FDE9BFBA4D6E9B24E4A953F27F;
        endcase
    end
endfunction

endmodule
