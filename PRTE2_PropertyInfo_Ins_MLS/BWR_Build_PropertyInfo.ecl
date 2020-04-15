/* **********************************************************************************************
WARNING: This does not do a spray - it builds keys with whatever base exists...
This requires the new spray process using BWR_Spray_Alpharetta_Base before running the build
**********************************************************************************************
***** MLS CONVERSION NOTES:
Test in Dev W20200225-134552, new base layout, new all 6 record sources.
**********************************************************************************************
	Generates RID and ADDRESS keys using new customer test data base file with 6 record sources.
	 by separating the spray and the build, anyone can just run this BWR to rebuild keys
-----------------------------------------------------------------------------------------------------------
********************************************************************************************** 
For use by the MapView builds Charles has the lines in MapViewExtracts files to foreign_prod_boca read a base file we create here.
**** This Mapview base file needed - will now be kept up to date during the key build ****
********************************************************************************************** */

IMPORT PRTE2_PropertyInfo_Ins_MLS as PII;
IMPORT PRTE, PRTE_CSV, PRTE2_Common, PRTE2, ut,_control, lib_fileservices;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT PropertyInfo Key Build');
// #CONSTANT('SubstituteEmail','Bruce.Petro@lexisnexisrisk.com');		// useful for early testing to not spam everyone

string filedate := PRTE2_Common.Constants.TodayString+'';			// DATE PLUS LETTER IF NEEDED, needed for Keys, not for base files.

// Check with Terri - she probably will add some Orbit steps too
// Production_Steps_To_Do := PII.After_Build_Actions.post_processing_actions(filedate);
Production_Steps_To_Do := OUTPUT('Bypassing DOPS requests');

SEQUENTIAL(		PII.proc_build_propertyinfo(filedate),
					Production_Steps_To_Do,
					OUTPUT ('NEW Customer Test PropertyInfo KEYS BUILT')
						) :	SUCCESS(	PRTE2_Common.Email.sendSuccess('PropertyInfo')	),
								FAILURE(	PRTE2_Common.Email.sendFail('PropertyInfo')	);
