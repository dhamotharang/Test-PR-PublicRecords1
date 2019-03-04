import faa, BatchServices, Autokey_batch, AutokeyB2, doxie, doxie_raw, FCRA, BIPV2, FFD;

EXPORT batch_records (FaaV2_Services.IParam.BatchParams params, 
                      dataset(FaaV2_Services.layouts.batch_in) clean_in, 
                      boolean isFCRA = false)  := FUNCTION

  // slim record: account + DID/BDID (local: don't need it elsewhere)
  id_rec := RECORD
    doxie.layout_inBatchMaster.acctno;
    doxie.layout_references;
    doxie.layout_ref_bdid;
  END;

  //**** GET FAKEIDS - FLAPD SEARCH
  ak_config_data := MODULE(BatchServices.Interfaces.i_AK_Config)
      export UseAllLookUps := TRUE;
      export skip_set := faa.faa_autokey_constants().ak_skipSet;
  END;
  //**** GET FAKEIDS - FLAPD SEARCH
  ak_key := faa.faa_autokey_constants().str_autokeyname;
  ak_out := Autokey_batch.get_fids(project (clean_in, Autokey_batch.Layouts.rec_inBatchMaster), ak_key,ak_config_data);
  ak_dataset := faa.faa_autokey_constants().ak_dataset;
  outpl_rec :=dataset([],recordof(ak_dataset));
  
  //**** GET bdids and dids
  AutokeyB2.mac_get_payload (ak_out, ak_key, outpl_rec, outpl1, did_out, bdid_out);
  outpl:= ungroup(outpl1);
  // Slim down to just accounts and DIDs/BDIDs
  outpl_did := PROJECT (outpl(did_out>0), transform (id_rec, SELF.did := Left.did_out, SELF := Left));
  outpl_bdid := PROJECT (outpl(bdid_out>0), transform (id_rec,SELF.bdid := Left.bdid_out,SELF := Left, Self.did := 0));

  //**** IDS with ACCTNO
  dids_acctno := DEDUP (SORT (outpl_did, acctno,did), acctno, did);
  bdids_acctno := DEDUP (SORT (outpl_bdid, acctno,bdid), acctno, bdid);
  
  // Slim it down further -- to get just DIDS and BDIDS
  // On FCRA side only DIDs are used, and are taken from the input
  faa_dids  := if (IsFCRA,
                   project (clean_in (did != 0), doxie.layout_references),
                   DEDUP (SORT (PROJECT (dids_acctno, doxie.layout_references), did), did));
  faa_bdids := if (IsFCRA, 
                   dataset ([], doxie.layout_ref_bdid),
                   DEDUP (SORT (PROJECT (bdids_acctno, doxie.layout_ref_bdid), bdid), bdid));

	faa_linkids := if(~IsFCRA,PROJECT(clean_in(ultid != 0),transform(BIPV2.IDlayouts.l_xlink_ids2,SELF := LEFT)));
									
 
	// FFD				  
	dids := PROJECT(clean_in(did>0), FFD.Layouts.DidBatch); 

	pc_recs := IF(isFCRA, FFD.FetchPersonContext(dids, params.gateways, FFD.Constants.DataGroupSet.Aircraft, params.FFDOptionsMask));

	alert_flags := if(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, params.FCRAPurpose, params.FFDOptionsMask));
	
	// corrections (FCRA side only)
	ds_best  := project (clean_in, transform (doxie.layout_best, self.did:=left.did, self:=[])); //using input to create dataset for getting the flag file (overrides). For FCRA we only use DID to get overrides.
	ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs)); //this is for more than one person 
 
	slim_pc_recs := FFD.SlimPersonContext(pc_recs);
	
	//at RAW we need for FCRA to get all statemetIds disregarding input FFDOptionsMask 1st bit 
	// filtering of Dempsey hits if needed is addressed later in the code
	FFDOptionsMask_adj := if(isFCRA,params.FFDOptionsMask | FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS, params.FFDOptionsMask);

  //**** RAW FUNCTION
  // We might not have the problem with concurrent corrections as with, for example, watercrafts,
  // since aircrafts corections are fetched by 'aircraft_id', which is not shared among different DIDs
  faa_res := Doxie_Raw.AirCraft_Raw (
               faa_dids, faa_bdids,
               0, params.dppa, params.glb, params.ssn_mask, params.application_type, //0 == dateval
               IsFCRA, ds_flags,
							 faa_linkids,params.BIPFetchLevel, slim_pc_recs, FFDOptionsMask_adj);

  //**** BATCH FUNCTION
  batch_res := FaaV2_Services.Transforms.Batch_View.out_Layout(faa_res, params.BIPFetchLevel);
  
	
  //**** JOINING BACK ACCOUNT NUMBER
  out := JOIN(dids_acctno,batch_res(source=FaaV2_Services.Constants.autokey_src),LEFT.did = (unsigned6)RIGHT.did_out) +
         JOIN(bdids_acctno,batch_res(source=FaaV2_Services.Constants.autokey_src),LEFT.bdid = (unsigned6)RIGHT.bdid_out);

	// Add acctno back to linkid fetched results.
	out_link := JOIN(batch_res(source=FaaV2_Services.Constants.linkid_src),clean_in(ultid <>0),
											LEFT.UltID = RIGHT.UltID AND
											(LEFT.OrgID = RIGHT.OrgID OR params.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_OrgID) AND
											(LEFT.SeleID = RIGHT.SeleID OR params.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_SELEID) AND
											(LEFT.ProxID = RIGHT.ProxID OR params.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_ProxID) AND
											(LEFT.PowID = RIGHT.PowID OR params.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_PowID) AND
											(LEFT.EmpID = RIGHT.EmpID OR params.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_EmpID) AND
											(LEFT.DotID = RIGHT.ProxID OR params.BIPFetchLevel IN BIPV2.IDconstants.Set_Fetch_Level_Above_DotID),
											TRANSFORM(RECORDOF(out),
																		SELF.acctno := Right.acctno, 
																		SELF := LEFT,
																		SELF := RIGHT));
																		
  // on FCRA side account number can be taken from the input
  out_fcra := JOIN (clean_in (did != 0), batch_res(source=FaaV2_Services.Constants.autokey_src),
                    Left.did = (unsigned6)Right.did_out,
                    transform (FaaV2_Services.Layouts.batch_out_pre, 
                               Self.acctno := Left.acctno, Self := Right));
	
	// Combine autokey and linkid results
	out_all := SORT(out + out_link,acctno);
	
	ds_out_all := PROJECT(out_all, FaaV2_Services.Layouts.batch_out_pre);
  
	// data maybe suppressed due to alerts
	out_fcra_with_alerts := IF(isFCRA, FFD.Mac.ApplyConsumerAlertsBatch(out_fcra, alert_flags, Statements, FaaV2_Services.Layouts.batch_out_pre, params.FFDOptionsMask));

	// add resolved LexId to the results for inquiry history logging support                    
  ds_out_fcra := FFD.Mac.InquiryLexidBatch(clean_in, out_fcra_with_alerts, FaaV2_Services.Layouts.batch_out_pre, 0);

	//Sequencing the Records
	FaaV2_Services.Layouts.batch_out_pre sequenceIt(FaaV2_Services.Layouts.batch_out_pre L , INTEGER C):=  TRANSFORM
			SELF.SequenceNumber :=  C;
			SELF :=  L;
	END; 
	
	sequenced_out_fcra := PROJECT(ds_out_fcra, sequenceIt(LEFT,COUNTER)); // FCRA
	sequenced_out := PROJECT(ds_out_all, sequenceIt(LEFT,COUNTER)); //NON-FCRA
	
	consumer_statements := NORMALIZE(sequenced_out_fcra, LEFT.Statements, 
		TRANSFORM (FFD.Layouts.ConsumerStatementBatch,
							 self.SequenceNumber := left.SequenceNumber,
							 self.acctno := left.acctno,
							 self := right));	
	
	consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, params.FFDOptionsMask));
 consumer_alerts  := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, params.FFDOptionsMask));                                               
 consumer_statements_alerts := consumer_statements_prep + consumer_alerts;
	
	final_recs := if (IsFCRA, sequenced_out_fcra, sequenced_out);
	final_recs_out := PROJECT(final_recs, FaaV2_Services.Layouts.batch_out);	
	
	FFD.MAC.PrepareResultRecordBatch(final_recs_out, record_out, consumer_statements_alerts, FaaV2_Services.Layouts.batch_out);	
		
	RETURN record_out;
END;    

 