cmake_minimum_required(VERSION 3.20)

project(EMPTY C ASM)

# Sources
add_executable(${PROJECT_NAME}
    Core/Src/main.c
    Core/Src/stm32l0xx_hal_msp.c
    Core/Src/stm32l0xx_it.c
    Core/Src/system_stm32l0xx.c
    Core/Src/syscalls.c
    Core/Src/sysmem.c
    Core/Startup/startup_stm32l073rztx.s
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_cortex.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_dma.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_exti.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash_ex.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash_ramfunc.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_flash.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_gpio.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c_ex.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_i2c.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_rcc_ex.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr_ex.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_pwr.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart_ex.c
    Drivers/STM32L0xx_HAL_Driver/Src/stm32l0xx_hal_uart.c
)
set_target_properties(EMPTY PROPERTIES OUTPUT_NAME "EMPTY.elf")

# Include directories
target_include_directories(${PROJECT_NAME} PRIVATE
    Core/Inc
    Drivers/STM32L0xx_HAL_Driver/Inc
    Drivers/CMSIS/Device/ST/STM32L0xx/Include
    Drivers/CMSIS/Include
)

# Compiler definitions
target_compile_definitions(${PROJECT_NAME} PRIVATE
    STM32L073xx
    USE_HAL_DRIVER
)

# Convert ELF to BIN after build
find_program(CMAKE_OBJCOPY arm-none-eabi-objcopy)
add_custom_command(TARGET EMPTY POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:EMPTY> ${CMAKE_BINARY_DIR}/${PROJECT_NAME}.bin
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Compile options for ARM Cortex-M
target_compile_options(${PROJECT_NAME} PRIVATE
    -mcpu=cortex-m0plus
    -mthumb
    -O0
    -g
    -Wall
    -ffunction-sections
    -fdata-sections
)

# Linker options
target_link_options(${PROJECT_NAME} PRIVATE
    -T${CMAKE_SOURCE_DIR}/STM32L073RZTX_FLASH.ld
    -mcpu=cortex-m0plus
    -mthumb
    --specs=nano.specs
    --specs=nosys.specs
    -Wl,--gc-sections
    -Wl,-Map=${CMAKE_BINARY_DIR}/${PROJECT_NAME}.map
)