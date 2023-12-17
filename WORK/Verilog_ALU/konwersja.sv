// moduł konwersji liczby A zapisanej w kodzie ZM na liczbę kodowaną w U2

//nasz maksymalny zakresik konwersji:
//<-(2^30)+1, 2^30-1>
module konwersja (i_arg_A, o_result, o_error);

    //zadeklarowanie szerokości wektora wejścia
    parameter BITS = 32;

    //zadeklarowanie wejścia i wyjść
    input logic signed [BITS-1:0] i_arg_A;
    output logic [BITS-1:0] o_result;
    output logic o_error;    
    wire logic i_arg_A_MSB;
    wire logic i_arg_A_MSB_2;
    wire [BITS-2:0] i_arg_A_REST;

    assign  i_arg_A_MSB = i_arg_A[BITS-1];
    assign  i_arg_A_MSB_2 = i_arg_A[BITS-2];
    assign  i_arg_A_REST = i_arg_A[BITS-2:0];

    //blok opisujący logikę
    always_comb begin
        //defaultowe ustawienie wartości wyjścia i wejścia
        o_result = 'bx;
        o_error = 0;

        //sytuacja, jak mamy dodatnią liczbę kodowaną w typie ZM, to nic nie trzeba robić
        if (i_arg_A_MSB == 0) begin
            o_result = i_arg_A;
        end
    
        //sytuacja, jak mamy ujemną liczbę kodowaną w ZM, to korzystamy z formuły
        //wyjscie = {1'b1, ~i_arg_A[BITS-2] +1'b1}
        //mamy w ogóle jakiekolwiek wyjście, dopóki nam się zero ujemne nie wylosuje. 
        //nie ma takiej opcji, że on poprawnie przekonwertuje mi {1'b1, '0}
        else if (i_arg_A_MSB == 1 && |i_arg_A_REST != 0) begin
            o_result = {1'b1, (~i_arg_A_MSB_2) +1'b1};
        end
        else begin 
            o_error = 1;
        end
    end
endmodule