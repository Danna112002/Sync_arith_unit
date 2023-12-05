//testbench ALU;
`timescale 1s/1ms

module sync_arith_unit_12_tb;

    parameter BITS=32;
    //sygnały sterujące 
    logic               i_clk, i_reset = '1;
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
        .i_op(i_op), 
        .i_clk(i_clk), 
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
        .o_result(o_result_gates), 
        .o_status(o_status_gates)
        );

        //generujemy sygnał zegarowy
        always #1 i_clk <= ~i_clk;

        //blok generacji losowych danych 
        integer seed_data=0;

        //na sztywno symulacja ma 80 przypadków do zrobienia
        always @(i_clk)
        begin
            #1
                i_arg_A = $random;
                i_arg_B = $random;
                i_op = $urandom_range(0,3);
        end

        integer liczba_testow=0;
        integer liczba_bledow=0;


    //dla opadającego zbocza pokazuj staty
    always @(posedge i_clk)
    begin
        liczba_testow = liczba_testow + 1;

            if ((o_result_model === o_result_gates)&&(o_result_model === o_result_gates))
            begin
                $display("OK @(%0d): Dane wyjsciowe modelu i bramek zgodne: %d === %d",
                $time, o_result_gates, o_result_model);
            end

            else
            begin
                $display("!!! BLAD @(%0d): Dane wyjsciowe modelu i bramek niezgodne: %d === %d",
                $time, o_result_gates, o_result_model);
                liczba_bledow = liczba_bledow + 1;
            end
    end

    //blok zadania wartosci początkowych i czasu symulacji 
    initial begin
        $dumpfile("signals_ALU.vcd");
        $dumpvars(0, sync_arith_unit_12_tb);
        #1
        i_clk<=0;
        i_reset<=0;
        i_arg_A<='0;
        i_arg_B<='0;
        i_op<='0;
        #80;
        $display("--------------------");
        $display("Liczba testow: %0d, liczba bledow: %0d", liczba_testow, liczba_bledow);
        $display("--------------------");
        $finish;
    end

endmodule