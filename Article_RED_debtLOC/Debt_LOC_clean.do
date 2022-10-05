cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
July 22, 2022
-----
Revue d'Économie du Développement :
Locus de contrôle, identité sociale et endettement en Inde du Sud
-----

-------------------------
*/




****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all

global directory = "C:\Users\Arnaud\Documents\MEGA\Thesis\Thesis_Debt_skills\Analysis"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"

global wave3 "NEEMSIS2-HH"
global loan "NEEMSIS2-all_loans"
****************************************
* END








****************************************
* EFA 2020
****************************************

********** 
use"$wave3", clear
keep if egoid>0

order HHID_panel INDID_panel ars2 curious cr_curious
sort HHID_panel INDID_panel



***** Save
save"$wave3~_ego_RED.dta", replace



********** Locus of control
use"$wave3~_ego_RED.dta", clear

/*
1. I like taking responsibility.
2. I find it best to make decisions by myself rather than to rely on fate.
3. When I encounter problems or opposition, I usually find ways and means to overcome them.
4. Success often depends more on luck than on effort.
5. I often have the feeling that I have little influence over what happens to me.
6. When I make important decisions, I often look at what others have done.
*/

global locus locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6
fre $locus

omegacoef locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6, reverse(locuscontrol4 locuscontrol5 locuscontrol6) noreverse(locuscontrol1 locuscontrol2 locuscontrol3)


***** Reverse locuscontrol4 5 6 for min=intern and max=extern as locuscontrol1 2 3
forvalues i=4(1)6 {
vreverse locuscontrol`i', gen(locuscontrol`i'_rv)
rename locuscontrol`i' locuscontrol`i'_original
rename locuscontrol`i'_rv locuscontrol`i'
}

global locus locuscontrol1 locuscontrol2 locuscontrol3 locuscontrol4 locuscontrol5 locuscontrol6
fre $locus


***** Internal consistency
omegacoef $locus  // .81


* Score
egen locus=rowmean($locus)
replace locus=round(locus, .01)
label var locus "intern --> extern"

tabstat locus, stat(n mean sd p50) by(sex)
ta locus
gen locuscat=.
replace locuscat=1 if locus<3
replace locuscat=2 if locus==3
replace locuscat=3 if locus>3

label define locuscast 1"Intern" 2"Mid" 3"Extern"
label values locuscat locuscat

ta locus locuscat

********** Locus and income
*intern --> extern
tabstat locus, stat(n mean sd p50) by(caste)
tabstat locus, stat(min p1 p5 p10 q p90 p95 p99 max) by(caste)

ta locus caste
ta locuscat caste, col nofreq
ta locuscat caste, chi2 cchi2 exp
*Ok, upper castes are over rep among intern


***** Save
save"$wave3~_ego_v2_RED.dta", replace

****************************************
* END