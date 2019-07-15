IMPORT STD, IDLExternalLinking,InsuranceHeader_Incremental;

EXPORT ExistingBase(DATASET(Layout_Header_Plus) dsIn, STRING versionIn, UNSIGNED timestampIn) := MODULE

	dsNewOnlyRIDs0 := dsIn(RecChangeType = InsuranceHeader_Incremental.Constants.RecordChangeType.New);

	// filter the new records from FullInc Ingest got did already through fn_updateDID 
	
	SHARED dsNewOnlyRIDs := dsNewOnlyRIDs0(rid = did);
	
	currentDate := STD.Date.CurrentDate(TRUE);
	minDateForNew := STD.Date.AdjustDate(currentDate,,,-1*InsuranceHeader_Incremental.Constants.DaysOldForNew);
	
	// apply date filter to exclude old records that sometimes appear as new RIDs
	SHARED dsNewOnlyRIDs_dateFilter := DISTRIBUTE(dsNewOnlyRIDs(dt_last_seen >= minDateForNew OR dt_vendor_last_reported >= minDateForNew),HASH(fname,lname));
	
	Layout_DIDAppend := RECORD
		RECORDOF(dsNewOnlyRIDs_dateFilter);
		UNSIGNED  append_did := 0;
		UNSIGNED4 unique_id ; 
	 INTEGER2  xlink_weight;
  UNSIGNED2 xlink_score;
  INTEGER1  xlink_distance;
  STRING60  xlink_matches;
  UNSIGNED4 xlink_keys;
  STRING    xlink_keys_desc;
  STRING    xlink_matches_desc;
	END;
	
	dsForAppend := PROJECT(dsNewOnlyRIDs_dateFilter, TRANSFORM(Layout_DIDAppend , SELF := LEFT, SELF.unique_id := COUNTER, SELF := []));
	
	// external linking to determine which records apply to new entities
	// using weight 30 and distance 0 to exclude weak matches and ambiguous cases from being treated as new entities
	IDLExternalLinking.mac_xlinking_on_thor(dsForAppend, 
																					append_did, sname, fname, mname, lname, gender, derived_gender, 
																					prim_name, prim_range, sec_range, city, st, zip, ssn, dob, dl_state, dl_nbr,,,
																					outfile,,50,6,,phone,,,FALSE);
	
	dsForAppend2 := outfile(append_did <> 0): PERSIST(Filenames.Persist_DIDAppendExisting, EXPIRE(15));
	
		// get only records has PII change with no other false info (false source_rid etc...) 
	
	dsForAppendwithDid := DISTRIBUTE(dsForAppend2(rid <> append_did),HASH(fname, lname, prim_name)); 
	
	base    := DISTRIBUTE(InsuranceHeader_Incremental.Files.dsBase,HASH(fname, lname,prim_name)); 
 
 // add claim number and policy number , gender 

 Changes := JOIN(base,
														 dsForAppendwithDid,
														 LEFT.fname       = RIGHT.fname and
														 LEFT.mname       = RIGHT.mname and
														 LEFT.lname       = RIGHT.lname and
														 LEFT.sname       = RIGHT.sname and
														 LEFT.ssn         = RIGHT.ssn and
														 LEFT.dob         = RIGHT.dob and
														 LEFT.dl_nbr      = RIGHT.dl_nbr and
														 LEFT.dl_state    = RIGHT.dl_state and
														 LEFT.prim_range  = RIGHT.prim_range and
														 //LEFT.predir      = RIGHT.predir and
														 LEFT.prim_name   = RIGHT.prim_name and
														 //LEFT.addr_suffix = RIGHT.addr_suffix and
														// LEFT.postdir     = RIGHT.postdir and
														 LEFT.sec_range   = RIGHT.sec_range and
														// LEFT.city        = RIGHT.city and
														 LEFT.st          = RIGHT.st and
														 LEFT.zip         = RIGHT.zip and 
														 LEFT.POLICY_NUMBER  = RIGHT.POLICY_NUMBER and 
														 LEFT.CLAIM_NUMBER   = RIGHT.CLAIM_NUMBER and 
														 LEFT.gender         = RIGHT.gender and 
														 LEFT.phone          = RIGHT.phone , 
														 TRANSFORM(RECORDOF(Layout_Header_Plus), SELF.DID := RIGHT.append_did , SELF.recchangeType := 7 , SELF:=RIGHT), RIGHT ONLY,LOCAL ) ; 
						
			EXPORT OutData := Changes ; 
						
END; 