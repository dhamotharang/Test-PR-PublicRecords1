import ut, autokey, AutokeyB2, RoxieKeyBuild;

export Proc_Build_Proflic_Keys(string filedate) := function

	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(Prof_LicenseV2.Key_ProfLic_Id,
										   '~thor_data400::key::ProlicV2::@version@::Prolic_Id','~thor_data400::key::ProlicV2::'+filedate+'::Prolic_Id',
										   bld_prolic_id_key);
	
	File_Autokeys := Prof_LicenseV2.File_ProfLic_Autokeys;

	// holds logical base name for a autokeys.
	logicalname := Prof_LicenseV2.Constants.autokey_logical(filedate);

	// holds key base name for autokeys 
	keyname     := Prof_LicenseV2.Constants.autokey_keyname;

	Skip_set    := Prof_LicenseV2.Constants.Skip_Set;

	AutokeyB2.MAC_Build(File_Autokeys, name.fname, name.mname, name.lname,
						best_ssn,
						dob,
						zero,
						addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,				 
						did,
						//personal above.  business below
						cname,
						zero,
						Phone,
						addr.prim_name, addr.prim_range, addr.st, addr.p_city_name, addr.zip5, addr.sec_range,
						bdid,
						keyname,
						logicalname, bld_auto_keys, false, skip_set, true,,
						true,,,prolic_seq_id,true); 

	//end Txbus autokeys
	// Move Prolic Id to built
	RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::Prolicv2::@version@::Prolic_Id','~thor_data400::key::prolicv2::'+filedate+'::Prolic_Id',mv_seq);

	// Move Prolic Id to QA
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::Prolicv2::@version@::Prolic_Id', 'Q', mv_seq_key);
	
	// Move autokeys to QA
	// Business Keys
	RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::prolicv2::autokey::@version@::payload', 'Q', mv_autokey_payload);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::AddressB2','Q',mv_autokey_addrB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::NameB2','Q',mv_autokey_nameB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::StNameB2','Q',mv_autokey_stnamB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::CityStNameB2','Q',mv_autokey_cityB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::ZipB2','Q',mv_autokey_zipB2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::NameWords2','Q',mv_autokey_Namewords2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::PhoneB2','Q',mv_autokey_phoneB2);
	// Person keys
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::Name','Q',mv_autokey_name);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::Address','Q',mv_autokey_addr);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::StName','Q',mv_autokey_stnam);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::CityStName','Q',mv_autokey_city);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::Zip','Q',mv_autokey_zip);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::prolicv2::autokey::@version@::SSN2','Q',mv_autokey_Ssn2);



	Build_Prolic_Keys := sequential(parallel(bld_prolic_id_key, bld_auto_keys),
	                                 mv_seq,
									 parallel(mv_seq_key, mv_autokey_payload, mv_autokey_addrB2, mv_autokey_nameB2,
											   mv_autokey_stnamB2, mv_autokey_cityB2, mv_autokey_zipB2, mv_autokey_Namewords2,
											   mv_autokey_phoneB2, mv_autokey_name, mv_autokey_addr, mv_autokey_stnam,
											   mv_autokey_city, mv_autokey_zip, mv_autokey_Ssn2								
									 ));




	return Build_Prolic_Keys;														

end;