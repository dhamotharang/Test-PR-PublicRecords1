import AutokeyB2, autokey, roxiekeybuild, CanadianPhones;

export proc_fedex_build_keys2(string version_date) := function
	fedex_dataset := fedex.fedex_autokey_constants.autokey_dataset2;
	logical_key		:= fedex.fedex_autokey_constants.str_AutokeyLogicalName2(version_date);
	super_keyname	:= fedex.fedex_autokey_constants.str_autokeyname2;
	skip_set			:= fedex.fedex_autokey_constants.autokey_skip_set;


//**** Build the Payload Key and create the FakeID
											
autokey.mac_useFakeIDs
	(fedex_dataset,
	 ds_withFakeID,
	 build_payload_key,
	 super_keyname,
	 logical_key,
	 DID,
	 BDID
	)
	
	
//**** Transform to the master autokey layout	
	
ds_inMasterLayout := 
	project(
		ds_withFakeID,
		transform(
			autokey.layouts.master,
			self.inp.fname := left.fname;
			self.inp.mname := left.mname;
			self.inp.lname := left.lname;
			self.inp.ssn := '';
			self.inp.dob := 0;
			self.inp.phone := (string10)left.phone;
			self.inp.prim_name := left.prim_name;
			self.inp.prim_range := left.prim_range;
			self.inp.st := left.st;
			self.inp.city_name := left.v_city_name;
			self.inp.zip := if (trim(left.country,left,right) ='CA',(string6)left.zip6,(string5)left.zip5); 
			self.inp.sec_range := left.sec_range;
			self.inp.states := 0;
			self.inp.lname1 := 0;
			self.inp.lname2 := 0;
			self.inp.lname3 :=0;
			self.inp.city1 := 0;
			self.inp.city2 := 0;
			self.inp.city3 := 0;
			self.inp.rel_fname1 := 0;
			self.inp.rel_fname2 := 0;
			self.inp.rel_fname3 := 0;
			self.inp.lookups := 0;
			self.inp.DID := 0;
			self.inp.bname := left.last_name;
			self.inp.fein := '';
			self.inp.bphone := (string10)left.phone;
			self.inp.bprim_name := left.prim_name;
			self.inp.bprim_range := left.prim_range;
			self.inp.bst := left.st;
			self.inp.bcity_name := left.v_city_name;
			self.inp.bzip := (string5)left.zip5;
			self.inp.bsec_range := left.sec_range;
			self.inp.BDID := 0;
			self.FakeID := left.FakeID;
			self.p := [];
			self.b := [];
		)
	);


//**** Create a module with my dataset and options for the autokey build

akmod := module(AutokeyB2.Fn_Build.params)
	export dataset(autokey.layouts.master) L_indata := ds_inMasterLayout;
	export string L_inkeyname 								:= super_keyname;
	export string L_inlogical 								:= logical_key;
	export boolean L_diffing 									:= FALSE;
	export boolean L_Biz_useAllLookups				:= TRUE;		
	export boolean L_Indv_useAllLookups				:= TRUE;		
	export boolean L_useOnlyRecordIDs					:= TRUE;
	export boolean L_useFakeIDs								:= TRUE;
	export boolean L_AddCities								:= FALSE;
	export set of string1 L_build_skip_set 		:= skip_set;
end;	


//***** Build and Move and Email

OUTACTION := 
	parallel(
		build_payload_key,
		AutokeyB2.Fn_Build.Do(akmod,CanadianPhones.MAutokey,CanadianPhones.MAutokeyB)
	);			

	AutoKeyB2.MAC_AcceptSK_to_QA(super_keyname,move_qa,,fedex.fedex_autokey_constants.autokey_skip_set);

	RoxieKeyBuild.Mac_Daily_Email_Local('FEDEX','SUCC', version_date, send_succ_msg, RoxieKeyBuild.Email_Notification_List);
	RoxieKeyBuild.Mac_Daily_Email_Local('FEDEX','FAIL', version_date, send_fail_msg, 'michael.gould@lexisnexis.com,John.Freibaum@lexisnexis.com');
	
	update_dops := RoxieKeyBuild.updateversion('FedexKeys',version_date,'michael.gould@lexisnexis.com,John.Freibaum@lexisnexis.com',,'N');
	build_keys	:= sequential(outaction, move_qa);
	build_fedex_keys := sequential(build_keys, update_dops) : success(send_succ_msg), failure(send_fail_msg);
	 
	return build_fedex_keys;

end;