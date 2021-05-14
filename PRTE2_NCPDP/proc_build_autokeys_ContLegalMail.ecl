IMPORT AutoKey, AutokeyB2, AutoKeyI;

EXPORT proc_build_autokeys_ContLegalMail(string filedate) := function

	c := prte2_ncpdp._Constants(filedate);

	/* Base file, which is a slimmed down version of the full keybuild layout */
	ak_dataset := prte2_ncpdp.Files.autokey_ContLegalMail;

	ak_keyname := c.ak_keyname_ContLegalMail; /* AutoKey Superfile container name */
	ak_logical := c.ak_logical_ContLegalMail; /* AutoKey Logical file name */
	ak_skipSet := c.ak_skipSet_ContLegalMail; /* Parms for autokeys to bypass */
		
	AutoKey.mac_useFakeIDs(ak_dataset,
				                 ds_withFakeID_AKB,
				                 proc_build_payload_key_AKB,
				                 ak_keyname,
				                 ak_logical,
				                 did,
				                 bdid)
		 
	ds_inLayoutMaster_AKB :=
	  PROJECT(ds_withFakeID_AKB,
						TRANSFORM(AutoKey.Layouts.Master,
							SELF.inp.fname      := LEFT.first_name;
							SELF.inp.mname      := LEFT.middle_initial;
							SELF.inp.lname      := LEFT.last_name;
							SELF.inp.ssn        := '';
							SELF.inp.dob        := 0;
							SELF.inp.phone      := LEFT.phone;
							SELF.inp.prim_name  := LEFT.business_prim_name;
							SELF.inp.prim_range := LEFT.business_prim_range;
							SELF.inp.st         := LEFT.business_st;
							SELF.inp.city_name  := LEFT.business_city;
							SELF.inp.zip        := LEFT.business_zip;
							SELF.inp.sec_range  := LEFT.business_sec_range;
							SELF.inp.states     := 0;
							SELF.inp.lname1     := 0;
							SELF.inp.lname2     := 0;
							SELF.inp.lname3     := 0;
							SELF.inp.city1      := 0;
							SELF.inp.city2      := 0;
							SELF.inp.city3      := 0;
							SELF.inp.rel_fname1 := 0;
							SELF.inp.rel_fname2 := 0;
							SELF.inp.rel_fname3 := 0;
							SELF.inp.lookups    := 0;
							SELF.inp.DID        := 0;
							SELF.inp.bname      := LEFT.business_name;
							SELF.inp.fein       := LEFT.fein;
							SELF.inp.bphone     := LEFT.business_phone;
							SELF.inp.bprim_name := LEFT.business_prim_name;
							SELF.inp.bprim_range:= LEFT.business_prim_range;
							SELF.inp.bst        := LEFT.business_st;
							SELF.inp.bcity_name := LEFT.business_city;
							SELF.inp.bzip       := LEFT.business_zip;
							SELF.inp.bsec_range := LEFT.business_sec_range;
							SELF.inp.BDID       := LEFT.BDID;
							SELF.fakeid         := LEFT.FakeID;
							SELF.p              := [];
							SELF.b              := []));
	 
	mod_AKB := MODULE(AutokeyB2.Fn_Build.params)
		EXPORT DATASET(AutoKey.Layouts.Master) L_indata := ds_inLayoutMaster_AKB;
		EXPORT STRING L_inkeyname := ak_keyname;
		EXPORT STRING L_inlogical := ak_logical;
		EXPORT SET OF STRING1 L_build_skip_set := ak_skipSet;
	END;

	build_auto_keys := PARALLEL(proc_build_payload_key_AKB,
															AutokeyB2.Fn_Build.Do(mod_AKB,
															                      AutoKeyI.BuildI_Indv.DoBuild,
															                      AutoKeyI.BuildI_Biz.DoBuild));

	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, moveToQA);

	akeys := SEQUENTIAL(build_auto_keys,
	                    moveToQA);

	RETURN akeys;

END;