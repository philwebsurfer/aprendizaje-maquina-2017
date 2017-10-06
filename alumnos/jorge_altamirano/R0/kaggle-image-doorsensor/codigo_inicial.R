library(readr)
library(dplyr)

df_t <- read_csv('kaggle-image-doorsensor/train.csv')
test <- read_csv('kaggle-image-doorsensor/test.csv')
table(df_t$estado)



mostrar_imagen <- function(renglon, dat){
  # v <- as.numeric(dat %>% dplyr::select(contains('X'))%>% .[renglon,])
  # v <- as.numeric(dat[renglon,] %>% dplyr::select(contains('X')))
  # Getting the col number:
  # head -n 1 train.csv | tr ',' '\n' | awk '{printf("%010d %s\n", NR, $0)}' | less
  v <- as.numeric(dat[renglon,c(1:38000)])
  mat <- (t(matrix(v, nrow=190, ncol=200, byrow=T))[,190:1])
  image(mat, axes = F, col=gray(0:255/255))#, xlim = 190, ylim=200)
}
# df_x = data.frame(t(c(1:250)))
# v <- as.numeric(df_x)
# mat <- (t(matrix(v, nrow=50, ncol=50, byrow=T))[,50:1])
# image(mat, axes = F, col=gray(0:255/255))
dim(df_t[1,] %>% dplyr::select(contains('X')) %>% matrix(nrow=190, ncol=200, byrow=T) %>% t %>%
      image(z = ., axes = F, col=gray(0:255/255)))

# as.POSIXct("2015-07-23 05:40:19", format="%M")
hora = df_t[1,38002]
strptime(hora[1,1], format="%H:%M:%S")
summary(df_t[,c(38001:38002)])
mostrar_imagen(1, df_t)
mostrar_imagen(100, df_t)
mostrar_imagen(190, df_t)
mostrar_imagen(130, df_t)

