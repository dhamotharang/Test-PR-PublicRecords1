IMPORT _Control, iesp;

	MAC_read_override_base('Gong', GongRecIDs, flag_file_id, l_did, persistent_record_id);
	ds_input := GongRecIDs;

	service_name	:= 'ConsumerDisclosure.FCRADataService';
	serviceURL		:= _Control.RoxieEnv.staging_fcra_roxieIP ;

	nodes			:= 50;
	threads		:= 2;
	layout_in   	:= iesp.fcradataservice.t_FcraDataServiceRequest;
	layout_out  := iesp.fcradataservice.t_FcraDataServiceReportResponse;

	layoutSoap := RECORD
		DATASET(layout_in) fcradataservicerequest;
	end;

	layout_in make_child_ds(ds_input L) := TRANSFORM
		SELF.Options.ReturnSuppressedRECORDs := true;
		SELF.Options.ReturnOverwrittenRECORDs := true;
		SELF.Options.DATASETSelection.Includeall:= true;
		SELF.ReportBy.lexid := L.did;
		SELF := L;
		SELF := [];
	END;

	layoutSoap trans(ds_input L) := TRANSFORM
		request := PROJECT(L, make_child_ds(LEFT));
		SELF.fcradataservicerequest := request;
		SELF := L;
	END;

	soap_input := DISTRIBUTE(PROJECT(DEDUP(SORT(ds_input, did), did), trans(LEFT)), RANDOM() % nodes);

	xlayout := RECORD
		layout_out;
		STRING errorcode;
	END;

	xlayout myFail(soap_input le) := TRANSFORM
		SELF.errorcode := FAILCODE + '  ' + FAILMESSAGE;
		SELF := [];
	END;

	soapResponse := SOAPCALL( soap_input,
							serviceURL,
							service_name,
							{soap_input},
							DATASET(xlayout),
							PARALLEL(threads),
							onFail(myFail(LEFT))
							):INDEPENDENT;

	Mac_Norm(DsIn,DsOut, rec):= MACRO
		DsOut	:=	NORMALIZE(soapResponse, LEFT.results.DsIn
								,TRANSFORM(iesp.fcradataservice.rec					
								,SELF:=RIGHT
								,SELF:=[]
							));
	ENDMACRO;

	Mac_Norm(Gong, OutGong, t_FcraDataServiceGongData);

	dNorm 	:= OutGong;
	dNorm1	:= dNorm(Metadata.ComplianceFlags.IsSuppressed  OR Metadata.ComplianceFlags.IsOverride  OR Metadata.ComplianceFlags.IsOverwritten);
	dNorm1;

	dsOut := TABLE(dNorm1, {Datagroup := Metadata.Datagroup
												,Did := Metadata.lexid
												,RecID :=TRIM(Metadata.RecID.RecID1)
																+	TRIM(Metadata.RecID.RecID2)
																+	TRIM(Metadata.RecID.RecID3)
																+	TRIM(Metadata.RecID.RecID4)
												,IsSuppressed:= MAX(GROUP, Metadata.ComplianceFlags.IsSuppressed)
												,IsOverride := MAX(GROUP, Metadata.ComplianceFlags.IsOverride)
												,IsOverwritten := MAX(GROUP, Metadata.ComplianceFlags.IsOverwritten)
												,fname := Rawdata.name_first
												,lname := Rawdata.name_last
												,prim_range := Rawdata.prim_range
												,prim_name := Rawdata.prim_name
												,zip := Rawdata.z5
												}
										,Metadata.Datagroup
										,Metadata.lexid
										,TRIM(Metadata.RecID.RecID1)+TRIM(Metadata.RecID.RecID2)+TRIM(Metadata.RecID.RecID3)+TRIM(Metadata.RecID.RecID4)
										,MERGE):INDEPENDENT;

	dsOut_candidates:= DEDUP(dsOut(IsOverride and ~IsOverwritten), all);

	orphans_ds := dsOut_candidates;
	OUTPUT(SORT(orphans_ds, did), NAMED('orphans_ds'));
	
	// evaluate
	overrides.mac_orphans_evaluate(gong,'gong',orphans_ds,dsout_gong,,did,persistent_record_id,,,,name_first,name_last,prim_range, prim_name, z5);
	
	OUTPUT(SORT(dsout_gong(recid != '0'),did), NAMED('evaluate'));	

	// get the did and recid from orphan_ds
	orphan_did_set := SET(orphans_ds(recid != '0'), (UNSIGNED)did);

	// JOIN keys on did and recid 
	overrides_keys := PULL(overrides.Keys.gong(did IN orphan_did_set));
	payload_keys := PULL(overrides.payload_keys.gong(l_did IN orphan_did_set));

	overrides_keys_ds := PROJECT(overrides_keys, TRANSFORM(fcra.Layout_Override_Gong OR {STRING version},
																							SELF.version := 'keys',
																							SELF := LEFT));
	payload_keys_ds := PROJECT(payload_keys, TRANSFORM(fcra.Layout_Override_Gong OR {STRING version},
																							SELF.version := 'payload_keys',
																							SELF.flag_file_id := '';
																							SELF := LEFT));
	cmb_keys_ds := SORT(overrides_keys_ds + payload_keys_ds, RECORD);

	//OUTPUT(cmb_keys_ds, NAMED('cmb_keys_ds'));


	RECORDOf(cmb_keys_ds) xform(cmb_keys_ds l) := TRANSFORM
		SELF.version := 'both';
		SELF := l;
	End;
				

	cmb_keys_ds_dist_with := DISTRIBUTE(cmb_keys_ds, HASH(did, persistent_record_id, src, name_first, name_last, prim_range, prim_name, z5));
	rolled_with := ROLLUP(cmb_keys_ds_dist_with, xform(LEFT), did, persistent_record_id, src, name_first, name_last, prim_range, prim_name, z5, local);
	/*
		OUTPUT(count(rolled_with), NAMED('cnt_rolled_with'));
		OUTPUT(count(rolled_with(version='both')), NAMED('cnt_matching_with'));
		OUTPUT(count(rolled_with(version='keys')), NAMED('cnt_overrides_only_with'));
		OUTPUT(count(rolled_with(version='payload_keys')), NAMED('cnt_payload_only_with'));	
												
		OUTPUT(SORT(rolled_with(version='keys'),did) , NAMED('overrides_only_with'));
		OUTPUT(SORT(rolled_with(version='payload_keys'),did), NAMED('payload_only_with'));	
		OUTPUT(SORT(rolled_with(version='both'),did), NAMED('both_only_with'));	
	*/
	overrides_rolled := rolled_with(version='keys');
	payloads_rolled := rolled_with(version='payload_keys');

	//overrides_rolled_DEDUP := DEDUP(SORT(overrides_rolled, did, persistent_record_id), did, persistent_record_id);
	//payloads_rolled_DEDUP := DEDUP(SORT(payloads_rolled, did, persistent_record_id), did, persistent_record_id);

	diff_layout := RECORD
		INTEGER did; 
		STRING payload_version;
		STRING override_version;
		INTEGER payload_persistent_record_id;
		INTEGER override_persistent_record_id;
		STRING payload_src;
		STRING override_src;
		STRING payload_name_first;
		STRING override_name_first;
		STRING payload_name_last;
		STRING override_name_last;
		STRING payload_prim_range;
		STRING override_prim_range;
		STRING payload_prim_name;
		STRING override_prim_name;
		STRING payload_z5;
		STRING override_z5;
		STRING diff_fields;
	End;

	diff_layout xform_diff(payloads_rolled l, overrides_rolled r) := TRANSFORM
		SELF.did :=  l.did;
		SELF.payload_version := l.version;
		SELF.payload_persistent_record_id := l.persistent_record_id;
		SELF.payload_src := l.src;
		SELF.payload_name_first := l.name_first;	
		SELF.payload_name_last := l.name_last;
		SELF.payload_prim_range := l.prim_range;
		SELF.payload_prim_name := l.prim_name;
		SELF.payload_z5 := l.z5;
		SELF.override_version := r.version;	
		SELF.override_persistent_record_id := r.persistent_record_id;
		SELF.override_src := r.src;
		SELF.override_name_first := r.name_first;	
		SELF.override_name_last := r.name_last;
		SELF.override_prim_range := r.prim_range;
		SELF.override_prim_name := r.prim_name;
		SELF.override_z5 := r.z5;	
		SELF.diff_fields := ROWDIFF(L,R);
	END;

	joined_did := JOIN(payloads_rolled, overrides_rolled, 
							LEFT.did = RIGHT.did, xform_diff(LEFT,RIGHT));
			
	// PID list
	orphan_pid_set := SET(orphans_ds(recid != '0'), (UNSIGNED)recid);

	// JOIN keys on did and recid 
	overrides_pid_keys 	:= PULL(overrides.Keys.gong(persistent_record_id IN orphan_pid_set));
	payload_pid_keys 		:= PULL(overrides.payload_keys.gong(persistent_record_id IN orphan_pid_set));

	overrides_pid_ds := PROJECT(overrides_pid_keys, TRANSFORM(fcra.Layout_Override_Gong OR {STRING version},
																						SELF.version := 'keys',
																						SELF := LEFT));
	payload_pid_ds := PROJECT(payload_pid_keys, TRANSFORM(fcra.Layout_Override_Gong OR {STRING version},
																						SELF.version := 'payload_keys',
																						SELF.flag_file_id := '';
																						SELF := LEFT));
	cmb_pid_ds := SORT(overrides_pid_ds + payload_pid_ds, RECORD);
			
	cmb_pid_ds_dist_with := DISTRIBUTE(cmb_pid_ds, HASH(did, persistent_record_id, src, name_first, name_last, prim_range, prim_name, z5));
	rolled_pid_with := ROLLUP(cmb_pid_ds_dist_with, xform(LEFT), did, persistent_record_id, src, name_first, name_last, prim_range, prim_name, z5, LOCAL);

	overrides_rolled_pid := rolled_pid_with(version='keys');
	payloads_rolled_pid := rolled_pid_with(version='payload_keys');

	joined_pid := JOIN(payloads_rolled_pid, overrides_rolled_pid, 
									LEFT.persistent_record_id = RIGHT.persistent_record_id, xform_diff(LEFT,RIGHT));
								
	combined_ds := joined_did + joined_pid;

	orphan_layout := RECORD
		overrides_rolled;
		STRING datagroup;
		STRING recid;
		BOOLEAN found_in_payload;
		STRING diff;
	END;

	orphan_layout orphan_xform(combined_ds  le, overrides_rolled re) := TRANSFORM
	   SELF.datagroup := overrides.Constants.getfileid(overrides.Constants.GONG);
		SELF.diff := le.diff_fields;
		SELF.recid := (STRING) re.persistent_record_id;
		SELF.found_in_payload := FALSE;
		SELF := re;
	END;

	total_orphans := JOIN(combined_ds, overrides_rolled, LEFT.did = RIGHT.did, orphan_xform(LEFT, RIGHT), RIGHT ONLY);
															 
	OUTPUT(total_orphans, NAMED('total_orphans'));														 
	OUTPUT(joined_did, NAMED('matched_dids'));
	OUTPUT(joined_pid, NAMED('matched_persistent_record_id'));
	
   // Loop thru each orphan and check if exist in payload keys by name, prim_range, prim_name, z5, did or recid.
	 // if exist it is not termed as a true_orphan 
	
   //payload_name_ds := overrides.payload_keys.gong(listed_name IN () );	
   
	did_set :=  SET(total_orphans, did); 
	recid_set :=  SET(total_orphans, persistent_record_id); 
	
	name_set := SET(total_orphans(listed_name <> ''), listed_name);
	prim_name_set := SET(total_orphans(prim_name <> ''), prim_name);
	prim_range_set := SET(total_orphans(prim_range <> ''), prim_range);
	z5_set := SET(total_orphans(z5 <> ''), z5); 
	
  payload_did_ds := PULL(overrides.payload_keys.gong(did IN did_set));	  	
  payload_recid_ds := PULL(overrides.payload_keys.gong(persistent_record_id IN recid_set));		
  
  payload_name_ds := overrides.payload_keys.gong(listed_name IN name_set);
  payload_prim_name_ds := overrides.payload_keys.gong(prim_name IN prim_name_set);
  payload_prim_range_ds := overrides.payload_keys.gong(prim_range IN prim_range_set);	
  payload_z5_ds := overrides.payload_keys.gong(z5 IN z5_set);
 

  payload_comb_ds := payload_name_ds + payload_prim_name_ds + payload_prim_range_ds + payload_z5_ds;
	
  payload_name_ds xform_payload(payload_name_ds L) := TRANSFORM
		SELF := L;
  END;
  
	payload_pii_ds := ROLLUP(payload_name_ds,  xform_payload(LEFT), listed_name, prim_name, prim_range, z5, LOCAL);
  
  
   //OUTPUT(payload_did_ds, NAMED('payload_did_ds_PULL'));	
   //OUTPUT(payload_recid_ds, NAMED('payload_recid_ds_PULL'));		
  //OUTPUT(payload_pii_ds, NAMED('payload_pii_ds_PULL'));
	
  //OUTPUT(COUNT(payload_pii_ds), NAMED('COUNT_payload_pii_ds_PULL'));

  orphan_layout  PayloadCheck(total_orphans l) := TRANSFORM
     		
		payload_name_count_ds :=  payload_pii_ds(listed_name = l.listed_name,  prim_range = l.prim_name,
																			   prim_name = l.prim_name,  z5 = l.z5);		
		payload_did_count_ds :=  payload_did_ds(did IN [l.did, l.persistent_record_id]);
		payload_recid_count_ds := payload_recid_ds(persistent_record_id IN [l.did, l.persistent_record_id]);
		 //   
		SELF.found_in_payload :=  IF (COUNT(payload_name_count_ds) > 0 OR COUNT(payload_did_count_ds) > 0 OR COUNT(payload_recid_count_ds) > 0, TRUE, FALSE);  
		SELF := l;
	END;

	total_orphans_checked := PROJECT(total_orphans, PayloadCheck(LEFT));
   
	true_orphans := total_orphans_checked(found_in_payload = FALSE);
	
	OUTPUT(true_orphans, NAMED('true_orphans'));														 
	// test one true orphan check by name
	/*	
		OUTPUT(overrides.payload_keys.gong(listed_name = 'CHRISTOPHIDES LOUIS'), NAMED('payload_test'));
		OUTPUT(overrides.payload_keys.gong(did IN [446083144, 929421213039]), NAMED('Payload_Keys_Gong_DID_446083144'));
		OUTPUT(overrides.payload_keys.gong(persistent_record_id IN [929421213039, 446083144]), NAMED('Payload_Keys_Gong_RECID_446083144'));
	*/

	//OUTPUT(overrides.payload_keys.gong(did IN [754179542, 929495453487]), NAMED('Payload_Keys_Gong_DID_754179542'));
	//OUTPUT(overrides.payload_keys.gong(persistent_record_id IN [754179542, 929495453487]), NAMED('Payload_Keys_Gong_RECID_754179542'));
	
	EXPORT Gong_Override_Findings := true_orphans;	

