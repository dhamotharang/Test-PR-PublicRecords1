// PRTE2_Foreclosure.BWR_Build_Foreclosure - 
// -----------------------------------------------------------------------------------------------------------
//   Build the ForeclosureKeys files for Customer Test
// Moved over from PRTE2.BWR_NEW_proc_build_autokeys to create specialized PRTE2_Foreclosure module.
// Unlike the Alpharetta builds, we spray a base file with BWR_Spray_Scrambled_Foreclosures, then 
//   this build uses that base file and there is no "Add" concept, only full rebuilds.
//   by separating the spray and the build, anyone can just run this BWR to rebuild keys
// -----------------------------------------------------------------------------------------------------------

IMPORT PRTE2_Foreclosure, ut, PRTE2_Common;

#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT Foreclosures Build');

//* set filedate to current process date
string filedate := ut.GetDate+'';
// This is used by copyMissingKeys to copy keys from the DOPS version
string pIndexOldVersion := '20130530';			// Has to match DOPS version for ForeclosureKeys

// IF you are in PROD, should DOPS UpdateVersion happen?
DOPS_Indicator := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;				// Yes do DOPS update
// DOPS_Indicator := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;	// NO I will manually do DOPS update


Production_Steps_To_Do := PRTE2_Foreclosure.post_processing_actions(DOPS_Indicator,filedate,pIndexOldVersion);
//* ================================================================================================ *//

Sequential (
		PRTE2_Foreclosure.NEW_proc_build_autokeys(filedate).retval, 				// Trigger entire module to perform
		PRTE2_Foreclosure.Proc_build_foreclosure_keys(filedate).buildkeys,  // Trigger entire module to perform
		Production_Steps_To_Do
) :	SUCCESS(	PRTE2_Common.Email.sendSuccess('Foreclosures')	),
		FAILURE(	PRTE2_Common.Email.sendFail('Foreclosures')	);




