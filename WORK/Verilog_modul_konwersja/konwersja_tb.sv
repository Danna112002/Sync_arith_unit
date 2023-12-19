//testbench dla modułu konwersji
//wstępnie przewidziany z kilkoma testami warunków brzegowych
module konwersja_tb;

    parameter BITS = 32;
    localparam MOD_NUMBER = BITS-1;

    // sygnały wewnętrzne i ich atrybuty
    logic [BITS-1:0] s_i_arg_A;
    logic [BITS-1:0] s_o_model;
    logic [BITS-1:0] s_o_synthesis;
    logic            s_o_error_model;
    logic            s_o_error_synthesis;
    integer i;

    // instancjowanie wejść i wyjść, jawne przypisywanie portów
    konwersja     #(.BITS(BITS))        
    konwersja (
        .i_arg_A(s_i_arg_A), 
        .o_result(s_o_model), 
        .o_error(s_o_error_model)
        );

    konwersja_rtl           
    konwersja_rtl (
        .i_arg_A(s_i_arg_A), 
        .o_result(s_o_synthesis), 
        .o_error(s_o_error_synthesis)
        );    

    // Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
    initial begin
        s_i_arg_A = '0;

        //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji 
        $dumpfile("signals_konwersja.vcd"); 

        //Wskazania ze wszystkie sygnaly z testbench i nizej maja byc rejestrowane podczas symulacji
        $dumpvars(0, konwersja_tb);   
        
        // Pętla for przypisująca losowe wartości argumentom wejścia dla pięciu iteracji, rozpoczęcie symulacji
        //przypadki losowe, ale totalnie wpadające w zakres normalnego zachowania modułu
        for(i = 0; i < 6; i++) begin
                #1 s_i_arg_A = $urandom;
        end

        //test na ujemne zero:
        #1
        s_i_arg_A = {1'b1, {MOD_NUMBER{1'b0}}};

        //test na zero 
        #1
        s_i_arg_A = {{BITS{1'b1}}};

        //test na maksymalną i minimalną wartość:
        #1    
        s_i_arg_A = {1'b1, '1};
        #1
        s_i_arg_A = {1'b0, '1};
        #1
        $finish;
    end
endmodule