import AutoKeyB2,Address,autokey,AutoKeyI;

export proc_build_autokeys(string filedate) := function

/////////////////////////////////////////////////////////////////////////////////
// -- Prepped for Macro & Removed Child Records from file
/////////////////////////////////////////////////////////////////////////////////
pty := SANCTN.file_base_party;
inc := sort(table(SANCTN.file_base_incident
				,{BATCH_NUMBER,INCIDENT_NUMBER,incident_date_clean,AG_CODE}
				,BATCH_NUMBER,INCIDENT_NUMBER,incident_date_clean,AG_CODE,few)
				,BATCH_NUMBER,INCIDENT_NUMBER,incident_date_clean,AG_CODE);
				


xpnd_sanctn := RECORD
SANCTN.layout_autokeys;
  INTEGER8 zero := 0;
	blk  := '';
END;

xpnd_sanctn xpand_sanctn(pty L, inc R) :=  TRANSFORM

self.AG_CODE 	   := if(l.BATCH_NUMBER = r.BATCH_NUMBER and 
				         l.INCIDENT_NUMBER = r.INCIDENT_NUMBER
						 ,R.AG_CODE,'');
self.INCIDENT_DATE := if(l.BATCH_NUMBER = r.BATCH_NUMBER and 
				         l.INCIDENT_NUMBER = r.INCIDENT_NUMBER
						 ,R.incident_date_clean,'');
						 
self               := L; 
END;


DS_sanctn := dedup(join(pty,inc,
				  left.BATCH_NUMBER = right.BATCH_NUMBER and 
				  left.INCIDENT_NUMBER = right.INCIDENT_NUMBER,
				  xpand_sanctn(left,right),left outer,lookup),record,all);

// Address.MAC_Multi_City(DS_sanctn,p_city_name,zip5,multiCitysanctn);
// dist_DSsanctn := distribute(multiCitysanctn,random());

/////////////////////////////////////////////////////////////////////////////////
// -- Initialize AutoKey Macro
/////////////////////////////////////////////////////////////////////////////////

ak_keyname := '~thor_data400::key::sanctn::@version@::autokey::';
ak_logical := '~thor_data400::key::sanctn::' + filedate + '::autokey::';
set_skip := ['P','Q','S','F'];//keys to omit building
		//P in this set to skip personal phones
		//Q in this set to skip business phones
		//S in this set to skip SSN
		//F in this set to skip FEIN
		//C in this set to skip ALL personal (Contact) data
		//B in this set to skip ALL Business data


autokey.mac_useFakeIDs(
	DS_sanctn, 
	ds_withFakeID_AKB,  
	proc_build_payload_key_AKB, 
	ak_keyname, 
	ak_logical, 
	did, 
	zero
) 
	 
ds_forLayoutMaster_AKB := ds_withFakeID_AKB; 

zero := 0;
string_zero := '0';
	 
ds_inLayoutMaster_AKB :=  
	project( 
		ds_forLayoutMaster_AKB, 
		transform( 
			autokey.layouts.master, 
			self.inp.fname := left.fname; 
			self.inp.mname := left.mname; 
			self.inp.lname := left.lname; 
			self.inp.ssn := if((integer)left.blk=0,'',(string9)left.blk); 
			self.inp.dob := zero; 
			self.inp.phone := string_zero; 
			self.inp.prim_name := left.prim_name; 
			self.inp.prim_range := left.prim_range; 
			self.inp.st := left.st; 
			self.inp.city_name := left.v_city_name; 
			self.inp.zip := (string6)left.zip5; 
			self.inp.sec_range := left.sec_range; 
			self.inp.states := zero; 
			self.inp.lname1 := zero; 
			self.inp.lname2 := zero; 
			self.inp.lname3 := zero; 
			self.inp.city1 := zero; 
			self.inp.city2 := zero; 
			self.inp.city3 := zero; 
			self.inp.rel_fname1 := zero; 
			self.inp.rel_fname2 := zero; 
			self.inp.rel_fname3 := zero; 
			self.inp.lookups := zero; 
			self.inp.DID := (unsigned6)left.did; 
			self.inp.bname := left.cname; 
			self.inp.fein := if((integer)left.blk=0,'',(string9)left.blk); 
			self.inp.bphone := string_zero; 
			self.inp.bprim_name := left.prim_name; 
			self.inp.bprim_range := left.prim_range; 
			self.inp.bst := left.st; 
			self.inp.bcity_name := left.v_city_name; 
			self.inp.bzip := (string5)left.zip5; 
			self.inp.bsec_range := left.sec_range; 
			self.inp.BDID := zero; 
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
	export set of string1 L_build_skip_set  := set_skip; 
end; 
	 
bld_sanctn_auto :=  
	parallel(proc_build_payload_key_AKB, 
	AutokeyB2.Fn_Build.Do(mod_AKB,AutoKeyI.BuildI_Indv.DoBuild,AutoKeyI.BuildI_Biz.DoBuild) 
	); 
	 
	


/////////////////////////////////////////////////////////////////////////////////
// -- Move AutoKeys to QA
/////////////////////////////////////////////////////////////////////////////////

AutoKeyB2.MAC_AcceptSK_to_QA(ak_keyname, move2qa,,set_skip)

retval := sequential(bld_sanctn_auto,move2qa);

 
return retval;

end;

