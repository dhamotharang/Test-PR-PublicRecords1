import Ingenix_NatlProf, AutoKeyB2, RoxieKeyBuild; 

export Proc_Sanctions_Autokeybuild(string filedate) := function

	base_sanc := dedup(Ingenix_NatlProf.file_SearchAutokey_Sanctions, record);
	
	skip_set := Ingenix_NatlProf.Constants.autokey_skip_set_sanc;

	Autokey_Name := Ingenix_NatlProf.Constants.AutokeyName_Sanc;

	type_str := Ingenix_NatlProf.Constants.autokey_typeStr_sanc;

	// holds logical base name for a autokeys.
	logicalName := Ingenix_NatlProf.Constants.sanctions_AutokeyLogicalName(filedate);

	// holds key base name for autokeys
	autokeyName := Ingenix_NatlProf.Constants.autokeyname_sanc;

	AutoKeyB2.MAC_Build (base_sanc,name.fname, name.mname, name.lname,
						 zero,
						 sanc_dob,
						 zero,
						 addr.prim_name, addr.prim_range, addr.st, addr.v_city_name, addr.zip5, addr.sec_range,
						 zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 zero,zero,zero,
						 lookups,
						 did,
						 // Provider Screening Batch Phase 2 enhancements - added Business name/addr fields
						 sanc_busnme,
						 blank,
						 zero,
						 addr.prim_name, addr.prim_range, addr.st, addr.v_city_name, addr.zip5, addr.sec_range,
						 zero, // bdid, not needed in payload so left as zero
						 autokeyName,
						 logicalName,
						 bld_sanc_auto,false,
						 skip_set,true,type_str,
						 true,,,sanc_id,true); 

	// Move autokeys to QA
	RoxieKeyBuild.MAC_SK_Move_v2(autokeyName + 'Payload', 'Q', mv_fdids_key);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Address','Q',mv_autokey_addr);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Name','Q',mv_autokey_name);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'StName','Q',mv_autokey_stname);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'CityStName','Q',mv_autokey_city);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'Zip','Q',mv_autokey_zip);
	// Stop building the SSN2 key as per the bug# 27181
	//RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'SSN2','Q',mv_autokey_ssn2);
 
	// Provider Screening Batch Phase 2 enhancements - move Business autokeys
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'addressb2','Q',mv_autokey_baddr);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'citystnameb2','Q',mv_autokey_bcity);	
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'nameb2','Q',mv_autokey_bname);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'namewords2','Q',mv_autokey_bnamew);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'stnameb2','Q',mv_autokey_bstname);
	RoxieKeyBuild.Mac_SK_Move_V2(autokeyName + 'zipb2','Q',mv_autokey_bzip);

	build_sanc_keys := sequential(bld_sanc_auto, 
								   parallel(mv_fdids_key, mv_autokey_addr, mv_autokey_name, 
											 mv_autokey_stname, mv_autokey_city, mv_autokey_zip,
									     mv_autokey_baddr, mv_autokey_bcity, mv_autokey_bname, 
										   mv_autokey_bnamew, mv_autokey_bstname, mv_autokey_bzip
											)
								  );
	 
	return build_sanc_keys;

end;
