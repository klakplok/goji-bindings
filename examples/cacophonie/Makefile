.PHONY: clean

all: main.js libs.js

%.js: %.byte
	js_of_ocaml -pretty $< -o $@

libs.js:
	goji jslink howler raphael -o $@

main.byte: main.ml
	ocamlfind ocamlc -g -custom \
          -package howler,raphael,js_of_ocaml \
          $< -linkpkg -o $@

clean:
	rm -f *~ main.js libs.js *.byte *.cm*
