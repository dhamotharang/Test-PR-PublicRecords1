import address, did_add, doxie, header_slimsort, suppress, ut,header, didville,NID;
/* 
Required inputs include one of the ssn inputs, yob, and zip, all others are optional.
The standard behavior is to only return one result or fail if no unique match.  
AllowMultipleResults overrides this.
 */


// Read user input
inp := DID_Numeric_Services.inputs;

mod_access := inp.mod_access;

input_ssn4 									:= inp.input_ssn4;
zip_value 									:= inp.zip_value;
yob_value 									:= inp.yob_value;
fi_value 										:= inp.fi_value;
li_value 										:= inp.li_value;
prange_value								:= inp.prange_value;
input_prange								:= inp.input_prange;
input_zip										:= inp.input_zip;
ssn4_value									:= inp.ssn4_value;
ssn5_value									:= inp.ssn5_value;
ssn_value										:= inp.ssn_value;
dppa_purpose								:= mod_access.dppa;
glb_purpose									:= mod_access.glb;
maxresults_val 							:= inp.maxresults_val;
ssn_mask_value 							:= mod_access.ssn_mask;
AllowMultipleResults_value 	:= inp.AllowMultipleResults_value; 
glb_ok											:= mod_access.isValidGLB ();
dppa_ok											:= mod_access.isValidDPPA ();
thresh_value								:= inp.thresh_value;


//***** DEFINE THE INDEX READS

// Macros for index reads 
ndex_mac(yob_check) := MACRO
			keyed(ssn4= input_ssn4) AND
			keyed(zip= zip_value[1]) AND
			keyed(yob=yob_check)
ENDMACRO;

ndex_mac2(yob_check) := MACRO
	ndex_mac(yob_check) AND
	keyed(fi=fi_value OR fi_value=0) AND
	keyed(li=li_value OR li_value=0) AND
	(prim_range = input_prange or input_prange=0) AND
	(ssn5 = ssn5_value or ssn5_value=0)	
ENDMACRO;


// Module for my index reads
IndexRead(unsigned4 Lyob) :=
MODULE
	// export Empty := header_slimsort.key_ssn4_numerics(FALSE);

	export FullFilter := 
	MODULE
		export AllRecs := header_slimsort.key_ssn4_numerics(ndex_mac2(Lyob));
		export Lim1 := limit(dedup(sort(AllRecs,did),did),1,skip);
	END;

	export SSN5Filter :=
	MODULE
		export AllRecs := header_slimsort.key_ssn4_numerics(ndex_mac(Lyob) and (ssn5=ssn5_value or ssn5_value=0));
		Just1DID	:= if(count(dedup(sort(AllRecs,did),did))=1,AllRecs);  
		export Lim1 := choosen(sort(Just1DID, if(fi=fi_value or fi_value=0,0,1),if(li=li_value or li_value=0,0,1)),1);
	END;

END;

//Record definition for failures and an empty dataset
rec := recordof(header_slimsort.key_ssn4_numerics);



//***** FIND OUT IF THERE IS ANOTHER MATCHING DID (BUT THAT HAS NO DOB)

// if there are matches on the input, get the dids back that match the input but have 0 yob 
pre_hrecs_from_inputs_w0 := 
map(
	EXISTS(IndexRead(yob_value).FullFilter.Lim1)
		=> join(IndexRead(0).FullFilter.AllRecs,IndexRead(yob_value).FullFilter.AllRecs,left.did=right.did,left only),
	EXISTS(IndexRead(yob_value).SSN5Filter.Lim1)
		=> join(IndexRead(0).SSN5Filter.AllRecs,IndexRead(yob_value).SSN5Filter.AllRecs,left.did=right.did,left only),
		dataset([],rec)
);

is_hrec_w_only_0dob := exists(pre_hrecs_from_inputs_w0);
									



//***** PICK A RESULT SET OR A FAILURE

