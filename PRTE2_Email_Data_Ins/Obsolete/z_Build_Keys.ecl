IMPORT Email_Data, Roxiekeybuild, Autokey, PRTE2_Email_Data_Ins;
// Roxie, 
Files := PRTE2_Email_Data_Ins.Files;

EXPORT Build_Keys (STRING filedate) := FUNCTION

		Key := PRTE2_Email_Data_Ins.Keys(filedate);
		
		// set up the file names we will need below
		string email_ampv_did_name := Files.bk_email_ampv_name('did');
		string email_ampv_addr_name := Files.bk_email_ampv_name('email_addresses');
		
		string filedateString := (string)filedate;
		string email_dated_did_name := Files.bk_email_dated_name(filedateString , 'did');
		string email_dated_addr_name := Files.bk_email_dated_name(filedateString , 'email_addresses');
		
		// build index files
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key.Key_Did, email_ampv_did_name, email_dated_did_name, email_did_key);
		RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Key.Key_Email_Address, email_ampv_addr_name, email_dated_addr_name, email_address_key);

		// Move keys to build
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2(email_ampv_did_name ,email_dated_did_name, mv_email_did_key);
		RoxieKeyBuild.Mac_SK_Move_to_Built_v2(email_ampv_addr_name, email_dated_addr_name, mv_email_address_key);

		// Move keys to QA
		
		RoxieKeyBuild.MAC_SK_Move_v2(email_ampv_did_name, 'Q', mv_email_did_key_qa);
		RoxieKeyBuild.MAC_SK_Move_v2(email_ampv_addr_name, 'Q', mv_email_address_key_qa);

		// Comment out the FCRA sections because CT should not need these
		build_keys_action := sequential(
														email_did_key,
														email_address_key,
														mv_email_did_key,
														mv_email_address_key,
														mv_email_did_key_qa,
														mv_email_address_key_qa
														);

		build_autokeys_action := build_autokeys((string) filedate);

		// Move autokeys to QA
		RoxieKeyBuild.MAC_SK_Move_v2(Files.bk_autokey_ampv_name('payload'), 'Q', mv_autokey_payload);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.bk_autokey_ampv_name('ssn2'),'Q',mv_autokey_ssn);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.bk_autokey_ampv_name('Name'),'Q',mv_autokey_name);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.bk_autokey_ampv_name('Address'),'Q',mv_autokey_addr);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.bk_autokey_ampv_name('StName'),'Q',mv_autokey_stnam);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.bk_autokey_ampv_name('CityStName'),'Q',mv_autokey_city);
		RoxieKeyBuild.Mac_SK_Move_V2(Files.bk_autokey_ampv_name('Zip'),'Q',mv_autokey_zip);

		createMainKeysAction := Create_SuperFiles(Files.bk_key_base_name).Do;
		createAutoKeysAction := Create_AutoKeys_SuperFiles(Files.bk_autokey_base_name).Do;

		return sequential(sequential(createMainKeysAction, createAutoKeysAction, 
																	build_autokeys_action,
																	mv_autokey_payload,
																	build_keys_action),
											parallel(mv_autokey_ssn,
															 mv_autokey_name,
															 mv_autokey_addr,
															 mv_autokey_stnam,
															 mv_autokey_city,
															 mv_autokey_zip) );

END;