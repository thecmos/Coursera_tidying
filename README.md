# Coursera_tidying
# Repo for Coursera assignment, Getting and Cleaning data course, week 4. 
# Packages used are dplyr and tidyr.
# I have not written functions to programmatically tidy the data set. Instead, I have worked interactively at the R console.
# Comments are inserted in the code to explain almost each step.
# These are in short:
# 1. Read the files using scan and read.delim functions. The files contain training and testing recorded results, activities and subjects id's, activities names. I have also imported the inertial signal files using read.table function, and I have added its variables as column names in the new bound/merged dataset, even though it was a tedious effort and it was clear that these variables did not have to be extracted.
# 2. Column names are added, using the variable names extracted from the researchers' files.
# 3. Since none of different tables contain the "key" variable, the tables' rows and columns have to be bound using rbind and cbind. I have to assume that the researchers constructed the tables in a way that ensured perfect correspondence or rows across all tables. Only once I am using the merge function.
# 4. A little cleaning of the variables names, to remove dashes.
# 5. Also need to convert all values of the final tidy dataset to numeric because for some reason when trying afterwards to calculate the cariable means, error messages showed they were not numeric.
# 6. Both dataset requested, tidy dataset and means dataset, exported as csv files to enjoy their beauty.
# Note: I am convinced that the team of researchers who conducted the wearable computing experiment is a group of great electronic engineers, but in my humble opinion they should take this course right away.
# If this assignment is really supposed to take two hours then I need to put much more effort in learning how to get and clean data, because it has taken me much much longer than that.