// for the result sets with multiple records, i still need to do a little sorting and deduping
ranki(unsigned1 fi, unsigned1 li) := if(fi = fi_value, 0, 1) + if(li = li_value, 0, 1);
limdedup(dataset(recordof(header_slimsort.key_ssn4_numerics)) res) := 
limit(
	dedup(
		sort(res, did, ranki(fi, li)), 
		did
	),
	maxresults_val, 
	FAIL(203, doxie.ErrorCodes(203))
);

key_res := 
if(
	AllowMultipleResults_value,
	map(
		//Full Filter with DOB
		EXISTS(IndexRead(yob_value).FullFilter.AllRecs)
			=> limdedup(IndexRead(yob_value).FullFilter.AllRecs + IndexRead(0).FullFilter.AllRecs),	//All
		
		//SSN5 Filter with DOB
		EXISTS(IndexRead(yob_value).SSN5Filter.AllRecs)
			=> limdedup(IndexRead(yob_value).SSN5Filter.AllRecs + IndexRead(0).SSN5Filter.AllRecs), //All

		//Both without DOB
		limdedup(IndexRead(0).FullFilter.AllRecs + IndexRead(0).SSN5Filter.AllRecs)  //All
	),
	map(
		//Full Filter with DOB
		EXISTS(IndexRead(yob_value).FullFilter.Lim1) and 
		not is_hrec_w_only_0dob
			=> IndexRead(yob_value).FullFilter.Lim1, //Limit 1
			
		//SSN5 Filter with DOB				
		EXISTS(IndexRead(yob_value).SSN5Filter.Lim1) and 
		not is_hrec_w_only_0dob
			=> IndexRead(yob_value).SSN5Filter.Lim1, //Limit 1	 
			
		//With DOB failure
		EXISTS(IndexRead(yob_value).FullFilter.AllRecs) 
			=> FAIL(rec, 203, doxie.ErrorCodes(203)), 	
		
		//Full Filter without DOB
		EXISTS(IndexRead(0).FullFilter.Lim1)
			=> IndexRead(0).FullFilter.Lim1, //Limit 1
			
		//SSN5 Filter without DOB			
		EXISTS(IndexRead(0).SSN5Filter.Lim1)
			=> IndexRead(0).SSN5Filter.Lim1, //Limit 1
			
		//Without DOB failure	
		EXISTS(IndexRead(0).FullFilter.AllRecs) 
			=> FAIL(rec, 203, doxie.ErrorCodes(203)),
		
			//Last resort
			choosen(IndexRead(yob_value).SSN5Filter.Lim1 & IndexRead(0).SSN5Filter.Lim1,1)
			// IndexRead(0).Empty
		)
);

// output(IndexRead(yob_value).FullFilter.AllRecs, named('yob_full'));
// output(IndexRead(0).FullFilter.AllRecs, named('z_full'));
// output(IndexRead(yob_value).SSN5Filter.AllRecs, named('yob_SSN5'));
// output(IndexRead(0).SSN5Filter.AllRecs, named('z_SSN5'));
// output(AllowMultipleResults_value, named('AllowMultipleResults_value'));
// output(EXISTS(IndexRead(yob_value).SSN5Filter.AllRecs), named('EXISTS'));
// output(limdedup(IndexRead(yob_value).SSN5Filter.AllRecs + IndexRead(0).SSN5Filter.AllRecs), named('limdedup'));
// output(key_res,  named('key_res'));

did := PROJECT(key_res,doxie.layout_references);




//***** SCORING (DO NOT CHECK PERMISSIONS) AND DISPLAY (CHECK PERMISSIONS)

// Get best records with and without permissions. The one with permission checked will be used for field
// display, the one without will be used to calculate address score

br_permission_check := doxie.best_records(did, doSuppress:=false, modAccess := mod_access);
							
// Pass in dppa and glb 255 so that we get all records back. We want all records so that we can have the best
// address score reflect the best address. We will only display the address that user is permitted to see, this
// is done by calling header.MAC_GlbClean_Header
  mod_access_unrestricted := MODULE (mod_access)
    EXPORT unsigned1 dppa := 255;
    EXPORT unsigned1 glb := 255;
  END;
  br := doxie.best_records (did, doSuppress:=false, modAccess := mod_access_unrestricted);

