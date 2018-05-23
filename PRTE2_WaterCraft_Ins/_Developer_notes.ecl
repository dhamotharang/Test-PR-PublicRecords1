/* ***********************************************************************************************
//TODO JAN 2018 - noticed that the DIDs in the old data aren't real - someday fix DIDs
???  NO - Insurance has NEVER used all these watercraft - I think the contractor must have 
include existing Boca data in the base file, and since then Boca did their own build and either
duplicated the extra data in our base file OR else they just started with new data when they did 
the Boca business case to re-do the builds.

ALSO: Unique should be watercraft_key + sequence_key but Shannon says unique isn't a good clean 
thing due to data corruption that they haven't had time to fix.

[‎5/‎17/‎2018 2:19 PM] Petro, Bruce (RIS-ATL): 
Shannon, got 1 second for quick question?
In watercraft - is a record unique by watercraft_key+sequence_key?
[‎5/‎17/‎2018 2:23 PM] Skumanich, Shannon (RIS-BCT): 
Supposed to be, but that has been an issue for some time as the code for both are not correct.  
But correcting it would change about 80% of the records which you know would cause a major meltdown 
for scoring so it actually has to be a coordinated project to fix.  So far has not become high priority yet. 
[‎5/‎17/‎2018 2:24 PM] Petro, Bruce (RIS-ATL): 
Ah, so sounds like no way to identify a unique record then.  thanks.  not a major thing, just wondering.
[‎5/‎17/‎2018 2:25 PM] Skumanich, Shannon (RIS-BCT): 
Well, for the most part, watercraft_key and sequence_key are unique.
The only issue you would run into would be if sequence_key is blank, and watercraft_key uses a manufacturer name.

Utilities Gather Live Prod samples removes rows from production that are in the Gather file.
Because of the uniqueness problem I tried linking on watercraft_key+sequence_key+registration_Date+hull_number
COUNT(PROD_ReadOnly_DS);	//91,770,210  
COUNT(Gathered)				//19,000
COUNT(NEW_Only);				//91,552,834 
So yeah it is eliminating some but boy - eliminating a lot more than I thought. Back to the unique issue I guess.
*********************************************************************************************** */