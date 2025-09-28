# Student Test Score Modelling and Prediction 

This project explores how **study hours, sleep, attendance, and prior academic performance** influence student exam results. Using a dataset of 200 students, the analysis applies exploratory data analysis (EDA), builds a multiple linear regression model, and evaluates predictive performance with a train/test split.

The full narrative and results are available in the **Quarto report (`report.qmd`)**, while `code.R` contains the clean script version of the workflow.

---

## Project Overview

### 1) Exploratory Data Analysis
- Checked for missing values and unique IDs  
- Generated descriptive statistics (mean, SD, median, min, max)  
- Visualized distributions with histograms  
- Created a correlation matrix to examine relationships between variables  

### 2) Regression Modelling
- Predictors: `hours_studied`, `sleep_hours`, `attendance_percent`, `previous_scores`  
- Checked assumptions: linearity, independence, homoscedasticity, normality, multicollinearity (VIF)  

### 3) Model Evaluation
- Train/test split: 75% training, 25% testing  
- Performance on test set:  
  - R² ≈ 0.86  
  - MAE ≈ 2.16  
  - RMSE ≈ 2.63  
- Diagnostic visuals: Predicted vs Actual, Residuals vs Predicted  

---

## Getting Started

### Requirements
R packages:  
`tidyverse`, `table1`, `car`, `stargazer`, `corrplot`, `broom`, `rsample`, `tibble`

### Running the Project
1. Clone the repository:  
   `git clone https://github.com/<your-username>/student-test-scores-prediction.git`  
2. Open `student-test-scores-prediction.Rproj` in RStudio  
3. Run the analysis in `code.R`, or render the full report by running Quarto on `report.qmd`  

---

## Results (Summary)

- **Hours studied** shows the strongest positive effect on exam scores  
- **Previous scores** and **attendance** add meaningful predictive power  
- **Sleep hours** contributes modestly  
- Overall, the model explains exam outcomes well on unseen data (R² ≈ 0.86) with low error  

---

## License

This project is released under the MIT License.  
