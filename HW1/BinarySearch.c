#include <stdint.h>
#include <stdio.h>
#include <stdbool.h>

uint16_t clz(uint32_t x) {
  if (x == 0)
    return 32;
  uint16_t n = 0;
  if (x <= 0x0000FFFF) {
    n += 16;
    x <<= 16;
  }
  if (x <= 0x00FFFFFF) {
    n += 8;
    x <<= 8;
  }
  if (x <= 0x0FFFFFFF) {
    n += 4;
    x <<= 4;
  }
  if (x <= 0x3FFFFFFF) {
    n += 2;
    x <<= 2;
  }
  if (x <= 0x7FFFFFFF) {
    n += 1;
    x <<= 1;
  }
  return n;
}
uint16_t ctz(uint32_t x) {
  if (x == 0)
    return 32;

  uint16_t n = 0;
  if (x & 0x1) {
    n = 0;
    return n;
  } // odd
  else {
    if ((x & 0x0000FFFF) == 0) {
      n += 16;
      x >>= 16;
    }
    if ((x & 0x000000FF) == 0) {
      n += 8;
      x >>= 8;
    }
    if ((x & 0x0000000F) == 0) {
      n += 4;
      x >>= 4;
    }
    if ((x & 0x00000003) == 0) {
      n += 2;
      x >>= 2;
    }
    if ((x & 0x00000001) == 0) {
      n += 1;
      x >>= 1;
    }
  }
  return n;
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