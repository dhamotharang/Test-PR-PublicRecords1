import ut, doxie, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Calbus_Keys(string filedate) := function


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Calbus.Key_Calbus_Account_Nbr,
                       '~thor_data400::key::calbus::@version@::Account_Nbr','~thor_data400::key::calbus::'+filedate+'::Account_Nbr',
                       bld_acc_nbr_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Calbus.Key_Calbus_BDID,
                       '~thor_data400::key::calbus::@version@::bdid','~thor_data400::key::calbus::'+filedate+'::bdid',
                       bld_bdid_key);
/*					   
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Calbus.Key_Calbus_DID,
                       '~thor_data400::key::calbus::@version@::did','~thor_data400::key::calbus::'+filedate+'::did',
                       bld_did_key);
*/

//start txbus autokeys
File_Autokeys := Calbus.File_Calbus_Autokeys;

// holds logical base name for a autokeys.
logicalname := Calbus.Constants.autokey_logical(filedate);

// holds key base name for autokeys 
keyname     := Calbus.Constants.autokey_keyname;

skip_set    := Calbus.Constants.skip_set;

AutokeyB2.MAC_Build(File_Autokeys, OwnerCleanName.fname, OwnerCleanName.mname, OwnerCleanName.lname,
					zero,
					zero,
					zero,
					addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,				 
					did,
					//personal above.  business below
					Owner_Name,
					zero,
					zero,
					addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
					bdid,
					keyname,
					logicalname, bld_auto_keys, false, skip_set, true,,
					true,,,zero); 

//end Txbus autokeys 

// Move BDID key to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::calbus::@version@::Account_Nbr','~thor_data400::key::calbus::'+filedate+'::Account_Nbr',mv_acc_nbr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::calbus::@version@::bdid','~thor_data400::key::calbus::'+filedate+'::bdid',mv_bdid);
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::calbus::@version@::did','~thor_data400::key::calbus::'+filedate+'::did',mv_did);
// Move BDID key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::@version@::Account_Nbr', 'Q', mv_acc_nbr_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::@version@::bdid', 'Q', mv_bdid_key);
//RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::@version@::did', 'Q', mv_did_key);


// Move autokeys to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::AddressB2','Q',mv_autokey_addrB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::NameB2','Q',mv_autokey_nameB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::StNameB2','Q',mv_autokey_stnamB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::CityStNameB2','Q',mv_autokey_cityB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::ZipB2','Q',mv_autokey_zipB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::NameWords2','Q',mv_autokey_Namewords2);
// Person keys
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::Zip','Q',mv_autokey_zip);


Build_Calbus_Keys := sequential(parallel(bld_acc_nbr_key, bld_bdid_key, bld_auto_keys), 
                                  parallel(mv_acc_nbr, mv_bdid),
                                  parallel(mv_acc_nbr_key, mv_bdid_key, mv_fdids_key, mv_autokey_addrB2, 
								            mv_autokey_nameB2, mv_autokey_stnamB2, mv_autokey_cityB2, 
								            mv_autokey_zipB2, mv_autokey_Namewords2, mv_autokey_name, mv_autokey_addr,
								            mv_autokey_stnam, mv_autokey_city, mv_autokey_zip
								));


return Build_Calbus_Keys;														

end;
