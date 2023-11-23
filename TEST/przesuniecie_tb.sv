// testbench modułu przesunięcia arytmetycznego 
// zaczynamy moduł ławeczki testowej
module przesuniecie_tb;

    //parametryzowanie sygnałów, duże, bo chcemy sobie zobaczyć zachowanie sygnału B
    //na większym zakresie niż pół cyferki
    parameter BITS=32;
    
    // sygnały wewnętrzne w tej konkretnej ławeczce testowej
    logic [BITS-1:0] s_i_arg_A;
    logic [BITS-1:0] s_i_arg_B;
    logic            s_o_error_model;
    logic            s_o_error_synthesis;
    logic            s_o_overflow_model;
    logic            s_o_overflow_synthesis;
    logic [BITS-1:0] s_o_model;
    logic [BITS-1:0] s_o_synthesis;    
    
    // instancjowanie wejść i wyjść, jawne przypisywanie portów, łączenie kabelków
    przesuniecie     #(.BITS(BITS))        
    przesuniecie     (
        .i_arg_A(s_i_arg_A), 
        .i_arg_B(s_i_arg_B),
        .o_result(s_o_model), 
        .o_error(s_o_error_model), 
        .o_overflow(s_o_overflow_model)
        ); 

    przesuniecie_rtl           
    przesuniecie_rtl (
        .i_arg_A(s_i_arg_A), 
        .i_arg_B(s_i_arg_B), 
        .o_result(s_o_synthesis), 
        .o_error(s_o_error_synthesis), 
        .o_overflow(s_o_overflow_synthesis)
        );

    // Dostarczenie zmiennych do testu, rozpoczęcie bloku initial
    initial begin

        //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji
        $dumpfile("signals.vcd");  

        //Wskazania, że wszystkie sygnały z testbencha i niżej mają być rejestrowane podczas symulacji
        $dumpvars(0, przesuniecie_tb);   

        //początkowe wyzerowanie wartości sygnałów A i B
        s_i_arg_A=0;
        s_i_arg_B=0;      
        #1

        //wygenerowanie losowych wartości dla wybranych przeze mnie przypadków
        //ściągawka: maksymalne A = 2**BITS - 1; minimalne A = -(2**BITS - 1);
        for (int i = 0; i < 5; i++) begin

            //tablica wartości A dla idealnego przypadku
            #1
            s_i_arg_A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1); 
            //losowanie z maksymalnego zakresu B, które to wartości będą przypadkami wzorowymi
            s_i_arg_B = $urandom_range(0, 31);          
        end
    
        for (int i = 0; i<5; i++) begin        
            //tablica wartości A dla przesunięcia równego zero
            #1
            s_i_arg_A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //przesunięcie równe zero, to każde B jest 0
            s_i_arg_B = 0;
        end

        for (int i = 0; i<5; i++) begin       
            //tablica wartości A dla negatywnego przesunięcia
            #1
            s_i_arg_A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //przesunięcie negatywne
            s_i_arg_B = $urandom_range(-2**(BITS-1)+1, -1);
        end

        for (int i = 0; i<5; i++) begin       
            //A dla masymalnego przesunięcia
            #1
            s_i_arg_A = $urandom_range(2**(BITS-2), 2**(BITS-1)-1);
            //B maksymalnego przesunięcia, to zawsze 32
            s_i_arg_B = 32;
        end

        for (int i = 0; i<5; i++) begin       
            //A dla przepełnienia
            #1
            s_i_arg_A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //b dla przepełnienia z odpowiedniego zakresu
            s_i_arg_B = $urandom_range(33, 2**(BITS-1)-1);
        end

        //skrajne przypadki, ujemne zero i dodatnie zero,
        //maksymalny integer dodatni, maksymalny integer ujemny dla maksymalnego przesunięcia
        #1
        s_i_arg_A = {1'b1, 31'b0};
        s_i_arg_B = 32;
        #1
        s_i_arg_A = {1'b1, 31'b1};
        s_i_arg_B = 32;
        #1
        s_i_arg_A = {1'b0, 31'b0};
        s_i_arg_B = 32;
        #1
        s_i_arg_A = {1'b0, 31'b1};
        s_i_arg_B = 32;
        #1

        //skrajne przypadki, ujemne zero i dodatnie zero,
        //maksymalny integer dodatni, maksymalny integer ujemny dla przepełnienia
        s_i_arg_A = {1'b1, 31'b0};
        s_i_arg_B = $urandom_range(33, 2**(BITS-1)-1);
        #1
        s_i_arg_A = {1'b1, 31'b1};
        s_i_arg_B = $urandom_range(33, 2**(BITS-1)-1);
        #1
        s_i_arg_A = {1'b0, 31'b0};
        s_i_arg_B = $urandom_range(33, 2**(BITS-1)-1);
        #1
        s_i_arg_A = {1'b0, 31'b1};
        s_i_arg_B = $urandom_range(33, 2**(BITS-1)-1);
        #1
        
    $finish;
    end    
endmodule