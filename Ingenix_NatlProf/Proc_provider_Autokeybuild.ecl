import Ingenix_NatlProf, AutoKeyB2, RoxieKeyBuild; 

export Proc_provider_Autokeybuild(string filedate) := function

	pre_base_prov := Ingenix_NatlProf.file_SearchAutokey_provider;
	base_prov := dedup(sort(pre_base_prov, providerid, addressid, birthdate, phonenumber, filetyp, skew(0.5,0.5)), record):persist('~thor_data400::persist::ingenix::provider_autokey_dedup');

	skip_set  := Ingenix_NatlProf.Constants.autokey_skip_set_prov;

	type_str  := Ingenix_NatlProf.Constants.autokey_typeStr_prov;

	// holds logical base name for a autokeys.
	logicalName := Ingenix_NatlProf.Constants.provider_AutokeyLogicalName(filedate);

	// holds key base name for autokeys
	autokeyName := Ingenix_NatlProf.Constants.autokeyname_prov;

	AutoKeyB2.MAC_Build (base_prov, name.fname, name.mname, name.lname,
						 zero,
						 BirthDate,
						 PhoneNumber,
						 addr.prim_name, addr.prim_range, addr.st, addr.v_city_name, addr.zip5, addr.sec_range,
						 zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,
						 DID,
						 //personal above.  business below
						 blank,
						 blank,
						 zero,
						 blank,blank,blank,blank,blank,blank,
						 zero,
						 autokeyName,
						 logicalName,
						 bld_prov_auto,false,
						 skip_set,true,type_str,
						 true,,,ProviderID,true);


	// Move autokeys to QA
	RoxieKeyBuild.MAC_SK_Move_v2(autokeyName + 'payload', 'Q', mv_fdids_key);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Address','Q',mv_autokey_addr);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Name','Q',mv_autokey_name);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'StName','Q',mv_autokey_stname);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'CityStName','Q',mv_autokey_city);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Zip','Q',mv_autokey_zip);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Phone2','Q',mv_autokey_phone2);


	build_prov_keys := sequential(bld_prov_auto, 
								   parallel(mv_fdids_key, mv_autokey_addr, mv_autokey_name, 
											 mv_autokey_stname, mv_autokey_city, mv_autokey_zip,
											 mv_autokey_phone2)
								  );
	 
	return build_prov_keys;

end;






