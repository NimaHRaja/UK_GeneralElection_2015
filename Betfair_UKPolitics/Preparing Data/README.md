Betfair_UKPolitics_Preparing Data
=======================

/data
-----
raw data files.

Get_list_of_Betfair_UKPolitics_Markets
--------------------------------------
*Get_list_of_Betfair_UKPolitics_Markets.R* retrieves a list of all UK-Politics from Betfair,  

and saves the result in */data/list_of_Betfair_UKPolitics_Markets.txt*.


Betfair_data_parse
------------------
C# project.  

Used [Fiddler](http://www.telerik.com/fiddler) and [http://json2csharp.com/](http://json2csharp.com/) to create two of the classes.  

Reads *list_of_Betfair_UKPolitics_Markets.txt* and extracts the odds for all the markets in that list.  

For each combination market of outcome the code returns up to 3 values for back and up to 3 values for lay. (same for size (available to bet).  

Appends the new data to the existing */data/Betfair_UKPolitics_odds.csv*.


Clean_UKPolitics_Odds_Data
--------------------------
*Clean_UKPolitics_Odds_Data.R* reads */data/Betfair_UKPolitics_odds.csv*,  

and for each combination of Market/outcome/time finds the best available odds (both back and lay)  

and saves the output in *Betfair_UKPolitics_Odds_History.csv*.

*Clean_UKPolitics_Odds_Data_Tests* tests */data/Betfair_UKPolitics_odds.csv*, looking for inconsistencies, duplicates, ...

Betfair_UKPolitics_Odds_History.csv
-----------------------------------
Output file with 6 columns:
- Market 
- Outcome
- Date_char
- Back
- Lay
- Matched
