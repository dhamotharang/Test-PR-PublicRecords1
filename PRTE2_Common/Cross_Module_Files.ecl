 IMPORT prte2, PRTE, PRTE2_Common, LN_PropertyV2;
 // NOTE: Do not import various builds such as PRTE2_Email_Data or PRTE2_Email_Data_Ins because they use this.
 // if we ever add an import here to reference them then their reference of details here would break.

EXPORT Cross_Module_Files := MODULE

 	// **** In DEV, you may need to use foreign references if the file doesn't exist in DEV.  
	// Looks like Linda only sprayed this file in production not dev.
	EXPORT MASTER_BASE_PREFIX				:= '~prct::BASE::ct';
	EXPORT MASTER_ALPBASE_PREFIX		:= '~prct::BASE::ct_alp';
	EXPORT MASTER_AUDIT_PREFIX			:= '~prct::BASE_Audit::ct';
	EXPORT MASTER_IN_PREFIX					:= '~prct::IN::ct';
	EXPORT MASTER_TMP_PREFIX				:= '~prct::TMP::ct';
	EXPORT MASTER_SPRAY_PREFIX 		  := '~prct::SPRAYED::ct';
	EXPORT MASTER_KEY_PREFIX 				:= '~prte::key';

	SHARED Alpha_Prefix							:= '::alpharetta';
	SHARED Base_Prefix2							:= '~prct::BASE::custtest';
	SHARED Header_Base_Prefix				:= MASTER_BASE_PREFIX+Alpha_Prefix;
	SHARED Header_Base_Name					:= 'PeopleHeader_Base';
	SHARED Header_Rel_Name					:= 'PeopleHeader_Base_Relatives';
	EXPORT AlphaDIDsHeaderBaseName 	:= Header_Base_Prefix+'::qa::'+Header_Base_Name; 			// needed for prte_csv
	EXPORT AlphaFinalHeaderBaseName := Header_Base_Prefix+'::qa::'+Header_Rel_Name;				// needed for prte_csv
	// These two DS above are always referenced via the PRTE_CSV.ge_header_base.AlphaFinalHeaderDS --- May become obsolete??
	
// ***************** OLD historical files. data - search - ALL OF THESE may be obsolete. **********************************
// We are giving up foreclosure data - was not being used.  - search - this may be obsolete.
	SHARED BradsLocalFCName 				:= Base_Prefix2+'::foreclosures::qa::FRCL_scrambled';
// OLD LNProperty data - search - this may be obsolete.
	SHARED Brads50kLNPLocalName 		:= MASTER_BASE_PREFIX+'::ln_property::qa::scrambled_lnp_v2';

// ************ OLD historical files. data - search - I think PRTE_CSV.ge_header_base is still being used, need to remove
			SHARED LindasLocalFCName 				:= '~thor_data400::prct_pii::in::custtest::foreclosure4';
			SHARED LindasForeignFCName 			:= PRTE2_Common.Constants.foreign_prod + LindasLocalFCName;
			SHARED LindasFinalFCName 				:= IF(Constants.Running_in_production,LindasLocalFCName,LindasForeignFCName);
			SHARED Lindas300LNPLocal				:= '~prte::in::ct::csv::scrambled::ln_propertyv2';
   	// Linda 2012
			EXPORT Lindas300Foreclosure_file_on_lz := DATASET(LindasForeignFCName, prte2.layouts.foreclosure_batch_in,
   																							CSV(HEADING(1),QUOTE('"'),MAXLENGTH(32768)));
   	// Bruce 12/12/2013
			EXPORT Brads50kForeclosure_file_on_lz := DATASET(BradsLocalFCName, prte2.layouts.foreclosure_batch_in,THOR);
			EXPORT Lindas300LNP_DS_on_lz		:= DATASET(Lindas300LNPLocal,  prte2.layouts.batch_in_LNProperty,
   																			CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
			EXPORT Brads50kLNP_DS_on_lz := DATASET(Brads50kLNPLocalName, prte2.layouts.batch_in_LNProperty, THOR);
// END: ************ OLD historical files. data - search - ALL OF THESE may be obsolete. **********************************


	
	// -----------------------------------------------------------------------------------------
	// Many of these new modules we are using layouts from PRTE_CSV OR from new Boca Builds
	//    previously we had to have the file name in both the home module (EG: PRTE2_Phonesplus_Ins) and also in the PRTE_CSV
	// -----------------------------------------------------------------------------------------
	// NEW - Fall of 2016, we are begining to move Alpha official file naming into here which can
	//       be used by both our home folder AND by the new Boca PRTE2 build that is being created

	// ------------------------------ Phones Plus ----------------------------------------------
	EXPORT PhonesPlus_Suffix_Name			:= 'all_data';
	EXPORT PhonesPlus_MODULE_SUFFIX		:= '::phonesplus_Alpha';	// DF-20535 restored version of Boca code
	// EXPORT PhonesPlus_MODULE_SUFFIX		:= '::phonesplus';			// to use the reference here for the name.
	EXPORT PhonesPlus_Full_Prefix			:= MASTER_BASE_PREFIX + PhonesPlus_MODULE_SUFFIX;
	EXPORT PhonesPlus_Base_SF_Name		:= PhonesPlus_Full_Prefix + '::qa::' + PhonesPlus_Suffix_Name;
	// ------------------------------ Phones Plus ----------------------------------------------
	
	// ------------------------------ Liens V2 ----------------------------------------------
	EXPORT LiensV2_Suffix_Main			:= '_main';
	EXPORT LiensV2_Suffix_Party		:= '_party';
	EXPORT LiensV2_Suffix_Status		:= '::status';
	EXPORT LiensV2_MODULE_SUFFIX		:= '::LiensV2_Alpha';
	EXPORT LiensV2_Full_Prefix			:= MASTER_BASE_PREFIX + LiensV2_MODULE_SUFFIX;
	// using their new PromoteSupers macro - so no QA involved in the base file name.
	EXPORT LiensV2_Base_SF_Main		:= LiensV2_Full_Prefix +  LiensV2_Suffix_Main;
	EXPORT LiensV2_Base_SF_Party		:= LiensV2_Full_Prefix +  LiensV2_Suffix_Party;
	// ------------------------------ Liens V2 ----------------------------------------------


	// ------------------------------ LNProperty V2 -----------------------------------------
	// NOTE: Terri perfers to simply reference our code to read our base file and they will
	// do the transform on their side.  So no cross module file naming is required.
	EXPORT LNProperty_MODULE_SUFFIX		:= '::LNPropertyV2_Alpha';
	// ------------------------------ LNProperty V2 -----------------------------------------

/*		see also
	PRTE_Header_Files.LNPForeclosureDIDPersistHeaderDataName;
	PRTE_Header_Files.LNPForeclosureDIDPersistedHeaderData;
*/

END;