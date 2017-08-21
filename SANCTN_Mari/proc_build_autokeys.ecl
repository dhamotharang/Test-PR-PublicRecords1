import SANCTN_Mari, autokeyB2,autokey,AutoKeyI;

export proc_build_autokeys (string filedate) := function


c		:= SANCTN_Mari.constants;

ak_dataset := c.ak_dataset;
ak_keyname := c.ak_keyname;
ak_logical := c.ak_logical(filedate);
ak_setSkip	:= c.skipSet;
ak_typeStr	:= c.type_str; 


autokey.mac_useFakeIDs (ak_dataset, 
												ds_withFakeID_AKB,
				                proc_build_payload_key_AKB,
												ak_keyname,
												ak_logical,
												did,
												bdid)

												
	ds_forLayoutMaster_AKB := ds_withFakeID_AKB;
	ds_inLayoutMaster_AKB := project(ds_forLayoutMaster_AKB,transform(autokey.layouts.master
																	,self.inp.fname := left.name.fname;
																	self.inp.mname := left.name.mname;
																	self.inp.lname := left.name.lname;
																	self.inp.ssn := if((integer)left.ssn=0,' ',(string9)left.ssn);
																	self.inp.dob := (integer)left.dob;
																	self.inp.phone := (string10)left.phone;
																	self.inp.prim_name := left.addr.prim_name;
																	self.inp.prim_range := left.addr.prim_range;
																	self.inp.st := left.addr.st;
																	self.inp.city_name := left.addr.v_city_name;
																	self.inp.zip := (string6)left.addr.zip5;
																	self.inp.sec_range := left.addr.sec_range;
																	self.inp.states := left.zero;
																	self.inp.lname1 := left.zero;
																	self.inp.lname2 := left.zero;
																	self.inp.lname3 := left.zero;
																	self.inp.city1 := left.zero;
																	self.inp.city2 := left.zero;
																	self.inp.city3 := left.zero;
																	self.inp.rel_fname1 := left.zero;
																	self.inp.rel_fname2 := left.zero;
																	self.inp.rel_fname3 := left.zero;
																	self.inp.lookups := left.zero;
																	self.inp.DID := (unsigned6)left.did;
																	self.inp.bname := left.company;
																	self.inp.fein := if((integer)left.tin=0,' ',(string9)left.tin);
																	self.inp.bphone := left.blank;
																	self.inp.bprim_name := left.addr.prim_name;
																	self.inp.bprim_range := left.addr.prim_range;
																	self.inp.bst := left.addr.st;
																	self.inp.bcity_name := left.addr.v_city_name;
																	self.inp.bzip := (string5)left.addr.zip5;
																	self.inp.bsec_range := left.addr.sec_range;
																	self.inp.BDID := (unsigned6)left.bdid;
																	self.FakeID := left.FakeID;
																	self.p := [];
																	self.b := [];
		)
	);

mod_AKB := module(AutokeyB2.Fn_Build.params)
		export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB;
		export string L_inkeyname := ak_keyname;
		export string L_inlogical := ak_logical;
		export boolean L_diffing := false;
		export boolean L_Biz_useAllLookups := true;
		export boolean L_Indv_useAllLookups := true;
		export boolean L_by_lookup := true;
		export boolean L_skipaddrnorm := false;
		export boolean L_skipB2behavior := false;
		export boolean L_useOnlyRecordIDs := true;
		export boolean L_useFakeIDs := true;
		export boolean L_AddCities := true;
		export integer L_Biz_favor_lookup := 0;
		export integer L_Indv_favor_lookup := 0;
		export integer L_Rep_addr := 4;
		export set of string1 L_build_skip_set  := ak_setSkip;
end;

	bld_sanctn_auto := parallel(proc_build_payload_key_AKB
														,AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild
														,AutoKeyI.BuildI_Biz.DoBuild));
														
	AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);

	akeys := sequential(bld_sanctn_auto,moveToQA);
																	 
return akeys;														


end;