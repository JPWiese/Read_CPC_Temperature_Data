

Compute_Monthly_Means <- function(Location_Data, sWeatherVar, yr)
{
  
  m_first <- FirstMonth
  m_last <- LastMonth
  
  # create a list holding the first day of each month
  
  if (yr %% 4 == 0) # leap year (366 days)
  {
    FirstDayOfMonth <- list(1, 32, 61, 92, 122, 153, 183, 214, 245, 275, 306, 336, 367)
  }
  else # regular year (365 days)
  {
    FirstDayOfMonth <- list(1, 32, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366)
  }
  
  # open the data file for this year
  
  sYr <- as.character(yr)
  iFileName <- paste(Location_Data, "/", sWeatherVar, ".", sYr,".nc", sep = "")
  nc <- nc_open(iFileName)
  
  # extract information about weather variable
  
  dname <- sWeatherVar
  dlname <- ncatt_get( nc, dname, attname="long_name", verbose=FALSE )
  dlunits <- ncatt_get( nc, dname, attname="units", verbose=FALSE )
  fillvalue <- ncatt_get(nc, dname, "_FillValue")
  
  # get the dimensions of the data array  
  
  xlon <- ncvar_get(nc, "lon")
  xlat <- ncvar_get(nc, "lat")
  xtime <- ncvar_get(nc, "time")
  
  nlon <- dim(xlon)   #720
  nlat<- dim(xlat)    #360
  ntime<- dim(xtime)  #365 days
  
  # make grid of given longitude and latitude
  
  lonlat <- expand.grid(xlon, xlat)     
  
  #fetch the weather data 
  
  myData.array <- ncvar_get(nc, dname)
  
  # convert the data to a data frame
  
  #this df should have 720 * 360 = 259200 rows, each row holding
  #the myData for a lat/lon pair. There will be 365 or 366 columns, holding
  #myData for each day of the year.
  
  myData.vec.long <- as.vector(myData.array) 
  myData.mat <- matrix(myData.vec.long, nrow = nlon * nlat, ncol = ntime)
  myData.df <- data.frame(myData.mat)
  
  # close the netcdf file
  
  nc_close(nc)
  
  # compute monthly averages
  
  nCol <- ncol(myData.df)  #1980, 1984, 1988 etc = 366 days, while other years = 365 days
  
  fd <- FirstDayOfMonth
  
  xMeans <- 0
  
  for (m in m_first:m_last)
  {
    
    d_first <- fd[[m]]
    d_last <- fd[[m + 1]] - 1
    
    # this is the mean for each row of the data frame, focusing on the specified range of days;
    # select c(first:last) should select the entire range of columns from "first" to "last",
    # where, in this case, these values are the first and last days of a month
    
    xMean <- rowMeans(subset(myData.df, select = c(d_first:d_last)), na.rm = TRUE)
    
    # merge results for each month into a single data frame
    
    if (m == 1) 
    {
      xMeans <- xMean
    }
    else 
    {
      xMeans <- cbind(xMeans, xMean)
    }
    
  }
  
  # two decimals is plenty -- more decimals unnecessarily increases output file size
  
  xMeans <- round(xMeans, 2)
  xMeans <- data.frame(xMeans)
  
  # assign a name to each column of the data frame of monthly means
  
  for (m in m_first:m_last)
  {
    sYear <- as.character(yr)
    sMonth <- as.character(m)
    sColName <- paste("f", sYear, "-", sMonth, sep = "")
    names(xMeans)[m] <- sColName
  }
  
  # if we are in the first year of analysis, add columns for lat/lon coordinates
  
  if (yr == FirstYear)
  {
    xMeans <- cbind(lonlat, xMeans)
    names(xMeans)[1] <- "lon"
    names(xMeans)[2] <- "lat"
  }
  
    
  return(xMeans)
  
}  

