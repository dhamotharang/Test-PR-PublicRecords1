import Txbus, ut, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Txbus_BID_Keys(string filedate) := function


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Txbus.Key_Txbus_Taxpayer_Nbr_BID,
                       '~thor_data400::key::Txbus::@version@::bid::Taxpayer_nbr','~thor_data400::key::Txbus::'+filedate+'::bid::Taxpayer_nbr',
                       bld_taxnbr_BID_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Txbus.Key_Txbus_BID,
                       '~thor_data400::key::Txbus::@version@::bid','~thor_data400::key::Txbus::'+filedate+'::bid',
                       bld_bid_key);

/*
RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Txbus.Key_Txbus_DID_BID,
                       '~thor_data400::key::Txbus::@version@::did_BID','~thor_data400::key::Txbus::'+filedate+'::did_BID',
                       bld_did_BID_key);
*/
//BID autokeys
//start txbus autokeys
File_BID_Autokeys := project(TXBUS.File_Txbus_Autokeys, transform(Txbus.Layouts_Txbus.Layout_Autokeys, self.bdid := left.bid, self := left));

// holds logical base name for a autokeys.
logicalname := Txbus.Constants.bid_autokey_logical(filedate);

// holds key base name for autokeys 
keyname     := Txbus.Constants.bid_autokey_keyname;

Skip_set    := Txbus.Constants.Skip_Set;

AutokeyB2.MAC_Build(File_BID_Autokeys, taxpayerCleanName.fname, taxpayerCleanName.mname, taxpayerCleanName.lname,
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
					logicalname, bld_auto_bid_keys, false, skip_set, true,,
					true,,,zero); 

//end Txbus autokeys 

// Move Taxpayer_nbr, BDID & DID key to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::bid::Taxpayer_nbr','~thor_data400::key::txbus::'+filedate+'::bid::Taxpayer_nbr',mv_taxnbr_BID);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::bid','~thor_data400::key::txbus::'+filedate+'::bid',mv_bid);
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::txbus::@version@::did_BID','~thor_data400::key::txbus::'+filedate+'::did_BID',mv_did_BID);


// Move Taxpayer_nbr, BDID & DID key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::bid::Taxpayer_nbr', 'Q', mv_taxnbr_bid_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::bid', 'Q', mv_bid_key);
//RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::@version@::did_BID', 'Q', mv_did_bid_key);


// Move autokeys to QA
// Business Keys
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::txbus::autokey::@version@::bid::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::AddressB2','Q',mv_autokey_addrB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::NameB2','Q',mv_autokey_nameB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::StNameB2','Q',mv_autokey_stnamB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::CityStNameB2','Q',mv_autokey_cityB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::ZipB2','Q',mv_autokey_zipB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::NameWords2','Q',mv_autokey_Namewords2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::PhoneB2','Q',mv_autokey_phoneB2);
// Person keys
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::txbus::autokey::@version@::bid::Zip','Q',mv_autokey_zip);



Build_Txbus_Keys := sequential(parallel(bld_taxnbr_bid_key, bld_bid_key, /*bld_did_bid_key,*/ bld_auto_bid_keys), 
                                parallel(mv_taxnbr_BID, mv_bid/*, mv_did_BID*/),
                                parallel(mv_taxnbr_bid_key, mv_bid_key, /*mv_did_bid_key,*/ mv_fdids_key, mv_autokey_addrB2, 
										  mv_autokey_nameB2, mv_autokey_stnamB2, mv_autokey_cityB2, mv_autokey_zipB2, 
								          mv_autokey_Namewords2, mv_autokey_phoneB2, mv_autokey_name, mv_autokey_addr,
								          mv_autokey_stnam, mv_autokey_city, mv_autokey_zip								
								));


return Build_Txbus_Keys;														

end;
