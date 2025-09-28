###---Libraries---###
library(tidyverse) # Data Handling
library(table1)  # Creating metrics table
library(car)
library(stargazer)
library(corrplot)
library(broom)
library(rsample)
library(tibble)

###---Input---###
student_data <- read_csv('data/student_exam_scores.csv')

###---Processing---###

# Check for NA's in data
colSums(is.na(student_data))

# Check unique ids
n_distinct(student_data$student_id)

# Check mean, sd, median, min, max of all variables
table1(~ hours_studied + 
         sleep_hours + 
         attendance_percent +
         previous_scores +
         exam_score, 
         data = student_data) # data show no zeros

# Histogrma of hours_studied spread
student_data %>% 
  ggplot(aes(x = hours_studied, fill = hours_studied)) +
  geom_histogram(binwidth = .5, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

# Histogram fo sleep_hours spread
student_data %>% 
  ggplot(aes(x = sleep_hours, fill = sleep_hours)) +
  geom_histogram(binwidth = .3, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

# Histogram of attendance_percent spread
student_data %>% 
  ggplot(aes(x = attendance_percent, fill = attendance_percent)) +
  geom_histogram(binwidth = 2.5, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

# Histogram of previous_score spread
student_data %>% 
  ggplot(aes(x = previous_scores, fill = previous_scores)) +
  geom_histogram(binwidth = 3, fill = 'steelblue', color = 'black') +
  theme_minimal() 

# Histogram of 
student_data %>% 
  ggplot(aes(x = exam_score, fill = exam_score)) +
  geom_histogram(binwidth = 2, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

# Create a correlation matrix
student_data %>% 
  select(hours_studied, sleep_hours, attendance_percent, previous_scores,
         exam_score) %>% 
  cor(use = 'complete.obs') %>% 
  corrplot(method = 'color', type = 'upper', tl.col = 'black', 
           addCoef.col = 'black')


###---Modelling and Prediction---####

# create 75% sample for fitting model
set.seed(123)
split <- initial_split(student_data, prop = 0.75)

training_data <- training(split)
test_data <- testing(split)


# Create moddel
model1 <- lm(exam_score ~ hours_studied + sleep_hours + attendance_percent +
    previous_scores, data = training_data)
summary(model1) # summary of model
glance(model1) # overview of effectsizes

# Check for muliticollinarity
vif(model1)

# Check other assumptions
par(mfrow=c(2,2))
plot(model1)  

# Predict on test data
preds <- predict(model1, newdata = test_data)

# Evaluate performance
results <- tibble(
  Metric = c("R²", "MAE", "RMSE"),
  Value  = c(
    cor(preds, test_data$exam_score)^2,
    mean(abs(preds - test_data$exam_score)),
    sqrt(mean((preds - test_data$exam_score)^2))
  )
)

results