Compute_Global_Average <- function(MonthlyMeans, Output_Global)
{

 # This function computes the global average temperature across
 # all lat and lon pairs that have data. A weighted average is
 # used, where the weight is proportional to the cosine of latitude.
 # Keep in mind that the spacing between lines of longitude is
 # widest at the equator, and narrows as one approaches the poles.
  
 nCols <- ncol(MonthlyMeans)  
  
 MonthlyMeans$cos <- cos(MonthlyMeans$lat * 3.1415 / 180)

 sumCos <- sum(MonthlyMeans$cos)
 
 # multiple data columns by the cosine of latitude
 
 c_first <- 3    # the first 2 columns hold the lat and lon, so we start with col 3
 c_last <- nCols

 MonthlyMeans <- MonthlyMeans[c_first:c_last] * MonthlyMeans$cos

 # calculate global average for each column (where a column holds one month of data)
 
 GlobalSum <- colSums(MonthlyMeans)
 GlobalAvg <- GlobalSum / sumCos
 GlobalAvg <- round(GlobalAvg, 2)
 GlobalAvg <- data.frame(GlobalAvg)
 names(GlobalAvg)[1] <- "celsius"
 
 # output results
 
 write.csv(GlobalAvg, file = Output_Global)
 
}


Output_Raw_Data <- function(Location_Data, sWeatherVar, yr)
{
  
  # open the data file for this year
  
  sYr <- as.character(yr)
  iFileName <- paste(Location_Data, "/", sWeatherVar, ".", sYr,".nc", sep = "")
  nc <- nc_open(iFileName)
  
  # extract information about weather variable
  
  dname <- sWeatherVar
  dlname <- ncatt_get( nc, dname, attname="long_name", verbose=FALSE )
  dlunits <- ncatt_get( nc, dname, attname="units", verbose=FALSE )
  fillvalue <- ncatt_get(nc, dname, "_FillValue")
  
  # get the dimensions of the data array  
  
  xlon <- ncvar_get(nc, "lon")
  xlat <- ncvar_get(nc, "lat")
  xtime <- ncvar_get(nc, "time")
  
  nlon <- dim(xlon)   #720
  nlat<- dim(xlat)    #360
  ntime<- dim(xtime)  #365 days
  
  # make grid of given longitude and latitude
  
  lonlat <- expand.grid(xlon, xlat)     
  
  #fetch the weather data 
  
  myData.array <- ncvar_get(nc, dname)
  
  # convert the data to a data frame
  
  #this df should have 720 * 360 = 259200 rows, each row holding
  #the myData for a lat/lon pair. There will be 365 or 366 columns, holding
  #myData for each day of the year.
  
  myData.vec.long <- as.vector(myData.array) 
  myData.mat <- matrix(myData.vec.long, nrow = nlon * nlat, ncol = ntime)
  myData.df <- data.frame(myData.mat)
  
  # close the netcdf file
  
  nc_close(nc)
  
  # two decimals is plenty -- more decimals unnecessarily increases output file size
  
  myData.df <- round(myData.df, 2)
  
  # assign a name to each column of the data frame 
  
  nDays = ncol(myData.df)
  
  for (d in 1:nDays)
  {
    sYear <- as.character(yr)
    sDay <- as.character(d)
    sColName <- paste("f", sYear, "-", sDay, sep = "")
    names(myData.df)[d] <- sColName
  }
  
  myData.df <- cbind(lonlat, myData.df)
  names(myData.df)[1] <- "lon"
  names(myData.df)[2] <- "lat"
  
  # drop rows for lat/lon pairs that are over the ocean and thus have no data
  
  myData.df <- na.omit(myData.df)
  
  # output CSV file
  
  write.csv(myData.df, row.names = FALSE, "out_raw_data.csv")
  
}  


round_df <- function(df, digits) 
{

  nums <- vapply(df, is.numeric, FUN.VALUE = logical(1))

  df[,nums] <- round(df[,nums], digits = digits)

  (df)
	
}



