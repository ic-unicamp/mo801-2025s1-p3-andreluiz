#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define N 32
#define Temperatura 5
//#define DEBUG

void create_spin_lattice(int proportion){
  FILE *memory;
  memory = fopen("memory.mem","w");
  
  if (memory == NULL) {
        perror("Erro ao abrir o arquivo");
        return;
  }
  
  for(int i=0; i<N; i++){
    for(int j=0; j<N; j++){
      float random = (rand() % 1000) + 1;
      char bit;
      if(random >= proportion)
        bit = 1;
      else
        bit = 0;
      
      fprintf(memory,"%c",bit+'0');
    }
      fprintf(memory,"\n");
  }
  fclose(memory);
}

int main() {
    srand(time(NULL));
    
    //Prepara o modelo
    create_spin_lattice(350);

    return 0;
}
