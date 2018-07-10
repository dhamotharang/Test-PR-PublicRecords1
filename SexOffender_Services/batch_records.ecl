IMPORT Autokey_batch, Doxie, BatchServices, Suppress,	BatchShare, FCRA, FFD;

/* STRATEGY: Since it appears likely that more than one batch service may make use of 
   SexPredator data, this attribute/module will fetch Offenders and their concomitant
	 Offenses without formatting the layout for any particular service. The service layer
	 shall be responsible for changing the layout of the data to meet the product require-
	 ments. 
	 
	 Document unique identifiers (seisint_primary_key or sspk) shall be found through an
	 Autokey lookup and a header search. I've decided (somewhat arbitrarily) not to provide
	 an option or parameter that will instruct the system to perform a deep dive or avoid it. 
	 
	 The system shall perform record restriction via standard suppression, and it shall and 
	 penalize all matching records.
	 
	 This module/attribute shall provide exportable attributes: 
	 - offenders           
	 - offenders_main_only (based on offenders, whose name_type = '0' (main record?))
	 - offenses 

	 UPDATE (October 2012): Since this attribute only appears to be used by SexOffenderCPS_BatchService 
	 and potentially by Post Beneficiary Fraud Batch Service,
	 I reduced the number of shareds and exports to only export the following 3 attributes:
   - offenders, which corresponds to previous offenders_main_only
   - offenses, which corresponds to previous offenses
	 - records, which is the normalization of offenders and offenses
*/

rec_offender_plus_acctno := SexOffender_Services.Layouts.rec_offender_plus_acctno;

