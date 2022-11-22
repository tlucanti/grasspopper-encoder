`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Miet
// Engineer: Kostya
//
// Create Date: 19.06.2022 11:14:33
// Design Name: Grasspopper
// Module Name: grasspopper-module
// Project Name: Grasspopper
// Target Devices: any
// Tool Versions: 2021.1
// Description:
//
// Parameters:
//
// Dependencies: None
//
// Revision: v0.1
//   v0.1 - file Created
//
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////


module grasspopper_module(
    input               pclk_i,
    input               presetn_i,
    input   [31:0]      paddr_i,
    input               psel_i,
    input               penable_i,
    input               pwrite_i,
    input   [3:0] [7:0] pwdata_i,
    input   [3:0]       pstrb_i,
    output              pready_o,
    output  [31:0]      prdata_o,
    output              pslverr_o
);

reg [7:0]   mem[35:0];

wire    resetn;
wire    req;
wire    ack;
wire    busy;
wire    valid;
wire    [127:0] d_i;
wire    [127:0] d_o;

grasspopper gp(
    .clk        (pclk_i),
    .rst        (~resetn),
    .data_i     (d_i),
    .request_i  (req),
    .ack_i      (ack),
    .data_o     (d_o),
    .valid_o    (valid),
    .busy_o     (busy)
);

always @(posedge pclk_i) begin
    if (pwrite_i) begin
        mem[paddr_i + 0] <= pstrb_i[0] ? pwdata_i[0] : mem[paddr_i + 0];
        mem[paddr_i + 1] <= pstrb_i[1] ? pwdata_i[1] : mem[paddr_i + 1];
        mem[paddr_i + 2] <= pstrb_i[2] ? pwdata_i[2] : mem[paddr_i + 2];
        mem[paddr_i + 3] <= pstrb_i[3] ? pwdata_i[3] : mem[paddr_i + 3];
    end

    if (valid) begin
        mem[20 +  0] <= d_o[ 0 * 8 +: 8];
        mem[20 +  1] <= d_o[ 1 * 8 +: 8];
        mem[20 +  2] <= d_o[ 2 * 8 +: 8];
        mem[20 +  3] <= d_o[ 3 * 8 +: 8];
        mem[20 +  4] <= d_o[ 4 * 8 +: 8];
        mem[20 +  5] <= d_o[ 5 * 8 +: 8];
        mem[20 +  6] <= d_o[ 6 * 8 +: 8];
        mem[20 +  7] <= d_o[ 7 * 8 +: 8];
        mem[20 +  8] <= d_o[ 8 * 8 +: 8];
        mem[20 +  9] <= d_o[ 9 * 8 +: 8];
        mem[20 + 10] <= d_o[10 * 8 +: 8];
        mem[20 + 11] <= d_o[11 * 8 +: 8];
        mem[20 + 12] <= d_o[12 * 8 +: 8];
        mem[20 + 13] <= d_o[13 * 8 +: 8];
        mem[20 + 14] <= d_o[14 * 8 +: 8];
        mem[20 + 15] <= d_o[15 * 8 +: 8];
    end

    mem[3] <= busy;
    mem[2] <= valid;
end

assign  pslverr_o = ((pwrite_i && (20 <= paddr_i)) || (paddr_i == 0 && pstrb_i[3:2]));
assign  pready_o = penable_i;
assign  resetn = mem[0] && presetn_i;
assign  ack = mem[1][1];
assign  req = mem[1][0];
assign  d_i = {
    mem[19], mem[18], mem[17], mem[16], mem[15], mem[14], mem[13], mem[12],
    mem[11], mem[10], mem[9], mem[8], mem[7], mem[6], mem[5], mem[4]
};
assign  prdata_o = {
    mem[paddr_i + 3], mem[paddr_i + 2], mem[paddr_i + 1], mem[paddr_i]
};

endmodule

