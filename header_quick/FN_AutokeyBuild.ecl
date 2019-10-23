import ut, header, doxie, autokey, autokeyb, autokeyB2, AutoKeyI, _Control,dx_header;

export FN_AutokeyBuild(dataset(dx_header.Layout_Header) head, string filedate) := 
FUNCTION



//***** Extra fields to make macro happy 
//map date_first_seen when date_last_seen is 0
go := project(head,transform(header_quick.layout_Autokey - layout_header_exclusions, 
self.dt_last_seen  := if(left.dt_last_seen = 0, left.dt_first_seen, left.dt_last_seen), self := left));

//***** Build autokeys
inkeyname := header_quick.str_AutokeyName;
inlogical := header_quick.str_AutokeyLogicalName(filedate);
ss := ['B','-'];

autokey.mac_useFakeIDs 
	(go, 
	ds_withFakeID_AKB,  
	proc_build_payload_key_AKB, 
	inkeyname, 
	inlogical, 
	DID, 
	zero2, 
	false, 
	'HEAD', 
	integer8, 
	false, 
	false, 
	zero1) 
	 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 
	 
ds_inLayoutMaster_AKB :=  
	project( 
	ds_forLayoutMaster_AKB, 
	 transform( 
	 autokey.layouts.master, 
		 self.inp.fname := left.fname; 
		 self.inp.mname := left.mname; 
		 self.inp.lname := left.lname; 
		 self.inp.ssn := if((integer)left.ssn=0,'',(string9)left.ssn); 
		 self.inp.dob := (integer)left.dob; 
		 self.inp.phone := (string10)left.phone; 
		 self.inp.prim_name := left.prim_name; 
		 self.inp.prim_range := left.prim_range; 
		 self.inp.st := left.st; 
		 self.inp.city_name := left.city_name; 
		 self.inp.zip := (string6)left.zip; 
		 self.inp.sec_range := left.sec_range; 
		 self.inp.states := left.zero1; 
		 self.inp.lname1 := left.zero1; 
		 self.inp.lname2 := left.zero1; 
		 self.inp.lname3 := left.zero1; 
		 self.inp.city1 := left.zero1; 
		 self.inp.city2 := left.zero1; 
		 self.inp.city3 := left.zero1; 
		 self.inp.rel_fname1 := left.zero1; 
		 self.inp.rel_fname2 := left.zero1; 
		 self.inp.rel_fname3 := left.zero1; 
		 self.inp.lookups := left.zero1; 
		 self.inp.DID := (unsigned6)left.DID; 
		 self.inp.bname := left.blank;
						//personal above.  business below; 
		 self.inp.fein := if((integer)left.blank=0,'',(string9)left.blank); 
		 self.inp.bphone := (string10)left.blank; 
		 self.inp.bprim_name := left.blank; 
		 self.inp.bprim_range := left.blank; 
		 self.inp.bst := left.blank; 
		 self.inp.bcity_name := left.blank; 
		 self.inp.bzip := (string5)left.blank; 
		 self.inp.bsec_range := left.blank; 
		 self.inp.BDID := (unsigned6)left.zero2; 
		 self.FakeID := left.FakeID; 
		 self.p := []; 
		 self.b := []; 
	 ) 
	 ); 
	  
	 
 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := inkeyname; 
	export string L_inlogical := inlogical; 
	export boolean L_diffing := false; 
	export boolean L_Biz_useAllLookups := FALSE; 
	export boolean L_Indv_useAllLookups := FALSE; 
	export boolean L_by_lookup := true; 
	export boolean L_skipaddrnorm := false; 
	export boolean L_skipB2behavior := TRUE; 
	export boolean L_useOnlyRecordIDs := false; 
	export boolean L_useFakeIDs := true; 
	export boolean L_AddCities := true; 
	export integer L_Biz_favor_lookup := 0; 
	export integer L_Indv_favor_lookup := 0; 
	export integer L_Rep_addr := 4; 
	export set of string1 L_build_skip_set := ss; 
	export boolean L_UseNewPreferredFirst:= true;
	end; 
	 
	outaction1 :=  
	parallel(proc_build_payload_key_AKB, 
	AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild,AutoKeyI.BuildI_Biz.DoBuild) 
	); 
	 
	
AutoKeyB.MAC_AcceptSK_to_QA(header_quick.str_AutokeyName, outaction2,,
                          ss)
	
return sequential(outaction1, outaction2);

END;