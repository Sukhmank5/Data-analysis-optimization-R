# Load necessary package
library(ggplot2)  # For creating plots

# Load the dataset
load("TheData.RData")  # Load the .RData file that contains clean_data dataframe

# View the first few rows
head(clean_data)  # Check that the data loaded correctly

# VISUALIZATION
# Create scatter plot with regression line
ggplot(clean_data, aes(x = PE10, y = `Real Price`)) + 
  geom_point(alpha = 0.6, color = "red") +  # Plot points
  geom_smooth(method = "lm", color = "pink", se = TRUE) +  # Regression line
  labs(
    title = "Relationship Between PE10 and Inflation-Adjusted S&P 500 Price",
    x = "Shiller PE Ratio (PE10)",
    y = "Real S&P 500 Price"
  ) +
  theme_minimal()  # Clean minimal theme

# ANALYSIS
# I chose a Linear Model (lm)
# This is appropriate because both PE10 and Real Price are continuous variables and I'm testing a predictive linear relationship.

# Run the linear regression
model <- lm(`Real Price` ~ PE10, data = clean_data)  # Fit linear model

# Show summary of the model
summary(model)  # Outputs coefficients, p-values, R-squared, etc.

# The regression analysis shows that for every 1-unit increase in PE10, the real S&P 500 price increases by approximately 61.87 points. 
# This relationship is statistically significant (p < 2e-16), and the model explains about 58.5% of the variation in real prices (R² = 0.5847).

# CHECKING ASSUMPTIONS
# 1. Linearity
plot(clean_data$PE10, clean_data$`Real Price`)  # Should show a roughly linear pattern

# 2. Residuals for normality
hist(residuals(model))  # Histogram of residuals should look normal

# 3. Homoscedasticity (equal variance)
plot(model$fitted.values, residuals(model))  # Should not show a funnel shape

# INTERPRETATION
# There is a statistically significant positive relationship between PE10 and real (inflation-adjusted) S&P 500 price.
# Specifically, the model suggests that for each 1-unit increase in PE10, the real S&P 500 price increases by approximately 61.87 points, on average.
# However, it’s important to note that this analysis looks at the relationship between PE10 and current prices, not future returns.
# Therefore, this does not contradict the common belief that high PE10 values often predict lower long-term future returns.
# Instead, it simply confirms that markets tend to be priced higher when valuations (like PE10) are elevated.
