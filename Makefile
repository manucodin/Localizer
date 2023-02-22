EXECUTABLE_NAME = localizer

prefix ?= /usr/local
bindir = $(prefix)/bin
libdir = $(prefix)/lib

build:
	rm -rf .build
	swift build -c release --disable-sandbox

install: build
	install -d "$(bindir)" "$(libdir)"
	install ".build/release/$(EXECUTABLE_NAME)" "$(bindir)"

uninstall:
		rm -rf "$(bindir)/$(EXECUTABLE_NAME)"

clean:
	rm -rf .build

.PHONY: build install uninstall clean
