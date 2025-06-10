#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#define N 500
//#define DEBUG

typedef struct{
  int spins[N][N];
  float energy;
  float J;
}Ising;

void create_spin_lattice(Ising *model, int proportion){
  for(int i=0; i<N; i++){
    for(int j=0; j<N; j++){
      float random = (rand() % 1000) + 1;
      if(random >= proportion)
        model->spins[i][j] = 1;
      else
        model->spins[i][j] = -1;
    }
  }
}

void calculate_hamiltonian(Ising *model){
  model->energy = 0;
  for(int i=0; i<N; i++){
    for(int j=0; j<N; j++){
      int current_spin = model->spins[i][j];
      if(i!=0)
        model->energy+= model->spins[i-1][j]*current_spin;
      if(i!=N-1)
        model->energy+= model->spins[i+1][j]*current_spin;
      if(j!=0)
        model->energy+= model->spins[i][j-1]*current_spin;
      if(j!=N-1)
        model->energy+= model->spins[i][j+1]*current_spin;
    }
  }
  model->energy*=-model->J;
}

void isingStep(Ising *X_t, float Temp){
    float dE=0, dEy=0, dEx=0;

    //Rotate random spin
    int i=(rand() % N);
    int j=(rand() % N);
    #ifdef DEBUG
    printf("Rotate (%d,%d)\n",i,j);
    #endif
    int current_Y_spin = X_t->spins[i][j]*-1;

    //Calculate delta E
    if(i!=0){
      dEy+= X_t->spins[i-1][j]*current_Y_spin;
      dEx+= X_t->spins[i-1][j]*X_t->spins[i][j];
    }
    if(i!=N-1){
      dEy+= X_t->spins[i+1][j]*current_Y_spin;
      dEx+= X_t->spins[i+1][j]*X_t->spins[i][j];
    }
    if(j!=0){
      dEy+= X_t->spins[i][j-1]*current_Y_spin;
      dEx+= X_t->spins[i][j-1]*X_t->spins[i][j];
    }
    if(j!=N-1){
      dEy+= X_t->spins[i][j+1]*current_Y_spin;
      dEx+= X_t->spins[i][j+1]*X_t->spins[i][j];      
    }
    dE = X_t->J*(dEy - dEx);
    
    //Metropolis step
    if(dE<0){
      #ifdef DEBUG
      printf("dE<0");
      #endif
      X_t->spins[i][j] = current_Y_spin;
      X_t->energy += dE;
    }else{
      float U = ((rand() % 100) + 1)*0.01;
      float boltz_dist = -dE/Temp;
      float probability = exp(boltz_dist);
      float alpha = boltz_dist>1?1:probability;
      if(U<=alpha){
        #ifdef DEBUG
        printf("dE>0 e U<alpha");
        #endif
        X_t->spins[i][j] = current_Y_spin;
        X_t->energy += dE;
      }
    }
}

void print_model(Ising *X){
  for(int j=0; j<N; j++){
    for(int i=0; i<N; i++){
      if(X->spins[i][j] == -1)
        printf("%d,",X->spins[i][j]);
      else
        printf(" %d,",X->spins[i][j]);
    }
    printf("\n");
  }
}

int main() {
    srand(time(NULL));
    Ising X;
    X.J = 3;
    unsigned long int executions = 1000000;
    create_spin_lattice(&X,500);
    calculate_hamiltonian(&X);
    #ifdef DEBUG
    printf("X\nenergy: %f\n",X.energy);
    print_model(&X);
    #endif
    int i=0;
    for(i=0; i<executions; i++){
      isingStep(&X,0.5);
    }
    printf("%d",i);
    #ifdef DEBUG
    printf("X\nenergy: %f\n",X.energy);
    print_model(&X);
    #endif
    return 0;
}
