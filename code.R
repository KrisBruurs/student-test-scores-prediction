###---Libraries---###
library(tidyverse) # Data Handling
library(table1)

###---Input---###
student_data <- read_csv('data/student_exam_scores.csv')

###---Processing---###

# Check unique ids
n_distinct(student_data$student_id)

# Check mean, sd, median, min, max of all variables
table1(~ hours_studied + 
         sleep_hours + 
         attendance_percent +
         previous_scores +
         exam_score, 
         data = student_data) # data show no zeros

# Check how the data is spread
student_data %>% 
  ggplot(aes(x = hours_studied, fill = hours_studied)) +
  geom_histogram(binwidth = .5, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

student_data %>% 
  ggplot(aes(x = sleep_hours, fill = sleep_hours)) +
  geom_histogram(binwidth = .3, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

student_data %>% 
  ggplot(aes(x = attendance_percent, fill = attendance_percent)) +
  geom_histogram(binwidth = 2.5, fill = 'steelblue', color = 'black') + 
  theme_minimal() 

student_data %>% 
  ggplot(aes(x = previous_scores, fill = previous_scores)) +
  geom_histogram(binwidth = 3, fill = 'steelblue', color = 'black') +
  theme_minimal() 

student_data %>% 
  ggplot(aes(x = exam_score, fill = exam_score)) +
  geom_histogram(binwidth = 2, fill = 'steelblue', color = 'black') + 
  theme_minimal() 


model1 <- glm(exam_score ~ hours_studied + sleep_hours + attendance_percent +
    previous_scores, data = student_data)

summary(model1)
