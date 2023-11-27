// testbench modułu przesunięcia arytmetycznego 
// zaczynamy moduł ławeczki testowej
module przesuniecie_tb;

    //parametryzowanie sygnałów, duże, bo chcemy sobie zobaczyć zachowanie sygnału B
    //na większym zakresie niż pół cyferki
    parameter BITS=32;
    localparam TOP = 2**(BITS-1)-1;
    localparam BOTTOM = -(2**(BITS-1)-1);
    
    // sygnały wewnętrzne w tej konkretnej ławeczce testowej
    logic [BITS-1:0] s_i_arg_A;
    logic [BITS-1:0] s_i_arg_B;
    logic            s_o_error_model;
    logic            s_o_error_synthesis;
    logic [BITS-1:0] s_o_model;
    logic [BITS-1:0] s_o_synthesis;    
    
    // instancjowanie wejść i wyjść, jawne przypisywanie portów, łączenie kabelków
    przesuniecie     #(.BITS(BITS))        
    przesuniecie     (
        .i_arg_A(s_i_arg_A), 
        .i_arg_B(s_i_arg_B),
        .o_result(s_o_model), 
        .o_error(s_o_error_model)
        ); 

    przesuniecie_rtl           
    przesuniecie_rtl (
        .i_arg_A(s_i_arg_A), 
        .i_arg_B(s_i_arg_B), 
        .o_result(s_o_synthesis), 
        .o_error(s_o_error_synthesis)
        );

    // Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
    initial begin

        //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji
        $dumpfile("signals_przesuniecie.vcd");  

        //Wskazania, że wszystkie sygnały z testbencha i niżej mają być rejestrowane podczas symulacji
        $dumpvars(0, przesuniecie_tb);   

        //początkowe wyzerowanie wartości sygnałów A i B
        s_i_arg_A=0;
        s_i_arg_B=0;      

        //wygenerowanie losowych wartości dla wybranych przeze mnie przypadków
        //ściągawka: maksymalne A = 2**BITS - 1; minimalne A = -(2**BITS - 1);
        for (int i = 0; i<5; i++) begin
            //wartości A dla idealnego przypadku
            #1
            s_i_arg_A = $urandom_range(BOTTOM, TOP); 
            //losowanie z maksymalnego zakresu B, które to wartości będą przypadkami wzorowymi
            s_i_arg_B = ~$urandom_range(0, BITS-1);          
        end
    
        for (int i = 0; i<5; i++) begin
            #1
            //przesunięcie równe zero, to każde B jest 0, ale krwa znaczone, ofc, że znaczone
            s_i_arg_B = '1;
            s_i_arg_B = {1'b0, '1};
        end

        for (int i = 0; i<5; i++) begin       
            #1
            //przesunięcie negatywne
            s_i_arg_B = ~$urandom_range(BOTTOM, -1);
        end

        for (int i = 0; i<5; i++) begin 
            #1
            //B dla >=32 przesunięcia to
            s_i_arg_B = $urandom_range(BITS, TOP);
        end

        //skrajne przypadki, ujemne zero i dodatnie zero w argumencie A
        //maksymalny integer dodatni, maksymalny integer ujemny dla b>=bits+1
        s_i_arg_A = {1'b1, '0};
        s_i_arg_B = ~$urandom_range(BITS, TOP);
        #1
        s_i_arg_A = '1;
        s_i_arg_B = ~$urandom_range(BITS, TOP);
        #1
        s_i_arg_A = '0;
        s_i_arg_B = ~$urandom_range(BITS, TOP);
        #1
        s_i_arg_A = {1'b0, '1};
        s_i_arg_B = ~$urandom_range(BITS, TOP);
        #1
        
    $finish;
    end    
endmodule