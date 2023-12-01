#include <stdint.h>
#include <stdio.h>
#include <string.h>

extern uint64_t get_cycles();
extern uint64_t get_instret();

/*
 * Taken from the Sparkle-suite which is a collection of lightweight symmetric
 * cryptographic algorithms currently in the final round of the NIST
 * standardization effort.
 * See https://sparkle-lwc.github.io/
 */
extern void sparkle_asm();

#define WORDS 12
#define ROUNDS 7

int main(void)
{


    /* measure cycles */
    uint64_t instret = get_instret();
    uint64_t oldcount = get_cycles();
    printf("1\n");
    sparkle_asm();
    printf("\n2\n");
    uint64_t cyclecount = get_cycles() - oldcount;

    printf("cycle count: %u\n", (unsigned int) cyclecount);
    printf("instret: %x\n", (unsigned) (instret & 0xffffffff));

    return 0;
}
