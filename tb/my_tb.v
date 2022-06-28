
module tb_gp();

reg             clk;
reg             reset;

wire    [255:0] data_i = 256'h0x1122334455667700ffeeddccbbaa9988;
wire    [255:0] data_o;
wire            busy;

grasspopper gr (
    .clk(clk),
    .reset(reset),
    .data_i(data_i),
    .data_o(data_o),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 0;
    @(negedge clk);
    reset = 1;
    repeat(2) begin
      @(negedge clk);
    end
    reset = 0;
    #2000;
    
    $finish();
end
endmodule
