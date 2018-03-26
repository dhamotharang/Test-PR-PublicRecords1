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
	EXPORT Add_Foreign_prod					:= PRTE2_Common.Constants.Add_Foreign_prod;	// a function
	EXPORT ALP_BASE_NAME						:= 'alpha_base';
	EXPORT LNProperty_MODULE_SUFFIX	:= PRTE2_Common.Cross_Module_Files.LNProperty_MODULE_SUFFIX; // '::LNPropertyV2_Alpha';
	EXPORT Module_Name							:= 'LNProperty';
	EXPORT SPRAY_PREFIX_NAME    		:= '~prct::SPRAY::LNProperty';
	EXPORT IN_PREFIX_NAME						:= '~prct::IN'+LNProperty_MODULE_SUFFIX+'::';					// CSV Sprayed Thor file
	EXPORT BASE_PREFIX_NAME					:= '~prct::BASE'+LNProperty_MODULE_SUFFIX+'::';				// Processed Spray file to final Base

	// ---------- File Spraying names and references ------------------------------------------------
	EXPORT FILE_SPRAY_NAME					:= SPRAY_PREFIX_NAME + '::CSV::'+ALP_BASE_NAME+ '_' + ThorLib.Wuid();
	EXPORT ALP_SPRAY_DS							:= DATASET(FILE_SPRAY_NAME, Layouts_V2.LN_spreadsheet,
   	                                                 CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	
	// ---------- File Spraying names and references ------------------------------------------------

//Oct 2015 - at some point, we may want to make the base spreadsheet to be in the expanded layout (maybe plus address original fields)
	// Alpha_Audit_SF_DS + address1, orig_city, orig_st, orig_zip
	// NOTE: the following 3 fields already exist in expanded so I could use them: 
	//       property_full_street_address,	property_address_unit_number,	property_address_citystatezip
		
	//---------------- We then need one base file to Spray/Despray our CSV -------------------
	EXPORT ALP_IN_SF_NAME					:= IN_PREFIX_NAME + ALP_BASE_NAME;
	EXPORT ALP_IN_SF_DS						:= DATASET(ALP_IN_SF_NAME, Layouts_V2.LN_spreadsheet, THOR);

	//---------------- We then need one base file for final base to hand the build -------------------
	// 							New_Base_Name		:= '~prct::BASE::LNPropertyV2_Alpha::alpha_base';
	EXPORT ALP_LNP_SF_NAME					:= BASE_PREFIX_NAME + ALP_BASE_NAME;
	EXPORT ALP_LNP_SF_DS						:= DATASET(ALP_LNP_SF_NAME, Layouts_V2.layout_LNP_V2_expanded_payload, THOR);
	// PRTE2_LNProperty.Files reads our base via the above PRTE2_LNProperty_Ins.Files.ALP_LNP_SF_DS
	// which means we cannot change our layout here w/o possibly messing them up, also means we cannot reference their folder.

	// Prod version of the files are just for easy CustTest desprays from DEV (without having to login to prod)
	EXPORT ALP_LNP_SF_NAME_Prod			:= Add_Foreign_prod(ALP_LNP_SF_NAME);
	EXPORT ALP_LNP_SF_DS_Prod				:= DATASET(ALP_LNP_SF_NAME_Prod, Layouts_V2.layout_LNP_V2_expanded_payload, THOR);

	// Reference just for research
	EXPORT CODES_V3_SF_NAME := Add_Foreign_prod('thor_data400::base::codes_v3');
	EXPORT CODES_V3_SF_DS		:= DATASET(CODES_V3_SF_NAME, Layouts_V2.Codes_V3_Layout, FLAT);

END;
