import doxie, marriage_divorce_v2_Services, BatchServices, marriage_divorce_v2, Autokey_batch, AutokeyB2, FCRA,FFD,ut,STD;

// md := marriage_divorce_v2_Services;

export batch_records (marriage_divorce_v2_Services.input.batch_params configData, 
                      dataset(marriage_divorce_v2_Services.layouts.batch_in) clean_in, 
                      boolean isFCRA = false)  := FUNCTION
											
  // -------- Fetch IDs --------
  // Non-FCRA: search by autokeys
	ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
			export UseAllLookUps := TRUE;
			export skip_set := Marriage_Divorce_v2.Constants('').ak_skipSet;
	END;
							 
  //ak input 												 
  ak_input := PROJECT (clean_in, Autokey_batch.Layouts.rec_inBatchMaster);
								
  //**** GET FAKEIDS - FLAPD SEARCH
	ak_key := Marriage_Divorce_v2.Constants('').ak_keyname;
  ak_out := Autokey_batch.get_fids(ak_input, ak_key, ak_config_data);

	outpl_rec := marriage_divorce_v2.file_searchautokey;
	AutokeyB2.mac_get_payload(ak_out,ak_key,outpl_rec, outpl,did,zero,'BC');

  // intermediate record: raw function doesn't preserve account numbers, so we would need to join
  // raw results back to the batch IDS-search dataset.
  // On non-FCRA side this join will be accomplished by record_id, on FCRA -- by DID
	rec_acct := RECORD
	  marriage_divorce_v2_Services.layouts.batch_in.acctno;
	  marriage_divorce_v2_Services.layouts.batch_in.did;   // will be blank on non-FCRA usage
	  marriage_divorce_v2_Services.layouts.l_id.record_id; // will be blank on FCRA-side
	END;
	ids_acctno_ak := DEDUP (SORT (project(ungroup(outpl), rec_acct), acctno, record_id), acctno, record_id);

  // Non-FCRA: further dedup -- don't need anything but record_ids
	ids_ak := DEDUP (SORT (project (ids_acctno_ak, marriage_divorce_v2_Services.layouts.expanded_id), record_id), record_id);

  // FCRA: fetch by DID	only
  fcra_dids := clean_in (did != 0);
  ids_fcra := marriage_divorce_v2_Services.MDRaw.get_id_from_did (project (fcra_dids, doxie.layout_references), IsFCRA);

  // finally, IDs:
  ids := if (IsFCRA, ids_fcra, ids_ak);

  // dataset we will link raw data back to:
	ids_acctno := if (IsFCRA, 
                    project (fcra_dids, transform (rec_acct, Self.record_id := 0, Self := Left)),
                    ids_acctno_ak);


  // -------- get row records --------
	//FCRA FFD  	
	pc_dids := project(fcra_dids, FFD.Layouts.DidBatch); 
	
	pc_recs := if(isFCRA, FFD.FetchPersonContext(pc_dids, configData.gateways, FFD.Constants.DataGroupSet.Marriage_Divorce, configData.FFDOptionsMask));
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	
  ds_best := project(fcra_dids,transform(doxie.layout_best,self.did:=left.did,self:=[]));
  ds_flags := FFD.GetFlagFile (ds_best, pc_recs);

	alert_flags := FFD.ConsumerFlag.getAlertIndicators(pc_recs, configData.FCRAPurpose, configData.FFDOptionsMask);
	
	// we need to override 1st bit here to make sure records with statements are flagged correctly
	// Dempsey Hits filtering is done separately (if needed)
  FFDOptionsMask_adj := configData.FFDOptionsMask | FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS;  
	ds_raw := marriage_divorce_v2_Services.MDRaw.batch_view.by_id (ids, configData.non_subject_suppression, 
																																 IsFCRA, ds_flags, slim_pc_recs, FFDOptionsMask_adj);

	
	// -------- reattach acctno and add Filing Type --------
  f_filling_type (string1 ftype) := map (ftype = '3' => 'M',
                                         ftype = '7' => 'D',
                                         '');
  
  marriage_divorce_v2_Services.layouts.batch_out_pre SetFilingType (rec_acct L, ds_raw R) := transform
    Self.acctno := L.acctno;
		Self.record_id := (string) R.record_id; // can be blank on the left side (for FCRA)
    Self.output_type := f_filling_type (R.Filing_type);
		Self := R;
  end;
  // Non-FCRA: attach by record ID
	raw_acctno := JOIN (ids_acctno, ds_raw,
	                    (String12)Left.record_id = Right.record_id,
                      SetFilingType (Left, Right),
                      keep (1), limit (0));

  // FCRA: "same" join, just by DID	
	raw_acctno_fcra := JOIN (ids_acctno, ds_raw,
	                         Left.did = Right.search_did,
                           SetFilingType (Left, Right),
                           keep (ut.limits.MARRIAGEDIVORCE_PER_DID), limit (0)); //TODO: limit

  out_acctno := if (IsFCRA, raw_acctno_fcra, raw_acctno);
  
  
	// -------- transform to final layout filtering by filing dates, if provided in the input --------
	match_dates(string input_dt,string db_dt) := function
	  formatted_input_dt := STD.Str.FilterOut(TRIM(input_dt), '/');
		source := formatted_input_dt[1..length(formatted_input_dt)-length(formatted_input_dt)%2] ;
		mc := STD.Str.Find(TRIM(db_dt),source,1) >0
		      OR STD.Str.Find(TRIM(db_dt),source[1..4],1) >0 ;
		RETURN mc;
	ENd;
	
  marriage_divorce_v2_Services.layouts.batch_out_pre FilterByDate (marriage_divorce_v2_Services.layouts.batch_out_pre L, clean_in R ) := transform, 
    SKIP ((R.filling_date[4]<>'') and 
           ~(match_dates (R.filling_date, L.marriage_dt) or match_dates (R.filling_date, L.divorce_dt)))			 
    Self := L;
  end;

	filtered_out := JOIN (out_acctno, clean_in,
												 LEFT.acctno = RIGHT.acctno,
												 FilterByDate (Left, Right),
												 keep (1), limit (0));
											  
  out_fcra_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(filtered_out, alert_flags, Statements, Marriage_divorce_v2_Services.Layouts.batch_out_pre,configData.FFDOptionsMask);
	                            
	// add resolved LexId to the results for inquiry history logging support                    
  ds_out_fcra := FFD.Mac.InquiryLexidBatch(clean_in, out_fcra_with_alerts, Marriage_divorce_v2_Services.Layouts.batch_out_pre, 0);
  
  recs_fltr_with_alerts := IF(IsFCRA, ds_out_fcra, filtered_out);

	sequenced_out := PROJECT(recs_fltr_with_alerts, TRANSFORM(marriage_divorce_v2_Services.layouts.batch_out_pre, SELF.SequenceNumber := COUNTER, SELF := LEFT));
	recs_out := PROJECT(sequenced_out, Marriage_divorce_v2_Services.layouts.batch_out);	
	
	consumer_statements := NORMALIZE(sequenced_out, LEFT.Statements, 
		TRANSFORM(FFD.Layouts.ConsumerStatementBatch, 
		  SELF.Acctno := LEFT.Acctno,
			SELF.SequenceNumber := LEFT.SequenceNumber,
			SELF := RIGHT));
			
	// append the actual contents of each consumer statement		
	consumer_statements_prep := IF(IsFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, configData.FFDOptionsMask));	
  consumer_alerts  := IF(IsFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, configData.FFDOptionsMask));                                               
  consumer_statements_alerts := consumer_statements_prep + consumer_alerts;
	
	// store both records and statements under a single record structure
	FFD.MAC.PrepareResultRecordBatch(recs_out, record_out, consumer_statements_alerts, marriage_divorce_v2_Services.layouts.batch_out);		
	RETURN record_out;

end;