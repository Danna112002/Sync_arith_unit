//testbench ALU;
`timescale 1ns/1ps

module sync_arith_unit_12_tb;

    parameter BITS=32;
    localparam CLKPERIOD = 5;
    localparam SIMTIME = 1000;

    //sygnały sterujące 
    logic               i_reset = '0;
    logic               i_clk = '1;
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

    //generacja sygnału zegarowego               
    always #CLKPERIOD i_clk = ~i_clk;

    //dla opadającego zbocza zegara pokazuj staty
    integer liczba_testow=0;
    integer liczba_bledow=0;

    always @(negedge i_clk) begin
        liczba_testow = liczba_testow + 1;
        if (o_result_model === o_result_gates && o_status_model === o_status_gates) begin
            $display("OK @(%0d): Dane wyjsciowe modelu i bramek zgodne: %d === %d, %b === %b",
                $time, o_result_gates, o_result_model, o_status_gates, o_status_model);
        end 
        else begin
            $display("!!! BLAD @(%0d): Dane wyjsciowe modelu i bramek niezgodne: %d === %d, %b === %b",
                $time, o_result_gates, o_result_model, o_status_gates, o_status_model);
            liczba_bledow = liczba_bledow + 1;
        end
    end

    //blok zadania wartosci początkowych i czasu symulacji 
    initial begin

        i_clk = 0;
        i_reset = 1;
        #10;
        
        repeat (100) begin
            i_arg_A = $random;
            i_arg_B = $random;
            i_op = $urandom_range(0, 3);
            #10;  
        end

        #SIMTIME
        $display("--------------------");
        $display("Liczba testow: %0d, liczba bledow: %0d", liczba_testow, liczba_bledow);
        $display("--------------------");
        $finish;
    end
endmodule
