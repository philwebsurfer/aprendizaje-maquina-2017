library(ggplot2)
library(dplyr)
library(tidyr)
library(purrr)
library(kknn)


set.seed(175904)
# Modelo verdadero
p_1 <- function(x){
  ifelse(x < 15, 0.95, 0.95 - 0.007 * (x - 15))
}

# Simular muestra de entrenamiento
x <- pmin(rexp(500,1/30),100)
probs <- p_1(x)
g <- ifelse(rbinom(length(x), 1, probs)==1 ,1, 2)
dat_ent <- data_frame(x = x, p_1 = probs, g = factor(g))
dat_ent <- dat_ent %>% select(x, g) 
ggplot(dat_ent, aes(x=x)) + 
  geom_jitter(aes(color = g, y = as.numeric(g=='1')), width = 0, height = 0.1)
# head(dat_ent)

# Simular muestra de prueba
x <- pmin(rexp(1000,1/30),100)
probs <- p_1(x)
g <- ifelse(rbinom(length(x), 1, probs)==1 ,1, 2)
dat_prueba <- data_frame(x = x, g = factor(g))
ggplot(dat_ent, aes(x=x)) + 
  geom_jitter(aes(color = g, y = as.numeric(g=='1')), width = 0, height = 0.1)
# head(dat_prueba)


########################
### Parte 1: preparación

# Usa esta función para evitar Inf cuando hay probabilidades iguales a 0
s <- function(x) {
  epsilon <- 0.00001
  x <- ifelse(x < epsilon, epsilon, x)
  -2*log(x)
}

## Completa esta función

dev_calc <- function(dat_ent, dat){
  devianza <- function(k){
    vmc <- kknn(g ~ x, train = dat_ent,  k = k,
                test = dat, kernel = 'rectangular')
    dat$hat_p_1 <- predict(vmc, type ='prob')[,1]
    dat$hat_p_2 <- predict(vmc, type ='prob')[,2]
    dat <- dat %>%
      mutate(hat_p_g = ifelse(g == 1, hat_p_1, hat_p_2)) %>%
      mutate(dev = s(hat_p_g))
    error_dev <- dat %>% ungroup %>% 
      summarise(dev_prom = mean(dev)) %>%
      pull(dev_prom)
    ## calcula aquí error_dev, que debe ser 
    ## la devianza promedio sobre la muestra dat
    error_dev
  }
  devianza
}

dev_ent <- dev_calc(dat_ent, dat_ent)
dev_prueba <- dev_calc(dat_ent, dat_prueba)

# Debes obtener 0.6379824 y 1.176322
dev_ent(10)
dev_prueba(10)

###################
## Parte 2: ajuste y evaluación

modelos <- data_frame(k=c(5, 20, 60, 200 , 400))

modelos <- modelos %>% rowwise %>% 
  mutate(dev_ent = dev_ent(k), dev_prueba = dev_prueba(k))
  ### escribe aquí tu código para calcular devianza de entrenamiento y prueba)
modelos

#################
## Parte 3: gráficas de al menos modelos

## estos datos los vas a usar para graficar
graf_data <- data_frame(x = seq(0,100, 1))
vmc <- kknn(g ~ x, train = dat_ent,  k = 5,
            test = graf_data, kernel = 'rectangular')
graf_data$p_1 <- vmc$prob[ ,1]

## aquí tu código para graficar el modelo ajustado


