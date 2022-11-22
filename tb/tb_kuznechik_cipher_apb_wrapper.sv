`timescale 1ns/1ps

module tb_kuznechik_cipher_apb_wrapper();

    ////////////////////
    // Design package //
    ////////////////////

    import kuznechik_cipher_apb_wrapper_pkg::*;


    ////////////////
    // Parameters //
    ////////////////

    // Clock period
    parameter real CLK_PERIOD = 10;

    // Test iterations
    parameter TEST_ITERATIONS = 100;

    // Test timeout (clock periods)
    parameter TEST_TIMEOUT = 100000;


    ////////////////////
    // Design signals //
    ////////////////////

    logic             pclk_i;
    logic             presetn_i;
    logic      [31:0] paddr_i;
    logic             psel_i;
    logic             penable_i;
    logic             pwrite_i;
    logic [3:0] [7:0] pwdata_i;
    logic       [3:0] pstrb_i;
    logic             pready_o;
    logic      [31:0] prdata_o;
    logic             pslverr_o;


    /////////
    // DUT //
    /////////

    grasspopper_module DUT (
        .pclk_i     ( pclk_i    ),
        .presetn_i  ( presetn_i ),
        .paddr_i    ( paddr_i   ),
        .psel_i     ( psel_i    ),
        .penable_i  ( penable_i ),
        .pwrite_i   ( pwrite_i  ),
        .pwdata_i   ( pwdata_i  ),
        .pstrb_i    ( pstrb_i   ),
        .pready_o   ( pready_o  ),
        .prdata_o   ( prdata_o  ),
        .pslverr_o  ( pslverr_o )
    );


    ///////////
    // Tasks //
    ///////////

    // Reset

    task reset();
        fork
            begin
                presetn_i <= 1'b0;
                #(5*CLK_PERIOD);
                presetn_i <= 1'b1;
            end
            begin
                paddr_i   <= '0;
                psel_i    <= '0;
                penable_i <= '0;
                pwrite_i  <= '0;
                pwdata_i  <= '0;
                pstrb_i   <= '0;
            end
        join
    endtask

    // APB

    task automatic exec_apb_write_trans(
        input bit [31:0] paddr,
        input bit [31:0] pwdata,
        input bit  [3:0] pstrb,
        input bit        pslverr
    );
        // Setup phase
        paddr_i  <= paddr;
        psel_i   <= 1'b1;
        pwrite_i <= 1'b1;
        pwdata_i <= pwdata;
        pstrb_i  <= pstrb;
        // Access phase
        @(posedge pclk_i);
        penable_i <= 1'b1;
        do begin
            @(posedge pclk_i);
        end while(!pready_o);
        // Check error
        check_pslverr(pslverr_o, pslverr);
        // Save data
        pslverr = pslverr_o;
        // Unset penable
        penable_i <= 1'b0;
    endtask

    task automatic exec_apb_read_trans(
        input  bit [31:0] paddr,
        output bit [31:0] prdata,
        input  bit        pslverr
    );
        // Setup phase
        paddr_i  <= paddr;
        psel_i   <= 1'b1;
        pwrite_i <= 1'b0;
        // Access phase
        @(posedge pclk_i);
        penable_i <= 1'b1;
        do begin
            @(posedge pclk_i);
        end while(!pready_o);
        // Check error
        check_pslverr(pslverr_o, pslverr);
        // Save data
        prdata = prdata_o;
        // Unset penable
        penable_i <= 1'b0;
    endtask

    // Specific

    task get_cipher_control(
        output bit [31:0] control,
        input  bit        pslverr
    );
        exec_apb_read_trans(CONTROL, control, pslverr);
    endtask

    task get_cipher_busy(
        output bit busy,
        input  bit        pslverr
    );
        bit [31:0] control;
        exec_apb_read_trans(CONTROL, control, pslverr);
        busy = control[BUSY*8];
    endtask

    task get_cipher_valid(
        output bit valid,
        input  bit pslverr
    );
        bit [31:0] control;
        exec_apb_read_trans(CONTROL, control, pslverr);
        valid = control[VALID*8];
    endtask

    task set_cipher_req_ack(
        input bit pslverr
    );
        automatic bit [31:0] control = 1 << REQ_ACK*8;
        set_cipher_control(control, pslverr);
    endtask

    task set_cipher_rst(
        input bit pslverr
    );
        automatic bit [31:0] control = '0;
        set_cipher_control(control, pslverr);
    endtask

    task set_cipher_control(
        input  bit [31:0] control,
        input  bit        pslverr
    );
        bit [3:0] pstrb;
        pstrb[BUSY]    = 0; pstrb[VALID] = 0;
        pstrb[REQ_ACK] = 1; pstrb[RST]   = 1;
        exec_apb_write_trans(CONTROL, control, pstrb, pslverr);
    endtask

    task get_cipher_data_out(
        output bit [3:0][31:0] data,
        input  bit      [ 3:0] pslverr
    );
        for(int i = 0; i < 4; i = i + 1)
            exec_apb_read_trans(DATA_OUT + 4*i, data[i], pslverr[i]);
    endtask

    task set_cipher_data_in(
        input  bit [3:0][31:0] data,
        input  bit      [ 3:0] pslverr
    );
        for(int i = 0; i < 4; i = i + 1)
            exec_apb_write_trans(DATA_IN + 4*i, data[i], 4'b1111, pslverr[i]);
    endtask

    task get_cipher_data_in(
        output bit [3:0][31:0] data,
        input  bit      [ 3:0] pslverr
    );
        for(int i = 0; i < 4; i = i + 1)
            exec_apb_read_trans(DATA_IN + 4*i, data[i], pslverr[i]);
    endtask

    task cipher_set_and_req(
        input  bit [3:0][31:0] data_in
    );
        bit [3:0][7:0] control;
        // Set reset register to one
        control[RST] = 1;
        // Set data
        set_cipher_data_in(data_in, 4'b0000);
        // Request encrypt
        control[REQ_ACK] = 1;
        set_cipher_control(control, 1'b0);
    endtask

    task cipher_get_and_ack(
        output bit [3:0][31:0] data_out
    );
        bit            valid;
        bit [3:0][7:0] control;
        // Set control register
        control[RST    ] = 1;
        control[REQ_ACK] = 1;
        // Wait for encryption
        do begin
            get_cipher_valid(valid, 1'b0);
        end while(!valid);
        // Get encripted data
        get_cipher_data_out(data_out, 4'b0000);
        // Set ack
        set_cipher_control(control, 1'b0);
    endtask

    task cipher_encrypt_data(
        input  bit [3:0][31:0] data_in,
        output bit [3:0][31:0] data_out
    );
        cipher_set_and_req(data_in);
        cipher_get_and_ack(data_out);
    endtask

    // Checkers

    function void check_pslverr(
        input bit pslverr,
        input bit level
    );
        if(pslverr != level) begin
            $error("PSLVERR = %0b detected but not expected", pslverr);
            $stop();
        end
    endfunction

    // Tests

    task reg_valid_read_write_test(int iterations = 10);
        bit [3:0][ 7:0] control_in;
        bit [3:0][ 7:0] control_out;
        bit [3:0][31:0] data_in;
        bit [3:0][31:0] data_out;
        $display("\nStarting valid write/read (%0d iterations)", iterations);
        for(int i = 0; i < iterations; i = i + 1) begin
            $display("Iteration %0d", i);
            void'(std::randomize(control_in, data_in) with {
                control_in[RST    ][0] == 1; // No reset
                control_in[REQ_ACK][0] == 0; // No ack or request
                control_in[BUSY   ]    == 0; // Zero busy
                control_in[VALID  ]    == 0; // Zero valid
            });
            set_cipher_control(control_in,  1'b0);
            set_cipher_data_in(data_in,  4'b0000);
            get_cipher_data_in(data_out, 4'b0000);
            if(data_in != data_out) begin
                $error("DATA_IN[WRITE] != DATA_IN[READ]: %h != %h", data_in, data_out);
                $stop();
            end
        end
    endtask

    task reg_invalid_read_write_test(int iterations = 10);
        bit      [ 3:0] pstrb;
        bit [3:0][ 7:0] control_in;
        bit [3:0][ 7:0] control_out;
        bit [3:0][31:0] data_in;
        bit [3:0][31:0] data_out;
        $display("\nStarting invalid write/read (%0d iterations)", iterations);
        pstrb[BUSY ] = 1; // Write busy
        pstrb[VALID] = 1; // Write valid
        for(int i = 0; i < iterations; i = i + 1) begin
            $display("Iteration %0d", i);
            void'(std::randomize(control_in, data_in) with {
                control_in[RST    ][0] == 1; // No reset
                control_in[REQ_ACK][0] == 0; // No ack or request
            });
            exec_apb_write_trans(CONTROL, control_in, pstrb, 1'b1);
            for(int i = 0; i < 4; i = i + 1)
                exec_apb_write_trans(DATA_OUT + 4*i, data_in[i], 4'b1111, 1'b1);
        end
    endtask

    task work_mode_test(int iterations = 10);
        bit [3:0][31:0] data_in;
        bit [3:0][31:0] data_out;
        $display("\nStarting work mode test (%0d iterations)", iterations);
        for(int i = 0; i < iterations; i = i + 1) begin
            $display("Iteration %0d", i);
            void'(std::randomize(data_in));
            // Encrypt data
            $display("Encrypting data: %h", data_in);
            cipher_encrypt_data(data_in, data_out);
            $display("Got encrypted data: %h", data_out);
        end
    endtask

    task int_work_mode_test(int iterations = 10);
        /*bit [3:0][31:0] data_in;
        bit [3:0][31:0] data_out;
        bit [3:0][ 7:0] control;
        // Set control register
        control[RST    ] = 1;
        control[REQ_ACK] = 1;
        $display("\nStarting interrupted work mode test (%0d iterations)", iterations);
        for(int i = 0; i < iterations; i = i + 1) begin
            $display("Iteration %0d", i);
            void'(std::randomize(data_in));
            $display("Encrypting data: %h", data_in);
            // Set data and request encrypt
            cipher_set_and_req(data_in);
            // Set request again
            // Here we expecting slave error
            $display("Interrupting");
            set_cipher_control(control, 1'b1);
            // Get encrypted data
            cipher_get_and_ack(data_out);
            $display("Got encrypted data: %h", data_out);
        end*/
    endtask

    task reset_work_mode_test(int iterations = 10);
        bit             status;
        bit      [ 3:0] pstrb;
        bit [3:0][31:0] data_in;
        bit [3:0][ 7:0] control;
        // Set control register
        control[RST    ] = 0;
        control[REQ_ACK] = 0;
        // Set strobes for control register
        pstrb[RST    ] = 1; // Setting reset here
        pstrb[REQ_ACK] = 0; // Not setting request-ack here
        $display("\nStarting reset work mode test (%0d iterations)", iterations);
        for(int i = 0; i < iterations; i = i + 1) begin
            $display("Iteration %0d", i);
            void'(std::randomize(data_in));
            $display("Encrypting data: %h", data_in);
            // Set data and request encrypt
            cipher_set_and_req(data_in);
            // Set reset
            $display("Applying reset");
            exec_apb_write_trans(CONTROL, control, pstrb, 1'b0);
            // Here we expecting zero busy and valid registers
            get_cipher_valid(status, 1'b0);
            if(status) begin
                $error("VALID == 1 detected but reset was applied");
                $stop();
            end
            get_cipher_busy(status, 1'b0);
            if(status) begin
                $error("BUSY == 1 detected but reset was applied");
                $stop();
            end
        end
    endtask

    //////////////
    // Stimulus //
    //////////////

    // Clock
    initial begin
        pclk_i = 1'b0;
        forever begin
            #(CLK_PERIOD/2) pclk_i = ~pclk_i;
        end
    end

    // Main stimulus
    initial begin
        fork
            begin
                reset();
                reg_valid_read_write_test  (TEST_ITERATIONS);
                reg_invalid_read_write_test(TEST_ITERATIONS);
                work_mode_test             (TEST_ITERATIONS);
                int_work_mode_test         (TEST_ITERATIONS);
                reset_work_mode_test       (TEST_ITERATIONS);
                $display("\nAll tests done");
            end
            begin
                repeat(TEST_TIMEOUT) @(posedge pclk_i);
                $error("\nTest was failed: timeout");
            end
        join_any
        $finish();
    end

endmodule
