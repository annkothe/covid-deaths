//Title: Toronto COVID Deaths
//Author: Angela Kothe
//Date: 12.22.21
//Purpose: Cleaning COVID 
//Requires: Open Toronto COVID file, Week 12/22
//Output: Internal

clear all

cd "/Users/annkothe/Documents/GitHub/covid deaths"

import delimited "COVID19cases.csv", clear

// renaming variables
rename assigned_id id
rename neighbourhoodname neighbourhood
rename reporteddate date

// filter by fatalities.
drop if outcome != "FATAL" 

keep id date neighbourhood fsa

// calculating deaths
sort date neighbourhood

gen x = 1

egen ndeaths = sum(x), by (date neighbourhood)
label variable ndeaths "Death in a Neighborhood on a Specific Day"

*deaths per day
egen dailytotal = sum(x), by (date)

*column of total number of deaths in the dataset
*gen grosstotal = dailytotal + (_n - 1)

*egen grosstotal = sum(x), by (date)

*collapse to organize by neighborhood and date
collapse (firstnm) id fsa dailytotal ndeaths, by(date neighbourhood)

// save
save "cleanedCOVID19fatalities.dta"


*In a seperate file, collapse daily totals by date then add them along
