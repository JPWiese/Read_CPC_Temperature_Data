
# A program to loop through each year in the CPC temperature dataset
# and compute monthly means for each latitude/longitude pair.
# I have excluded 2020 because the code isn't designed to handle partial years.

# If you run this program from 1979 through 2019, and across all 12 calendar months,
# the resulting CSV output file will be about 180 megabytes.


cat("\014")

# you need the ncdf4 library, but you only need to install it once

#install.packages("ncdf4")  

library("ncdf4")

# set the variables below to indicate file locations and what you want to analyze

Location_R_Code <- "D:/JPW/data_CPC_Global_Temp"  # location of your R program

Location_Data <- "D:/JPW/data_CPC_Global_Temp/data_raw"   # location of CPC netCDF data files

WeatherMetric <- "tmin"  # tmin or tmax = daily min or max temperature

Output_Detailed <- "out_gridded_tmin.csv"  # output file for detailed tabulation results

Output_Global <- "out_global_tmin.csv"  # output file for global average results

FirstYear <<- 1979  # the year and month range across which to run the tabulations;
LastYear <<- 2019   # note that "<<-" indicates that these are global variables which
FirstMonth <<- 1    # can be accessed anywhere in the program, as opposed to simply
LastMonth <<- 12    # in the main program

OutputRawDataYear <<- 0 # just to show you the data, I output the raw data for this year;
                        # alternatively, set to zero to deactivate this code

# Each year's netcdf file is about 80 megs. If you convert to CSV, the file will be about
# 350 megs. However, must of the data is simply "NA" values indicating that a particular
# lat/lon pair is over water. Eliminating these unimportant rows reduces the CSV file size
# to 


setwd(Location_R_Code)

source("cpc_tabulate_support.r")

cat("\014")

# loop through the data files, processing one year at a time

MonthlyMeans <- 0

if (OutputRawDataYear >= 1979 & OutputRawDataYear <= 2019)
{
  Output_Raw_Data(Location_Data, WeatherMetric, OutputRawDataYear)
}


for (yr in FirstYear:LastYear) 
{
  
  print(yr) # progress update
  
  MeansThisYear <- Compute_Monthly_Means(Location_Data, WeatherMetric, yr)
  
  if (yr == FirstYear)
  {
   MonthlyMeans <- MeansThisYear 
  }
  else
  {
   MonthlyMeans <- cbind(MonthlyMeans, MeansThisYear) 
  }
  
}

# drop rows for lat/lon pairs that are over the ocean and thus have no data

MonthlyMeans <- na.omit(MonthlyMeans)

# output monthly means for each latitude and longitude pair

write.csv(MonthlyMeans, row.names = FALSE, file = Output_Detailed)

# compute global monthly averages across all lat/lon pairs

Compute_Global_Average(MonthlyMeans, Output_Global)

# done

print("Success! Done with calculations.")