header_recs_wo_permission_check := doxie.mod_header_records(false,true,,,true,ModAccess := mod_access).results(project(did,doxie.layout_references_hh));
for_permission_check := project(header_recs_wo_permission_check, doxie.layout_header_records);
Header.MAC_GlbClean_Header(for_permission_check,pre_header_recs_w_permission_check, , , mod_access)
header_recs_w_permission_check := project(pre_header_recs_w_permission_check, doxie.layout_presentation);


best_from_func_w_permission_check :=  didville.BestAddress.best_recs(header_recs_w_permission_check,did,dppa_purpose,glb_purpose,input_zip,prange_value,fi_value,li_value);
best_from_func_wo_permission_check := 
if(
	count(header_recs_wo_permission_check)=count(header_recs_w_permission_check),  
	best_from_func_w_permission_check, 
	didville.BestAddress.best_recs(header_recs_wo_permission_check,did,dppa_purpose,glb_purpose,input_zip,prange_value,fi_value,li_value)
);

best_addr_rec_for_score := 
if(
	count(best_from_func_wo_permission_check) = count(did),
	project(best_from_func_wo_permission_check,Didville.Layout_Did_Numeric_Out.Addr_Best),
	project(br,Didville.Layout_Did_Numeric_Out.Addr_Best)
);

best_addr_rec_for_display :=
if(
	count(best_from_func_w_permission_check) = count(did),
	project(best_from_func_w_permission_check,Didville.Layout_Did_Numeric_Out.Addr_Best),
	project(br_permission_check,Didville.Layout_Did_Numeric_Out.Addr_Best)
);							



didville.Layout_Did_Numeric_Out.Out_Rec append_best(key_res le, br ri) :=
TRANSFORM
	SELF.fi := fi_value;
	// TODO: fix input echo
	SELF.best_ssn := ri.ssn;
	SELF.best_title := ri.title;
  SELF.best_fname := ri.fname;
  SELF.best_mname := ri.mname;
  SELF.best_lname := ri.lname;
  SELF.best_name_suffix := ri.name_suffix;

  SELF.best_dob := (STRING8)ri.dob;
  SELF.best_dod := ri.dod;
  SELF.best_phone := ri.phone;
	
	// missing leading 0's

	SELF.verify_best_ssn := 
	if(
		ssn_value='', 
		did_add.SSN_Match_Score(ssn4_value,ri.ssn,true),
		did_add.SSN_Match_Score(ssn_value,ri.ssn,False)
	);
  															
	fname_match :=
		fi_value =ut.Chr2PhoneDigit(ri.fname[1]) OR 
		fi_value=ut.Chr2PhoneDigit(NID.PreferredFirstNew(ri.fname)[1]) OR
		fi_value=ut.Chr2PhoneDigit(NID.PreferredFirstNew(ri.fname,false)[1]);
	lname_match := 
		li_value = ut.Chr2PhoneDigit(ri.lname[1]); 
	
  SELF.verify_best_name := 
	map(
		(fi_value=0 OR ri.fname='') AND
		(li_value=0 OR ri.lname='')
			=>255,
		(fname_match OR fi_value=0 OR ri.fname='')  AND 
		lname_match OR li_value=0 OR ri.lname='' 
			=> 100,
			0
	);
	
  verify_best_dob := 
	IF(
		yob_value=0 or ri.dob=0, 
		255,
		IF(
			(STRING4)yob_value=((STRING)ri.dob)[1..4],
			100,
			0
		)
	);
	
	SELF.verify_best_dob :=	verify_best_dob;
		
	SELF.score_any_ssn  := 
	if(
		ssn_value='', 
		did_add.SSN_Match_Score( ssn4_value,(INTFORMAT(le.ssn5,5,1) + INTFORMAT(le.ssn4,4,1)),true),
		did_add.SSN_Match_Score( ssn_value,(INTFORMAT(le.ssn5,5,1) + INTFORMAT(le.ssn4,4,1)),false)
	);
															
  SELF.score_any_addr := 
	map(
		((unsigned3)(zip_value[1])=0 OR le.zip=0) AND
		(prange_value='' or le.prim_range=0)
			=>255,
		zip_value[1]=le.zip and (input_prange= le.prim_range or
		prange_value='' or le.prim_range=0)
			=>100,
		zip_value[1]=le.zip 
			=>(90-2*ut.StringSimilar(prange_value,(string)le.prim_range)),
			max(0, 100-ut.zip_Dist(input_zip,(string5)le.zip))
	);
	
	SELF.score_any_name := 
	map(
		fi_value=0 and li_value=0
			=>255,
		(fi_value=le.fi or fi_value=0) and (li_value=le.li or li_value=0) 
			=>100,
		fi_value=le.fi or li_value=le.li
			=>70,
			0
	
	);
	
  SELF.score_any_dob  := 
	IF(
		(yob_value=0 or ri.dob=0) and le.yob=0, 
		255,
		IF(
			(STRING4)yob_value=((STRING)ri.dob)[1..4] or le.yob<>0,
			100,
			0
		)
	);
	
	SELF.any_addr_date := 0;
	SELF.score := 
	CASE(
		SELF.score_any_name,
		100 	=> 40,
		255 	=> 30,
		70  	=> 25,
					15
	) +
	CASE(
		SELF.score_any_addr,
		100  	=>20,
					10
	) +
	CASE(
		SELF.score_any_dob,
		100 	=> 20,
					10
	) +
	CASE(
		SELF.score_any_ssn,
		100 	=> 20,
					0
	);								
	SELF := le;
	SELF :=[];

