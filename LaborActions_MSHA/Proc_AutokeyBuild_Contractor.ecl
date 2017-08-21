IMPORT autokeyb2,autokey,AutoKeyI;

EXPORT Proc_AutokeyBuild_Contractor(STRING filedate,STRING filetype) := FUNCTION

		c := LaborActions_MSHA.Constants(filedate,filetype);
		ak_dataset_contractor	:= c.ak_dataset_contractor; 	/* Base file projected as new layout with did & bdid 		*/
		ak_keyname  					:= c.ak_keyname_contractor; 	/* AutoKey Superfile container name											*/
		ak_logical  					:= c.ak_logical_contractor; 	/* AutoKey Logical file name														*/        
		ak_skipSet  					:= c.ak_skipSet;  						/* Parms for autokeys to bypass													*/    
		ak_typeStr  					:= c.ak_typeStr;  						/* 'AK'																									*/                              
		
		autokey.mac_useFakeIDs 
				(ak_dataset_contractor, 
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
		SELF.inp.bname      := LEFT.Contractor_Name; 
		SELF.inp.fein       := '';
		SELF.inp.bphone     := '';  
		SELF.inp.bprim_name := ''; 
		SELF.inp.bprim_range:= ''; 
		SELF.inp.bst        := ''; 
		SELF.inp.bcity_name := ''; 
		SELF.inp.bzip       := ''; 
		SELF.inp.bsec_range := '';  
		SELF.inp.BDID       := LEFT.zero;
		SELF.fakeid         := LEFT.FakeID; 
		SELF.p              := []; 
		SELF.b              := [])); 	  
	 
	mod_AKB := module(AutokeyB2.Fn_Build.params) 
		EXPORT DATASET(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
		EXPORT STRING L_inkeyname := 	LaborActions_MSHA.constants(,filetype).ak_keyname_contractor; 
		EXPORT STRING L_inlogical := 	LaborActions_MSHA.constants(filedate,filetype).ak_logical_contractor; 
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