# Repositório base para o Projeto 3

Aluno: André Luiz Vasconcelos Ferreira - 291649

## Breve descrição dos objetivos

O objetivo do presente projeto é implementar um periférico que sirva como um simulador de modelo Ising. Dessa forma, foi criado um SoC em que um código em C gera uma malha de spins aleatória e submete-a ao periférico que simula o comportamento dessa estrutura física. O sistema desenvolvido então calcula a variação de energia e o direcionamento dos spins do modelo Ising ao longo das iterações do algoritmo. 

A malha de spins do presente projeto tem dimensões 32x32 e o simulador atua em 1000 iterações.

## Desafios encontrados

O primeiro desafio foi entender o que é um modelo Ising e como utilizar o algoritmo de metropolis no contexto da simulação desse tipo de representação matemática;

O segundo desafio foi implementar o simulador de modelo Ising com uma linguagem de descrição de hardware (no caso, a linguagem escolhida para o presente projeto foi o verilog). A implementação se baseou no artigo  "FPGA Hardware Acceleration of Monte Carlo Simulations for the Ising Model". Além de entender os insights dos autores do trabalho, também houveram dificuldades relacionadas ao meu conhecimento de verilog, que ainda é recente.

O terceiro desafio foi adicionar o sistema escrito em verilog no simulador do litex. No trabalho 2 o periférico que desenvolvi foi escrito em Migen e era extremamente simples, neste trabalho o periférico foi escrito inteiramente em verilog e era muito mais complexo. Demorei um pouco para adicionar os arquivos .v ao sistema do simulador, mas no fim das contas apenas bastou criar um wrapper em migen que fazia a ponte entre o código do litex e os meus arquivos .v. 

Em relação aos problemas do modelo Ising em si no litex_sim, algumas barreiras são o tempo de execução e a dimensão das matrizes que o representam. O simulador não aceitava uma matriz 32x32 e a execução dos cálculos do modelo ising são lentas neste ambiente(quando executados sem auxílio de um periférico). Para superar essas questões, a implementação do modelo em verilog conta com uma técnica de paralelismo (Dividir a matriz em duas submatrizes, uma "branca" e uma "cinza".mais detalhes no relatório em pdf), o que permite atualização de vários spins ao mesmo tempo, e com lookup tables que agilizam os cálculos que envolvem o processo de flip de um spin(mais detalhes no relatório em pdf). 

## Barreiras alcançadas

Os dois simuladores de modelo Ising que implementei (um em C, executado no meu computador pessoal, e o em Verilog, executado no Litex_sim) tiveram resultados coerentes com a literatura, porém o presente no periférico apresenta um problemas cuja causa não consegui identificar: Os resultados da variação de energia ao longo do tempo e do direcionamento médio dos spins apresentam uma estranha oscilação que torna suas estatísticas estranhas(mais detalhes no relatório em pdf). Apesar dessas oscilações, quando coleto os dados apenas de 4 em 4 iterações, os gráficos do meu simulador ficam menos caóticos e com resultados menos estranhos. Não sei avaliar se a causa desse comportamento estranho é o paralelismo da minha solução (já que a implementação em C puro que foi executada no meu computador pessoal não conta com esse tipo de recurso) ou se envolve algum erro de implementação meu.

Outra dificuldade que acabei não superando é relacionada à geração de números aleatórios. O meu sistema possui sim uma aleatoriedade na geração de dados para seu funcionamento, mas não consegui pensar em uma forma de criar seeds variadas para a função rand() do C nem para as minhas implementações do Sfrl implementado para o periférico.  


## Comentários gerais e conclusões

O desenvolvimento deste projeto foi muito interessante uma vez que aprendi muitas coisas durante o processo. Primeiramente entendi melhor o que é o modelo Ising e como funciona a implementação mais famosa de seu simulador, por meio do algoritmo de Metropolis. Entender isso é importante para o meu projeto de mestrado. Em seguida, a implementação do modelo Ising em verilog me permitiu treinar e estudar novamente essa linguagem de descrição de Hardware, o que, juntamente com o trabalho 1 da disciplina, me prepara bem para potenciais futuros projetos envolvendo aceleradores e FPGA. Por fim, a plataforma LiteX se apresentou muito útil e interessante, porém, novamente, sua documentação deixou a desejar e tornou honerosa algumas atividades que poderiam ser triviais.
