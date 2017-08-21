import Txbus, ut, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Txbus_Keys(string filedate) := function


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Txbus.Key_Txbus_Taxpayer_Nbr,
                       '~thor_data400::key::Txbus::@version@::Taxpayer_nbr','~thor_data400::key::Txbus::'+filedate+'::Taxpayer_nbr',
                       bld_taxnbr_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Txbus.Key_Txbus_BDID,
                       '~thor_data400::key::Txbus::@version@::bdid','~thor_data400::key::Txbus::'+filedate+'::bdid',
                       bld_bdid_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Txbus.Key_Txbus_DID,
                       '~thor_data400::key::Txbus::@version@::did','~thor_data400::key::Txbus::'+filedate+'::did',
                       bld_did_key);
											 
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(TXBUS.Key_Txbus_LinkIds.key,
                       '~thor_data400::key::Txbus::@version@::LinkIDs','~thor_data400::key::Txbus::'+filedate+'::LinkIDs',
                       bld_LinkIDs_key);											 

//start txbus autokeys

File_Autokeys :=TXBUS.File_Txbus_Autokeys;

// holds logical base name for a autokeys.
logicalname := Txbus.Constants.autokey_logical(filedate);

// holds key base name for autokeys 
keyname     := Txbus.Constants.autokey_keyname;

Skip_set    := Txbus.Constants.Skip_Set;

AutokeyB2.MAC_Build(File_Autokeys, taxpayerCleanName.fname, taxpayerCleanName.mname, taxpayerCleanName.lname,
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
					Name,
					zero,
					Phone,
					addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
					bdid,
					keyname,
					logicalname, bld_auto_keys, false, skip_set, true,,
					true,,,zero); 

//end Txbus autokeys 

// Move Taxpayer_nbr, BDID & DID & LinkIDs key to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::Taxpayer_nbr','~thor_data400::key::txbus::'+filedate+'::Taxpayer_nbr',mv_taxnbr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::bdid','~thor_data400::key::txbus::'+filedate+'::bdid',mv_bdid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::did','~thor_data400::key::txbus::'+filedate+'::did',mv_did);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::LinkIDs','~thor_data400::key::txbus::'+filedate+'::LinkIDs',mv_LinkIDs);

// Move Taxpayer_nbr, BDID & DID & LinkIDs key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::Taxpayer_nbr', 'Q', mv_taxnbr_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::bdid', 'Q', mv_bdid_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::did', 'Q', mv_did_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::LinkIDs', 'Q', mv_LinkIDs_key);


// Move autokeys to QA
// Business Keys
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::autokey::@version@::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::AddressB2','Q',mv_autokey_addrB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::NameB2','Q',mv_autokey_nameB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::StNameB2','Q',mv_autokey_stnamB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::CityStNameB2','Q',mv_autokey_cityB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::ZipB2','Q',mv_autokey_zipB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::NameWords2','Q',mv_autokey_Namewords2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::PhoneB2','Q',mv_autokey_phoneB2);
// Person keys
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::Zip','Q',mv_autokey_zip);



Build_Txbus_Keys := sequential(parallel(bld_taxnbr_key, bld_bdid_key, bld_did_key, bld_LinkIDs_key, bld_auto_keys), 
                               parallel(mv_taxnbr, mv_bdid, mv_did, mv_LinkIDs),
                               parallel(mv_taxnbr_key, mv_bdid_key, mv_did_key, mv_LinkIDs_key, mv_fdids_key, mv_autokey_addrB2, 
																				 mv_autokey_nameB2, mv_autokey_stnamB2, mv_autokey_cityB2, mv_autokey_zipB2, 
																				 mv_autokey_Namewords2, mv_autokey_phoneB2, mv_autokey_name, mv_autokey_addr,
																				 mv_autokey_stnam, mv_autokey_city, mv_autokey_zip)
															 );

return Build_Txbus_Keys;														

end;

