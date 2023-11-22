// testbench modułu przesunięcia arytmetycznego 

// deklaracja skali zegarka dla tej symulacji
`timescale 1ns/1ps
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
    
    
    // tablica z kilkoma zestawami danych wejściowych
    typedef struct packed {
        int A;
        int B;
    } Testcase;

    Testcase testcases_examplary[0:4];
    Testcase testcases_zero_shift[0:4];
    Testcase testcases_32_shift[0:8];
    Testcase testcases_neg_shift[0:4];
    Testcase testcases_overflow[0:8];


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

        //inicjalizacja ziarna losowości, żeby funkcja $urandom wyszła z progu
        $randomseed;

        //w tym pliku zostaną zapisane zapisane sygnały zarejestrowane w symulacji
        $dumpfile("signals.vcd");  

        //Wskazania, że wszystkie sygnały z testbencha i niżej mają być rejestrowane podczas symulacji
        $dumpvars(0, przesuniecie_tb);   

        //początkowe wyzerowanie wartości sygnałów A i B
        s_i_arg_A=0;
        s_i_arg_B=0;

        //zapełnienie pierwszych czterech pól tablicy przepełnienia i maksymalnego przesunięcia
        //muszę zobaczyć, jak to się zachowuje
        //skrajne przypadki, ujemne zero i dodatnie zero,
        //maksymalny integer dodatni, maksymalny integer ujemny
        //Testcase testcases_32_shift[0:3].A = '{Testcase'(32'h1, 32'h0), Testcase'(32'h1, 32'h1), Testcase'(32'h0, 32'h0), Testcase'(32'h0, 32'h1)};

        //Testcase testcases_overflow[0:3].A = '{Testcase'(32'h1, 32'h0), Testcase'(32'h1, 32'h1), Testcase'(32'h0, 32'h0), Testcase'(32'h0, 32'h1)};

        //wygenerowanie losowych wartości dla wybranych przeze mnie przypadków
        //ściągawka: maksymalne A = 2**BITS - 1; minimalne A = -(2**BITS - 1);
        for (int i = 0; i < 5; i++) begin

            //tablica wartości A dla idealnego przypadku
            testcases_examplary[i].A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1); 
            //losowanie z maksymalnego zakresu B, które to wartości będą przypadkami wzorowymi
            testcases_examplary[i].B = $urandom_range(0, 31);
             //przypisanie wartości argumentom A i B
            #10
            s_i_arg_A = testcases_examplary[i].A;
            #10
            s_i_arg_B = testcases_examplary[i].B;

            //tablica wartości A dla przesunięcia równego zero
            testcases_zero_shift[i].A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //przesunięcie równe zero, to każde B jest 0
            testcases_zero_shift[i].B = 0;
            #10
            s_i_arg_A = testcases_zero_shift[i].A;
            #10
            s_i_arg_B = testcases_zero_shift[i].B;

            //tablica wartości A dla negatywnego przesunięcia
            testcases_neg_shift[i].A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //przesunięcie negatywne:
            testcases_neg_shift[i].B = $urandom_range(-2**(BITS-1)+1, 0);
            #10
            s_i_arg_A = testcases_neg_shift[i].A;
            #10
            s_i_arg_B = testcases_neg_shift[i].B;

        end

        for(i = 0; i<9; i++) begin
            //tablica wartości A dla przesunięcia maksymalnego z wartościami od 4 do 8 miejsca,
            //bo pierwsze 4 miejsca są zarezerwowane na 
            //skrajne przypadki, ujemne zero i dodatnie zero,
            testcases_32_shift[3+i].A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //przesunięcie maksymalne, to każde B jest 32
            testcases_32_shift[i].B = 32;

            //tablica wartości A dla przepełnienia
            testcases_overflow[3+i].A = $urandom_range(-2**(BITS-1)+1, 2**(BITS-1)-1);
            //tablica wartości B dla przepełnienia, przesunięcie musi być dłuższe od liczby bitów,
            //na których zapisane jest A
            testcases_overflow[i].B = $urandom_range(33, 2**(BITS-1)-1);
            
            //dokonanie testu dla przepełnienia
            #10
            s_i_arg_A = testcases_overflow[i].A;
            #10
            s_i_arg_B = testcases_overflow[i].B;

            //dokonanie testu dla maksymalnego przesunięcia
            #10
            s_i_arg_A = testcases_32_shift[i].A;
            #10
            s_i_arg_B = testcases_32_shift[i].B;
        end    
    $finish;
    end    
endmodule