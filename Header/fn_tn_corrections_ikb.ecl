IMPORT InsuranceHeader_Incremental,doxie,did_add,Std;
export fn_tn_corrections_ikb() := function

 	out_rec := RECORD 
		header.layout_header,
		string1 valid_dob := '';
		unsigned6 hhid := 0;
		STRING18 county_name := '';
		STRING120 listed_name := '';
		STRING10 listed_phone := '';
		unsigned4 dod := 0;
		STRING1 death_code := '';
		unsigned4 lookup_did := 0;
		UNSIGNED4 DT_EFFECTIVE_FIRST, 
		UNSIGNED4 DT_EFFECTIVE_LAST;
	end; 

	// Get Boca (ADL) corrected LexIDs
    ds:=InsuranceHeader_Incremental.Files.IncBaseAll_Current_DS(
			
				RecChangeType <> InsuranceHeader_Incremental.Constants.RecordChangeType.New AND
				((STRING)buildDateTimeStamp)[1..8] >= (STRING) InsuranceHeader_Incremental.Build_Date.BocaDops
			
			);

	ds1:=project(ds(src[1..3]='ADL'),{ds.did});
	dds1:=dedup(ds1,did,all):persist('~thor_data400::header::ikb::temp_tn_re_append_records',expire(7));
 
 	// Get current Transunion records for LexIDs that have been corrected
	j1:=join(dds1,doxie.Key_Header,LEFT.did=RIGHT.s_did and RIGHT.src in ['TN','TS','LT','TU'], transform(RIGHT) );

	// re-did START ******************************************************************************************

	r1 := record
	unsigned1 did_score := 0;
	j1;
	end;

	good_names_has_SSN := j1(ssn <> '');
	good_names_no_SSN  := j1(ssn = '');

	//passing the records with SSN to name + SSN matching 
	matchset := ['S'];

	//switching to sensitive... i think transunion data had suspicious DOB's to begin with
	//DID with dob2 but drop it later
	did_add.MAC_Match_Flex
		(good_names_has_SSN, matchset,					
		ssn, foo, fname, mname, lname, name_suffix, 
		foo, foo, foo, foo, foo, foo, 
		DID, r1, true, DID_Score,
		75, re_did1);

	//passing the records without SSN + the records without name SSN matching (DID_score = 0) to 
	//other matchings. 
	second_call := re_did1(did_score = 0) + project(good_names_no_SSN,r1);

	matchset1 := ['A','Z','D','P'];

	did_add.MAC_Match_Flex
		(second_call, matchset1,					
	 	ssn, dob, fname, mname, lname, name_suffix, 
	 	prim_range, prim_name, sec_range, zip, st, phone, 
	 	DID, r1, true, DID_Score,
	 	75, re_did2);

	//combine the records from two matchflex
	re_did := (re_did1(did_score <> 0) + re_did2):persist('~thor_data400::persist::header::ikb::tn_re_did');

	// re-did END *************************************************************************************************

	todays_date:= Std.Date.Today();

	update_records:= join(distribute(re_did(did<>0),hash(rid)),distribute(doxie.Key_Header(src in ['TN','TS','LT','TU']),hash(rid)),
    	 					LEFT.rid=RIGHT.rid AND
	 						LEFT.did<>RIGHT.did,
	 						transform(out_rec,
						 						SELF.dt_effective_first:=todays_date,
												SELF.dt_effective_last:=0,

	/* ASSIGN CORRECTED LexID --> */			SELF.did:=LEFT.did,
												
												SELF:= RIGHT), LOCAL
							);

	poison_records:= join(distribute(re_did(did<>0),hash(rid)),distribute(doxie.Key_Header(src in ['TN','TS','LT','TU']),hash(rid)),
    	 					LEFT.rid=RIGHT.rid AND
	 						LEFT.did<>RIGHT.did,
	 						transform(out_rec,	
							 					SELF.dt_effective_first:=20160101,
	/* SET END EFFECTIVE DATE --> */			SELF.dt_effective_last:=todays_date,
												 
												SELF:= RIGHT), LOCAL
						);

	return dedup(update_records+poison_records,did,rid,all);

end;
