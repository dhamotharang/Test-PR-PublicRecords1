import autokeyb2,standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;

export procBuildAutoKeys(string pVersion = ut.GetDate) :=  FUNCTION

pBase := InstantID_Archiving.Files_Base.Delta + InstantID_Archiving.Files_Base_Batch.key_files;

	lskname := '~thor_data400::key::instantid_archiving::autokey::';
	llgname := InstantID_Archiving.str_AutokeyLogicalName(pVersion);
	
	pNewBase := PROJECT(pBase, TRANSFORM({InstantID_Archiving.Layout_Base, unsigned6 did := 0, unsigned6 bdid := 0},
															SELF.bdid := LEFT.transaction_id_key;
															SELF.did :=LEFT.transaction_id_key;
															SELF := LEFT));
	
	newBase := DEDUP(SORT(DISTRIBUTE(pNewBase, transaction_id_key), transaction_id_key, LOCAL), transaction_id_key, LOCAL);

	 RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(InstantID_Archiving.Key_AutokeyPayload,'~thor_data400::key::instantid_archiving::@version@::autokey_payload','~thor_data400::key::instantid_archiving::'+pversion+'::autokey_payload',bk_pay);
	 RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::instantid_archiving::@version@::autokey_payload','~thor_data400::key::instantid_archiving::'+pversion+'::autokey_payload',mv_pay,3);
	 RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::instantid_archiving::@version@::autokey_payload','Q',mvq_pay,3);

build_payload_key := SEQUENTIAL(bk_pay, mv_pay, mvq_pay);

ds_forLayoutMaster_AKB := newBase;

	ds_inLayoutMaster_AKB_temp :=  NORMALIZE(ds_forLayoutMaster_AKB, 4, transform(autokey.layouts.master, 
		self.inp.fname := 	CHOOSE(COUNTER, left.fname, left.fname, left.fname2, left.fname2); 
		self.inp.mname := 	CHOOSE(COUNTER, left.mname, left.mname, left.mname2, left.mname2); 
		self.inp.lname := 	CHOOSE(COUNTER, left.lname, left.lname, left.lname2, left.lname2); 
		self.inp.ssn := 	if((integer)left.ssn=0,'',(string9)left.ssn); 
		self.inp.dob := 	(integer)left.dob; 
		self.inp.prim_name := CHOOSE(COUNTER, left.prim_name, left.prim_name2, left.prim_name, left.prim_name2); 
		self.inp.prim_range := CHOOSE(COUNTER, left.prim_range, left.prim_range2, left.prim_range, left.prim_range2); 
		self.inp.st := 		CHOOSE(COUNTER, left.st, left.st2, left.st, left.st2); 
		self.inp.city_name := CHOOSE(COUNTER, left.v_city_name, left.v_city_name2, left.v_city_name, left.v_city_name2); 
		self.inp.zip := 	CHOOSE(COUNTER, (string5)left.zip5, (string5)left.zip52, (string5)left.zip5, (string5)left.zip52); 
		self.inp.sec_range := CHOOSE(COUNTER, left.sec_range, left.sec_range2, left.sec_range, left.sec_range2); 
		self.inp.states := 	0; 
		self.inp.lname1 := 	0; 
		self.inp.lname2 := 	0; 
		self.inp.lname3 := 	0; 
		self.inp.city1 := 	0; 
		self.inp.city2 := 	0; 
		self.inp.city3 := 	0; 
		self.inp.rel_fname1 := 0; 
		self.inp.rel_fname2 := 0; 
		self.inp.rel_fname3 := 0; 
		// self.inp.lookups := (unsigned4)trim(left.orig_company_id); 
		// self.inp.DID := 	(unsigned6)left.DID; 
		self.fakeid := 		left.transaction_id_key; 
		self.p := []; 
		self.b := [];
		self.inp := [])); 	  
	  
	 ds_inLayoutMaster_AKB := dedup(sort(distribute(ds_inLayoutMaster_AKB_temp, hash(fakeid)), record, local), record, local);
	 
 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := 	InstantID_Archiving.str_AutoKeyReference; 
	export string L_inlogical := 	InstantID_Archiving.str_AutokeyLogicalName(pVersion); 
	export boolean L_diffing := 	false; 
	export boolean L_Biz_useAllLookups := 	true; 
	export boolean L_Indv_useAllLookups := 	true; 
	export boolean L_by_lookup := 	true; 
	export boolean L_skipaddrnorm := 		false; 
	export boolean L_skipB2behavior := 		false; //was true
	export boolean L_useOnlyRecordIDs := 	true; 
	export boolean L_useFakeIDs := 	true; 
	export boolean L_AddCities := 	true; 
	export integer L_Biz_favor_lookup := 	0; 
	export integer L_Indv_favor_lookup := 	0; 
	export integer L_Rep_addr := 	4; 
	export set of string1 L_build_skip_set := []; 
	export boolean L_useLiteralLookupsValue:=false;
	end; 

outaction := SEQUENTIAL(
								build_payload_key; 
								AutokeyB2.Fn_Build.DoQA(mod_AKB, AutoKeyI.BuildI_Indv.DoBuild, AutoKeyI.BuildI_Biz.DoBuild); //added biz
								); 

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

										
return outaction;
end;