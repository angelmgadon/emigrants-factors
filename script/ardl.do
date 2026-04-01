* change directory
 cd "C:\Users\Admin\Desktop\thesis_stata"
 
 * activate log
* log using "C:\Users\Admin\Desktop\thesis_stata\ardl_logs.smcl"

 
 * import data
 clear
 import delimited "C:\Users\Admin\Desktop\thesis_stata\data\raw_data.csv"
 
 ** step 0. introduce time series
 
 tsset year
 
** preprocess
summarize emig exc ph_gdp ph_unemp ph_tax us_gdp us_unemp us_tax
summarize ln_emig ln_exc ln_ph_gdp ln_ph_unemp ln_ph_tax ln_us_gdp ln_us_unemp ln_us_tax

** 1. pretests

** 1.a stationarity

** 1.a emigrants
varsoc ln_emig
dfuller ln_emig, lags(2)
dfuller D.ln_emig, lags(2)

** 1.b exchange rate
varsoc ln_exc
dfuller ln_exc, lags(1)
dfuller D.ln_exc, lags(1)

** 1.c ph_gdp
varsoc ln_ph_gdp
dfuller ln_ph_gdp, lags(1)
dfuller D.ln_ph_gdp, lags(1)

* Note: ikaw na tiwas ani.

** ardl using Sebastian's

ardl ln_y ln_px1 ln_px2 ln_px3 ln_ux1

** bound testing






