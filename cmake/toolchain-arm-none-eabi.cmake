# =============================
# ARM Cortex-M Toolchain File
# =============================

# This tells CMake that we are cross-compiling
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Prevent CMake from using host system flags
set(CMAKE_OSX_SYSROOT "")
set(CMAKE_OSX_ARCHITECTURES "")
unset(CMAKE_OSX_DEPLOYMENT_TARGET CACHE)

# Path prefix of the ARM toolchain
set(TOOLCHAIN_PATH /Applications/ArmGNUToolchain/15.2.rel1/arm-none-eabi)
set(TOOLCHAIN_PREFIX ${TOOLCHAIN_PATH}/bin/arm-none-eabi)

# Compilers
set(CMAKE_C_COMPILER     ${TOOLCHAIN_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER   ${TOOLCHAIN_PREFIX}-g++)
set(CMAKE_ASM_COMPILER   ${TOOLCHAIN_PREFIX}-gcc)

# Tools
set(CMAKE_OBJCOPY        ${TOOLCHAIN_PREFIX}-objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE           ${TOOLCHAIN_PREFIX}-size CACHE INTERNAL "size tool")

# No standard libraries from host system
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# Prevent CMake from testing compiler with platform flags
set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)

# CPU settings
#set(MCU_FLAGS "-mcpu=cortex-m4 -mthumb")

# Common C flags
#set(CMAKE_C_FLAGS_INIT "${MCU_FLAGS} -ffreestanding -fno-builtin -Wall -Wextra")

# ASM flags
#set(CMAKE_ASM_FLAGS_INIT "${MCU_FLAGS}")

# C++ flags (if needed)
#set(CMAKE_CXX_FLAGS_INIT "${MCU_FLAGS} -fno-exceptions -fno-rtti")

# Linker flags (the main CMakeLists passes the linker script)
#set(CMAKE_EXE_LINKER_FLAGS_INIT "${MCU_FLAGS} -nostdlib -Wl,--gc-sections")