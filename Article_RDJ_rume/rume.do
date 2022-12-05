cls
/*
-------------------------
Arnaud Natal
arnaud.natal@u-bordeaux.fr
November 26, 2022
-----
Research Data Journal for the Humanities and Social Sciences:
RUME dataset
-----

-------------------------
*/




****************************************
* INITIALIZATION
****************************************
clear all
macro drop _all

global directory = "C:\Users\Arnaud\Documents\MEGA\Publi\Article_RDJ_RUME\Analysis"
cd"$directory"
global git "C:\Users\Arnaud\Documents\GitHub"

global HH "RUME-HH"
global loan "RUME-loans_mainloans"
global occup "RUME-occupations"
global lender "RUME-lenders"
****************************************
* END








****************************************
* Stat
****************************************
use"$HH", clear

********** Table 1
preserve
bysort HHID2010: egen HHsize=sum(1)
keep HHID2010 caste jatis religion ownland village villagearea HHsize
duplicates drop HHID2010, force 
sum HHsize
ta village
ta villagearea
ta caste
ta religion
ta ownland
restore


********** Table 2
ta sex
sum age
ta education









****************************************
* END
