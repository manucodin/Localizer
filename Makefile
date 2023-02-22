EXECUTABLE_NAME = localizer

BIN_PATH = /usr/local/bin
INSTALL_PATH = $(BIN_PATH)/$(EXECUTABLE_NAME)
BUILD_PATH = .build/release/$(EXECUTABLE_NAME)

install: build
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

uninstall:
	rm -rf $(INSTALL_PATH)

build:
	rm -rf .build
	swift build --configuration release

clean:
	rm -rf .build

.PHONY: build install uninstall clean
