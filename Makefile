EXECUTABLE_NAME = localizer

BIN_PATH = /usr/local/bin
INSTALL_PATH = $(BIN_PATH)/$(EXECUTABLE_NAME)
BUILD_PATH = .build/release/$(EXECUTABLE_NAME)

.PHONY: install build

install: build
	cp -f $(BUILD_PATH) $(INSTALL_PATH)

build:
	rm -rf .build
	swift build --configuration release