import autokeyb2,autokey,AutoKeyI;

export proc_autokeybuild(string filedate) :=  function

		c := NPPES.Constants(filedate);
		ak_dataset := c.ak_dataset;
		ak_keyname := c.ak_keyname;
		ak_logical := c.ak_logical;
		ak_skipSet := c.ak_skipSet;
		ak_typeStr := c.ak_typeStr;

autokey.mac_useFakeIDs 
		(ak_dataset, 
		ds_withFakeID_AKB,  
		proc_build_payload_key_AKB, 
		ak_keyname, 
		ak_logical, 
		did, 
		bdid) 		
		 
	ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
	ds_inLayoutMaster_AKB :=  project(ds_forLayoutMaster_AKB, transform(autokey.layouts.master, 
		self.inp.fname := 	left.clean_name_provider.fname; 
		self.inp.mname := 	left.clean_name_provider.mname; 
		self.inp.lname := 	left.clean_name_provider.lname; 
		self.inp.ssn := 	''; 
		self.inp.dob := 	0; 
		self.inp.phone := 	(string10)left.cleanMailingPhone; 
		self.inp.prim_name := left.clean_norm_address.prim_name; 
		self.inp.prim_range := left.clean_norm_address.prim_range; 
		self.inp.st := 		left.clean_norm_address.st; 
		self.inp.city_name := left.clean_norm_address.v_city_name; 
		self.inp.zip := 	(string6)left.clean_norm_address.zip; 
		self.inp.sec_range := left.clean_norm_address.sec_range; 
		self.inp.states := 	left.zero; 
		self.inp.lname1 := 	left.zero; 
		self.inp.lname2 := 	left.zero;   
		self.inp.lname3 := 	left.zero; 
		self.inp.city1 := 	left.zero; 
		self.inp.city2 := 	left.zero; 
		self.inp.city3 := 	left.zero; 
		self.inp.rel_fname1 := left.zero; 
		self.inp.rel_fname2 := left.zero; 
		self.inp.rel_fname3 := left.zero; 
		self.inp.lookups := left.zero; 
		self.inp.DID := 	(unsigned6)left.DID; 
		self.inp.bname := 	left.provider_organization_name; 
		self.inp.fein := 	'';
		self.inp.bphone := 	(string10)left.cleanMailingPhone;  
		self.inp.bprim_name := left.clean_norm_address.prim_name; 
		self.inp.bprim_range := left.clean_norm_address.prim_range; 
		self.inp.bst := 	left.clean_norm_address.st; 
		self.inp.bcity_name := left.clean_norm_address.v_city_name; 
		self.inp.bzip := 	(string5)left.clean_norm_address.zip; 
		self.inp.bsec_range := left.clean_norm_address.sec_range; 
		self.inp.BDID := 	(unsigned6)left.BDID; 
		self.fakeid := 		left.FakeID; 
		self.p := []; 
		self.b := [])); 	  
	 
 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := 	nppes.constants().ak_keyname; 
	export string L_inlogical := 	nppes.constants(filedate).ak_logical; 
	export set of string1 L_build_skip_set := ak_skipSet; 
	end; 
												
build_auto_keys :=  
		parallel(
			proc_build_payload_key_AKB, 
			AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild,AutoKeyI.BuildI_Biz.DoBuild) 
		);
		
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);		 
						 
	akeys := sequential(build_auto_keys,moveToQA);												

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
										
return akeys;

end;
