library(readr)
library(dplyr)

df_t <- read_csv('kaggle-image-doorsensor/train.csv')
test <- read_csv('kaggle-image-doorsensor/test.csv')
table(df_t$estado)



mostrar_imagen <- function(renglon, dat){
  v <- as.numeric(dat %>% dplyr::select(contains('X'))%>% .[renglon,])
  mat <- (t(matrix(v, nrow=190, ncol=200, byrow=T))[,190:1])
  image(mat, axes = F, col=gray(0:255/255))
}

mostrar_imagen(1, df_t)
mostrar_imagen(100, df_t)
mostrar_imagen(190, df_t)
mostrar_imagen(130, df_t)

