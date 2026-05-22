library(rpart)
library(rpart.plot)
library(caret)

dados_jurimetria[] <- lapply(dados_jurimetria, function(x) {
  if(is.character(x)) as.factor(x) else x
})

# Separação treino/teste
set.seed(123)

indice_treino <- createDataPartition(
  y = dados_jurimetria$resultado,
  p = 0.7,
  list = FALSE
)

treino <- dados_jurimetria[indice_treino, ]
teste  <- dados_jurimetria[-indice_treino, ]

# Modelo
modelo_tree <- rpart(
  resultado ~ .,
  data = treino,
  method = "class"
)

# Plot
rpart.plot(modelo_tree)

# Previsão
pred_tree <- predict(
  modelo_tree,
  teste,
  type = "class"
)

# Garantir mesmos níveis
pred_tree <- factor(
  pred_tree,
  levels = levels(teste$resultado)
)

# Matriz de confusão
confusionMatrix(
  pred_tree,
  teste$resultado
)


