// This file is Copyright (c) 2020 Florent Kermarrec <florent@enjoy-digital.fr>
// License: BSD

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <irq.h>
#include <libbase/uart.h>
#include <libbase/console.h>
#include <generated/csr.h>
#include <time.h>
#define N 32
#define Temperatura 1
/*-----------------------------------------------------------------------*/
/* Uart                                                                  */
/*-----------------------------------------------------------------------*/

static void prompt(void)
{
	printf("\e[92;1mlitex-demo-app\e[0m> ");
}

/*-----------------------------------------------------------------------*/
/* Help                                                                  */
/*-----------------------------------------------------------------------*/

static void help(void)
{
	puts("\nLiteX minimal demo app built "__DATE__" "__TIME__"\n");
	puts("Available commands:");
	puts("help               - Show this command");
	puts("reboot             - Reboot CPU");
#ifdef CSR_LEDS_BASE
	puts("led                - Led demo");
#endif
	puts("donut              - Spinning Donut demo");
	puts("helloc             - Hello C");
	puts("helloc_andre       - Hello Andre");
        puts("matmul             - matmul");
#ifdef WITH_CXX
	puts("hellocpp           - Hello C++");
#endif
}

/*-----------------------------------------------------------------------*/
/* Commands                                                              */
/*-----------------------------------------------------------------------*/

static void reboot_cmd(void)
{
	ctrl_reset_write(1);
}

void create_spin_lattice(int proportion){
  unsigned long long int val=0;  
  printf("\n");
  for(int i=0; i<N; i++){
    val = 0;
    for(int j=N-1; j>=0; j--){
      int random = (rand() % 1000) + 1;
      char bit;
      if(random >= proportion){
        bit = 1;
        val += 1<<j;//val += 2 elevado a j
      }else{
        bit = 0;
      }
      printf("%d",bit);
   }
      printf("\n");
      ising_model_input_lattice_write(val);
  }
}


int main(void)
{
#ifdef CONFIG_CPU_HAS_INTERRUPT
	irq_setmask(0);
	irq_setie(1);
#endif
	uart_init();

	help();
	prompt();      
        
        srand(9);
        create_spin_lattice(750); 
         
        //printf("\nsubtrador= %d",i);
         
	return 0;
}
