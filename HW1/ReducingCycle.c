#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

uint16_t clz(uint32_t x)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);

    /* count ones (population count) */
    x -= ((x >> 1) & 0x55555555);
    x = ((x >> 2) & 0x33333333) + (x & 0x33333333 );
    x = ((x >> 4) + x) & 0x0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);
    return (32 - (x & 0x3f));
}
uint16_t ctz(uint32_t x) {
  x |= (x << 1);
  x |= (x << 2);
  x |= (x << 4);
  x |= (x << 8);
  x |= (x << 16);
  // count ones (population count)
  x -= ((x >> 1) & 0x55555555);
  x = ((x >> 2) & 0x33333333) + (x & 0x33333333);
  x = ((x >> 4) + x) & 0x0f0f0f0f;
  x += (x >> 8);
  x += (x >> 16);
  return (32 - (x & 0x3f));
}
int main(){

  uint32_t x=0x01000000 ,y=0x0000015,product=0; 
  uint16_t exp_x=0,exp_y=0,ctz_x=0;
  exp_x=clz(x);
  exp_y=clz(y);
  if((64 - exp_x - exp_y) < 32){
    ctz_x =ctz(x);
    x = x >> ctz_x;
    for(int i=0;i<=(int)32-exp_x-ctz_x;i++){
      if(x&0x00000001){      
        product+=y;
      }
      y=y<<1;
      x=x>>1;
    }
    product = product << ctz_x;
    printf("%u",product);
  }
  else{
    printf("Overflow!");   
  }  
}