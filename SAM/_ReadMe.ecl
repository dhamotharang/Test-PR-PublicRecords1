/**

EPLS Field						SAM Field
==========					===============
Cause 							Nature (Cause)
Treatment 					Effect
CT Action 					[DISCONTINUED]
Action Date 				Active Date
Archived 						Inactive
Entity 							Special Entity Designation
Permanent 					[DISCONTINUED]
CT Code 						Exclusion Type
Exclusion Type 			Exclusion Program
Description 				Additional Comments


I’m used to searching the Excluded Parties List System (EPLS). With the
move to SAM, what changes do I need to know about?
All the information that was in EPLS was moved to SAM, but here are some changes you
will see:

SAM no longer uses Cause and Treatment (CT) codes. These codes have been
mapped to four Exclusion Types: Ineligible (Proceedings Pending), Ineligible
(Proceedings Completed), Prohibition/Restriction, and Voluntary Exclusion. The
Exclusion Type shown specifies why an entity is on the excluded parties list and
communicates the associated ramifications (e.g., whether I can award a contract to
this entity, etc.). Any record that was previously entered in EPLS with a CT code
will display that code on the screen as historical data, but future records in SAM will
have no CT codes. If you would like to see a list of CT codes and how they were
mapped, please go to www.sam.gov, select Help from the top navigation bar, and
select "Exclusions Information” and then “Exclusion Types" in the left navigation
panel.

Exclusions are categorized into four Classification Types: Firm, Individual, Vessel,
and Special Entity Designation. The last category is a miscellaneous category for any
organization that cannot be considered a Firm, Individual, or Vessel, but still needs to
be excluded. For example, the “Terrorists Against the USA” organization does not fit
into any of the previous categories and would be considered a Special Entity
Designation.

**/

/*
Sam file names are of the format SAM_Exclusions_Public_Extract_xxxxx.CSV
xxxxx is considered the version number

MakeSam will:
1) Spray the SAM file
2) Convert it to Bridger format
3) Desapry it to edata12

to call:
Sam.MakeSam('xxxxx');  // xxxxx matches the versions number of the SAM_Exclusions_Public_Extract_xxxxx.CSV file

*/