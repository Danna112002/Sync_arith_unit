//moduł ustawienia bitu w liczbie i_arg_A na 1, na indeksie wskazanym przez i_arg_B
module ustawienie (i_arg_A, i_arg_B, o_result, o_error);

//deklaracja parametrów
parameter BITS = 32;
localparam MOD_NUMBER = BITS -1;

//deklaracja wejść, wyjść i flag
    input logic signed [BITS-1:0] i_arg_A;
    input logic signed [BITS-1:0] i_arg_B;
    output logic signed [BITS-1:0] o_result;
    output logic o_error;
    logic [BITS-1:0] tymczasowy_rejestr;
    wire logic i_arg_B_MSB;

    assign i_arg_B_MSB = i_arg_B[BITS-1];

    //blok opisujący logikę
    always_comb begin 

        //defaultowe ustawienie wartości wyjść i rejestru tymczasowego
        o_result = 'bx;
        o_error = 0;
        tymczasowy_rejestr = '0;

        //jak B jest ujemne, to ustawiamy flagę błędu
        if (i_arg_B_MSB == 1 && i_arg_B != {1'b1, {MOD_NUMBER{1'b0}}}) begin
            o_error = 1;
        end

        //jak B jest większe od 31, to ustawiamy flagę błędu
        else if (i_arg_B > BITS-1) begin
            o_error = 1;
        end

        //inna reprezentacja B, to samo postępowanie, co wpadnięcie w zakres
        else if (i_arg_B == {MOD_NUMBER{1'b0}}) begin
            tymczasowy_rejestr[i_arg_B] = 0;
            o_result = tymczasowy_rejestr|(~i_arg_A);
        end

        //inna reprezentacja B, to samo postępowanie, co wpadnięcie w zakres 
        else if (i_arg_B == {1'b1, {MOD_NUMBER{1'b0}}}) begin
            tymczasowy_rejestr[i_arg_B] = 0;
            o_result = tymczasowy_rejestr|(~i_arg_A);
        end

        //jak B wpada w zakres, to ustawiamy tego bita
        else if ((i_arg_B>0) && i_arg_B<BITS) begin
            tymczasowy_rejestr[i_arg_B] = 1;
            o_result = tymczasowy_rejestr|(~i_arg_A);
        end

    end

endmodule

