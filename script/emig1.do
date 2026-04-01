* change directory
 cd "C:\Users\Admin\Desktop\emigrants-factors"
 
 * activate log
* log using "C:\Users\Admin\Desktop\emigrants-factors\ardl_logs.smcl"

 
 * import data
 clear
 import delimited "C:\Users\Admin\Desktop\emigrants-factors\data\final\emig1.csv"
 
 ** step 0. introduce time series
 
 tsset year
 
** preprocess
summarize emig er_phl gdppc_phl gdppc_usa unemp_phl unemp_usa tax_rev_phl tax_rev_usa
** checking if the variables are good for logging(ln), if values are negative or 0, do not log the vars.

summarize ln_emig ln_er_phl ln_gdppc_phl ln_gdppc_usa ln_unemp_phl ln_unemp_usa ln_tax_rev_phl ln_tax_rev_usa

** 1. pretests

** 1.a stationarity

** 1.a emigrants
varsoc ln_emig
** opt. lags is 2
dfuller ln_emig, lags(2)
dfuller D.ln_emig, lags(2)
** I(1)

** 1.b exchange rate
varsoc ln_er_phl
** opt. lags is 1
dfuller ln_er_phl, lags(1)
dfuller D.ln_er_phl, lags(1)
** I(1)

** 1.c ln_gdppc_phl
varsoc ln_gdppc_phl
** opt. lags is 1
dfuller ln_gdppc_phl, lags(1)
dfuller D.ln_gdppc_phl, lags(1)
** I(1)

** 1.d ln_gdppc_usa
varsoc ln_gdppc_usa
** opt. lags is 1
dfuller ln_gdppc_usa, lags(1)
dfuller D.ln_gdppc_usa, lags(1)
** I(1)

** 1.e ln_unemp_phl
varsoc ln_unemp_phl
** opt. lags is 3
dfuller ln_unemp_phl, lags(3)
dfuller D.ln_unemp_phl, lags(3)
** I(1)

** 1.f ln_unemp_usa
varsoc ln_unemp_usa
** opt. lags is 2
dfuller ln_unemp_usa, lags(2)
dfuller D.ln_unemp_usa, lags(2)
** I(1)

** 1.g ln_tax_rev_phl
varsoc ln_tax_rev_phl
** opt. lags is 2
dfuller ln_tax_rev_phl, lags(2)
dfuller D.ln_tax_rev_phl, lags(2)
** I(1)

** 1.h ln_tax_rev_usa
varsoc ln_tax_rev_usa
** opt. lags is 2
dfuller ln_tax_rev_usa, lags(2)
dfuller D.ln_tax_rev_usa, lags(2)
** I(1)


** ardl using Sebastian's

ardl ln_y ln_px1 ln_px2 ln_px3 ln_ux1

** bound testing






