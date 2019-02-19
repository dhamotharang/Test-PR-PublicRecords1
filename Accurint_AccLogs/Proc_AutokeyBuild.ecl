import autokeyb2, ut, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export proc_autokeybuild :=  FUNCTION

ds_forLayoutMaster_AKB := accurint_acclogs.file_SearchAutokey;

// ds_forLayoutMaster_AKB := d2; 
	 
	ds_inLayoutMaster_AKB :=  project(ds_forLayoutMaster_AKB, transform(autokey.layouts.master, 
		self.inp.fname := 	left.fname; 
		self.inp.mname := 	left.mname; 
		self.inp.lname := 	left.lname; 
		self.inp.ssn := 	if((integer)left.ssn=0,'',(string9)left.ssn); 
		self.inp.dob := 	(integer)left.dob; 
		self.inp.phone := 	(string10)left.phone; 
		self.inp.prim_name := left.prim_name; 
		self.inp.prim_range := left.prim_range; 
		self.inp.st := 		left.st; 
		self.inp.city_name := left.v_city_name; 
		self.inp.zip := 	(string6)left.zip; 
		self.inp.sec_range := left.sec_range; 
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
		self.inp.lookups := (unsigned4)trim(left.orig_company_id); 
		self.inp.DID := 	(unsigned6)left.DID; 
		self.inp.bname := 	left.cname; 
		self.inp.fein := 	if((integer)left.orig_ein=0,'',(string9)left.orig_ein); 
		self.inp.bphone := 	(string10)left.phone; 
		self.inp.bprim_name := left.prim_name; 
		self.inp.bprim_range := left.prim_range; 
		self.inp.bst := 	left.st; 
		self.inp.bcity_name := left.v_city_name; 
		self.inp.bzip := 	(string5)left.zip; 
		self.inp.bsec_range := left.sec_range; 
		self.inp.BDID := 	(unsigned6)left.BDID; 
		self.fakeid := 		left.record_id; 
		self.p := []; 
		self.b := [])); 	  
	 
 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := 	Accurint_AccLogs.str_AutoKeyReference; 
	export string L_inlogical := 	accurint_acclogs.str_AutokeyLogicalName(trim(accurint_acclogs.version, all)); 
	export boolean L_diffing := 	false; 
	export boolean L_Biz_useAllLookups := 	true; 
	export boolean L_Indv_useAllLookups := 	true; 
	export boolean L_by_lookup := 	true; 
	export boolean L_skipaddrnorm := 		false; 
	export boolean L_skipB2behavior := 		false; 
	export boolean L_useOnlyRecordIDs := 	true; 
	export boolean L_useFakeIDs := 	true; 
	export boolean L_AddCities := 	true; 
	export integer L_Biz_favor_lookup := 	0; 
	export integer L_Indv_favor_lookup := 	0; 
	export integer L_Rep_addr := 	4; 
	export set of string1 L_build_skip_set := []; 
	export boolean L_useLiteralLookupsValue:=true;
	end; 

outaction := parallel(AutokeyB2.Fn_Build.DoQA(mod_AKB,
												AutoKeyI.BuildI_Indv.DoBuild,
												AutoKeyI.BuildI_Biz.DoBuild)); 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

										
return outaction;
end;
