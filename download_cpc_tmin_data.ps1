$Urls = @()

$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1979.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1980.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1981.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1982.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1983.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1984.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1985.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1986.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1987.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1988.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1989.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1990.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1991.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1992.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1993.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1994.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1995.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1996.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1997.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1998.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.1999.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2000.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2001.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2002.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2003.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2004.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2005.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2006.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2007.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2008.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2009.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2010.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2011.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2012.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2013.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2014.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2015.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2016.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2017.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2018.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2019.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmin.2020.nc"


$OutPath = "D:\JPW\Data_CPC_Global_Temp\"

ForEach ( $item in $Urls) {

   Write-Host "Outputting file: " $item -ForegroundColor Yellow

   $file = $OutPath +  ($item).split('/')[-1]

   (New-Object System.Net.WebClient).DownloadFile($item, $file)

}