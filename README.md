# Systemy Cyforwe i Komputerowe: projekt indywidualny

## Spis teści

- [Nazwa projektu](#Systemy-Cyforwe-i-Komputerowe:-projekt-indywidualny)
- [Opis](#Opis)
- [Uruchomienie i niezbędne środowiska](#uruchomienie-i-niezbędne-środowiska)
- [Przeznaczenie](#przeznaczenie)
- [Współpraca z innymi członkami](#Współpraca-z-innymi-członkami)


## Opis
Implementacja synchronicznej jednostki arytmetyczno-logicznej sync_arith_unit_12 w języku SystemVerilog. Realizuje 4 rodzaje prostych operacji arytmetycznych, logicznych i innych, zapisanych na liczbach całkowitych w kodzie ZM.

## Uruchomienie i niezbędne środowiska

Działanie kodu obserwowane będzie na analizie wyników zachowania modułów *'testbench'* w analizatorze ***GTKWave***. Sprawozdanie z przeprowadzonych testów zostanie udokumentowane, w dalszej części tego pliku znajdzie się link do odpowiedniego pliku.

- [***Visual Studio Code***](#https://code.visualstudio.com/) - edycja oraz tworzenie kodu modułów i dokumentacji
- [***GTKWave Analyzer***](#https://gtkwave.sourceforge.net/) - wersja v3.3.104 (w)1999-2020 BSI, analiza przebiegów sygnałów zegarowych przed syntezą i po niej
- [***Yosys Open Synthesis Suite***](#https://yosyshq.net/yosys/) - wersja 0.9 (git sha1 1979e0b) - framework do syntezy poziomu transferu rejestru Verilog, w tym przypadku: System Verilog.
- [***Meld(????)***](#https://meldmerge.org/) - porównywanie kodów modułów w celach bliżej mi niepoznanych, może się przyda
- ***Chhhuuuuusteczka wie co jeszcze*** - lista do późniejszej edycji

## Przeznaczenie

Przeznaczeniem tej niewielkiej jednostki wykonawczej jest bycie częścią większej magistrali złożonej z dodatkowo dwóch innych jednostek wykonawczych, w skład których wchodzą implementacje innych podstawowych modułów. 

## Współpraca z innymi członkami

Po wykonaniu indywidualnego zadania utworzenia własnej jednostki arytmetyczno-logicznej, cały zespół będzie odpowiedzialny za zaprojektowanie magistrali komunikującej się z odpowiednio zmodyfikowanymi modułami ***sync_arith_unit_12*** według zadanego przez prowadzącego protokołu komunikacyjnego.

## Dokumentacja z testów jednostkowych i testu modułowego

Link do dokumentu z dokumentacją dotyczącą całego modułu ***sync_arith_unit_12***
oraz poszczególnych jednostek:





