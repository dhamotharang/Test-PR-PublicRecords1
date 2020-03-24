/* ************************************************************************************************
 PRTE2_PropertyInfo_Ins._Developer_Notes
***************************************************************************************************
??  Next change we must make will be the Data3 changes - at that time we can fix the poor address stuff
***************************************************************************************************
Nov 2017 - need to remove all the Boca stuff.  If they start wanting data and a build they can do it.
							Also renamed the old PRTE2_PropertyInfo folder to PRTE2_PropertyInfo_Obsolete and requested
							this to be renamed in PROD as well.
***************************************************************************************************
Sept 2017 - asked Roxie developers - they use V_CITY_NAME for all comparisons so we should use that for despray.
New August 2017 - slight alteration to the add to get city from p_city_name for the clean address work.
		- Also altered the full base spray/build to also fill the cleaning fields from Nancy's fields.
		- SOON we need to alter this base to separate Nancy fields from updated clean fields.
New April 2017 - PRTE2_PropertyInfo Rashmi changes to Constants, Files, Layouts
New Heading toward STD Boca build...
April 2017 - Bruce altered in PRTE2_PropertyInfo:
		BWR_Build_PropertyInfo, BWR_Despray_Alpharetta_Base, BWR_Spray_Alpharetta_Base, Constants,
		Files - removed Boca File mentions, 
		Fn_Spray_Alpharetta_Add_Records, Fn_Spray_Alpharetta_Spreadsheet, - added pre-process prior to saving CSV file
		Get_Payload,  - Now the get_payload exports return files in the new Boca_Official_Layout.
		key_PropertyInfo_address, key_PropertyInfo_rid - complete re-write to use the same logic as the 
											PropertyCharacteristics versions
		Layouts, - new Boca_Official_Layout and separate AlphaPropertyCSVRec - we will have two base files
		NEW_process_build_propertyinfo, - CURRENTLY DOES NOT SAVE THE OFFICIAL ALPHA-Base in the Boca_Official_Layout (TODO)
		Transform_Alpha_Data, - tweaks to property transform
		Transforms - probably overkill but after spraying just to be safe we transform to the CSV layout and clean up fields

April 2017 after testing that code to confirm it works with new layout, Bruce copied all active code into new
code module (folder) - PRTE2_PropertyInfo_Ins
April 2017 - also MOVED all U* attributes into a new  PRTE2_PropertyInfo_Ins_Dev
1. Fn_Spray - creates base file with base file layout same as before but with 3 new fields.
2. Get_Payload - creates base file with new Boca Base layout but these are in MEMORY only during key build.
  TODO - need to after Fn_Spray do a new second key save with 3 generations which a new Boca build can use for Alpha data.
NOTE: 

***************************************************************************************************
*************** OLD PRTE2_PropertyInfo NOTES ******************************************************
***************************************************************************************************
NEW!  Dec 2016 - TODO in 2017 - we need to perform the record cloning and other preparations (get_payload)
and save a new secondary base file which can be copied to Alpharetta for use by the MapView builds
Charles has the following in MapViewExtracts files
PropCharacter_Extract_DS 	:= DATASET(data_services.foreign_prod_boca + 'thor_data400::base::propertyinfo',MapViewExtracts.Layouts.Base,thor);
dYearBuiltFile	:= MapviewExtracts.Files.PropCharacter_Extract_DS(vendor_source = 'A' and latitude <> '' and longitude <> ''); 
***************************************************************************************************
JULY 2016 - discovered that the PRTE2 PropInfo build does NOT do 3 gen SF so we are building
up a lot of dead files - plus the little key check logic has to have hardcoded the latest version
TODO - fix the build by adding the 3 gen macros for the keys.  (oddly we do 3gen for the base)
***************************************************************************************************
-------------- used the following to confirm that there are no duplicate address records ----------------
IMPORT PRTE2_PropertyInfo;
DS := PRTE2_PropertyInfo.Files.PII_ALPHA_BASE_SF_DS;
OUTPUT(DS);
OUTPUT(COUNT(DS));
DS2 := DEDUP(DS,vendor_source,prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,v_city_name,st,zip);
OUTPUT(COUNT(DS2));
----------------------------------------------------------------------------------------------------------

Localized averages data enhancement...
***********************************************************************************
Logic in the query or ESP:
				L.A. cannot be used if Source A (300) OR Source B (200) is available
        if either A or B is present, localized averaging CANNOT be used
				see 'DEFLT' and set that Confidence Factor = 900 
    Which records are touched?
        Only records that are OKCTY source
        It is available in all 50 states and DC
        Localized averaging falls under Source B in a property report
        Only if Land_use := ['' (empty), 'SFR','AGR','VNY','HSR','RNH','RVL','RES','RRR','RWH','COO','CLH','BGW','HST', 'PPT', 'PRS','ZLL',''];   (added '' EG: Blank)

    Which fields are touched?
        if any of the 17 below are blank, then fill them with some fake localized average.
        set the source = 'DEFLT'
    ONE THOUGHT - only do 10 per state?  no decided not
        It is easier to just push thru any records that qualify above and any fields that qualify above
***********************************************************************************
PRTE2_PropertyInfo.U_Localized_Averages_DOIT	-- BWR with lots of logic in it.
PRTE2_PropertyInfo.U_Localized_Averages_Sets	-- "random" sets of values.
PRTE2_PropertyInfo.U_Localized_Averages_Study_Prep	-- Preview data
PRTE2_PropertyInfo.U_Localized_Averages_Testing_BWR	-- Preliminary testing - finding that RANDOM() cannot be inside a TRANSFORM
PRTE2_PropertyInfo.U_Localized_Averages_Testing_BWR2 -- Preliminary testing - more RANDOM() experiments

PRTE2_PropertyInfo.Get_Payload -- NEED TO ALTER to add and use 
	noDEFLT(STRING s1) := IF(S1='DEFLT','OKCTY',S1);
				// as we create C records, replace any of the new Localized Average sources in B don't want them in C

*/