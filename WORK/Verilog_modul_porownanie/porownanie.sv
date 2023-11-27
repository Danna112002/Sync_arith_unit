//moduł porównania wartości sygnałów wejściowych A i B

module porownanie (i_arg_A, i_arg_B, o_result);
    parameter BITS = 32;

    //deklarowanie wejść i wyjść
    input logic signed [BITS-1:0] i_arg_A;
    input logic signed [BITS-1:0] i_arg_B;
    output logic signed o_result;

    //blok opisujący logikę
    always_comb 
    begin
        //defaultowe zerowanie wyjścia
        o_result = 0;
        //zaczynamy porównywanie

        if (i_arg_A > (~i_arg_B)) begin
            o_result = 1;
        end

        else begin
            o_result = 0;
        end
    end
endmodule