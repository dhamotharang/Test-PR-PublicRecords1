// WIP
/* *********************************************************************************************
PRTE2_LNProperty_Ins.Files

If we keep our 1 base file - we'll have to 
   * save it as an initial INTERNAL base with 3 gen - that will be the spray/despray point
   * Post-spray process to transform out into 3 base files for Boca to use.
If we don't keep it and move to 3 - ????  any way to save our data?
********************************************************************************************* */

IMPORT LN_PropertyV2, PRTE2_Common;

EXPORT Files := MODULE

		EXPORT LNProperty_Base_SF_Deed		:= PRTE2_Common.Cross_Module_Files.LNProperty_Base_SF_Deed;
		EXPORT LNProperty_Base_SF_Tax			:= PRTE2_Common.Cross_Module_Files.LNProperty_Base_SF_Tax;
		EXPORT LNProperty_Base_SF_Search	:= PRTE2_Common.Cross_Module_Files.LNProperty_Base_SF_Search;

		EXPORT LNProperty_Deed_DS 				:= DATASET(LNProperty_Base_SF_Deed, Layouts.DeedLayout, THOR);
		EXPORT LNProperty_Tax_DS 					:= DATASET(LNProperty_Base_SF_Tax, Layouts.DeedLayout, THOR);
		EXPORT LNProperty_Search_DS 			:= DATASET(LNProperty_Base_SF_Search, Layouts.DeedLayout, THOR);

// For now duplicated in PRTE2_Common.Cross_Module_Files. - if Jeremy uses that DS definition then re-write the above to reference these.
// EXPORT LNProperty_Deed_DS 				:= PRTE2_Common.Cross_Module_Files.LNProperty_Deed_Ins_DS;
// EXPORT LNProperty_Tax_DS 				:= PRTE2_Common.Cross_Module_Files.LNProperty_Tax_Ins_DS;
// EXPORT LNProperty_Search_DS 			:= PRTE2_Common.Cross_Module_Files.LNProperty_Search_Ins_DS;


