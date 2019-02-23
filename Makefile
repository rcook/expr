ALL_TARGETS :=
PROGRAM_NAME := expr
MAIN_SOURCES := $(PROGRAM_NAME).ml
MAIN_TARGETS := \
	$(PROGRAM_NAME) \
	$(PROGRAM_NAME).cmi \
	$(PROGRAM_NAME).cmo \
	$(PROGRAM_NAME).cmx \
	$(PROGRAM_NAME).o

.PHONY: default
default: $(PROGRAM_NAME)

$(MAIN_TARGETS): $(MAIN_SOURCES)
	ocamlfind ocamlopt -o $@ -thread -linkpkg -package core $<
ALL_TARGETS += $(MAIN_TARGETS)

clean:
	rm -rf $(ALL_TARGETS)