END;


j0_unfil := JOIN(key_res,br_permission_check,LEFT.did=RIGHT.did,append_best(LEFT,RIGHT), LEFT OUTER);
j0 := j0_unfil(score >= thresh_value);

Suppress.MAC_Mask(j0, j, best_ssn, null, true, false);

Didville.Layout_Did_Numeric_Out.Out_Rec append_best_addr(j li,best_addr_rec_for_display ri):=TRANSFORM
  SELF.best_addr1 := 
		address.Addr1FromComponents(ri.prim_range, ri.predir, ri.prim_name, ri.suffix, ri.postdir, ri.unit_desig, ri.sec_range);
  SELF.best_city := ri.city_name;
  SELF.best_state := ri.st;
  SELF.best_zip := ri.zip;
  SELF.best_zip4 := ri.zip4;
  SELF.best_addr_date := ri.addr_dt_last_seen;
	SELF.tnt := ri.tnt;
	Self := li;
END;

j2 := JOIN(j,best_addr_rec_for_display,left.did=right.did,append_best_addr(LEFT,RIGHT));

Didville.Layout_Did_Numeric_Out.Out_Rec append_best_addr_score(j2 li,best_addr_rec_for_score ri):=TRANSFORM
	SELF.verify_best_address := 
	map(
		((unsigned3)(zip_value[1])=0 OR ri.zip='') AND
		(prange_value='' or ri.prim_range='')
			=>255,
		input_zip=ri.zip and (prange_value= ri.prim_range or
		prange_value='' or ri.prim_range='')
			=>100,
		input_zip=ri.zip 
			=>(90-2*ut.StringSimilar(prange_value,ri.prim_range)),
			max(0, 100-ut.zip_Dist(input_zip,ri.zip)));
	SELF.score_any_addr := max(li.score_any_addr,self.verify_best_address);
	SELF := li;
END;


j3 := JOIN( j2, best_addr_rec_for_score, left.did=right.did, append_best_addr_score(LEFT,RIGHT), LEFT OUTER);

j4 := 
if(
	exists(key_res),
	j3, 
	project( //for the case that we have no results and want to just return the inputs
		dataset([{1}], {unsigned a}),
		transform(
			Didville.Layout_Did_Numeric_Out.Out_Rec,
			self.ssn4 := input_ssn4, 
			self.zip := zip_value[1],
			self.yob := yob_value, 
			self.fi := fi_value, 
			self:=[]
		)
	)
);

export records := sort(j4, -score, -yob, -DID, record);