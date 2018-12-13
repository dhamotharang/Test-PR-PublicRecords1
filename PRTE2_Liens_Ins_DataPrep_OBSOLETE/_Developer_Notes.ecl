/* *********************************************************************************************
PRTE2_Liens_Ins_DataPrep._Developer_Notes

May 2017 - adding new test cases for Equifax and TU and Risk Classifier
NOTE: These are now a standard way we can gather and create data when handed N number of IHDR records.

1) BWR_Add_Equifax, BWR_Add_TU	- First had to spray in 50k data they handed us in order to then select just 10/state from each
2) BWR_Gather_PROD_PartyMain_perState	- gather production data with PII still included for samples
3) BWR_Generate_1a_Spray_IHDR_Records	- spray used to spray in IHDR records handed that are for Risk Classifier
4) BWR_Generate_1b_Read_IHDR_Foreign	- used to read from IHDR after we did "add" process for 500 TU and EQ selected by 1)
5) BWR_Generate_1c_Renumber_JoinInt		- This was added to the 3 and 4 above but can be run if renumber is still needed.
6) BWR_Generate_2_From_IHDR_Records		- Takes IHDR records, joins with Prod Party records, joins with Prod Main, overwrites PII
7) BWR_Generate_3_RemoveSamplesUsed		- Either need to run this or else re-run #2 above to wipe out previous prod data.
Files
Layouts
BWR_Despray_WIP_Files

*********************************************************************************************
NOTE: FilingNumber (or orig_filingNumber,case_number) PLUS FilingLocation === PII TRACKABLE!!!!!  Alter one or both

*********************************************************************************************
There are a number of phases we went through to create initial data from what Analytics group handed us.
All of the U_* files are the initial phases described below
* Files below starting with U_GatherFix_BocaPRCT_Cases* names were initial attempts to take old PRCT 
  test data owned by Boca and manipulate that into good test data for Alpharetta.  This was successful
  but the group decided that Boca data was not good enough so we basically throw that away.

* Files below starting with U_GatherFix_Analytics_* were the second phase - taking data handed to 
us by the analytics group and turning that into new fake Alpharetta data.  This had one limitation
that the records handed to us were single event records - so we now have a lot of single event records
with no multiple records for history, no multiple records for people having multiple L&J and no multiple
for multiple people having one L or J

* U_GatherFix_Analytics_PRCT_1_PrimParty - special case - took primary drivers and created 47k initial party records.
NOTE: some of these had a HIT when checking the CT Alpharetta DID against the PRCT Boca DID - so these are marked and have 
zero in the joinint field - they cannot be used until we fix the IHDR and other alpharetta data and move them over to 
Boca compatible LexIDs.  
U_GatherFix_Analytics_Despray is the despray process to be run after the following:
	U_GatherFix_Analytics_PRCT_1_PrimParty
	U_GatherFix_Analytics_PRCT_2_Main   (the final import was LJTestCases1213_wTMSID.csv)
	U_GatherFix_Analytics_PRCT_2_PostProcess
	U_GatherFix_Analytics_PRCT_3_Usable
	U_GatherFix_Analytics_PRCT_9_audits	(just to check record counts, tmsid dups, etc)


Basic utility used by all phases
PRTE2_Liens_Ins_DataPrep.U_Gather_Layouts
PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Constants
PRTE2_Liens_Ins_DataPrep.U_Gather_PRCT_Files

* Also attributes that start with PRTE2_Liens_Ins_DataPrep.U_Production_* are scripts run in PROD Thor
to gather the tmsids that were in the file we got from analytics.  And pointers to read those files
foreign_prod for further steps here in dev.


output(LiensV2_preprocess.Files_lkp.filing_type, named('CA_FilingType'));
output(LiensV2_preprocess.Files_lkp.change_filing, named('CA_ChangeFilingType'));
output(LiensV2_preprocess.Files_lkp.HGFiling_type, named('HG_FilingType'));


********************************************************************************************* */