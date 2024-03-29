//jednostka arytmetyczno-logiczna 
`include "/home/ania/Pulpit/Studia/SCK/SCK_23Z/anna_dziezyk_sck23z_projekt_indywidualny/WORK/Verilog_modul_ustawienie/ustawienie.sv"
`include "/home/ania/Pulpit/Studia/SCK/SCK_23Z/anna_dziezyk_sck23z_projekt_indywidualny/WORK/Verilog_modul_przesuniecie/przesuniecie.sv"
`include "/home/ania/Pulpit/Studia/SCK/SCK_23Z/anna_dziezyk_sck23z_projekt_indywidualny/WORK/Verilog_modul_porownanie/porownanie.sv"
`include "/home/ania/Pulpit/Studia/SCK/SCK_23Z/anna_dziezyk_sck23z_projekt_indywidualny/WORK/Verilog_modul_konwersja/konwersja.sv"
module sync_arith_unit_12 (
    i_arg_A, 
    i_arg_B, 
    i_op, 
    i_clk, 
    i_reset, 
    o_result, 
    o_status, 
    o_error_konw, 
    o_error_przes, 
    o_error_ust
    );

    parameter BITS = 32;

    //zadeklarowanie wejść i wyjść 
    input logic signed   [BITS-1:0] i_arg_A;
    input logic signed   [BITS-1:0] i_arg_B; 
    input logic          [1:0]      i_op;
    input logic                     i_clk;
    input logic                     i_reset;
    output logic signed  [BITS-1:0] o_result;
    output logic         [3:0]      o_status;
    output logic                    o_error_konw;
    output logic                    o_error_przes; 
    output logic                    o_error_ust;

    //zadeklarowanie pomocniczych zmiennych do rejestrowania flag i wewnętrznych rejestrów
    logic [BITS-1:0] wynik;
    logic [BITS-1:0] konw_wynik;
    logic poro_wynik;
    logic [BITS-1:0] przesu_wynik;
    logic [BITS-1:0] ustaw_wynik;
    logic [BITS-1:0] wektor;
    logic flaga_ERROR;
    logic flaga_NOT_EVEN_ZERO;
    logic flaga_ZEROS;
    logic flaga_OVERFLOW;

    //jawne przypisywanie portów do pojedynczych modułów
    konwersja           #(.BITS(BITS))        
    konwersja            (.i_arg_A(i_arg_A), .o_result(konw_wynik), .o_error(o_error_konw));    
    porownanie          #(.BITS(BITS))        
    porownanie           (.i_arg_A(i_arg_A), .i_arg_B(i_arg_B), .o_result(poro_wynik));
    ustawienie          #(.BITS(BITS))        
    ustawienie           (.i_arg_A(i_arg_A), .i_arg_B(i_arg_B), .o_result(ustaw_wynik), .o_error(o_error_ust));
    przesuniecie        #(.BITS(BITS))  
    przesuniecie         (.i_arg_A(i_arg_A), .i_arg_B(i_arg_B), .o_result(przesu_wynik), .o_error(o_error_przes));

    //funkcja mi potrzebna by automatycznie mi parzystość zer liczyła
    //iteruje po wszystkich bitach sygnału wyniku i liczy zera
    //wypluwa modulo z dzielenia liczby zer na dwa.
    function IS_ODD_ZEROS(input logic [BITS-1:0] result);
        integer count_zeros;
        integer i;
        //iteracyjne liczenie zer
        count_zeros = 0;
        for (i = 0; i < BITS; i = i + 1) begin
            if (result[i] == 1'b0) begin
                count_zeros = count_zeros + 1;
            end
        end
        //dla nieparzystych zer zwracaj 1, jak nie to zero.
        if (count_zeros % 2 == 1) begin
            IS_ODD_ZEROS = 1'b1;
        end
        else begin
            IS_ODD_ZEROS = 1'b0;
        end
    endfunction

    //blok synchroniczny 
    always_comb
    begin
        //wybór operacji na danych wejściowych i_oper;
        case(i_op)
            2'b01 : wynik = poro_wynik;
            2'b10 : wynik = ustaw_wynik;
            2'b11 : wynik = przesu_wynik;
            2'b00 : wynik = konw_wynik;
            default :
            wynik = 'bx;
        endcase        

        flaga_ERROR = '0;
        flaga_NOT_EVEN_ZERO = '0;
        flaga_OVERFLOW = '0;
        flaga_ZEROS = '0;
         
        //ustawianie flag
        //flaga ERROR 
        if ((o_error_konw == '1)||(o_error_przes == '1)||(o_error_ust == '1)) begin
            flaga_ERROR = 1'b1;
            flaga_NOT_EVEN_ZERO = 1'b0;
            flaga_ZEROS = 1'b0;
        end
        //flaga sygnalizuje nieparzystą liczbę zer w wyniku 
        if (IS_ODD_ZEROS(wynik)==1) begin
            flaga_NOT_EVEN_ZERO = 1'b1;
        end
        //flaga sygnalizuje, że wynik to same zera
        if (wynik == '0) begin
            flaga_ZEROS = 1'b1;
        end
    end

    //blok synchronizowalny
    always_ff @(posedge i_clk, posedge i_reset) begin
        if (i_reset==1'b1) begin
        o_result <= '0;
        o_status <= '0;
        end
        else begin
        o_result <= wynik;
        o_status <= {flaga_ERROR, flaga_NOT_EVEN_ZERO, flaga_ZEROS, flaga_OVERFLOW};
        end
    end
endmodule



