// moduł przesunięcia bitowego wejścia A o ~B bitów 
module przesuniecie (i_arg_A, i_arg_B, o_result, o_error);

    // zadeklarowanie parametru szerokości wektorów wejściowych
    parameter BITS = 32;
    localparam MOD_NUMBER = BITS-1;

    // zadeklarowanie wektorów wejściowych i wyjściowych
    input logic signed [BITS-1:0] i_arg_A;
    input logic signed [BITS-1:0] i_arg_B;
    output logic signed [BITS-1:0] o_result;
    output logic o_error;

    always_comb begin
        //domyślnie ustawione wartości wyjść
        o_result = 'bx;
        o_error = 0;

        //przypadek wzorowy, przesunięcie nie przekracza 31 bitów
        // żadne flagi się nie zapalają
        if (~i_arg_B > 0 && ~i_arg_B < BITS) begin
            o_result = i_arg_A >> ~i_arg_B;
            o_error = 0;
        end

        // przypadek, jak przesunięcie wynosi 0, to wynik jest taki sam, jak wejście A
        // żadne flagi się nie zapalają
        else if (~i_arg_B =='0 || i_arg_A=='0 || i_arg_A == {1'b0, {MOD_NUMBER{1'b1}}} || ~i_arg_B == {1'b1, {MOD_NUMBER{1'b0}}}) begin
            o_result = i_arg_A;
            o_error = 0;
        end

        // przypadek, jak przesunięcie jest >=BITS 
        //znaczy się bity ustawiamy na zera lub na jedynki w zależności od znaku A
        else if (~i_arg_B >= BITS) begin
            o_result = (i_arg_A < 0) ? {MOD_NUMBER{1'b1}} : {MOD_NUMBER{1'b0}};
            o_error = 0;
        end

        //przypadek, gdy przesunięcie jest ujemne - wynik jest nezdefiniowany i zapalony jest bit błędu
        else if (~i_arg_B <= -1) begin
            o_error = 1;        
        end  
    end
endmodule