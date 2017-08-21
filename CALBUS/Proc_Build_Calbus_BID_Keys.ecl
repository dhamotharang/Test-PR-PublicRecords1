import ut, doxie, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Calbus_BID_Keys(string filedate) := function


RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Calbus.Key_Calbus_Account_Nbr_Bid,
                       '~thor_data400::key::calbus::@version@::Bid::Account_Nbr','~thor_data400::key::calbus::'+filedate+'::Bid::Account_Nbr',
                       bld_acc_nbr_bid_key);

RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Calbus.Key_Calbus_BID,
                       '~thor_data400::key::calbus::@version@::bid','~thor_data400::key::calbus::'+filedate+'::bid',
                       bld_bid_key);


//start calbus autokeys
skip_set    := Calbus.Constants.skip_set;

//BID autokeys
//start calbus autokeys
File_bid_Autokeys := project(Calbus.File_Calbus_Autokeys, transform(Calbus.Layouts_Calbus.Layout_Autokeys, self.bdid := left.bid, self := left));

// holds logical base name for a autokeys.
bid_logicalname := Calbus.Constants.bid_autokey_logical(filedate);

// holds key base name for autokeys 
bid_keyname     := Calbus.Constants.bid_autokey_keyname;

AutokeyB2.MAC_Build(File_bid_Autokeys, OwnerCleanName.fname, OwnerCleanName.mname, OwnerCleanName.lname,
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
					bid_keyname,
					bid_logicalname, bld_bid_auto_keys, false, skip_set, true,,
					true,,,zero); 

//end Calbus autokeys 

// Move BDID key to build
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::calbus::@version@::Bid::Account_Nbr','~thor_data400::key::calbus::'+filedate+'::Bid::Account_Nbr',mv_acc_nbr_Bid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::calbus::@version@::bid','~thor_data400::key::calbus::'+filedate+'::bid',mv_bid);

// Move BDID key to QA
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::@version@::Bid::Account_Nbr', 'Q', mv_acc_nbr_bid_key);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::@version@::bid', 'Q', mv_bid_key);

// Move autokeys to QA

RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::calbus::autokey::@version@::bid::payload', 'Q', mv_fdids_key);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::AddressB2','Q',mv_autokey_addrB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::NameB2','Q',mv_autokey_nameB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::StNameB2','Q',mv_autokey_stnamB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::CityStNameB2','Q',mv_autokey_cityB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::ZipB2','Q',mv_autokey_zipB2);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::NameWords2','Q',mv_autokey_Namewords2);
// Person keys
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::Name','Q',mv_autokey_name);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::Address','Q',mv_autokey_addr);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::StName','Q',mv_autokey_stnam);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::CityStName','Q',mv_autokey_city);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::calbus::autokey::@version@::bid::Zip','Q',mv_autokey_zip);


Build_Calbus_BID_Keys := sequential(parallel(bld_acc_nbr_bid_key, bld_bid_key, bld_bid_auto_keys), 
                                  parallel(mv_acc_nbr_bid, mv_bid),
                                  parallel(mv_acc_nbr_bid_key, mv_bid_key, mv_fdids_key, mv_autokey_addrB2, 
								            mv_autokey_nameB2, mv_autokey_stnamB2, mv_autokey_cityB2, 
								            mv_autokey_zipB2, mv_autokey_Namewords2, mv_autokey_name, mv_autokey_addr,
								            mv_autokey_stnam, mv_autokey_city, mv_autokey_zip
								));


return Build_Calbus_BID_Keys;														

end;
