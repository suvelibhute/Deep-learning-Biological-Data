#install keras and tensorflow packages

library(tidymodels)
library(parsnip)

dataset <- read.csv('C:/Users/suvel/Desktop/rcode/data_input_rf_1.csv', header = T)
dataset$Conditions <- as.factor(dataset$Conditions)
#all predictors are already normalized and ready to use

#splitting data into training and testing dataset

set.seed(seed = 1972) 
train_test_split <-
  rsample::initial_split(
    data = dataset,     
    prop = 0.80) 

train_test_split

train_tbl <- training(train_test_split)
test_tbl  <- testing(train_test_split)

test_tbl
train_tbl


data_rec <- 
  recipe(Conditions ~ ., data = train_tbl) %>%
  
  prep(training = train_tbl, retain = TRUE)
# We will juice() to get the processed training set back


# For testing when we arrive at a final model: 
test_data_final <- bake(data_rec, new_data = test_tbl, all_predictors())

set.seed(seed = 1972)
nnet_fit <-
  mlp(epochs = 1000, hidden_units = 1, dropout = 0.1) %>%
  set_mode("classification") %>% 
  # Also set engine-specific `verbose` argument to prevent logging the results: 
  set_engine("keras", verbose = 0) %>%
  fit(Conditions ~ ., data = juice(data_rec))

nnet_fit



test_results <- 
  test_tbl %>%
  bind_cols(
    predict(nnet_fit, new_data = test_data_final),
    predict(nnet_fit, new_data = test_data_final, type = "prob")
  )
test_results %>% slice(1:5)


test_results %>% accuracy(truth = Conditions, .pred_class)

train_results <- 
  train_tbl %>%
  bind_cols(
    predict(nnet_fit, new_data = juice(data_rec)),
    predict(nnet_fit, new_data = juice(data_rec), type = "prob")
  )
train_results %>% slice(1:5)

train_results %>% accuracy(truth = Conditions, .pred_class)

autoplot(roc_curve(test_results, Conditions, 1, 2, 3, 4, 5))




