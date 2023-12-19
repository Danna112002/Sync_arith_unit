//testbench modułu porowananie.sv
//wstępnie przewidziany bez żadnych błędów ani przepełnienia w środku

module porownanie_tb;

parameter BITS=32;
localparam MOD_NUMBER = BITS-1;

// sygnały wewnętrzne
logic [BITS-1:0] s_i_arg_A;
logic [BITS-1:0] s_i_arg_B;
logic  s_o_model;
logic  s_o_synthesis;

// instancjowanie wejść i wyjść, jawne przypisywanie portów

porownanie     #(.BITS(BITS))        
porownanie     (
    .i_arg_A(s_i_arg_A), 
    .i_arg_B(s_i_arg_B), 
    .o_result(s_o_model)
    );    

porownanie_rtl           
Porownanie_rtl (
    .i_arg_A(s_i_arg_A), 
    .i_arg_B(s_i_arg_B), 
    .o_result(s_o_synthesis)
    );    

// Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
initial begin
    //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji
        $dumpfile("signals_porownanie.vcd");  

        //Wskazania, że wszystkie sygnały z testbencha i niżej mają być rejestrowane podczas symulacji
        $dumpvars(0, porownanie_tb);   

        //początkowe wyzerowanie wartości sygnałów A i B
        s_i_arg_A = 0;
        s_i_arg_B = '1;      
        #1

                // Pętla for przypisująca losowe wartości argumentom wejścia dla pięciu iteracji, rozpoczęcie symulacji
        for (int i=0; i<=10; i++) begin
            #1
            s_i_arg_A = $urandom;
            s_i_arg_B = $urandom;
        end
        
       for (int i = 0; i<5; i++) begin
            #1
            s_i_arg_A = '0;
            //przesunięcie równe zero, to każde B jest 0, ale krwa znaczone, ofc, że znaczone
            s_i_arg_B = '1;
            #1
            s_i_arg_B = ~{1'b0, {MOD_NUMBER{1'b1}}};
        end

        for (int i = 0; i<5; i++) begin
            #1
            s_i_arg_A = {1'b1, {MOD_NUMBER{1'b0}}};
            //przesunięcie równe zero, to każde B jest 0, ale krwa znaczone, ofc, że znaczone
            s_i_arg_B = '1;
            #1
            s_i_arg_B = ~{1'b0, {MOD_NUMBER{1'b1}}};
        end

    end
endmodule