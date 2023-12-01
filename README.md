# 2023_Computuer_architecture
[HW1](https://hackmd.io/@LLL00/Computer_Architecture_HW1)
[HW2](https://hackmd.io/@LLL00/Computer_Architecture_HW2)
[HW3](https://hackmd.io/@LLL00/Computer_Architecture_HW3)
forked from [sysprog21/ca2023-lab3](https://github.com/sysprog21/ca2023-lab3)

# Assignment1: RISC-V Assembly and Instruction Pipeline
> Due: ==Oct 10, 2023==
## Requirements
1. Following the instructions of [Lab1: RV32I Simulator](/@sysprog/H1TpVYMdB), you shall write RISC-V assembly programs ([RV32I](https://en.wikipedia.org/wiki/RISC-V) ISA) and output to the console with environment calls.
    * Choose one problem (A, B, or C) from [Quiz1](https://hackmd.io/@sysprog/arch2023-quiz1), translate it from C code to a complete RISC-V assembly program, and include the relevant test data.
    * Generate a simplified (but still informative) use case that serves as the subject for your assignment, demonstrating the practical application of the above selected problem (i.e., derived from Problem A/B/C from [Quiz1](https://hackmd.io/@sysprog/arch2023-quiz1)). For instance, you can create a use case that involves performing branchless [counting leading zero](https://en.wikipedia.org/wiki/Leading_zero) operations on integer [base-2 values](https://man7.org/linux/man-pages/man3/log2.3.html) titled as "[Implement log2 with branchless clz](https://graphics.stanford.edu/~seander/bithacks.html)" or "[Matrix multiplication using bfloat16](https://huggingface.co/blog/hf-bitsandbytes-integration)."
    * You are required to use only RV32I instructions (without M or F/D extensions) for floating-point data manipulation. This means you should not depend on a C compiler to generate assembly routines; instead, you must write RISC-V assembly code from scratch.
    * At least 3 test data should be included in your program(s).
        * Without accepting an external data set, you can inline the predefined data.
    * Do choose a **unique subject** to work on, as each student should have a separate program. Starting earlier is advised to ensure you have ample time for your work.
    * Your program(s) must include loops (or recursive calls) and conditional branches, especially when writing test cases.
    * You must demonstrate iterative efforts to enhance the RISC-V programs, including reducing code size and minimizing runtime overhead, with explicit measurements.
    * Although **you MUST write down your own RISC-V assembly**, you can still verify the output of the C compiler's assembly output. As a result, you are able to describe the entire program.
    * You must ensure that the program functions correctly with the [Ripes](https://github.com/mortbopet/Ripes) simulator.
    * Reference: [Example RISC-V Assembly Programs](https://marz.utk.edu/my-courses/cosc230/book/example-risc-v-assembly-programs/)
2. You must provide explanations for both the program's functionality and the operation of each instruction using the [Ripes](https://github.com/mortbopet/Ripes) simulator.
    * Using the visualization for signals such as register write/enable signals, multiplexer input selection, and more, describe your application. You must provide examples for each stage, including IF, ID, IE, MEM, and WB. You should also explain the appropriate memory update steps. 
3. Write down your thoughts and progress in [HackMD notes](https://hackmd.io/s/features).
    * [Example page](https://hackmd.io/@kaeteyaruyo/risc-v-hw1)
        > :warning: Do not modify this note.
    * Insert your HackMD notes and RISC-V assembly programs in the following table.
    * Your HackMD page should be [Published](https://hackmd.io/s/all-about-profile-page) and editable as [Signed-in write](https://hackmd.io/@codimd/note-permission).
    * **Write in English** and feel free to utilize ChatGPT or [QuillBot](https://quillbot.com/) to improve your writing.

# Assignment2: GNU Toolchain
> Due: ==Oct 31, 2023==

## Requirements
1. Following the instructions in [Lab2: RISC-V RV32I[MACF] emulator with ELF support](https://hackmd.io/@sysprog/SJAR5XMmi), select one assembly program from [Assignment1: RISC-V Assembly and Instruction Pipeline](https://hackmd.io/@sysprog/2023-arch-homework1), and adapt it into both RISC-V assembly and C implementations that can be executed flawlessly with [rv32emu](https://github.com/sysprog21/rv32emu).
    * You must NOT select programs that you have previously submitted.
    * You should provide a brief description of your motivations for your selection.
    * You may choose to study the same subject as other students, but you must make your own discoveries.
    * There are just **RV32I** instructions that can be used. This means that you MUST build C programs with the `-march=rv32i -mabi=ilp32` flags.
        * RV32M (multiply and divide) and RV32F (single-precision floating point) are not permitted.
    * :warning: [rv32emu](https://github.com/sysprog21/rv32emu) and [Ripes](https://github.com/mortbopet/Ripes) may not work together, therefore please be aware of the potential incompatibility. Please check [docs/syscall.md](https://github.com/sysprog21/rv32emu/blob/master/docs/syscall.md) and [src/syscall.c](https://github.com/sysprog21/rv32emu/blob/master/src/syscall.c) in advance.
    * Do not duplicate workspaces or the entire repository from [rv32emu](https://github.com/sysprog21/rv32emu). As a starting point, copy the [`asm-hello`](https://github.com/sysprog21/rv32emu/tree/master/tests/asm-hello) directory instead. You shall modify `Makefile` and the linker script accordingly.
    * [kdnvt](https://github.com/kdnvt) produced [some excellent work](https://hackmd.io/@kdnvt/2022-arch-hw1) that can be used as a benchmark for program analysis and future optimizations. Please read his report carefully and pay attention to certain suggestions and observations.
    * (**Optional**) You have the choice to choose the programs, [pi.c](https://github.com/sysprog21/rv32emu/blob/master/tests/pi.c) and [nqueens.c](https://github.com/sysprog21/rv32emu/blob/master/tests/nqueens.c), and create RISC-V assembly that is superior to that produced by GNU Toolchain. That is, your handwritten RISC-V assembly program should run more quickly and occupy less space in the ELF image.
2. Disassemble the ELF files produced by the C compiler and contrast the handwritten and compiler-optimized assembly listings.
    * You can append the compilation options to experiment. e.g., Change `-Ofast` (optimized for speed) to `-Os` (optimized for size).
    * Describe your obserations and explain.
3. Check the [ticks.c](https://github.com/sysprog21/rv32emu/blob/master/tests/ticks.c) and [perfcounter](https://github.com/sysprog21/rv32emu/tree/master/tests/perfcounter) for the statistics of your program's execution. Then, try to optimize the handwritten/generated assembly. You shall read [RISC-V Assembly Programmer's Manual](https://github.com/riscv/riscv-asm-manual/blob/master/riscv-asm.md) carefully.
    * :warning: We care about CSR cycles at the moment.
    * Can you improve the assembly code generated by gcc with optimizations? Or, can you write even faster/smaller programs in RISC-V assembly?
    * You may drop some function calls and apply techniques such as [loop unrolling](https://en.wikipedia.org/wiki/Loop_unrolling) and [peephole optimization](http://homepage.cs.uiowa.edu/~dwjones/compiler/notes/38.shtml).
        > Quote from [RISC-V Instruction Set Manual](https://github.com/riscv/riscv-isa-manual): The RDCYCLE pseudo-instruction reads the low XLEN bits of the cycle CSR which holds a count of the number of clock cycles executed by the processor on which the hardware thread is running from an arbitrary start time in the past. RDCYCLEH is an RV32I-only instruction that reads bits 63–32 of the same cycle counter. The underlying 64-bit counter should never overflow in practice.
4. Write down your thoughts and progress in [HackMD notes](https://hackmd.io/s/features).
    * [Example page](https://hackmd.io/@wIVnCcUaTouAktrkMVLEMA/SJEP_amvK)
        > :warning: Do not modify this note.
    * Insert your HackMD notes and programs in the following table.
    * Of course, you MUST write in English.
5. BONUS: Find  the bugs inside [rv32emu](https://github.com/sysprog21/rv32emu) and send pull requests to improve it!

# Assignment3: single-cycle RISC-V CPU
> Due: ==Dec 1, 2023==

:::danger
:warning: This assignment is quite challenging, and it is recommended that you dedicate a minimum of **3 full days** to complete it. Otherwise, it may be difficult to produce a meaningful outcome.
:::

## Requirements
1. Following the instructions in [Lab3: Construct a single-cycle RISC-V CPU with Chisel](https://hackmd.io/@sysprog/r1mlr3I7p), engage with the [Chisel Tutorial](https://github.com/ucb-bar/chisel-tutorial) by completing the provided exercises.
    * Make sure you have already completed the exercises from Part 1 to Part 3.6 and are familiar with Chisel/Scala.
    * **Avoid frequent Google searches**, as the provided materials on the lab page are curated to facilitate your learning experience. Simply focus on learning by actively engaging with the prepared materials.
    * You may encounter various challenges during this process. Please review the [GitHub issues](https://github.com/freechipsproject/chisel-bootcamp/issues) and make note of your observations.
    * Describe the operation of 'Hello World in Chisel' and enhance it by incorporating logic circuit.
2. Adhering to the guidance provided in [Lab3: Construct a single-cycle RISC-V CPU with Chisel](https://hackmd.io/@sysprog/r1mlr3I7p), incorporate the code within the `// lab3` section in `src/main/scala/riscv/core/*.scala` to pass the corresponding unit tests. This hands-on approach encourages you to learn by actively participating in the process, enhancing your understanding of the subject matter.
    * **Refrain from copying and pasting your solution directly into the HackMD note**. Instead, provide a concise summary of the various test cases, outlining the aspects of the CPU they evaluate, the techniques employed for loading test program instructions, and the outcomes of these test cases.
    * For signals involved in filling in the blanks, use the testing framework to output waveform diagrams and describe the changes in key signals of corresponding components when executing different instructions.
    * Fork the GitHub repository [ca2023-lab3](https://github.com/sysprog21/ca2023-lab3) and make commits that correspond to your ongoing efforts accordingly. The progress should always be publicly visible and transparent. $\to$ Read the GitHub documentation, such as [Fork a repo](https://docs.github.com/en/get-started/quickstart/fork-a-repo).
3. Modify the handwritten RISC-V assembly code in [Homework2](https://hackmd.io/@sysprog/2023-arch-homework2) to ensure it functions correctly on the single-cycle RISC-V CPU aka "MyCPU" designed during [Lab3: Construct a single-cycle RISC-V CPU with Chisel](https://hackmd.io/@sysprog/r1mlr3I7p). Keep the modified code in the `csrc` directory.
    * Extend the Scala code in `src/test/scala/riscv/singlecycle/CPUTest.scala` to include additional test items related to your modified RISC-V assembly program. Ensure you compile it into an ELF file, which will later be converted into a binary file using the objcopy utility. Refer to the `FibonacciTest` as an example to see how to extend the [ChiselScalatestTester](https://index.scala-lang.org/ucb-bar/chiseltest) for testing the `src/main/resources/fibonacci.asmbin` program.
    * Execute your program using Verilator and analyze the signals by examining the waveform diagrams. Describe the variations in key signals of the respective components when different instructions are executed.
    * To ensure compatibility between the programs used in [Homework2](https://hackmd.io/@sysprog/2023-arch-homework2) and MyCPU, you should remove the `RDCYCLE`/`RDCYCLEH` instructions. Alternatively, you can expand the CPU's functionality by implementing the relevant CSR instructions, which would enable the execution of `RDCYCLE`/`RDCYCLEH` instructions on MyCPU.
5. Write down your thoughts and progress in [HackMD notes](https://hackmd.io/s/features).
    - Of course, you MUST write in English.
    - **Avoid using screenshots that solely contain plain text**. Here are the reasons why:
        * Text-based content is more efficiently searchable than having to browse through images iteratively.
        * The rendering engine of HackMD can consistently generate well-structured layouts with annotated text instead of relying on arbitrary pictures.
        * It provides a more accessible and user-friendly experience for individuals with visual impairments.
6. BONUS: Enhance MyCPU to provide improved ecall/break support, enabling RISC-V programs to make system calls similar to the functionalities available in [rv32emu](https://github.com/sysprog21/rv32emu).
