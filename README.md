# 🌤️ Air Quality Analysis & Ozone Prediction

An end-to-end **Data Analysis and Machine Learning project in R** using the built-in `airquality` dataset.

This project explores air quality patterns through **data cleaning, exploratory data analysis, statistical analysis, anomaly detection, feature engineering, and linear regression modeling**. Two regression models are developed and compared to understand how temperature, wind speed, and solar radiation influence ozone concentration.

---

## 📌 Project Overview

Air quality is strongly influenced by environmental and meteorological conditions. In this project, the `airquality` dataset is analyzed to investigate the relationship between **Ozone concentration** and key weather variables.

The project follows a complete data science workflow:

> **Data Cleaning → EDA → Correlation Analysis → Regression → Time Analysis → Anomaly Detection → Feature Engineering → Model Training → Model Evaluation**

---

## 🎯 Objectives

* Clean and prepare the air quality dataset
* Explore the distribution of ozone concentration
* Identify relationships between ozone and weather variables
* Analyze monthly and time-based ozone patterns
* Detect unusual ozone observations using the IQR method
* Engineer new features for predictive modeling
* Build linear regression models
* Compare model performance
* Understand the major factors associated with ozone concentration

---

## 📊 Dataset

The project uses R's built-in **`airquality` dataset**.

### Main Variables

| Variable  | Description               |
| --------- | ------------------------- |
| `Ozone`   | Ozone concentration       |
| `Solar.R` | Solar radiation           |
| `Wind`    | Average wind speed        |
| `Temp`    | Maximum daily temperature |
| `Month`   | Month of observation      |
| `Day`     | Day of observation        |

The dataset contains daily air-quality observations collected during **May–September 1973** in New York.

---

## 🧹 1. Data Cleaning

The first stage prepares the dataset for analysis.

Key operations include:

* Checking missing values
* Calculating missing values for each column
* Removing incomplete observations
* Checking the structure of the cleaned dataset
* Verifying summary statistics

R functions used include:

```r
is.na()
colSums()
na.omit()
complete.cases()
str()
summary()
```

The cleaned dataset is stored as:

```r
airquality_clean
```

---

## 📈 2. Exploratory Data Analysis

Several visualizations are used to understand the data.

### Distribution Analysis

A histogram is used to examine the distribution of ozone concentration.

### Outlier Analysis

A boxplot is used to identify unusually high or low ozone observations.

### Relationship Analysis

Scatterplots are created to investigate relationships between:

* Ozone vs Temperature
* Ozone vs Wind
* Ozone vs Solar Radiation

These visualizations provide an initial understanding of how environmental variables are associated with ozone concentration.

---

## 🔗 3. Correlation Analysis

Pearson correlation is used to measure the linear relationship between variables.

Key correlations observed:

| Relationship             | Correlation |
| ------------------------ | ----------: |
| Ozone vs Temperature     |     ≈ 0.601 |
| Ozone vs Wind            |    ≈ -0.532 |
| Ozone vs Solar Radiation |     ≈ 0.296 |

### Interpretation

* **Temperature:** Moderate positive relationship with Ozone
* **Wind:** Moderate negative relationship with Ozone
* **Solar Radiation:** Weak positive relationship with Ozone

This suggests that temperature and wind speed have stronger linear relationships with ozone than solar radiation in this dataset.

---

## 📐 4. Simple Linear Regression

Separate linear regression models are created to examine individual predictors.

### Ozone ~ Temperature

The temperature model shows a positive relationship between temperature and ozone concentration.

* Coefficient ≈ **1.844**
* R² ≈ **36.1%**
* Statistically significant relationship

### Ozone ~ Wind

Wind shows a negative relationship with ozone concentration.

* Coefficient ≈ **-4.387**
* R² ≈ **28.3%**

### Ozone ~ Solar Radiation

Solar radiation has a weaker positive relationship with ozone.

* Coefficient ≈ **0.098**
* R² ≈ **8.7%**

---

## 📊 5. Multiple Linear Regression

A multiple regression model is created using all three environmental predictors:

```r
Ozone ~ Temp + Wind + Solar.R
```

### Model Results

| Predictor       | Coefficient |
| --------------- | ----------: |
| Temperature     |     ≈ 1.233 |
| Wind            |    ≈ -2.787 |
| Solar Radiation |     ≈ 0.057 |

The model explains approximately:

**R² ≈ 47.21%**

of the variation in ozone concentration.

This indicates that using multiple environmental variables together provides better explanatory power than relying on a single predictor.

---

## 📅 6. Time & Monthly Analysis

The project also investigates ozone behavior over time.

Analysis includes:

* Daily ozone trends
* Monthly ozone distributions
* Time-series visualization
* 7-day moving average
* Autocorrelation analysis

### Key Observations

* July shows a high median ozone level.
* September shows a lower median ozone level.
* July has a relatively large ozone range.
* Some unusually high observations occur during summer months.

A centered 7-day moving average is also applied to identify smoother trends in ozone concentration.

---

## 🚨 7. Anomaly Detection

The **Interquartile Range (IQR)** method is used to detect unusual ozone values.

The boundaries are calculated using:

```text
Lower Bound = Q1 − 1.5 × IQR
Upper Bound = Q3 + 1.5 × IQR
```

### Results

* Upper bound: **83.5 ppb**
* Lower bound: **-16.5 ppb**
* **15 observations** were identified as anomalies
* Anomalies were mainly unusually high ozone observations
* The maximum detected ozone value was approximately **168 ppb**

The largest number of anomalies occurred during **August**.

---

## 🛠️ 8. Feature Engineering

