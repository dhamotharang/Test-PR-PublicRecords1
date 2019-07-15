IMPORT STD, IDLExternalLinking;
EXPORT NewOnlyBase(DATASET(Layout_Header_Plus) dsIn, STRING versionIn, UNSIGNED timestampIn) := MODULE
	// can use incremental as header
	dsNewOnlyRIDs0 := dsIn(RecChangeType = Constants.RecordChangeType.New);
	// filter the new records from FullInc Ingest got did already through fn_updateDID 
	SHARED dsNewOnlyRIDs := dsNewOnlyRIDs0(rid = did);
	
	currentDate := STD.Date.CurrentDate(TRUE);
	minDateForNew := STD.Date.AdjustDate(currentDate,,,-1*Constants.DaysOldForNew);
	
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
																					outfile,,30,0,,phone);
	
	dsForAppend2 := outfile(append_did = 0);
	
	// using weight 45 and distance 0 with lname removed to get results which may be excluded due to lname
	IDLExternalLinking.mac_xlinking_on_thor(dsForAppend2, 
																					append_did, , , , , gender, derived_gender, 
																					prim_name, prim_range, sec_range, city, st, zip, ssn, dob, dl_state, dl_nbr,,,
																					outfile2,,45,0,,phone);
	
	SHARED dsAllResults := outfile(append_did > 0) + outfile2 : PERSIST(Filenames.Persist_DIDAppend, EXPIRE(30));
	
	SHARED dsNewEntities := dsAllResults(append_did = 0);
	
	// Filter out thin records mostly Claims or policy only data 
	
  Filterpolicy := dsNewEntities(fname<> ''  AND lname <>'' AND (dob <> 0 OR ssn<>'' OR prim_name+prim_range+city+st+zip <>'' OR (dl_state <>'' AND dl_nbr <>''))) ;
 
 	// Match with existing name,address, Getting multiple records with same name and address some records have more info
	
	FilterpolicyNew  := Filterpolicy(append_did = 0 AND prim_name <>'') ; 
	Filterpolicyrest := Filterpolicy(~(append_did = 0 AND prim_name <>'')); 
	
	MatchwithExisting := DEDUP(JOIN(dsAllResults(append_did > 0), FilterpolicyNew ,  
			                             LEFT.fname = RIGHT.fname AND 
																	 LEFT.lname = RIGHT.lname AND 
																	 LEFT.prim_range = RIGHT.prim_range AND
																	 LEFT.prim_name= RIGHT.prim_name AND 
																	 LEFT.sec_range = RIGHT.sec_range AND 
																	 LEFT.st = RIGHT.st AND 
																	 LEFT.zip = RIGHT.zip ,
																	 TRANSFORM({FilterpolicyNew} , SELF := RIGHT),RIGHT ONLY,HASH),all)+Filterpolicyrest ;
																	 
	EXPORT OutData := PROJECT(MatchwithExisting , RECORDOF(dsNewOnlyRIDs_dateFilter));

	dsStats := DATASET([
	                    {WORKUNIT, versionIn, 0, timestampIn, '', 'numRecs_In', COUNT(dsIn), FALSE},
											{WORKUNIT, versionIn, 0, timestampIn, '', 'numRecs_New', COUNT(dsNewOnlyRIDs), FALSE},
											{WORKUNIT, versionIn, 0, timestampIn, '', 'numRecs_New_NewDate', COUNT(dsNewOnlyRIDs_dateFilter), FALSE},
											{WORKUNIT, versionIn, 0, timestampIn, '', 'numRecs_NewEntity', COUNT(dsNewEntities), FALSE}
										 ], Layout_Stats);
	
	EXPORT Stats := dsStats;
	
END;
