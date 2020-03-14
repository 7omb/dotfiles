#!/bin/sh
# Remap the tile key on MacOS
# The simplest way to load it on Startup is to place it in:
# System Preferences -> User -> Startup objects

 hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},{"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064}]}'