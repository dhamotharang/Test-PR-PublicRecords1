import autokey,AutoKeyB2,AutoKeyI,CNLD_Facilities; 


export proc_build_autokeys(string filedate) := function

c		:= CNLD_Facilities.constants;

ak_dataset	:= c.ak_dataset;
ak_keyname	:= c.ak_keyname;
ak_logical	:= c.ak_logical(filedate);
ak_setSkip	:= c.set_skip;
	
autokey.mac_useFakeIDs (ak_dataset, 
												ds_withFakeID_AKB,
				                proc_build_payload_key_AKB,
												ak_keyname,
												ak_logical,
												did,
												bdid)


outdataset := 
			project(
							ds_withFakeID_AKB,
								transform(autokey.layouts.master,
												self.inp.fname := left.blank;
												self.inp.mname := left.blank;
												self.inp.lname := left.blank;
												self.inp.ssn := left.blank;
												self.inp.dob := left.zero;
												self.inp.phone := left.blank;
												self.inp.prim_name := left.blank;
												self.inp.prim_range := left.blank;
												self.inp.st := left.blank;
												self.inp.city_name := left.blank;
												self.inp.zip := left.blank;
												self.inp.sec_range := left.blank;
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
												self.inp.DID := left.did;
												self.inp.bname := left.org_name;
												self.inp.fein := left.cln_ssn_taxid;
												self.inp.bphone := left.addr_phone;
												self.inp.bprim_name := left.prim_name;
												self.inp.bprim_range := left.prim_range;
												self.inp.bst := left.st;
												self.inp.bcity_name := left.v_city_name;
												self.inp.bzip := left.zip5;
												self.inp.bsec_range := left.sec_range;
												self.inp.BDID := left.bdid;
												self.inp.lat := (unsigned)left.geo_lat;
												self.inp.long := (unsigned)left.geo_long;
												self.FakeID := left.FakeID;
												self.p := [];
												self.b := [];
												// self := [];
		)
	);


akmod := module(AutokeyB2.Fn_Build.params)
	export dataset(autokey.layouts.master) L_indata := outdataset;
	export string L_inkeyname 								:= ak_keyname;
	export string L_inlogical 								:= ak_logical;
	export set of string1 L_build_skip_set  := ak_setSkip;
end;	



bld_auto_keys := 	parallel(proc_build_payload_key_AKB,
													 AutokeyB2.Fn_Build.Do(akmod,
																								 AutoKeyI.BuildI_Indv.DoBuild,
																								 AutoKeyI.BuildI_Biz.DoBuild));


AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname,moveToQA);

retval := sequential(bld_auto_keys,moveToQA);
																	 
return retval;														


end;
