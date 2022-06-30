
module tb_gp();

reg             clk;
reg             reset;
reg     [127:0] data_i;

wire    [127:0] data_o;
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
    reset = 1;
    @(negedge clk);
    reset = 0;
    #5
    data_i <= 128'h1122334455667700ffeeddccbbaa9988;
    #10;
    data_i <= 128'h0;
    reset = 0;
    #5
    data_i <= 128'h0;
    #2000;
    
    $finish();
end
endmodule
