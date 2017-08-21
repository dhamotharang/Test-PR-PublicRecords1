IMPORT PRTE2, ut, doxie;

//TODO - I'm guessing at some of the file names and paths here ...
// Guesses include: LandingZone_File_Dir_AllData & NewData, fileSprayedPrefix, phase1PersistFileString
//  AND lzFilePathNewData
//TODO do I have the strings right with doxie.Version_SuperKey and '::@version@::'
//TODO Is this right?  in web page, I see inconsistency in autokey names if qa, then autokey::qa, but if version then @version@::autokey

EXPORT _constants := MODULE

		EXPORT String BAP_TESTING_EMAIL := 'bruce.petro@lexisnexis.com; brucepetro@gmail.com';

		// SHARED string clusterPrefix := '~thor_200::';			
		// Currently I think we will avoid the clusterPrefix to keep built PRTE file names unique from real data.
		
		SHARED string PRTEPrefix := '~prte::';
		SHARED string baseEmailSuffix := 'email_data';
		SHARED string CSV_Suffix	:= 'CSV';

		//---------------------------------------------------------------------------------------------------
		//-- Initial Builds File Names ----------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------
		// For _BWR_1_BuildMaster and _BWR_2_Despray_Base
		//NOTE: for Landing Zone file locations, use the / notations
		//In Boca they are uploading the files to Linda's dir, with a subdir they name.
		EXPORT string EDATA11 := PRTE2.Constants.EDATA11;
		EXPORT string LZ_Path_LindaCain:= '/load01/linda_cain/';		
		//---------------------------------------------------------------------------------------------------
		
		
		//---------------------------------------------------------------------------------------------------
		// *** P1 (old MEDIAONE) Process Files 
		//     - these need to begin with a CSV in the landing zone, build up a phase1 output file
		// Used in Fn_Spray, p1_file_sprayed, p1_file_output, Map_P1_As_Email
		SHARED Sprayed_Suffix			:= 'sprayed';
		SHARED string fileSprayedPrefix := PRTEPrefix+'in::ct::'+baseEmailSuffix;
		EXPORT string fileSprayedString := fileSprayedPrefix + '::' + Sprayed_Suffix + '::' + WORKUNIT;	//What MediaOne calls file_mediaone (infile of proc_build_base)
		EXPORT string phase1PersistFileString := PRTEPrefix+'ct::base::email_source_phase1::' + WORKUNIT;	//What MediaOne calls file_base	(output of proc_build_base) //~thor::base::mediaone
		//---------------------------------------------------------------------------------------------------
		//TODO ????  why does this specify with thor_data400 instead of thor_200 ?????
		//TODO I'm thinking that the base file built goes on thor_data400 while the keys built go on thor_200 ?  CHECKITOUT
		//---------------------------------------------------------------------------------------------------
		// Used in _files, and Fn_Spray
		SHARED string baseSuperFilePrefix := PRTEPrefix+'ct::base::' ;
		// SHARED string baseSuperFilePrefix := '~thor_400::prte::ct::base::' ;
		// Above experimenting with names, hitting an error...
		EXPORT string baseSuperFileString := baseSuperFilePrefix+baseEmailSuffix ; 		// Build_Master - final output super file
		// Not sure we need this but this is what the MAC_SF_BuildProcess calls the base file
		EXPORT string baseFileString(string wUnit) := baseSuperFileString+'_'+wUnit;	// Name of the logical file under that SF
		//---------------------------------------------------------------------------------------------------

		//---------------------------------------------------------------------------------------------------
		// For _BWR_2_Despray_Base		
		SHARED string AllData_Suffix	:= 'alldata.csv';
		EXPORT string Email_Base_CSV := fileSprayedPrefix + '::' + CSV_Suffix + '::' + AllData_Suffix+ '::' + WORKUNIT;
		//---------------------------------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------------------------------
		//-- Secondary Builds File Names --------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------
		SHARED string baseEmailKeyName := 'key::'+baseEmailSuffix;
		// SHARED string clusteredKeyName := clusterPrefix	+	baseEmailKeyName;		// I think we need to replace the prefix
		SHARED string clusteredKeyName := PRTEPrefix	+	baseEmailKeyName;					// to keep the key names from conflicting


		// key names found in attribute:   _keys
		EXPORT string bk_key_base_name := clusteredKeyName+'::';
		EXPORT string bk_email_dated_name(string filedate, string postf) := clusteredKeyName+'::'+(string)filedate+'::'+postf;

		// autokey names found in attribute:   _keys
		EXPORT string keyPayloadName := clusteredKeyName+'::autokey::qa::payload';									// _keys.Key_Payload

		//--- for Build_keys attribute
		// @version@ handled by RoxieKeyBuild.Check_Replace_Version
		EXPORT string bk_email_ampv_name(string postf) := clusteredKeyName+'::@version@::'+postf;
		EXPORT string bk_autokey_base_name := clusteredKeyName+'::autokey::';
		EXPORT string bk_autokey_ampv_name(string postf) := bk_autokey_base_name+'@version@::'+postf;

		// autokey names found in attribute:   _functions
		EXPORT ak_skipSet := ['P','B'];
		EXPORT string ak_typeStr	:= 'BC';
		// EXPORT string ak_keyname := clusterPrefix	+	'key::'+baseEmailSuffix+'::autokey::@version@::';				// _functions.Build_Autokey
		EXPORT string ak_keyname := PRTEPrefix	+	'key::'+baseEmailSuffix+'::autokey::@version@::';				// _functions.Build_Autokey
		EXPORT string autokeyFileVerString(STRING filedate) := bk_email_dated_name(filedate,'autokey::');	// 2nd parameter MediaOne.proc_build_autokey sends to AutoKeyB2.MAC_Build



		//TODO ********************** PROBABLE OBSOLETE STUFF FOUND ONLY IN z_attributes ****************************
		EXPORT string hhidPersistFileName := '~persist::'+baseEmailSuffix+'::before_rollup';	//z_Build_Base_ORIG_TMP
		EXPORT string autokeyFileString := clusteredKeyName+'::PRTE::autokey::';						// z_p1_build_autokey_ORIG
		//TODO END ****************** PROBABLE OBSOLETE STUFF FOUND ONLY IN z_attributes ****************************

		//---------------------------------------------------------------------------------------------------
		// EXPORT string foreign_key_name_did := ut.foreign_prod+'thor_200::'+baseEmailKeyName+'::'+doxie.Version_SuperKey+'::did';
		// EXPORT string foreign_key_name_addr := ut.foreign_prod+'thor_200::'+baseEmailKeyName+'::'+doxie.Version_SuperKey+'::email_addresses';
		//---------------------------------------------------------------------------------------------------
		
		//---------------------------------------------------------------------------------------------------
		// But if removing baseFCRASuperFileName, pull the reference from _files as well.
		// EXPORT string baseFCRASuperFileName := baseSuperFilePrefix+baseEmailSuffix+'_fcra';	// z__BWR_FN_Build_Email_ORIG_TMP - fcra output file
		// But if removing foreign_key_name_fcra, pull the reference from _keys as well.
		// EXPORT string foreign_key_name_fcra := ut.foreign_prod+'thor_200::'+baseEmailKeyName+'::fcra::'+doxie.Version_SuperKey+'::did';
		//---------------------------------------------------------------------------------------------------

END;
