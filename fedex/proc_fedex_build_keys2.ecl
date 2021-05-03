import AutokeyB2, autokey, roxiekeybuild, CanadianPhones,scrubs_fedex,std;

export proc_fedex_build_keys2(string version_date, boolean isdelta) := function
	fedex_datasetPre := fedex.fedex_autokey_constants.autokey_dataset2;
	logical_key		:= fedex.fedex_autokey_constants.str_AutokeyLogicalName2(version_date);
	super_keyname	:= fedex.fedex_autokey_constants.str_autokeyname2;
	skip_set			:= fedex.fedex_autokey_constants.autokey_skip_set;


//**** Build the Payload Key and create the FakeID
fedex_datasetStep1:=if(isdelta,fedex_datasetPre(version=version_date),fedex_datasetPre);
fedex_dataset:=project(fedex_datasetStep1,transform(recordof(fedex_datasetStep1)-[version],self:=left;));
PreviousKey:=index(fedex.key_fedex2_payload,'~thor_data400::key::fedex2::autokey::qa::payload');
PrevMaxFID := if(isdelta,MAX(PreviousKey,fakeid),0);											
autokey.mac_useFakeIDs
	(fedex_dataset,
	 ds_withFakeID,
	 build_payload_key,
	 super_keyname,
	 logical_key,
	 DID,
	 BDID,
	 ,,,,,,false,true,PrevMaxFID
	);
	
	
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

	//AutoKeyB2.MAC_AcceptSK_to_QA(super_keyname,move_qa,,fedex.fedex_autokey_constants.autokey_skip_set);
	deltaMove:=sequential(
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::payload', '~thor_data400::key::fedex2::'+version_date+'::autokey::payload'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::stname', '~thor_data400::key::fedex2::'+version_date+'::autokey::stname'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::zip', '~thor_data400::key::fedex2::'+version_date+'::autokey::zip'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::zipprlname', '~thor_data400::key::fedex2::'+version_date+'::autokey::zipprlname'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::address', '~thor_data400::key::fedex2::'+version_date+'::autokey::address'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::citystname', '~thor_data400::key::fedex2::'+version_date+'::autokey::citystname'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::name', '~thor_data400::key::fedex2::'+version_date+'::autokey::name'),
		fileservices.addsuperfile('~thor_data400::key::fedex2::autokey::qa::phone2', '~thor_data400::key::fedex2::'+version_date+'::autokey::phone2'),
	);

	fullMove:=sequential(
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::payload','~thor_data400::key::fedex2::autokey::father::payload','~thor_data400::key::fedex2::autokey::grandfather::payload'],'~thor_data400::key::fedex2::'+version_date+'::autokey::payload',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::stname','~thor_data400::key::fedex2::autokey::father::stname','~thor_data400::key::fedex2::autokey::grandfather::stname'],'~thor_data400::key::fedex2::'+version_date+'::autokey::stname',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::zip','~thor_data400::key::fedex2::autokey::father::zip','~thor_data400::key::fedex2::autokey::grandfather::zip'],'~thor_data400::key::fedex2::'+version_date+'::autokey::zip',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::zipprlname','~thor_data400::key::fedex2::autokey::father::zipprlname','~thor_data400::key::fedex2::autokey::grandfather::zipprlname'],'~thor_data400::key::fedex2::'+version_date+'::autokey::zipprlname',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::address','~thor_data400::key::fedex2::autokey::father::address','~thor_data400::key::fedex2::autokey::grandfather::address'],'~thor_data400::key::fedex2::'+version_date+'::autokey::address',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::citystname','~thor_data400::key::fedex2::autokey::father::citystname','~thor_data400::key::fedex2::autokey::grandfather::citystname'],'~thor_data400::key::fedex2::'+version_date+'::autokey::citystname',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::name','~thor_data400::key::fedex2::autokey::father::name','~thor_data400::key::fedex2::autokey::grandfather::name'],'~thor_data400::key::fedex2::'+version_date+'::autokey::name',true),
		STD.File.PromoteSuperFileList(['~thor_data400::key::fedex2::autokey::qa::phone2','~thor_data400::key::fedex2::autokey::father::phone2','~thor_data400::key::fedex2::autokey::grandfather::phone2'],'~thor_data400::key::fedex2::'+version_date+'::autokey::phone2',true),
	);

	move_qa:=if(isdelta,deltaMove,fullMove);
	RoxieKeyBuild.Mac_Daily_Email_Local('FEDEX','SUCC', version_date, send_succ_msg, RoxieKeyBuild.Email_Notification_List);
	RoxieKeyBuild.Mac_Daily_Email_Local('FEDEX','FAIL', version_date, send_fail_msg, 'michael.gould@lexisnexis.com,John.Freibaum@lexisnexis.com');
	Run_Scrubs 	:= scrubs_fedex.fn_RunScrubs(version_date);


	update_dops_Full := RoxieKeyBuild.updateversion('FedexKeys',version_date,'michael.gould@lexisnexis.com,John.Freibaum@lexisnexis.com',,'N',,,,,,'F');
	update_dops_Delta := RoxieKeyBuild.updateversion('FedexKeys',version_date,'michael.gould@lexisnexis.com,John.Freibaum@lexisnexis.com',,'N',,,,,,'D');
	build_keys	:= sequential(outaction, move_qa);

	build_fedex_keys := sequential
						(
							build_keys, 
							run_scrubs,
							if(isDelta,update_dops_Delta,update_dops_Full)
						) : success(send_succ_msg), failure(send_fail_msg);
	 
	return build_fedex_keys;

end;
