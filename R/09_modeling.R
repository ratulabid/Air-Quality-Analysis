# Prepare modeling data
model_data <- airquality_clean[, c("Ozone", "Temp", "Wind", "Solar.R", "Temp_Wind")]
head(model_data)
colSums(is.na(model_data))

# Train/Test Split

set.seed(123)

n <- nrow(model_data)

train_index <- sample(1:n, size = 0.8 * n)

train_data <- model_data[train_index, ]
test_data  <- model_data[-train_index, ]

nrow(train_data)
nrow(test_data)

# Observation:
# The dataset was randomly divided into 80% training data and 20% testing data.
# The training data will be used to build the model, while the testing data
# will be used later to evaluate its predictions.


# Build the Multiple Linear Regression Model

model1 <- lm(Ozone ~ Temp + Wind + Solar.R,
             data = train_data)


summary(model1)

# Observation:
# The multiple linear regression model explains about 45.73% of the variation
# in Ozone. Temperature has a significant positive effect on Ozone, while Wind
# has a significant negative effect and Solar.R has a significant positive effect.
# Overall, the model is statistically significant (p < 0.001).


# Make Predictions
predictions <- predict(model1, newdata = test_data)
head(predictions)


# Observation:
# The model generated Ozone predictions for the unseen test data.
# The predicted values vary considerably, with some predictions close to
# the expected Ozone range while others are negative, such as -14.18.
# This shows that the model's predictions will need to be evaluated further.


# Compare Actual vs Predicted Ozone

comparison <- data.frame(
  Actual = test_data$Ozone,
  Predicted = predictions
)

head(comparison)

# Observation:
# Observation:
# The predicted Ozone values are sometimes close to the actual values,
# but there are also large differences. For example, an actual value of
# 7 was predicted as 44.08, and an actual value of 6 was predicted as
# -14.18. This indicates that the model does not predict every observation accurately.

# Build an Improved Model

Ozone ~ Temp + Wind + Solar.R + Temp_Wind

model2 <- lm(Ozone ~ Temp + Wind + Solar.R + Temp_Wind,
             data = train_data)

summary(model2)

# Observation:
# The improved model explains 56.24% of the variation in Ozone,
# increasing the R-squared from 45.73% in model1 to 56.24% in model2.
# Temp_Wind is statistically significant (p < 0.001), indicating that
# the interaction between Temperature and Wind contributes meaningfully
# to predicting Ozone. Overall, model2 is statistically significant.

# Save Models and Predictions

# Predictions from Model 1
pred_model1 <- predict(model1, newdata = test_data)
# Predictions from Model 2
pred_model2 <- predict(model2, newdata = test_data)

model_results <- data.frame(
  Actual = test_data$Ozone,
  Model1_Predicted = pred_model1,
  Model2_Predicted = pred_model2
)

head(model_results)

# Observation
# Both Model 1 and Model 2 generate predictions that differ from the actual Ozone values.
# Model 2 generally gives more reasonable predictions for these test observations.
# Model 1 has some large errors, such as predicting -14.18 when the actual value is 6.
# Model 2 also has errors, but its predictions are generally closer to the actual values.
# Therefore, Model 2 appears to perform better than Model 1 on these sample test observations.