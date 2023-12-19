//moduł porównania wartości sygnałów wejściowych A i B

module porownanie (i_arg_A, i_arg_B, o_result);
    parameter BITS = 32;
    localparam MOD_NUMBER = BITS-1;

    //deklarowanie wejść i wyjść
    input logic signed [BITS-1:0] i_arg_A;
    input logic signed [BITS-1:0] i_arg_B;
    output logic signed o_result;

    //blok opisujący logikę
    always_comb begin
        //zaczynamy porównywanie
        if (i_arg_A > (~i_arg_B)) begin
            o_result = 1;
        end

//||i_arg_A == {1'b1, {MOD_NUMBER{1'b0}}}) && (~i_arg_B == {MOD_NUMBER{1'b0}}
//||~i_arg_B == {1'b1, {MOD_NUMBER{1'b0}}}))

        else if (i_arg_A == {MOD_NUMBER{1'b0}}&&~i_arg_B == {MOD_NUMBER{1'b0}}) begin
            o_result = 0;
        end

        else if (i_arg_A == {MOD_NUMBER{1'b0}}&&~i_arg_B == {1'b1, {MOD_NUMBER{1'b0}}}) begin
            o_result = 0;
        end

        else if (i_arg_A == {1'b1, {MOD_NUMBER{1'b0}}} &&~i_arg_B == {1'b1, {MOD_NUMBER{1'b0}}}) begin
            o_result = 0;
        end
 
        else if (i_arg_A == {1'b1, {MOD_NUMBER{1'b0}}}&&~i_arg_B == {MOD_NUMBER{1'b0}}) begin
            o_result = 0;
        end

        else begin
            o_result = 0;
        end
    end
endmodule