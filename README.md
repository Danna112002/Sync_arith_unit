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

Działanie kodu obserwowane będzie na analizie wyników zachowania modułów *'testbench'* w analizatorze ***GTKWave***. Sprawozdanie z przeprowadzonych testów zostało udokumentowane, znajduje się w folderze DOC. Aby po pobraniu uruchomić dany moduł i obserwować jego działanie, należy pobrać folder z modułem z folderu WORK, wejść do katalogu z modułem, następnie w terminalu wpisać kolejno:

$ make

$ make clear

$ make waves.

Poniżej znajdują się wypunktowane programy rekomendowane do uruchomienia modułów.
- ***Visual Studio Code*** - edycja oraz tworzenie kodu modułów i dokumentacji.
- ***GTKWave Analyzer*** - wersja v3.3.104 (w)1999-2020 BSI, analiza przebiegów sygnałów zegarowych przed syntezą i po niej.
- ***Yosys Open Synthesis Suite*** - wersja 0.36 - framework do syntezy poziomu transferu rejestru Verilog, w tym przypadku: System Verilog.
- ***Meld*** - porównywanie kodów modułów w celach poszukiwań latchów i niedociąnięć.
- ***Icarus Verilog*** - wersja 12.0 - implementacja kompilatora języka opisu sprzętu Verilog, która generuje listy sieci w żądanym formacie oraz symulator.

## Przeznaczenie

Przeznaczeniem tej niewielkiej jednostki wykonawczej jest bycie częścią większej magistrali złożonej z dodatkowo dwóch innych jednostek wykonawczych, w skład których wchodzą implementacje innych podstawowych modułów. 

## Współpraca z innymi członkami

Po wykonaniu indywidualnego zadania utworzenia własnej jednostki arytmetyczno-logicznej, cały zespół będzie odpowiedzialny za zaprojektowanie magistrali komunikującej się z odpowiednio zmodyfikowanymi modułami ***sync_arith_unit_12***  według zadanego przez prowadzącego protokołu komunikacyjnego.





