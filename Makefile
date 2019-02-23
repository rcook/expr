ALL_TARGETS :=
HELLO_SOURCES := hello.ml
HELLO_TARGETS := hello hello.cmi hello.cmo

.PHONY: default
default: hello

$(HELLO_TARGETS): $(HELLO_SOURCES)
	ocamlc -o $@ $<
ALL_TARGETS += $(HELLO_TARGETS)

clean:
	rm -rf $(ALL_TARGETS)
