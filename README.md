# aft-hello-uart
Fork of riscv-hello-uart
M/S-mode RISC-V assembly code with UART output for execution in AFTx07. Used for basic print to magic address (0xB0000000) testing.
Comment out mret to run in M-mode, else it runs in S-mode.

### Building:
make meminit

### Cleaning:
make clean

### Running:
Run with Vaftx07 executable.
Vaftx07 meminit.bin