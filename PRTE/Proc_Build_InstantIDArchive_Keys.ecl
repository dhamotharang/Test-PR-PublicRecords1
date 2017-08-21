IMPORT InstantID_Archiving;
import autokeyb2, ut, zz_cemtemp, standard, ut, doxie, autokey,AutoKeyI, RoxieKeyBuild;


filedate := '20140218';
pversion := filedate;

pBase := dataset([],InstantID_Archiving.Layout_Base);

	lskname := '~prte::key::instantid_archiving::autokey::';
	llgname := '~prte::key::instantid_archiving::'+filedate+'::autokey_';
	
	pNewBase := PROJECT(pBase, TRANSFORM({InstantID_Archiving.Layout_Base, unsigned6 did := 0, unsigned6 bdid := 0},
															SELF.bdid := LEFT.transaction_id_key;
															SELF.did :=LEFT.transaction_id_key;
															SELF := LEFT));
	
	newBase := DEDUP(SORT(DISTRIBUTE(pNewBase, transaction_id_key), transaction_id_key, LOCAL), transaction_id_key, LOCAL);

ds_forLayoutMaster_AKB := newBase;

	ds_inLayoutMaster_AKB :=  NORMALIZE(ds_forLayoutMaster_AKB, 4, transform(autokey.layouts.master, 
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

str_AutoKeyReference2 := '~prte::key::instantid_archiving::autokey::@version@::';
str_AutokeyLogicalName2(string filedate = ut.GetDate) := '~prte::key::instantid_archiving::'+filedate+'::autokey_';

 mod_AKB := module(AutokeyB2.Fn_Build.params) 
	export dataset(autokey.layouts.master) L_indata := ds_inLayoutMaster_AKB; 
	export string L_inkeyname := 	str_AutoKeyReference2; 
	export string L_inlogical := 	str_AutokeyLogicalName2(pVersion); 
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
								AutokeyB2.Fn_Build.Do(mod_AKB, AutoKeyI.BuildI_Indv.DoBuild, AutoKeyI.BuildI_Biz.DoBuild); //added biz
								); 
/////////////////////////////////
	
	pNewBase2 := PROJECT(pBase, TRANSFORM({InstantID_Archiving.Layout_Base, unsigned6 did := 0, unsigned6 bdid := 0},
															SELF.bdid := LEFT.transaction_id_key;
															SELF.did :=LEFT.transaction_id_key;
															SELF := LEFT));
	
	newBase2 := DEDUP(SORT(DISTRIBUTE(pNewBase2, transaction_id_key), transaction_id_key, LOCAL), transaction_id_key, LOCAL);

Key_AutokeyPayload := BUILDINDEX(newBase2, {transaction_id_key}, {newBase2}, 
																			'~prte::key::instantid_archiving::' + pversion + '::autokey_payload');
////////////////////////////////////

{STRING8 date_added, STRING30 product, STRING25 transaction_id, STRING20 company_id}
																trInFIle(InstantID_Archiving.Layout_Base L) := TRANSFORM
																SELF.product := L.product;
																SELF.date_added := STRINGLIB.STRINGFILTER(L.date_added, '0123456789')[..8];
																SELF := L;
END;
																
InpFile := PROJECT(pBase, trInFIle(LEFT)); 

Key_DateAdded := BUILDINDEX(InpFile, {date_added, product, company_id}, {InpFile}, 
															'~prte::key::instantid_archiving::'+pversion+'::dateadded');
////////////////////////////////////	
																
InpFile1 := DATASET([], {STRING25 product, InstantID_Archiving.Layouts.Model}); 

Key_Model := BUILDINDEX(InpFile1, {transaction_id, score_id}, {InpFile1}, 
															'~prte::key::instantid_archiving::'+pversion+'::Model');														
////////////////////////////////////

InpFile2 := DATASET([], {STRING25 product, InstantID_Archiving.Layouts.ModelRisk});

Key_ModelRisk := BUILDINDEX(InpFile2, {transaction_id, score_id}, {InpFile2}, 
															'~prte::key::instantid_archiving::'+pVersion+'::ModelRisk');

////////////////////////////////////
InpFile3 := DATASET([], RECORDOF(InstantID_Archiving.Files_Base.Delta));

Key_Payload := BUILDINDEX(InpFile3, {transaction_ID}, {InpFile3}, 
															'~prte::key::instantid_archiving::'+pVersion+'::Payload');
////////////////////////////////////
InpFile4 := DATASET([], {STRING25 product := 'INSTANTID', InstantID_Archiving.Layouts.RedFlags});

Key_RedFlags := BUILDINDEX(InpFile4, {transaction_id}, {InpFile4}, '~prte::key::instantid_archiving::'+pversion+'::redflags');

////////////////////////////////////
InpFile5 := DATASET([], InstantID_Archiving.Layouts.Reportk);

Key_Report := BuildINDEX(InpFile5, {transaction_id}, {InpFile5}, 
															'~prte::key::instantid_archiving::'+pVersion+'::report');

////////////////////////////////////
InpFile6 := DATASET([], {STRING25 product, InstantID_Archiving.Layouts.Risk});

Key_Risk := BUILDINDEX(InpFile6, {transaction_id}, {InpFile6}, 
															'~prte::key::instantid_archiving::'+pVersion+'::risk');
															
////////////////////////////////////
InpFile7 := DATASET([], {STRING25 product, InstantID_Archiving.Layouts.ModelIndex});

Key_RiskIndex := BUILDINDEX(InpFile7, {transaction_id, score_id}, {InpFile7}, 
															'~prte::key::instantid_archiving::'+pVersion+'::index');
////////////////////////////////////
InpFile8 := DATASET([], {STRING25 product := 'INSTANTID INTERNATIONAL', InstantID_Archiving.Layouts.Verification});

Key_Verification := BUILDINDEX(InpFile8, {transaction_id}, {InpFile8}, 
															'~prte::key::instantid_archiving::'+pVersion+'::verification');

Key_Report1 := BuildINDEX(InpFile5, {transaction_id}, {InpFile5}, 
															'~prte::key::instantid_archiving::'+pVersion+'::report1');
	Key_Report2 := BuildINDEX(InpFile5, {transaction_id}, {InpFile5}, 
															'~prte::key::instantid_archiving::'+pVersion+'::report2');
	Key_Report3 := BuildINDEX(InpFile5, {transaction_id}, {InpFile5}, 
															'~prte::key::instantid_archiving::'+pVersion+'::report3');														
															
////////////////////////////////////
EXPORT Proc_Build_InstantIDArchive_Keys := SEQUENTIAL(outaction,
																										 Key_AutokeyPayload,
																										 Key_DateAdded,
																										 Key_Model,
																										 Key_ModelRisk,
																										 Key_Payload,
																										 Key_RedFlags,
																										 Key_Report,
																										 Key_Risk,
																										 Key_RiskIndex,
																										 Key_Verification,
																										 key_report1,
																										 key_report2,
																										 key_report3
																										 );
