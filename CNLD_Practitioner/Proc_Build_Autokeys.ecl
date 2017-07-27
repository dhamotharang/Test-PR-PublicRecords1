IMPORT AutoKey, AutokeyB2, AutoKeyI;

EXPORT Proc_Build_Autokeys(STRING filedate) := FUNCTION

	c := CNLD_Practitioner.Constants(filedate);

	ak_dataset := c.ak_dataset;

	ak_keyname := c.ak_keyname; /* AutoKey Superfile container name */
	ak_logical := c.ak_logical; /* AutoKey Logical file name */
	ak_skipSet := c.ak_skipSet; /* Parms for autokeys to bypass */
		
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
							SELF.inp.fname      := left.fname;
							SELF.inp.mname      := left.mname;
							SELF.inp.lname      := left.lname;
							SELF.inp.ssn        := left.ssn;
							SELF.inp.dob        := (integer)left.dob;
							SELF.inp.phone      := left.address_phone;
							SELF.inp.prim_name  := left.prim_name;
							SELF.inp.prim_range := left.prim_range;
							SELF.inp.st         := left.st;
							SELF.inp.city_name  := left.p_city_name;
							SELF.inp.zip        := left.zip;
							SELF.inp.sec_range  := left.sec_range;
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
							SELF.inp.DID        := left.DID;
							SELF.inp.bname      := '';
							SELF.inp.fein       := '';
							SELF.inp.bphone     := '';
							SELF.inp.bprim_name := '';
							SELF.inp.bprim_range:= '';
							SELF.inp.bst        := '';
							SELF.inp.bcity_name := '';
							SELF.inp.bzip       := '';
							SELF.inp.bsec_range := '';
							SELF.inp.BDID       := left.BDID;
							SELF.fakeid         := left.FakeID;
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