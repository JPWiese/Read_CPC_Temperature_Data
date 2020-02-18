$Urls = @()

$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1979.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1980.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1981.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1982.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1983.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1984.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1985.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1986.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1987.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1988.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1989.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1990.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1991.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1992.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1993.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1994.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1995.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1996.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1997.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1998.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.1999.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2000.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2001.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2002.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2003.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2004.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2005.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2006.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2007.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2008.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2009.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2010.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2011.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2012.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2013.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2014.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2015.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2016.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2017.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2018.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2019.nc"
$Urls += "ftp://ftp.cdc.noaa.gov/Datasets/cpc_global_temp/tmax.2020.nc"


$OutPath = "D:\JPW\Data_CPC_Global_Temp\"

ForEach ( $item in $Urls) {

   Write-Host "Outputting file: " $item -ForegroundColor Yellow

   $file = $OutPath +  ($item).split('/')[-1]

   (New-Object System.Net.WebClient).DownloadFile($item, $file)

}