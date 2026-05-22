library(rpart)
library(rpart.plot)
library(caret)

data(iris)

# Separação treino/teste (baseado na nova variável alvo: Sepal.Length)
set.seed(123)
indice_treino <- createDataPartition(
  y = iris$Sepal.Length,
  p = 0.7,
  list = FALSE
)

treino <- iris[indice_treino, ]
teste  <- iris[-indice_treino, ]

# Treinamento (Mudança para Regressão)
modelo_tree <- rpart(
  Sepal.Length ~ .,     
  data = treino,
  method = "anova"      
)

# Visualização (O gráfico agora mostrará médias nos nós, em vez de classes)
rpart.plot(modelo_tree)

pred_tree <- predict(
  modelo_tree,
  teste
)

postResample(
  pred = pred_tree,
  obs = teste$Sepal.Length
)