/* 
  Interrupt enable, was a function-like macro (not translated by bindgen)
*/
void CyGlobalIntEnable(void){
  __asm("CPSIE   i");
}

/* 
  Interrupt disable, was a function-like macro (not translated by bindgen)
*/
void CyGlobalIntDisable(void){
  __asm("CPSID   i");
}