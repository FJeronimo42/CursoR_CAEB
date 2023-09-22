#### Introdução à análise estatística de dados com linguagem R ####
### XXXIII Semana acadêmica do curso de Ciências Biológicas
### Fernando Fortunato Jeronimo 
### 22.09.2023

#### Código 1 ####
#### Comandos básicos úteis ####

# Diretório de trabalho
setwd('pasta/pasta/pasta') # determina o diretório da sessão
getwd() # confere o diretório em uso
dir() # lista os arquvios e pastas no diretório
dir.create('Figuras')
dir.create('Dados')

# Pacotes
install.packages('tidyverse') # instala um pacote hospedado CRAN
library(tidyverse) # carrega o pacote
update.packages() # atualiza todos os pacotes instalados
vignette('dplyr') # abre a vinheta do pacote

# Ajuda e demonstração
help(dplyr) # abre a página de ajuda do pacote (é igual ao ?())
?mutate # abre a página de ajuda da função
demo(package = .packages(all.available = TRUE)) # abre a lista de possíveis demonstrações
demo(graphics) # abre uma demonstração da funcionalidade
example(lm) # roda um exemplo com aplicação da função
args(lm) # lista todos argumentos e padrões dos argumentos da função

# Pesquisas
find('filter') # lista os pacotes que contém a função
apropos('color') # lista os comandos que contém o termo
RSiteSearch('square') # lista pacotes, funções, vinhetas e documentações que contém o termo
ls() # lista os objetos no ambiente de trabalho
ls('package:tidyr') # lista os comandos do pacote
search() # lista os ambientes e pacotes em uso

# Checagens
str(iris) # apresenta a estrutura interna do objeto
typeof(iris$Sepal.Length) # apresenta o tipo do objeto
class(iris) # apresenta a classe do objeto

# Citação
citation('tidyverse') # para mostrar a referência de um pacote
citation() # para mostrar a referência do R



##### Sintaxe básica ####
# Criação de objeto
objeto1 <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
objeto2 <- 100
objeto3 <- 300
objeto4 <- c('azul', 'roxo', 'rosa')
objeto5 <- c(TRUE, FALSE, FALSE)

# Criação de matriz
matriz1 <- matrix(sample(1:100, 
                         replace = TRUE), 
                  nrow = 10, 
                  ncol = 10)
matriz1

matriz2 <- matrix(c('azul', 'vermelho', 'verde', 'amarelo', 'preto'),
                  nrow = 10, 
                  ncol = 10,
                  byrow = T)
matriz2

# Criação de listas
lista1 <- list(objeto1, objeto2, objeto3, objeto4, objeto5)
lista1 

lista2 <- list(objeto1, matriz1, objeto2, matriz2)
lista2

# Operações com vetores
objeto2 + objeto3

objeto1 * objeto2

objeto1 + objeto4

objeto5 == objeto5

# Operações com matrizes
objeto2 * matriz1

matriz1 - matriz1

matriz1 == matriz1

t(matriz1)



#### Acesso e alteração de vetores e itens em data frames/matrizes ####
iris[1] # retorna a coluna 1
iris[2,] # retorna a linha 2
iris[,3] # retorna os valores coluna 3
iris$Species # retorna os valores da coluna Species
iris[1]+iris[2] # todas operações aplicáveis podem ser feitsa desta forma

lista1[[1]] # acessar um item dentro da lista
lista2[[1]][5] # acessar um elmento dentro de um item em uma lista (vetor)
lista2[[4]][1,3] # acessar um elmento dentro de um item em uma lista (matriz)

data(iris)
id <- c(1:150) # vetores podem ser adicionados ao df desta forma se compatíveis
iris$id <- id 
str(iris)
iris <- iris[-c(6)] # e colunas podem ser removidas assim

obs151 <- c(5.5, 3.2, 1.3, 0.1, 'setosa') 
rbind(iris, obs151) # linhas (ou conjunto de) podem ser adicionadas desta forma 
cbind(iris, id) # colunas (ou conjunto de) podem ser adicionadas desta forma 



#### Estruturas de código ####

# Funções
funcao1 <- function(x){  
  x * 2
}

funcao2 <- function(y){  
  print(y * 100)
}

# Linha de comando simples
funcao1(x = objeto1)

# linha de comando aninhada
funcao2(y = funcao1(x = objeto1))

# Estrutura condicional simples
if(objeto2 == objeto3){
  print('os objetos são iguais')
  } else {
  print('os objetos são diferentes')
  }

# Estrutura condicional aninhada
if (objeto2 == objeto3){
  print('os objetos são iguais')
  } else if (objeto2 > objeto3){
    print('o objeto 2 é maior que o objeto 3')
    } else {
      print('o objeto 2 é maior que o objeto 3')
      }

# Estrutura de laço for
for(item in objeto1){
  vetor[item] <- item ^ 2
  print(item ^ 2)
}
vetor

# Estrutura de laço while
while (objeto2 < 501) {
  print(objeto2)
  objeto2 <- objeto2 + 100
  
} 
objeto2

# Estrutura de laço repeat
repeat {
  print(objeto3)
  objeto3 = objeto3 + 100
  if (objeto3 > 1000){
    break
  }
}
objeto3

# Família apply
# apply # aplica uma função em colunas de uma matrix ou df
m1 <- matrix(C<-(1:10),nrow=5, ncol=6)
m1
apply(m1, 2, sum) # aplica a função soma em cada coluna separadamente

# sapply # aplica uma função em todos itens retornando um vetor
m2 <- matrix(C<-(1:10),nrow=5, ncol=6)
m3 <- matrix(C<-(1:10),nrow=5, ncol=6)
lista <- list(m1, m2, m3)
sapply(lista, max)

# lapply # aplica uma função em todos itens retornando uma lista
lapply(lista, max) 

#tapply # aplica uma função em uma coluna agrupada por um fator
tapply(iris$Sepal.Width, iris$Species, median)