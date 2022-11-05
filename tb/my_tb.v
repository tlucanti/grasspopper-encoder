
module tb_gp();

reg             clk;
reg             reset;
reg     [127:0] data_i;

wire    [127:0] data_o;
wire            busy;
wire    [127:0] zeros;

grasspopper gr (
    .clk(clk),
    .reset(reset),
    .data_i(data_i),
    .data_o(data_o),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin
    data_i <= zeros;
    clk = 0;
    reset = 1;
    @(negedge clk);
    reset = 0;
    #5
    data_i <= 128'h1122334455667700ffeeddccbbaa9988;
    //data_i <= 128'h00112233445566778899AABBCCDDEEFF;
    #10;
    data_i <= zeros;
    reset = 0;
    #5
    data_i <= zeros;
    #20000;

    $finish();
end
endmodule
