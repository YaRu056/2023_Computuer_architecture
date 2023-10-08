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