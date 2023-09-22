#### Introdução à análise estatística de dados com linguagem R ####
### XXXIII Semana acadêmica do curso de Ciências Biológicas
### Fernando Fortunato Jeronimo 
### 22.09.2023

#### Código 2 ####
#### Projetos ####
#### Regressão Linear Simples ####

# Diretório de trabalho
setwd('pasta/pasta/pasta')
getwd()

# Pacotes
install.packages('pacman')
pacman::p_load(car, DataExplorer, DT, DescTools, DHARMa, gt, MuMIn, rstatix, 
               tidyverse)

# Dados
seto_data <- iris %>% 
  dplyr::filter(Species == 'setosa') %>% 
  select(-Species)
str(seto_data)
View(seto_data)



# Salvando e lendo dados
write.csv(seto_data, 'seto_data.csv')

seto_data <- read.csv('seto_data.csv')



# Exploração
plot_intro(seto_data)

plot_correlation(data = seto_data)

plot_scatterplot(data = seto_data, 
                 by = 'Sepal.Length',
                 ncol = 2)

plot_density(data = seto_data)

plot_histogram(seto_data)

create_report(data = seto_data)



# Criação dos modelos
modelo1 <- lm(formula = Sepal.Length ~ Sepal.Width, 
              data = seto_data)
summary(modelo1)

modelo2 <- lm(formula = Sepal.Length ~ Petal.Length + Sepal.Width, 
              data = seto_data)
summary(modelo2)

modelo3 <- lm(formula = Sepal.Length ~ Petal.Length * Sepal.Width, 
              data = seto_data)
summary(modelo3)

modelo4 <- lm(formula = Sepal.Length ~ ., 
              data = seto_data)
summary(modelo4)



# Seleção de modelos
selecao <- model.sel(modelo1, modelo2, modelo3, modelo4)
selecao



# Validação do modelo
par(mfrow = c(2,2))

plot(modelo1)

testResiduals(modelo1, 
              plot = T)

simulateResiduals(modelo1, 
                  plot = T, 
                  n = 1000)

shapiro.test(modelo1$residuals)

confint(modelo1)



# Gráfico do modelo
figura_modelo1 <- ggplot(data = seto_data,
                         mapping = aes(x = Sepal.Width,
                                       y = Sepal.Length))+
  geom_smooth(method = 'lm',
              linetype = 1,
              color = 'black')+
  geom_point(alpha = 0.75,
             size = 5,
             color = 'steelblue')+
  labs(x = 'Largura da Sépala', y = 'Comprimento da Sépala')+
  #lims(x = c(2, 4.5), y = c(4, 6))+
  theme_bw()+
  theme(axis.title = element_text(size = 14, 
                                  face = 'bold'))
figura_modelo1



# Salvar a figura
ggsave(filename = 'figura_modelo1.png',
       plot = figura_modelo1,
       width = 9,
       height = 9,
       units = 'cm',
       dpi = 600)





#### Análise de variância ####
# Dados
toot_data <- ToothGrowth %>%
  mutate(dose = as.factor(dose),
         supp = as.factor(supp)) %>% 
  
  glimpse()

str(toot_data )

View(toot_data)

# Exploração
plot_intro(toot_data)

plot_correlation(data = toot_data)

plot_density(data = toot_data)

plot_histogram(toot_data)

create_report(data = toot_data)

# Criação dos modelos
modelo5 <- aov(formula = len ~ supp,
               data = toot_data)
summary(modelo5)

modelo6 <- aov(formula = len ~ supp * dose,
               data = toot_data)

Anova(modelo6, type = 'III')

# Validação do modelo
par(mfrow = c(2,2))

plot(modelo6)

toot_data$Residuos <- modelo6$residuals

toot_data %>% 
  identify_outliers(Residuos)

levene_test(Residuos ~ supp * dose,
           data = toot_data, 
           center = mean)

shapiro.test(modelo6$residuals)

PostHocTest(modelo6, method = 'hsd')

confint(modelo6)



# Dados para figura
toot_summ <- toot_data %>% 
  group_by(dose, supp) %>% 
  get_summary_stats(len, type = 'full')

toot_plot <- inner_join(toot_data, toot_summ) %>% 
  distinct(dose, supp, .keep_all = T)
toot_plot

# Gráfico para o modelo
figura_modelo6 <- ggplot(data = toot_plot, 
                         mapping = aes(x = dose, 
                                       y = mean,
                                       color = supp))+
  geom_errorbar(aes(ymin=mean-sd,
                    ymax=mean+sd),
                width=0.25,
                size=0.75,
                color='black')+
geom_point(size=3)+
scale_color_manual(values = c('#440154', '#9B1111'))+
  labs(x = 'Dose', y = 'Comprimento do Dente', color = 'Suplemento')+
  theme_bw()+
  theme(axis.title = element_text(size = 14,
                                  face = 'bold'),
        legend.position = 'bottom')
figura_modelo6



# Salvar a figura
ggsave(filename = 'figura_modelo6.png',
       plot = figura_modelo6,
       width = 9,
       height = 10,
       units = 'cm',
       dpi = 600)



# Tabela
gt(toot_summ)
datatable(toot_summ)
