# Data Collection

I used a dataset for this analysis, which I obtained from the <a href="https://www.spc.noaa.gov/wcm/#data">SPC Tornado Database</a> Although a cleaned dataset with tornado data is available on <a href="https://www.kaggle.com/datasets/danbraswell/us-tornado-dataset-1950-2021">Kaggle</a>, the one I chose for this project contains more up-to-date information.

# Data Cleaning
Data cleaning for this project was performed using Excel. When I checked for duplicates, I found 342 duplicate values that were removed; I now have 68359 unique values. 

Using Find & Replace to check for NULL or empty values, I confirmed this data did not have any missing values. 

I also changed the data types in the “date” and “time” columns to “Short Date” and “Time” respectively to make sure those were formatted correctly as well. 

Missing tornado intensity data values were filled in with a value of -9. However, this could have skewed my data on the low side when I did my analysis, so I needed to replace those values with a placeholder. I used Find & Replace in Excel to replace each -9 value with NaN.
