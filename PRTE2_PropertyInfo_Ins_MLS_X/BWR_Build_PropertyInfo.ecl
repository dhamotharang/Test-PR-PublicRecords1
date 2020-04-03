/* **********************************************************************************************
This requires the new spray process using BWR_Spray_Alpharetta_Base before running the build
**********************************************************************************************
***** MLS CONVERSION NOTES:
Test in Dev W20200225-134552, new base layout, new all 6 record sources.
**********************************************************************************************
OLDER NOTES:
	PRTE2_PropertyInfo_Ins_MLS_X.BWR_Build_PropertyInfo -
	-----------------------------------------------------------------------------------------------------------
	Generate PRCT-PII files, RID and ADDRESS using old data plus new customer test data.
	Unlike the Alpharetta builds, we spray a base file with BWR_Spray_Scrambled_PII, then this build uses that
	 base file 
	 by separating the spray and the build, anyone can just run this BWR to rebuild keys
-----------------------------------------------------------------------------------------------------------
NEW! for use by the MapView builds Charles has the following two lines in MapViewExtracts files
PropCharacter_Extract_DS 	:= DATASET(data_services.foreign_prod_boca + 'thor_data400::base::propertyinfo',MapViewExtracts.Layouts.Base,thor);
dYearBuiltFile	:= MapviewExtracts.Files.PropCharacter_Extract_DS(vendor_source = 'A' and latitude <> '' and longitude <> ''); 

This Mapview base file needed - will now be kept up to date during the key build
********************************************************************************************** */

IMPORT PRTE2_PropertyInfo_Ins_MLS_X as PII;
IMPORT PRTE, PRTE_CSV, PRTE2_Common, PRTE2, ut,_control, lib_fileservices;

#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT PropertyInfo Build');

string filedate := PRTE2_Common.Constants.TodayString+'';			// DATE PLUS LETTER IF NEEDED

Production_Steps_To_Do := PII.After_Build_Actions.post_processing_actions(filedate);

SEQUENTIAL(		PII.proc_build_propertyinfo(filedate),
					Production_Steps_To_Do,
					OUTPUT ('NEW Customer Test PropertyInfo KEYS BUILT')
						) :	SUCCESS(	PRTE2_Common.Email.sendSuccess('PropertyInfo')	),
								FAILURE(	PRTE2_Common.Email.sendFail('PropertyInfo')	);
