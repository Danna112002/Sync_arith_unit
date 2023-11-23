EXAMPLE         = porownanie
MODEL_FILES     = ${EXAMPLE}.sv
RTL_FILES       = ${EXAMPLE}_rtl.sv
TB_FILES        = ${EXAMPLE}_tb.sv

# Domyślny target
all: rtl sim

# Target, który syntetyzuje moduł i robi plik rtl
rtl:
	yosys -s run.ys | tee synth.log

# Target, który dokonuje symulacji
sim: compile
	./$(EXAMPLE).iveri.run

# Kompilowanie modułów verilog do programu wykonawczego
compile: clear
	iverilog -g2005-sv \
		$(MODEL_FILES) $(RTL_FILES) $(TB_FILES) \
		-o $(EXAMPLE).iveri.run 2>&1 | tee $(EXAMPLE).iveri.log

# Uruchomienie przeglądu przebiegów
waves:
	gtkwave signals_${EXAMPLE}.vcd &

clear:
	if [ -f $(EXAMPLE).iveri.run ]; then rm $(EXAMPLE).iveri.run; fi

.PHONY: all rtl sim compile waves clear