EXPORT batch_records(SexOffender_Services.IParam.Batch_Params configData,
										 DATASET(SexOffender_Services.Layouts.batch_in) ds_batch_in, 
										 BOOLEAN isFCRA = FALSE,
										 DATASET (FFD.Layouts.PersonContextBatch) pc_recs = DATASET ([],FFD.Layouts.PersonContextBatch)
										 ):= MODULE

		ds_batch_in_common 	:= PROJECT(ds_batch_in, Autokey_batch.Layouts.rec_inBatchMaster);		
														 
		// 1. Search via AutoKey	
		fromAK := SexOffender_Services.batch_ids.AutokeyIds(ds_batch_in_common);
		
		// 2. Search via DID and DID Lookup (deepdive)
		fromDID := SexOffender_Services.batch_ids.IdsByDID(ds_batch_in_common, configData.RunDeepDive, isFCRA);
		
		// if isFCRA skip autokey search
		acctNos := IF(isFCRA, fromDID, fromAK + fromDID);
		SHARED acctNos_final := DEDUP(SORT(acctNos, acctno, seisint_primary_key, isDeepDive), acctno, seisint_primary_key);
		
		// Slim down the PersonContext
		SHARED slim_pc_recs := if(isFCRA, FFD.SlimPersonContext(pc_recs));
		
		// overrides for FCRA
		ds_best  := PROJECT(ds_batch_in(did <> 0),TRANSFORM(doxie.layout_best,SELF.did:=LEFT.did, SELF:=[])); //using input to create dataset for getting the flag file (overrides). For FCRA we only use DID to get overrides.
		SHARED ds_flags := IF(isFCRA, FFD.GetFlagFile (ds_best, pc_recs)); //this is for more than one person
	
	  SHARED alert_flags := IF(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, configData.FCRAPurpose, configData.FFDOptionsMask));
	
	  // we need to override 1st bit here to make sure records with statements are flagged correctly
	  // Dempsey Hits filtering is done separately (if needed)
    SHARED FFDOptionsMask_adj := configData.FFDOptionsMask | FFD.Constants.ConsumerOptions.SHOW_CONSUMER_STATEMENTS; 
		
		// 3. Get raw offenders records
		ds_offenders_raw := SexOffender_Services.Raw.batch_view.GetOffendersRecs(acctNos_final, isFCRA, ds_flags, slim_pc_recs, FFDOptionsMask_adj);
		
		// 4. Remove restricted records via DID & SSN pulling and suppression.
		appType := configData.applicationType;	  
    Suppress.MAC_Suppress(ds_offenders_raw,dids_pulled,appType,Suppress.Constants.LinkTypes.DID,did);
    Suppress.MAC_Suppress(dids_pulled,dids_ssns_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn);
    Suppress.MAC_Suppress(dids_ssns_pulled,dids_appended_ssns_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn_appended);

		ds_recs_pulled := JOIN(ds_offenders_raw, dids_appended_ssns_pulled,
														LEFT.acctno = RIGHT.acctno,
														TRANSFORM(LEFT),
														LEFT ONLY);
		
		//offenders that were not pulled
		ds_offenders_pre := JOIN(ds_offenders_raw, DEDUP(SORT(ds_recs_pulled, seisint_primary_key), seisint_primary_key),
																 LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
																 TRANSFORM(LEFT),
																 LEFT ONLY);
																					 
    SHARED ds_offenders := IF(IsFCRA, FFD.Mac.ApplyConsumerAlertsBatch(ds_offenders_pre, alert_flags, StatementIds, SexOffender_Services.Layouts.rec_offender_plus_acctno, configData.FFDOptionsMask),
	                            ds_offenders_pre);
		// 5. Penalize offenders.	
		ds_batch_in_undrscr := PROJECT(ds_batch_in, BatchServices.transforms.SexOffenderCPS.xfm_prepend_underscore(LEFT));	
		ds_offenders_with_penalty := JOIN(ds_batch_in_undrscr, ds_offenders, 
		                                  LEFT.acctno = RIGHT.acctno,
													            TRANSFORM(rec_offender_plus_acctno,
													                      SELF.penalt := if(isFCRA, 0, SexOffender_Services.Functions.penalize_offender(LEFT,RIGHT)),
		                                            SELF        := RIGHT));
																											 
		EXPORT offenders           := ds_offenders_with_penalty(name_type='0');	// We shall assume that each Offender has a name_type = '0'.	
		
		// 6. Get Offenses/Convictions using found offenders seising_primary key.
		ds_acctnos_sspks := PROJECT(ds_offenders, SexOffender_Services.Layouts.lookup_id_rec);
		ds_acctnos_sspks_deduped := DEDUP(SORT(ds_acctnos_sspks, acctno, seisint_primary_key), acctno, seisint_primary_key); //TODO: check if this is needed...	
	  ds_offenses := SexOffender_Services.Raw.batch_view.GetOffensesRecs(ds_acctnos_sspks_deduped, isFCRA, ds_flags, slim_pc_recs, FFDOptionsMask_adj);
		
		// 7. Expose exportable attributes.
	
		EXPORT offenses            := SORT(ds_offenses, acctno, seisint_primary_key, -conviction_date);
		
		// 8. Format to batch service output
	
		offenders_slim := PROJECT(offenders, BatchServices.transforms.SexOffenderCPS.xfm_slim_offenders(LEFT));
		
		ds_records := DENORMALIZE( offenders_slim, offenses, 
																	 LEFT.acctno = RIGHT.acctno AND
																	 LEFT.seisint_primary_key = RIGHT.seisint_primary_key,
																	 SexOffender_Services.batch_make_flat(LEFT, RIGHT, COUNTER) );	
 
    ds_records_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(ds_records, alert_flags, Statements, SexOffender_Services.Layouts.batch_out_pre, configData.FFDOptionsMask);
	                            
	  // add resolved LexId to the results for inquiry history logging support                    
    ds_out_fcra := FFD.Mac.InquiryLexidBatch(ds_batch_in, ds_records_with_alerts, SexOffender_Services.Layouts.batch_out_pre, 0);
  
    ds_records_out := IF(IsFCRA, ds_out_fcra, ds_records);
    
		//	sequence the records								 
		SHARED sequenced_out := PROJECT(ds_records_out, TRANSFORM(SexOffender_Services.Layouts.batch_out_pre, SELF.SequenceNumber := COUNTER, SELF := LEFT));
		EXPORT records := 	PROJECT(sequenced_out, SexOffender_Services.Layouts.batch_out);			// projecting to batch layout
		
		// get statements 
	  sd_out := NORMALIZE(sequenced_out, LEFT.Statements, TRANSFORM (FFD.Layouts.ConsumerStatementBatch, 
																								 SELF.Acctno := LEFT.Acctno,
																								 SELF.SequenceNumber := LEFT.SequenceNumber,
																								 SELF := RIGHT));
																								 
		consumer_statements  := IF(isFCRA, FFD.prepareConsumerStatementsBatch(sd_out, pc_recs, configData.FFDOptionsMask));  // FCRA FFD statements
    consumer_alerts  := IF(IsFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, configData.FFDOptionsMask));                                               
    consumer_statements_alerts := consumer_statements + consumer_alerts;

		EXPORT FFD_Statements := consumer_statements_alerts;  // FCRA FFD statements
					 
END;
