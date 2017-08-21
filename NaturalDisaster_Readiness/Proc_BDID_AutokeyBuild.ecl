IMPORT autokeyb2,autokey,AutoKeyI;

EXPORT Proc_BDID_AutokeyBuild(STRING filedate) := FUNCTION

		c := NaturalDisaster_Readiness.Constants(filedate);
		ak_dataset := c.ak_dataset;  /* Base file projected as new layout with did & bdid */
		ak_keyname := c.ak_keyname;  /* AutoKey Superfile container name */
		ak_logical := c.ak_logical;  /* AutoKey Logical file name */     
		ak_skipSet := c.ak_skipSet;  /* Parms for autokeys to bypass */ 
		ak_typeStr := c.ak_typeStr;  /* 'AK' */ 
		
		autokey.mac_useFakeIDs 
				(ak_dataset, 
				ds_withFakeID_AKB,  
				proc_build_payload_key_AKB, 
				ak_keyname, 
				ak_logical, 
				did, 
				bdid) 		
		 
	ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
	ds_inLayoutMaster_AKB := PROJECT(ds_forLayoutMaster_AKB, 
													 TRANSFORM(Autokey.Layouts.Master, 
		SELF.inp.fname      := ''; 
		SELF.inp.mname      := ''; 
		SELF.inp.lname      := ''; 
		SELF.inp.ssn        := ''; 
		SELF.inp.dob        := 0; 
		SELF.inp.phone      := ''; 
		SELF.inp.prim_name  := ''; 
		SELF.inp.prim_range := ''; 
		SELF.inp.st         := ''; 
		SELF.inp.city_name  := ''; 
		SELF.inp.zip        := ''; 
		SELF.inp.sec_range  := ''; 
		SELF.inp.states     := LEFT.zero; 
		SELF.inp.lname1     := LEFT.zero; 
		SELF.inp.lname2     := LEFT.zero;
		SELF.inp.lname3     := LEFT.zero;
		SELF.inp.city1      := LEFT.zero;
		SELF.inp.city2      := LEFT.zero;
		SELF.inp.city3      := LEFT.zero;
		SELF.inp.rel_fname1 := LEFT.zero;
		SELF.inp.rel_fname2 := LEFT.zero;
		SELF.inp.rel_fname3 := LEFT.zero;
		SELF.inp.lookups    := LEFT.zero;
		SELF.inp.DID        := LEFT.zero;
		SELF.inp.bname      := LEFT.Business_Name; 
		SELF.inp.fein       := '';
		SELF.inp.bphone     := LEFT.Business_Clean_Phone_No;  
		SELF.inp.bprim_name := LEFT.m_prim_name;
		SELF.inp.bprim_range:= LEFT.m_prim_range;
		SELF.inp.bst        := LEFT.Business_State; 
		SELF.inp.bcity_name := LEFT.Clean_Business_City;
		SELF.inp.bzip       := LEFT.Business_Zip_Code; 
		SELF.inp.bsec_range := LEFT.Business_Zip_Code4; 
		SELF.inp.BDID       := LEFT.BDID;
		SELF.fakeid         := LEFT.FakeID; 
		SELF.p              := []; 
		SELF.b              := [])); 	  

	mod_AKB := module(AutokeyB2.Fn_Build.params) 
		EXPORT DATASET(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
		EXPORT STRING L_inkeyname := 	NaturalDisaster_Readiness.constants().ak_keyname; 
		EXPORT STRING L_inlogical := 	NaturalDisaster_Readiness.constants(filedate).ak_logical; 
		EXPORT SET OF STRING1 L_build_skip_set := ak_skipSet; 
	end; 
												
	build_auto_keys := PARALLEL( proc_build_payload_key_AKB, 
															 AutokeyB2.Fn_Build.Do(mod_AKB,
															 AutoKeyI.BuildI_Indv.DoBuild,
															 AutoKeyI.BuildI_Biz.DoBuild) );
		
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);		 
						 
	akeys := SEQUENTIAL(build_auto_keys,moveToQA);												
										
	RETURN akeys;
	
END;