//Oct 2015 - at some point, we may want to make the base spreadsheet to be in the expanded layout (maybe plus address original fields)
	// Alpha_Audit_SF_DS + address1, orig_city, orig_st, orig_zip
	// NOTE: the following 3 fields already exist in expanded so I could use them: 
	//       property_full_street_address,	property_address_unit_number,	property_address_citystatezip

	EXPORT Add_Foreign_prod					:= PRTE2_Common.Constants.Add_Foreign_prod;	// a function
		
	EXPORT GATEWAY_NAME							:= 'gateway_LNP';
	EXPORT GATEWAY_SCRAMBLE					:= 'gateway_LNP_scramble';
	EXPORT SCRAMBLE_NAME						:= 'scrambled_LNP_v2';
	EXPORT ALP_BASE_NAME						:= 'alpha_base_V3';
	
	EXPORT Module_Name							:= 'ln_property';
	EXPORT IN_PREFIX_NAME						:= '~prct::IN::ct::ln_property';
	EXPORT BASE_PREFIX_NAME					:= '~prct::BASE::ct::ln_property';
	EXPORT SCRAMBLE_PREFIX_NAME			:= '~prct::SCRAMBLE::ct::ln_property';
	EXPORT SPRAYED_PREFIX_NAME    	:= '~prct::SPRAYED::ct::ln_property';
	// Someday move those above to use the common names ... (avoid DOPS mismatches)
	EXPORT KEY_PREFIX_NAME		    	:= '~prte::key::ln_propertyv2::';

	// Audit Files created during NEW_Proc_Build_LNPropertyV2_keys Processing
	EXPORT AlphaExpandedName 				:= '~prct::ct::ln_propertyv2::audit::Alpha_expanded';
	EXPORT AlphaDedupAuditFileName 	:= '~prct::ct::ln_propertyv2::audit::Alpha_Deduped';
	EXPORT finalAllExpandedName 		:= '~prct::ct::ln_propertyv2::audit::Final_ALL_expanded';


	// LCAIN300 - Old 300 test cases Linda did
	// EXPORT Linda_Pre_Scramble				:= 	'~thor40_241_7::prct_pii::in::custtest::lnproperty4';
	// EXPORT Linda_Pre_Scramble_DS		:= DATASET(Linda_Pre_Scramble, Layouts.batch_in,
	                                                 // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
																									 
	// EXPORT Linda_Scramble  					:= '~prte::in::ct::csv::scrambled::ln_propertyv2';
	// EXPORT Linda_Scramble_DS				:= DATASET(Linda_Scramble, Layouts.batch_in,
	                                                 // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// ---------- File Spraying names and references ------------------------------------------------
	EXPORT LNP_CSV_FILE							:= IN_PREFIX_NAME + '::CSV::' + ALP_BASE_NAME+'_'+ThorLib.Wuid();
	EXPORT FILE_SPRAY_NAME					:= SPRAYED_PREFIX_NAME + '::'+ALP_BASE_NAME+ '_' + ThorLib.Wuid();
	EXPORT ALP_SPRAY_DS							:= DATASET(FILE_SPRAY_NAME, Layouts_V2.LN_spreadsheet,
   	                                                 CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	// ---------- File Spraying names and references ------------------------------------------------

	// EXPORT LNP_Gateway_Base_SF			:= BASE_PREFIX_NAME + '::qa::' + GATEWAY_NAME;
	// EXPORT LNP_Gateway_Base_SF_DS		:= DATASET(LNP_Gateway_Base_SF, Layouts.batch_in, THOR);
	// EXPORT SCRAMBLE_SPRAY						:= SPRAYED_PREFIX_NAME + '::'+SCRAMBLE_NAME+ '_' + ThorLib.Wuid();
	// EXPORT SCRAMBLE_SPRAY_DS				:= DATASET(SCRAMBLE_SPRAY, Layouts.batch_in,
																									 // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
// These were used PRIOR to moving to the new layout and therefore are obsolete.  
// References exist in U* scripts which will not work now unless those are modified to work with the new layout.
	// EXPORT LNP_Scramble_SF					:= BASE_PREFIX_NAME + '::qa::' + ALP_BASE_NAME;
	// EXPORT LNP_Scramble_SF_DS				:= DATASET(LNP_Scramble_SF, Layouts.batch_in, THOR);
	// EXPORT LNP_Scramble_SF_Prod			:= Add_Foreign_prod(LNP_Scramble_SF);
	// EXPORT LNP_Scramble_SF_DS_Prod	:= DATASET(LNP_Scramble_SF, Layouts.batch_in, THOR);
	
	// This is the full Property Info base file for Alpharetta
	EXPORT ALP_LNP_SF_NAME					:= BASE_PREFIX_NAME + '::qa::' + ALP_BASE_NAME;
	EXPORT ALP_LNP_SF_DS						:= DATASET(ALP_LNP_SF_NAME, Layouts_V2.LN_spreadsheet, THOR);
	EXPORT ALP_LNP_SF_dad						:= BASE_PREFIX_NAME + '::father::' + ALP_BASE_NAME;
	EXPORT ALP_LNP_SF_DS_dad				:= DATASET(ALP_LNP_SF_dad, Layouts_V2.LN_spreadsheet, THOR);

	EXPORT Alpha_Audit_Name					:= AlphaExpandedName;
	EXPORT Alpha_Audit_SF_DS				:= DATASET(Alpha_Audit_Name, Layouts.layout_LNP_V2_expanded_payload, THOR);


	// New Boca Spray and Base files to contain Boca Data.
	EXPORT BOCA_BASE_SUFFIX					:= 'keys_Base_Boca';
	EXPORT BOCA_BASE_PERM_SUFFIX		:= 'PERM_SAVE::'+BOCA_BASE_SUFFIX;
	EXPORT BOCA_SPRAY_NAME					:= SPRAYED_PREFIX_NAME + '::'+BOCA_BASE_SUFFIX+ '_' + ThorLib.Wuid();
	EXPORT BOCA_SPRAY_DS						:= DATASET(BOCA_SPRAY_NAME, Layouts.layout_LNP_V2_expanded_payload,
																							CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	EXPORT BOCA_BASE_SF_NAME				:= BASE_PREFIX_NAME + '::qa::' + BOCA_BASE_PERM_SUFFIX;
	EXPORT BOCA_BASE_SF_DS					:= DATASET(BOCA_BASE_SF_NAME, Layouts.layout_LNP_V2_expanded_payload, THOR);

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT ALP_LNP_SF_NAME_Prod			:= Add_Foreign_prod(ALP_LNP_SF_NAME);
	EXPORT ALP_LNP_SF_DS_Prod				:= DATASET(ALP_LNP_SF_NAME_Prod, Layouts_V2.LN_spreadsheet, THOR);
	EXPORT BOCA_BASE_SF_NAME_PROD		:= Add_Foreign_prod(BOCA_BASE_SF_NAME);
	EXPORT BOCA_BASE_SF_DS_PROD			:= DATASET(BOCA_BASE_SF_NAME_PROD, Layouts.layout_LNP_V2_expanded_payload, THOR);
	EXPORT Alpha_Audit_Name_Prod		:= Add_Foreign_prod(Alpha_Audit_Name);
	EXPORT Alpha_Audit_SF_DS_Prod		:= DATASET(Alpha_Audit_Name_Prod, Layouts.layout_LNP_V2_expanded_payload, THOR);
	// SAMPLE TESTING DATA - Names A-O currently returns 184MB, D-H returns 88MB.
	EXPORT BOCA_PROD_SAMPLE_DATA := BOCA_BASE_SF_DS_PROD(lname[1]>'C' AND lname[1]<'I' AND person_addr.st IN ['TX','NY','NV','NJ','GA','FL','AZ']);

	// Reference just for research
	EXPORT CODES_V3_SF_NAME := Add_Foreign_prod('thor_data400::base::codes_v3');
	EXPORT CODES_V3_SF_DS		:= DATASET(CODES_V3_SF_NAME, Layouts.Codes_V3_Layout, FLAT);

	// following for use by the Keys attribute
	EXPORT iFileName(STRING postfix) := KEY_PREFIX_NAME + postfix;
	EXPORT fiFileName(STRING postfix) := KEY_PREFIX_NAME+'fcra::' + postfix;

	
END;
