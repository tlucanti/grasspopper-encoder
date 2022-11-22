
module tb_gp();

reg             clk;
reg             reset;
reg     [127:0] data_i;

wire    [127:0] data_o;
wire            busy;
wire    [127:0] zeros;
reg    [127:0] encoded [10:0];
reg [128*11-1:0] print_str;

grasspopper gr (
    .clk(clk),
    .reset(reset),
    .data_i(data_i),
    .data_o(data_o),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin
    data_i <= 127'h0;
    clk = 0;
    reset = 1;
    @(negedge clk);
    reset = 0;
    #5
    //data_i <= 128'h1122334455667700ffeeddccbbaa9988;
        data_i <= 128'hc177d2d35af6d17477545bfcf97d43a4;
        #10;
        data_i <= 128'h1b877fafa3ba0026e8ef95de495ac74c;
        #10;
        data_i <= 128'hcd84585b9b46f02519d00f7111a34452;
        #10;
        data_i <= 128'hfcec82557f40f3310eed30d097b2c368;
        #10;
        data_i <= 128'hc6cc2ddec17abc61e995062df1dead37;
        #10;
        data_i <= 128'hc0ddbf359d704ad7f52420798f94fc4b;
        #10;
        data_i <= 128'hdb434f2542b562db98eb19ef012eadb7;
        #10;
        data_i <= 128'hfe59f8e79163e45ec6c47cdf80e4b0c4;
        #10;
        data_i <= 128'h295d9b247899b5257b88c319519e6d15;
        #10;
        data_i <= 128'h30f6af74f3666a67216db25238be91e2;
        #10;
        data_i <= 128'h44bf130e7bcab6a1d2d867280bb89269;
        #10;

    #1510;
    #10;
    data_i <= 128'h0;
    encoded[0] <= data_o;
    #10;
    encoded[1] <= data_o;
    #10;
    encoded[2] <= data_o;
    #10;
    encoded[3] <= data_o;
    #10;
    encoded[4] <= data_o;
    #10;
    encoded[5] <= data_o;
    #10;
    encoded[6] <= data_o;
    #10;
    encoded[7] <= data_o;
    #10;
    encoded[8] <= data_o;
    #10;
    encoded[9] <= data_o;
    #10;
    encoded[10] <= data_o;
    #10;
        $display("Ciphering has been finished.");
        $display("============================");
        $display("===== Ciphered message =====");
        $display("============================");
        print_str = {encoded[0],
                        encoded[1],
                        encoded[2],
                        encoded[3],
                        encoded[4],
                        encoded[5],
                        encoded[6],
                        encoded[7],
                        encoded[8],
                        encoded[9],
                        encoded[10]
                    };
        $display("%s", print_str);
        $display("============================");
        $finish();

    //data_i <= 128'h00112233445566778899AABBCCDDEEFF;
    //#10;
    //data_i <= zeros;
    //reset = 0;
    //#5
    //data_i <= zeros;

end
endmodule
