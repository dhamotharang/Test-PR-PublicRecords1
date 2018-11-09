// PRTE2_PropertyInfo.BWR_Build_PropertyInfo -
// -----------------------------------------------------------------------------------------------------------
// Generate PRCT-PII files, RID and ADDRESS using old data plus new customer test data.
// Unlike the Alpharetta builds, we spray a base file with BWR_Spray_Scrambled_PII, then this build uses that
//  base file and there is no "Add" concept, only full rebuilds.
//  by separating the spray and the build, anyone can just run this BWR to rebuild keys
// -----------------------------------------------------------------------------------------------------------
IMPORT PRTE2_PropertyInfo as PII;
IMPORT PRTE, PRTE_CSV, PRTE2_Common, PRTE2, ut,_control, lib_fileservices;

#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT PropertyInfo Build');

string filedate := ut.GetDate+''; 

// IF you are in PROD, should DOPS UpdateVersion (if required) happen?
// DOPS_Indicator := PII.Constants.TRIAL_RUN_ONLY_NO_DOPS;	// NO I will manually do DOPS	updateVersion
DOPS_Indicator := PII.Constants.FULL_RUN_WITH_DOPS;					// Yes do DOPS updateVersion

Production_Steps_To_Do := PII.After_Build_Actions.post_processing_actions(DOPS_Indicator,filedate);

SEQUENTIAL(
					PII.New_process_build_propertyinfo(filedate),
					Production_Steps_To_Do,
					OUTPUT ('NEW Customer Test PropertyInfo KEYS BUILT')
						) :	SUCCESS(	PRTE2_Common.Email.sendSuccess('PropertyInfo')	),
								FAILURE(	PRTE2_Common.Email.sendFail('PropertyInfo')	);
