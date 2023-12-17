CONFIG_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
HOSTNAME := $(shell hostname)
TARGET ?= $(HOSTNAME)
HOSTS := $(shell ls $(CONFIG_DIR)/hosts)

.PHONY: update
update:
	nix flake update

.PHONY: switch
switch: TARGET=${HOSTNAME}
switch:
ifeq ($(TARGET), $(HOSTNAME))
	sudo nixos-rebuild -L switch --flake ".#${TARGET}"
else ifneq (, $(filter $(TARGET), $(HOSTS)))
	NIX_SSHOPTS="-t" nixos-rebuild -L switch --target-host "${TARGET}" --use-remote-sudo --flake ".#${TARGET}"
else
	@echo "Unknown host: ${TARGET}"
	@echo "Known hosts are: ${HOSTS}"
endif

.PHONY: upgrade
upgrade:
	$(MAKE) update
	$(MAKE) switch

.PHONY: gc
gc:
	sudo nix-collect-garbage --delete-old
	nix-collect-garbage --delete-old
	sudo /run/current-system/bin/switch-to-configuration boot
