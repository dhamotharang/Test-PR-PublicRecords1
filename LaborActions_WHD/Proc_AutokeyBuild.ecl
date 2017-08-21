IMPORT autokeyb2,autokey,AutoKeyI;

EXPORT proc_autokeybuild(STRING filedate) := FUNCTION

		c := LaborActions_WHD.Constants(filedate);
		ak_dataset := c.ak_dataset;  /* Base file projected as new layout with did & bdid */
		ak_keyname := c.ak_keyname;  /* AutoKey Superfile container name  */
		ak_logical := c.ak_logical;  /* AutoKey Logical file name         */
		ak_skipSet := c.ak_skipSet;  /* Parms for autokeys to bypass      */
		ak_typeStr := c.ak_typeStr;  /* 'AK'                              */
		
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
		SELF.inp.bname      := LEFT.EmployerName; 
		SELF.inp.fein       := '';
		SELF.inp.bphone     := '';  
		SELF.inp.bprim_name := LEFT.m_prim_name;    
		SELF.inp.bprim_range:= LEFT.m_prim_range; 
		SELF.inp.bst        := LEFT.m_st;            
		SELF.inp.bcity_name := LEFT.m_v_city_name;  
		SELF.inp.bzip       := LEFT.m_zip;         
		SELF.inp.bsec_range := LEFT.m_sec_range; 
		SELF.inp.BDID       := LEFT.bdid;           
		SELF.fakeid         := LEFT.FakeID; 
		SELF.p              := []; 
		SELF.b              := [])); 	  
	 
	mod_AKB := module(AutokeyB2.Fn_Build.params) 
		EXPORT DATASET(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
		EXPORT STRING L_inkeyname := 	LaborActions_WHD.constants().ak_keyname; 
		EXPORT STRING L_inlogical := 	LaborActions_WHD.constants(filedate).ak_logical; 
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
