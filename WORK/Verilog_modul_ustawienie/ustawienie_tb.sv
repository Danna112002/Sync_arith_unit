// testbench modułu ustawienia bitu na 1 na bicie i_arg_A o indeksie i_arg_B
// zaczynamy ławeczkę testową
module ustawienie_tb;
    parameter BITS = 32;
    localparam TOP = 2**(BITS-1)-1;
    localparam BOTTOM = -(2**(BITS-1)-1);

    // sygnały wewnętrzne dla tej konketnej ławeczki testowej 
    logic [BITS-1:0] s_i_arg_A;
    logic [BITS-1:0] s_i_arg_B;
    logic            s_o_error_model;
    logic            s_o_error_synthesis;
    logic [BITS-1:0] s_o_model;
    logic [BITS-1:0] s_o_synthesis;
    integer i;

    // instancjowanie wejść i wyjść, jawne przypisywanie portów
    ustawienie #(.BITS(BITS))        
    ustawienie (
        .i_arg_A(s_i_arg_A), 
        .i_arg_B(s_i_arg_B), 
        .o_result(s_o_model), 
        .o_error(s_o_error_model)
        );    

    ustawienie_rtl           
    ustawienie_rtl (
        .i_arg_A(s_i_arg_A), 
        .i_arg_B(s_i_arg_B), 
        .o_result(s_o_synthesis), 
        .o_error(s_o_error_synthesis)
        );

    // Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
    initial begin
        s_i_arg_A = '0;
        s_i_arg_B = '0;

        //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji
        $dumpfile("signals_ustawienie.vcd");  

        //Wskazania, że wszystkie sygnały z testbench i niżej mają być rejestrowane podczas symulacji
        $dumpvars(0, ustawienie_tb);       

        //najpierw testujemy przypadek idealny, na zerze najłatwiej zauważyć
        for (int i=0; i<6; i++) begin
            #1  
            s_i_arg_A = '1;
            s_i_arg_B = $urandom_range(1, BITS-1);
        end
        //teraz zobaczymy przypadki losowe dla liczb ujemnych 
        for (i=0; i<6; i++) begin
            #1  
            s_i_arg_B = $urandom_range(BOTTOM, -1);
        end

        //teraz zobaczymy przypadki losowe dla liczb >=32
        for (i=0; i<6; i++) begin
            #1  
            s_i_arg_B = $urandom_range(BITS, TOP);
        end

        //teraz zobaczymy przypadki losowe dla różnych reprezentacji 0, gdy B=0
        //zawartość A w każdym momencie tego modułu nie ma najmniejszego znaczenia
            #1  
            s_i_arg_B = '0;
            #1
            s_i_arg_B = {1'b1, '0};

        $finish;
    end
endmodule