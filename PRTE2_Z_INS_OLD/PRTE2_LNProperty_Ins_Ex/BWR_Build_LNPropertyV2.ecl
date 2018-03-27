// PRTE2_LNProperty.BWR_Build_LNPropertyV2 -
// -----------------------------------------------------------------------------------------------------------
// THIS WILL BUILD THE LNPROPERTY DATA USING BOTH THE BOCA BASE FILE AND ALPHARETTA BASE FILE
// (After EData12 crashed Danny worked with Bruce and we used an audit PERSIST file which became Boca Base)
// -----------------------------------------------------------------------------------------------------------
// Alpharetta specific note:
// Unlike the Alpharetta builds, we spray a base file with BWR_Spray_Scrambled_LNP, then this build uses that
//  base file and there is no "Add" concept, only full rebuilds.
//  by separating the spray and the build, anyone can just run this BWR to rebuild keys
// -----------------------------------------------------------------------------------------------------------

IMPORT PRTE2_LNProperty, PRTE2_Common, ut;
#OPTION('multiplePersistInstances',FALSE);
#WORKUNIT ('name', 'PRCT LNProperty Build');

string filedate := ut.GetDate+'a';
// These are used by copyMissingKeys to copy keys from the DOPS version
string pIndexOldVersion := '20130422c';			// Has to match DOPS version for LNPropertyV2Keys
string pFCRAOldVersion  := '20130422c';			// Has to match DOPS version for FRCA_LNPropertyV2Keys

// IF you are in PROD, should DOPS UpdateVersion happen?
// DOPS_Indicator := PRTE2_Common.Constants.FULL_RUN_WITH_DOPS;				// Yes do CopyMissingKeys and DOPS
DOPS_Indicator := PRTE2_Common.Constants.TRIAL_RUN_ONLY_NO_DOPS;	// NO I will manually do DOPS updateVersion

Production_Steps_To_Do := PRTE2_LNProperty.post_processing_actions(DOPS_Indicator,filedate,pIndexOldVersion,pFCRAOldVersion);
 
 Sequential(
					PRTE2_LNProperty.NEW_Proc_Build_LNPropertyV2_keys(filedate)
					, Production_Steps_To_Do
					, OUTPUT ('NEW LNPROPERTY V2 KEYS BUILT')
					) :	SUCCESS(	PRTE2_Common.Email.sendSuccess('LNProperty')	),
							FAILURE(	PRTE2_Common.Email.sendFail('LNProperty')	); 
