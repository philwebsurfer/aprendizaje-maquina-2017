Presentación Examen Final
========================================================
author: Jorge III Altamirano Astorga (175904) Uriel Miranda Miñon (177508)
font-family: 'Helvetica'
transition: fade
date: 2017/12/02

## What's Cooking 
### Dataset by Yummly

Objetivo
========================================================

Determinar en base a los ingredientes el tipo de cocina a la que pertenece un platillo.

Existen alrededor más de 6,000 ingredients en el dataset de entrenamiento (unclean):
+ Con 39,774 observaciones para el set de entrenamiento
+ Clasificados en 20 tipos de cocinas: mexicana, francesa, tailandesa, ...

Para el set de prueba son 9,944 observaciones.

Dentro de Aprendizaje Máquina éste es un problema de Aprendizaje Supervisado y de Clasificación.

Datos 1 de 3
========================================================

Los datos están en formato JSON, con una lista anidada y el ID en desorden como se muestra aquí.

<style>
div.slideContent pre code.r {
  font-size: 1.0em;
}
</style>



```r
train <- fromJSON("data/train.json") 
train <- train %>% as.data.frame
train %>% head(n=4) %>% kable
```



|    id|cuisine     |ingredients                                                                                                                                        |
|-----:|:-----------|:--------------------------------------------------------------------------------------------------------------------------------------------------|
| 10259|greek       |romaine lettuce, black olives, grape tomatoes, garlic, pepper, purple onion, seasoning, garbanzo beans, feta cheese crumbles                       |
| 25693|southern_us |plain flour, ground pepper, salt, tomatoes, ground black pepper, thyme, eggs, green tomatoes, yellow corn meal, milk, vegetable oil                |
| 20130|filipino    |eggs, pepper, salt, mayonaise, cooking oil, green chilies, grilled chicken breasts, garlic powder, yellow onion, soy sauce, butter, chicken livers |
| 22213|indian      |water, vegetable oil, wheat, salt                                                                                                                  |

Datos 2 de 3
========================================================
left: 60%
Los datos van a requerir algo de limpieza, como es usual: 
  + Existen ingredientes repetidos, dado que contienen cantidades o porcentajes
  + Existen ingredientes repetidos con caracteres especiales o acentuados 
  + Consideramos más conveniente convertir a minúsculas
  
***

```r
train$ingredients %>% unlist %>%  tolower %>%unique %>% data.frame(x=.) %>% arrange(x) %>%  head(n=10) %>% kable
```



|x                                                        |
|:--------------------------------------------------------|
|(    oz.) tomato sauce                                   |
|(   oz.) tomato paste                                    |
|(10 oz.) frozen chopped spinach                          |
|(10 oz.) frozen chopped spinach, thawed and squeezed dry |
|(14 oz.) sweetened condensed milk                        |
|(14.5 oz.) diced tomatoes                                |
|(15 oz.) refried beans                                   |
|1% low-fat buttermilk                                    |
|1% low-fat chocolate milk                                |
|1% low-fat cottage cheese                                |

Datos 3 de 3
========================================================
left: 30%
Data summary después de una breve limpieza, aún así requerimos trabajar en:
+ Separar la lista de ingredientes: se nos ocurre hacer una variable por cada ingrediente (los +6,000)
+ Dichas 6,000 variables serán nuestras $x$ y nuestra $y$ (objetivo) será `cuisine`
+ También requiere cambiar los espacios (" ") por "`_`" en dichas variables


| id|cuisine |ingredients                                                                                                                                                                                                                                                                   |
|--:|:-------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|  0|spanish |mussels, ground black pepper, garlic cloves, saffron threads, olive oil, stewed tomatoes, arborio rice, minced onion, medium shrimp, fat free less sodium chicken broth, green peas                                                                                           |
|  1|mexican |tomatoes, diced red onions, paprika, salt, corn tortillas, fresh cilantro, cremini, vegetable broth, freshly ground pepper, ground chipotle chile pepper, bell pepper, extra-virgin olive oil, yellow onion, ground cumin, poblano peppers, chili powder, garlic, pinto beans |
|  2|french  |chicken broth, truffles, pimentos, green pepper, olives, roast turkey, egg yolks, heavy cream, tarragon leaves, eggs, flour, butter, scallions, cold water, unflavored gelatin, leeks, salt, aspic                                                                            |

Métodos
========================================================

Pretendemos utilizar los siguientes métodos:

## **#1 Support Vector Machine: Multi-class classification**

Dado que es un método que nos pareció:

1. Con potencial para este problema
2. Tomando su sugerencia de usar un método no visto en clase

**#2 Regresión Lineal con Lasso:**  Por su simplicidad e interpretabilidad.

**#3 Bosques Aleatorios:**  Por los buenos resultados que tiene _out of the box_.

Bibliografía
========================================================

* [Aprendizaje Máquina - Luis Felipe González](https://felipegonzalez.github.io/aprendizaje-maquina-2017/)
* [kaggle.com/What's cooking](https://www.kaggle.com/c/whats-cooking/data)
* [R SVM @R-Project's Cran](https://cran.r-project.org/web/packages/e1071/vignettes/svmdoc.pdf)

Fin
========================================================

### <div style="text-align: center;">Q&A</div>

## <div style="height: 50px; margin: 0 auto; text-align: center;">¡Muchas gracias!</div>
