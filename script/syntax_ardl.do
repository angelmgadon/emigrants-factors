*==============================================================================
* ARDL Analysis: Bilateral Push-Pull Factors of Filipino Emigration to the United States using ARDL Model
* Author : Ralph A. Morales
* Date   : April 1, 2026
*==============================================================================

cd "C:\Users\Admin\Desktop\emigrants-factors"

*------------------------------------------------------------------------------
* 0. DATA SETUP
*------------------------------------------------------------------------------
clear
import delimited ".\data\final\emig1.csv"

tsset year

*------------------------------------------------------------------------------
* 1. DESCRIPTIVE STATISTICS
*------------------------------------------------------------------------------
summarize emig er_phl gdppc_phl gdppc_usa unemp_phl unemp_usa tax_phl tax_usa
summarize ln_emig ln_er_phl ln_gdppc_phl ln_gdppc_usa ln_unemp_phl ///
          ln_unemp_usa ln_tax_phl ln_tax_usa

*------------------------------------------------------------------------------
* 2. UNIT ROOT TESTS (ADF)
* All variables confirmed I(1): non-stationary in levels,
* stationary in first differences.
*
* Optimal lags selected via varsoc (AIC/BIC).
*------------------------------------------------------------------------------

* --- 2.1 Emigrants (ln_emig) — optimal lag: 2 ---
varsoc ln_emig
dfuller ln_emig,   lags(2)    // Level:      non-stationary
dfuller D.ln_emig, lags(2)    // Difference: stationary → I(1)

* --- 2.2 Exchange rate (ln_er_phl) — optimal lag: 1 ---
varsoc ln_er_phl
dfuller ln_er_phl,   lags(1)
dfuller D.ln_er_phl, lags(1)

* --- 2.3 Philippine GDP per capita (ln_gdppc_phl) — optimal lag: 1 ---
varsoc ln_gdppc_phl
dfuller ln_gdppc_phl,   lags(1)
dfuller D.ln_gdppc_phl, lags(1)

* --- 2.4 US GDP per capita (ln_gdppc_usa) — optimal lag: 1 ---
varsoc ln_gdppc_usa
dfuller ln_gdppc_usa,   lags(1)
dfuller D.ln_gdppc_usa, lags(1)

* --- 2.5 Philippine unemployment (ln_unemp_phl) — optimal lag: 3 ---
varsoc ln_unemp_phl
dfuller ln_unemp_phl,   lags(3)
dfuller D.ln_unemp_phl, lags(3)

* --- 2.6 US unemployment (ln_unemp_usa) — optimal lag: 2 ---
varsoc ln_unemp_usa
dfuller ln_unemp_usa,   lags(2)
dfuller D.ln_unemp_usa, lags(2)

* --- 2.7 Philippine tax revenue (ln_tax_phl) — optimal lag: 2 ---
varsoc ln_tax_phl
dfuller ln_tax_phl,   lags(2)
dfuller D.ln_tax_phl, lags(2)

* --- 2.8 US tax revenue (ln_tax_usa) — optimal lag: 2 ---
varsoc ln_tax_usa
dfuller ln_tax_usa, lags(2)    // Level only tested; D.ln_tax_usa assumed I(1)

*------------------------------------------------------------------------------
* 3. ARDL MODEL (Bounds Testing Approach)
* Dependent variable: ln_emig
* AIC lag selection, error-correction form
*------------------------------------------------------------------------------
ardl ln_emig ln_gdppc_phl ln_gdppc_usa ln_unemp_phl ln_tax_phl, ///
     maxlags(1) aic ec

* Bounds test for cointegration (H0: no long-run relationship)
estat ectest

*------------------------------------------------------------------------------
* 4. POST-ESTIMATION DIAGNOSTICS
*------------------------------------------------------------------------------

* 4.1 Serial correlation — Breusch-Godfrey (1 lag)
estat bgodfrey, lags(1)

* 4.2 Heteroskedasticity — Breusch-Pagan
estat hettest

* 4.3 Normality of residuals — Skewness/Kurtosis & Jarque-Bera
predict resid, residuals
sktest  resid
jb      resid
