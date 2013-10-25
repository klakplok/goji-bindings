BINDINGS=canvas howler raphael box2d phonegap
GENERATED=$(patsubst %, bindings/%, $(BINDINGS))

.PHONY: clean examples

all: $(GENERATED) examples

bindings/%: descriptions/%.ml
	ocamlfind ocamlopt -shared -package goji_lib $< -o descriptions/$*.cmxs
	-if [ ! -e bindings ] ; then mkdir bindings ; fi
	goji generate -d bindings descriptions/$*.cmxs
	cd bindings/$* && export OCAMLPATH="../" && make && make doc

clean:
	-rm -rf */*.cm* */*.o *~ */*~ bindings
	cd examples && make clean

examples:
	export OCAMLPATH=$$(pwd)/bindings/ ; cd examples ; make