Additional features are created to improve the modeling process.

### Date Feature

The `Month` and `Day` variables are combined to create a proper R `Date` variable.

### Temperature Category

Temperature is divided into:

* `Low`
* `Medium`
* `High`

### Wind Category

Wind speed is divided into:

* `Low Wind`
* `Medium Wind`
* `High Wind`

### Temperature-Wind Product Feature

A new feature is created:

```r
Temp_Wind = Temp * Wind
```

This engineered feature represents the combined numerical effect of temperature and wind in the predictive model.

---

## 🤖 9. Predictive Modeling

The cleaned dataset is divided into:

* **80% Training Data**
* **20% Testing Data**

A fixed random seed is used to make the split reproducible:

```r
set.seed(123)
```

---

### Model 1 — Baseline Model

```r
Ozone ~ Temp + Wind + Solar.R
```

The first model uses the three original environmental predictors.

### Model 2 — Feature-Enhanced Model

```r
Ozone ~ Temp + Wind + Solar.R + Temp_Wind
```

The second model additionally uses the engineered `Temp_Wind` feature.

### Model Performance

| Model   | Training R² |
| ------- | ----------: |
| Model 1 |    ≈ 45.73% |
| Model 2 |    ≈ 56.24% |

Model 2 provides higher explanatory power on the training data after adding the engineered feature.

---

## 📉 10. Actual vs Predicted Analysis

Predictions are generated using the test dataset.

An **Actual vs Predicted** plot is used to visually compare the models.

A reference line:

```r
y = x
```

represents perfect prediction.

The closer the predicted values are to this line, the better the predictions match the actual ozone values.

---

## 📏 Model Evaluation

The project can evaluate the models using:

### MAE — Mean Absolute Error

Measures the average absolute prediction error.

**Lower MAE = Better performance**

### RMSE — Root Mean Squared Error

Penalizes larger prediction errors more strongly.

**Lower RMSE = Better performance**

### R² — R-squared

Measures how much variation in the target variable is explained by the model.

**Higher R² = Generally better explanatory performance**

---

## 🔍 Key Findings

Based on the analysis:

1. **Temperature has a positive relationship with ozone concentration.**
2. **Wind has a negative relationship with ozone concentration.**
3. Solar radiation shows a weaker positive relationship with ozone.
4. Multiple regression explains more ozone variation than individual predictors.
5. Several unusually high ozone observations were detected using the IQR method.
6. Summer months contain many of the higher ozone observations.
7. Adding the engineered `Temp_Wind` feature improves the training R² of the second model.
8. Actual-vs-predicted visualization provides a useful way to compare model behavior.

---

## 🧰 Technologies & Tools

* **R**
* Base R
* Statistical Modeling
* Data Cleaning
* Exploratory Data Analysis
* Data Visualization
* Linear Regression
* Time-Series Analysis
* Feature Engineering
* Anomaly Detection

### R Functions Used

```text
is.na()
colSums()
na.omit()
complete.cases()
summary()
str()
hist()
boxplot()
plot()
cor()
lm()
summary()
predict()
quantile()
IQR()
ts()
filter()
acf()
cut()
sample()
```

---

## 📁 Project Structure

```text
Air-Quality-Analysis/
│
├── README.md
│
├── R/
│   ├── 01_data_understanding.R
│   ├── 02_data_quality.R
│   ├── 03_data_cleaning.R
│   ├── 04_eda.R
│   ├── 05_statistical_analysis.R
│   ├── 06_time_analysis.R
│   ├── 07_anomaly_detection.R
│   ├── 08_feature_engineerinng.R
│   └── 09_modeling.R
│
├── plots/
│   ├── Ozone vs Wind.png
│   ├── Ozone vs Temperature.png
│   ├── Ozone vs Solar Radiation.png
│   ├── Ozone Histrogram.png
│   ├── Ozone Boxplot.png
│   ├── Monthly Ozone Analysis.png
│   └── actual vs predicted.png
│
└── report/
    └── project_report.pdf
```

> **Note:** The exact filenames can be adjusted to match the actual project files.

---

## ▶️ How to Run

### 1. Clone the repository

```bash
https://github.com/ratulabid/Air-Quality-Analysis
```

### 2. Open the project in RStudio

Open the `.R` files from the `R/` directory.

### 3. Run the scripts

Run the scripts sequentially from data cleaning to model evaluation.

The project uses R's built-in `airquality` dataset, so no external dataset download is required for the core analysis.

---

## 📌 Project Workflow

```text
Raw Data
   ↓
Data Cleaning
   ↓
Exploratory Data Analysis
   ↓
Correlation Analysis
   ↓
Regression Analysis
   ↓
Time-Series Analysis
   ↓
Anomaly Detection
   ↓
Feature Engineering
   ↓
Train/Test Split
   ↓
Model 1
   ↓
Model 2
   ↓
Prediction
   ↓
Model Evaluation
   ↓
Final Insights
```

---

## 🚀 Future Improvements

Possible extensions of this project include:

* Interactive **Shiny dashboard**
* Advanced regression models
* Random Forest / XGBoost comparison
* Cross-validation
* Hyperparameter tuning
* More advanced time-series forecasting
* Automated model evaluation
* Interactive monthly air-quality visualization

---

## 👨‍💻 Author

**Md. Ratul Hasan Abid**

Artificial Intelligence & Data Science Student
Green University of Bangladesh

GitHub: [@ratulabid](https://github.com/ratulabid)

---

## ⭐ If You Find This Project Useful

Feel free to **star ⭐ the repository** and explore the analysis.
