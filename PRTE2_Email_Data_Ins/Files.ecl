/* ************************************************************************************************
PRTE2_Email_Data_Ins.Files
Nov 2017 - re-write to new LZ and base layouts
************************************************************************************************ */
IMPORT PRTE2_Common, PRTE2_Email_Data_ins;


EXPORT Files := MODULE
	EXPORT Add_Foreign_prod				:= PRTE2_Common.Constants.Add_Foreign_prod;		// a function
	
	EXPORT EMAIL_ALP_BASE_NAME	:= 'alpha_spreadsheet_base';
	EXPORT EMAIL_BASE_NAME				:= 'alpha_base';
	EXPORT qaVersion              := '::qa::';
	
	SHARED ModuleName							:= 'email_data_V2';
	SHARED KeySuffix							:= 'email_data';
	EXPORT BASE_PREFIX_NAME				:= '~prct::BASE::ct::'+ModuleName;
	EXPORT SPRAYED_PREFIX_NAME    := '~prct::SPRAYED::ct::'+ModuleName;
	EXPORT DSpray_PREFIX_NAME					:= '~prct::dSpray::ct::'+ModuleName;
	EXPORT KEY_PREFIX 						:= '~prte::key::'+KeySuffix;
// 'prct::BASE::ct::email_data'
	//-------------------------------------------------------------------------------------------------
	EXPORT FILE_SPRAY							:= SPRAYED_PREFIX_NAME + '::'+ EMAIL_ALP_BASE_NAME+ '::' +  ThorLib.Wuid();
	EXPORT SPRAYED_DS							:= DATASET(FILE_SPRAY, PRTE2_Email_Data_Ins.Layouts.Spreadsheet_base, 
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"'), MAXLENGTH(PRTE2_Email_Data_Ins.Constants.CSVMaxCount)));	

	//-------------------------------------------------------------------------------------------------
	EXPORT emailData_Base_SF			:= BASE_PREFIX_NAME + qaVersion + EMAIL_ALP_BASE_NAME;	
	EXPORT Email_Base_DS     			:= DATASET ( emailData_Base_SF, Layouts.Spreadsheet_base, THOR);

	// Production file used for desprays
	EXPORT email_Base_SF_PROD			:= Add_Foreign_prod(emailData_Base_SF);	
	EXPORT Email_Base_DS_PROD			:= DATASET ( email_Base_SF_PROD, Layouts.Spreadsheet_base, THOR);

	EXPORT email_Compat_SF					:= BASE_PREFIX_NAME + qaVersion + EMAIL_BASE_NAME;	
	EXPORT Email_Compat_DS					:= DATASET ( email_Compat_SF, Layouts.Boca_Compatible, THOR);

	// Production file used for desprays
	EXPORT email_Compat_SF_PROD	:= Add_Foreign_prod(email_Compat_SF);	
	EXPORT Email_Compat_DS_PROD	:= DATASET ( email_Compat_SF_PROD, Layouts.Boca_Compatible, THOR);

	//-------------------------------------------------------------------------------------------------
	EXPORT FILE_DESPRAY_CSV				:= DSpray_PREFIX_NAME + '::' + EMAIL_ALP_BASE_NAME;

	// --------- TEMPORARY BASE2: Save the original Alpha12 which have Alpha LexIDs ----------------------------
	// we need to append these at the last minute after joining spreadsheet with BHDR, but before building keys.
	// (these 12 have Alpharetta DIDs so JOIN to BHDR will fail and fields would be make empty)
	string ALPHA_12_FName := Add_Foreign_prod('prte::ct::base::email_data_Alpha12_SAVE');
	EXPORT Alpha_12_DS_PROD := DATASET ( ALPHA_12_FName, Layouts.Spreadsheet_base, thor);
	// Builds were hitting missing parts warnings so I created a backup on PROD thor.
	string ALPHA_12_FNameBackup := Add_Foreign_prod('prte::ct::base::email_data::Alpha12_SAVE');
	EXPORT Alpha_12_DS_PROD_Bkup := DATASET ( ALPHA_12_FNameBackup, Layouts.Spreadsheet_base, thor);
	// ---------------------------------------------------------------------------------------------------------
	// Above is not a SF, should not need maintenance, should go away after we fix LexID problems
	//  ************** ALSO, we MUST copy this to the new dataland once copy between dali's is working.
	// ---------------------------------------------------------------------------------------------------------

  EXPORT FINAL_DS := Email_Base_DS + Alpha_12_DS_PROD;
	// ---- END: TEMPORARY BASE2: Save the original Alpha12 which have Alpha LexIDs ----------------------------

	// Autokeys data buildable
	EXPORT email_ds      := FINAL_DS(append_is_valid_domain_ext AND current_rec);
	EXPORT File_AutoKey   := PROJECT(email_ds,PRTE2_Email_Data_Ins.Layouts.Autokey_layout);

	//-------------------------------------------------------------------------------------------------
	// Keys
	// key names found in attribute:   _keys
	EXPORT string bk_key_base_name := Key_Prefix +'::';	
  EXPORT string bk_email_dated_name(string filedate, string postf) := KEY_PREFIX+'::'+(string)filedate+'::'+postf;

	//-------------------------------------------------------------------------------------------------
	// autokey names found in attribute:   _keys
	EXPORT string keyPayloadName := Key_Prefix +'::autokey::qa::payload';	


	//-------------------------------------------------------------------------------------------------
	//--- for Build_keys attribute
	// @version@ handled by RoxieKeyBuild.Check_Replace_Version
	EXPORT string bk_email_ampv_name(string postf) := Key_Prefix+'::@version@::'+postf;
	EXPORT string bk_autokey_base_name := Key_Prefix+'::autokey::';
	EXPORT string bk_autokey_ampv_name(string postf) := bk_autokey_base_name+'@version@::'+postf;  

	
	//-------------------------------------------------------------------------------------------------
	// autokey names found in attribute:
	EXPORT ak_skipSet := ['P','B'];
	EXPORT string ak_typeStr	:= 'BC';
	
	//-------------------------------------------------------------------------------------------------
	EXPORT string ak_keyname := Key_Prefix +'::autokey::@version@::';				// _functions.Build_Autokey
	EXPORT string autokeyFileVerString(STRING filedate) := bk_email_dated_name(filedate,'autokey::');	// 2nd parameter MediaOne.proc_build_autokey sends to AutoKeyB2.MAC_Build


END;

