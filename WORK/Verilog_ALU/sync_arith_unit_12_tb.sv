//testbench ALU;
`timescale 1ns/1ps

module sync_arith_unit_12_tb;

    parameter BITS=32;
    localparam CLKPERIOD = 5;
    localparam SIMTIME = 1000;

    //sygnały sterujące 
    logic               i_reset = '0;
    logic               i_clk = '0;
    logic [BITS-1:0]    i_arg_A, i_arg_B;
    logic [1:0]         i_op;
    //wyjścia danych
    logic [BITS-1:0]    o_result_model;
    logic [3:0]         o_status_model;
    logic [BITS-1:0]    o_result_gates;
    logic [3:0]         o_status_gates;
    //jawne przypisanie portów
    //model
    sync_arith_unit_12 #(.BITS(BITS))
    sync_arith_unit_12  (
            .i_arg_A(i_arg_A),
            .i_arg_B(i_arg_B), 
            .i_clk(i_clk),
            .i_reset(i_reset),
            .i_op(i_op), 
            .o_result(o_result_model), 
            .o_status(o_status_model)
            );


    //bramki
    sync_arith_unit_12_rtl 
    sync_arith_unit_12_rtl (
            .i_arg_A(i_arg_A), 
            .i_arg_B(i_arg_B), 
            .i_op(i_op), 
            .i_clk(i_clk),
            .i_reset(i_reset), 
            .o_result(o_result_gates), 
            .o_status(o_status_gates) 
            );
    
    initial begin
        forever begin
            #10
            i_op = $urandom_range(0,3);            
        end
    end

        
    initial begin
        forever begin
            #10
            i_arg_A = $urandom;                 
        end
    end

   initial begin
        forever begin
            #10
            i_arg_B = $urandom;
            
            if ($time >= SIMTIME) begin
                $stop;  
            end
        end
    end

    

    initial begin 
        forever begin 
            #CLKPERIOD i_clk = ~i_clk;
        end
    end 

    initial begin
        forever begin
            #CLKPERIOD i_reset = ~i_reset;
        end
    end


    initial begin 

        //i_arg_A<='0;
        //i_arg_B<='0;
        //i_op<='0;
        $dumpfile("signals_ALU.vcd");
        $dumpvars(0, sync_arith_unit_12_tb);
        #SIMTIME;
        $finish;
    end

endmodule