clear
cls
set obs 100
set seed 100

gen gpa = 4*runiform()
generate cre = 4*floor(11*runiform())
gen never_taker = runiform()
gen D = 1 if gpa >= 2 & cre >= 20 & never_taker < 0.5
replace D = 0 if missing(D)
gen er = 0.1*(runiform()-0.5)

* b0=0 b1=0.1 b2=0.4/4 b3=0.4/40
gen Y1 = 0+1/10+gpa/10+cre/100+er
gen Y0 = 0+0/10+gpa/10+cre/100+er
gen Y = 0+D/10+gpa/10+cre/100+er

histogram gpa
histogram cre

reg Y D gpa cre
* render table out of regression
// ssc install outreg2
// outreg2 using test.doc

twoway (scatter D gpa)
twoway (scatter D cre)
twoway (scatter Y1 gpa) (lfit Y1 gpa) (scatter Y0 gpa) (lfit Y0 gpa)
twoway (scatter Y1 cre) (lfit Y1 cre) (scatter Y0 cre) (lfit Y0 cre)
