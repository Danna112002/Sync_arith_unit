// moduł przesunięcia arytmetycznego wejścia A o ~B bitów 
module przesuniecie (i_arg_A, i_arg_B, o_result, o_error, o_overflow);

// zadeklarowanie parametru szerokości wektorów wejściowych
parameter BITS = 32;

// zadeklarowanie wektorów wejściowych wraz z ich atrybutami
input logic  [BITS-1:0] i_arg_A;
input logic  [BITS-1:0] i_arg_B;

// zadeklarowanie wektora wyjściowego z jego atrybutami
output logic [BITS-1:0] o_result;

// zadeklarowanie bitów błędu i przepełnienia
output logic o_error;
output logic o_overflow;

always_comb 
begin

    //przypadek wzorowy, przesunięcie nie przekracza 31 bitów
    // żadne flagi się nie zapalają
    if (~i_arg_B > 0 && ~i_arg_B < 32) begin
        o_result = i_arg_A >> i_arg_B;
        o_error = '0;
        o_overflow = '0;
    end

    // przypadek, jak przesunięcie wynosi 0, to wynik jest taki sam, jak wejście A
    // żadne flagi się nie zapalają
    else if (~i_arg_B == 0) begin
        o_result = i_arg_A;
        o_error = '0;
        o_overflow = '0;
    end

    // przypadek, jak przesunięcie wynosi tyle samo, co długość wektora wejściowego A. 
    // czyli 32 bity - przepełnienia nie ma, bo przesunęliśmy wszystkie bity i ani jednego więcej,
    // błędu nie ma, bo wartość wyjściowa jest ustawiona na ALL ONES lub ALL ZEROS w zależności od
    // znaku wektora wejściowego A: gdy A jest ujemne, wynik jest ustawiony na ALL ONES, 
    // w przeciwnym przypadku to jest ALL ZEROS
    else if (~i_arg_B == 32) begin
        o_result = (i_arg_A < 0) ? '1 :'0;
        o_error = '0;
        o_overflow = '0;
    end

    //przypadek, gdy przesunięcie jest ujemne - wynik jest nezdefiniowany i zapalony jest bit błędu
    // bit przepełnienia jest wyłączony, bo to nie jest przepełnienie, tylko błąd operacji
    else if (~i_arg_B < 0) begin
        o_result = $unknown;
        o_error = '1;        
        o_overflow = '0;
    end
    
    // przypadek, gdy dochodzi do przepełnienia, więc zapalamy bit flagi przepełnienia, ale nie jest to
    // błąd operacji, chociaż wynik jest nieokreślony
    else if (~i_arg_B > 32) begin
        o_result = $unknown;
        o_error = '0;
        o_overflow = '1;
    end    
end
endmodule