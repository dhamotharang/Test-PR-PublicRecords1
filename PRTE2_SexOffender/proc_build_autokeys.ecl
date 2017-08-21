IMPORT doxie, ut, Data_Services, PRTE2_SexOffender, SexOffender, AutoKeyB2, autokey, AutoKeyI, RoxieKeyBuild; 

EXPORT proc_build_autokeys(string filedate) := FUNCTION
	
	//ENH Autokey
	l_ext := RECORD
		Layouts.AltLayout;
		zero := 0;
		unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('SEX'))| ut.bit_set(0,0);
		real8 lat;
		real8 long;	
	END;
	
	l_ext xpand(Layouts.AltLayout le,integer cntr) := TRANSFORM 
		SELF.did := cntr + autokey.did_adder('SEX'); 
		self.lat := (real)le.geo_lat;
		self.long := (real)le.geo_long;
		SELF := le; 
	END;
	
	ds_ENH := PROJECT(file_enh_key, xpand(LEFT,COUNTER));
	
	AutoKey.MAC_Build_version(ds_ENH,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						PRTE2_SexOffender.Constants.ENH_ak_keyname,
						PRTE2_SexOffender.Constants.KEY_PREFIX + filedate + '::enhpublic',outaction1,false)
	
	//Public Autokeys
	ds_orig := project(ds_ENH(alt_type='S'),
										transform({ds_ENH},
												self.alt_st := if(left.alt_st='',left.orig_state_code, left.alt_st);
												self := left));
						
	AutoKey.MAC_Build_version(ds_orig,fname,mname,lname,
						ssn,
						dob,
						police_agency_phone,
						alt_prim_name, alt_prim_range, alt_st, alt_city_name, alt_zip, alt_sec_range,
						zero,
						zero,zero,zero,
						zero,zero,zero,
						zero,zero,zero,
						lookups,
						did,
						PRTE2_SexOffender.Constants.SPK_ak_keyname,
						PRTE2_SexOffender.Constants.KEY_PREFIX + filedate + '::public',outaction2,false)
						
	//Move to QA
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'address','Q', mv_ENH_address_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'citystname','Q', mv_ENH_city_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'name','Q', mv_ENH_name_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'phone','Q', mv_ENH_phone_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'ssn','Q', mv_ENH_ssn_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'stname','Q', mv_ENH_stname_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.ENH_ak_keyname+'zip','Q', mv_ENH_zip_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'address','Q', mv_SPK_address_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'citystname','Q', mv_SPK_city_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'name','Q', mv_SPK_name_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'phone','Q', mv_SPK_phone_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'ssn','Q', mv_SPK_ssn_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'stname','Q', mv_SPK_stname_QA);
	RoxieKeyBuild.Mac_SK_Move_V2(PRTE2_SexOffender.Constants.SPK_ak_keyname+'zip','Q', mv_SPK_zip_QA);
	
	MovePublic	:= parallel(mv_ENH_address_QA,mv_ENH_city_QA,mv_ENH_name_QA,mv_ENH_phone_QA,mv_ENH_ssn_QA,mv_ENH_stname_QA,mv_ENH_zip_QA,
													mv_SPK_address_QA,mv_SPK_city_QA,mv_SPK_name_QA,mv_SPK_phone_QA,mv_SPK_ssn_QA,mv_SPK_stname_QA,mv_SPK_zip_QA);
						
	//Full Autokeys
	AutoKey.mac_useFakeIDs(PRTE2_SexOffender.Files.File_Autokey_Main, ds_withFakeID_AKB, proc_build_payload_key_AKB, PRTE2_SexOffender.Constants.ak_keyname, PRTE2_SexOffender.Constants.ak_logical(filedate), did, zero, true, Constants.ak_typeStr, unsigned6, false, false, zero);
	ds_forLayoutMaster_AKB := ds_withFakeID_AKB;
	ds_inLayoutMaster_AKB := PROJECT(ds_forLayoutMaster_AKB, TRANSFORM(autokey.layouts.master,
		self.inp.fname				:= left.fname;
		self.inp.mname				:= left.mname;
		self.inp.lname				:= left.lname;
		self.inp.ssn					:= if((integer)left.ssn=0,'',(string9)left.ssn);
		self.inp.dob					:= (integer)left.dob;
		self.inp.phone				:= (string10)left.zero;
		self.inp.prim_name		:= left.prim_name;
		self.inp.prim_range		:= left.prim_range;
		self.inp.st						:= left.st;
		self.inp.city_name		:= left.city_name;
		self.inp.zip					:= (string6)left.zip5;
		self.inp.sec_range		:= left.sec_range;
		self.inp.states				:= left.zero;
		self.inp.lname1				:= left.zero;
		self.inp.lname2				:= left.zero;
		self.inp.lname3				:= left.zero;
		self.inp.city1				:= left.zero;
		self.inp.city2				:= left.zero;
		self.inp.city3				:= left.zero;
		self.inp.rel_fname1		:= left.zero;
		self.inp.rel_fname2		:= left.zero;
		self.inp.rel_fname3		:= left.zero;
		self.inp.lookups			:= left.zero;
		self.inp.DID					:= (unsigned6)left.did;
		self.inp.bname				:= left.blank;
		self.inp.fein					:= if((integer)left.zero=0,'',(string9)left.zero);
		self.inp.bphone				:= (string10)left.zero;
		self.inp.bprim_name		:= left.blank;
		self.inp.bprim_range	:= left.blank;
		self.inp.bst					:= left.blank;
		self.inp.bcity_name		:= left.blank;
		self.inp.bzip					:= (string5)left.blank;
		self.inp.bsec_range		:= left.blank;
		self.inp.BDID					:= (unsigned6)left.zero;
		self.inp.lat					:= (real)left.geo_lat;
		self.inp.long					:= (real)left.geo_long;
		self.FakeID						:= left.FakeID;
		self.p								:= [];
		self.b								:= [];
		));

	mod_AKB := MODULE(AutokeyB2.Fn_Build.params)
		EXPORT dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB;
		EXPORT string		L_inkeyname						:= PRTE2_SexOffender.Constants.ak_keyname;
		EXPORT string		L_inlogical						:= PRTE2_SexOffender.Constants.ak_logical(filedate);
		EXPORT boolean	L_diffing							:= false;
		EXPORT boolean	L_Biz_useAllLookups		:= true;
		EXPORT boolean	L_Indv_useAllLookups	:= true;
		EXPORT boolean	L_by_lookup						:= true;
		EXPORT boolean	L_skipaddrnorm				:= false;
		EXPORT boolean	L_skipB2behavior			:= false;
		EXPORT boolean	L_useOnlyRecordIDs		:= true;
		EXPORT boolean	L_useFakeIDs					:= true;
		EXPORT boolean	L_AddCities						:= true;
		EXPORT integer	L_Biz_favor_lookup		:= 0;
		EXPORT integer	L_Indv_favor_lookup		:= 0;
		EXPORT integer	L_Rep_addr						:= 4;
		EXPORT set of string1 L_build_skip_set:= Constants.ak_skipSet;
	END;

	outaction3 := PARALLEL(proc_build_payload_key_AKB, AutokeyB2.Fn_Build.DoQA(mod_AKB, SexOffender.MAutokey, AutoKeyI.BuildI_Biz.DoBuild) );
	
RETURN SEQUENTIAL(outaction1, outaction2, MovePublic, outaction3);
	
END;

