#!/bin/bash
# Flash script for STM32 Nucleo L073RZ

if [ ! -f "build/EMPTY.bin" ]; then
    echo "Error: build/EMPTY.bin not found. Build the project first."
    exit 1
fi

echo "Flashing STM32L073RZ..."
st-flash write build/EMPTY.bin 0x08000000

if [ $? -eq 0 ]; then
    echo "✓ Flashing completed successfully!"
else
    echo "✗ Flashing failed!"
    exit 1
fi
