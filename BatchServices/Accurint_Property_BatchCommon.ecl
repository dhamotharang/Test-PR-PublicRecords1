IMPORT AutokeyB2_batch, BatchServices, FFD, FCRA, LN_PropertyV2_Services, LN_PropertyV2, BatchShare, Gateway, ut, STD;

EXPORT Accurint_Property_BatchCommon(boolean isFCRA, unsigned1 nss, boolean useCannedRecs) := FUNCTION
    /* ******************************************* SET-UP ****************************************** */
    
    #OPTION('optimizeProjects', TRUE);
    
    // Constants.
    
    TOO_MANY_MATCHES              := AutokeyB2_batch.Constants.FAILED_TOO_MANY_MATCHES;    
    OTHERWISE_DISPLAY_NO_PENALTY  := 0;
    // Locals.

    BOOLEAN formatted_values := FALSE : STORED('Return_Formatted_Values');
    INTEGER max_results_per_acct    := 20    : STORED('Max_Results_Per_Acct');
    
    BOOLEAN return_current_only     := FALSE : STORED('Return_Current_Only');
    
    BOOLEAN nameMatch_value :=    FALSE :STORED('Match_Name');
    BOOLEAN streetAddressMatch_value := FALSE :STORED('Match_Street_Address');
    BOOLEAN stateMatch_value :=   FALSE :STORED('Match_State');
    BOOLEAN cityMatch_value :=    FALSE :STORED('Match_City');
    BOOLEAN zipMatch_value :=     FALSE :STORED('Match_Zip');
    BOOLEAN dobMatch_value :=     FALSE :STORED('Match_DOB');
    BOOLEAN ssnMatch_value :=     FALSE :STORED('Match_SSN');
    BOOLEAN didMatch_value :=     FALSE :STORED('Match_LinkID');
    
    UNSIGNED PARTY_TYPE := BatchServices.Functions.LN_Property.return_party_types;
    
    // Not very graceful, but it works on all Roxie platforms.
    SET OF STRING record_types := BatchServices.Functions.LN_Property.return_record_types;
                                         
    /* ********************************** OBTAIN PROPERTY RECORDS ********************************* */
    
    rec1 := LN_PropertyV2_Services.layouts.batch_in;

    ds_xml_in    := DATASET([], rec1) : STORED('batch_in', FEW);
  
    // 2. Grab the input XML and throw into a dataset.  
    ds_in := IF( NOT useCannedRecs, 
                       ds_xml_in, 
                       project(BatchServices._Sample_inBatchMaster('Property'), rec1) 
                     );

     BatchShare.MAC_SequenceInput(ds_in, ds_sequenced);
    BatchShare.MAC_CapitalizeInput(ds_sequenced, ds_batch_in);
    
    gw_config := Gateway.Configuration.Get();
    // common batch settings, including a gateway to a remote Picklist
    batch_params := module (BatchShare.IParam.getBatchParamsV2())
      export dataset (Gateway.layouts.config) gateways := gw_config;
      export integer1 non_subject_suppression := nss;
    end;
                     
    // append DID (a soap call to Picklist service
    BatchShare.MAC_AppendPicklistDID (ds_batch_in, ds_batch_did, batch_params, true);    

    ds_ready := if (isFcra, ds_batch_did, ds_batch_in);
    
    // FFD 
    integer8 inFFDOptionsMask := FFD.FFDMask.Get();
    integer inFCRAPurpose := FCRA.FCRAPurpose.Get();

    // a) we are using the subject DID rather than the Best DID 
    ds_dids := project(ds_ready(did>0), FFD.Layouts.DidBatch);
      
    // b) Call the person context    
    pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gw_config, FFD.Constants.DataGroupSet.Property, inFFDOptionsMask));

    alert_flags := if(isFCRA, FFD.ConsumerFlag.getAlertIndicators(pc_recs, inFCRAPurpose, inFFDOptionsMask));
		
    // c) Slim down the PersonContext         
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
    
    ds_best := project(ds_ready, transform(doxie.layout_best, self.did := left.did, self:=[]));
    ds_flags := if(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));

    p_mod := BatchServices.Property_BatchService_Records(ds_ready, record_types, party_type, nss, isFCRA, , slim_pc_recs, inFFDOptionsMask, ds_flags);
    
    // Get the top N records for each acctno here. Note: we DON'T want to just get the top N ln_fares_ids for
    // each acctno and then match those against the property records, because many of those ln_fares_ids might be 
    // misses. Instead, attach the acctnos back to the property recs first, sort, and then get the top N.    
    BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos xfm_prepend_acctnos(p_mod.ds_all_fares_ids l, p_mod.ds_property_recs r) :=
      TRANSFORM
        SELF := l;
        SELF := r;
      END;
    
    ds_property_recs_filtered := IF(return_current_only, 
                                    p_mod.ds_property_recs(TRIM(current_record) = 'Y'), 
                                    p_mod.ds_property_recs);
    
    ds_property_recs_plus_acctnos := JOIN(p_mod.ds_all_fares_ids, ds_property_recs_filtered,
                                          LEFT.ln_fares_id = RIGHT.ln_fares_id
                                          and left.search_did = right.search_did,
                                          xfm_prepend_acctnos(LEFT, RIGHT),
                                          INNER, LIMIT(10000,SKIP));
                                          
   string8 mc := batchservices.functions.match_code_result(NameMatch_value, StreetAddressMatch_value,
                                                 cityMatch_value, stateMatch_value,
                                                 zipMatch_value, ssnMatch_value, FALSE,
                                                 DidMatch_value);                                          
    
   // add in match code stuff here
  temp_layout :=   record
    BOOLEAN match_name;
    BOOLEAN match_street_address;
    BOOLEAN match_city;
    BOOLEAN match_state;
    BOOLEAN match_zip;
    BOOLEAN match_ssn;
    BOOLEAN match_dob;
    BOOLEAN match_did;
    BOOLEAN matches;
    BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes;             
    BatchShare.Layouts.shareErrors - error_code;
  end;          
   
  temp_layout add_matchcodeValues(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos L,
                                  ds_ready R)  := TRANSFORM
                            
    tmp_match_name1  := batchservices.functions.LN_Property.fn_match_name(L.parties[1].entity, R);
    tmp_match_name2  := batchservices.functions.LN_Property.fn_match_name(L.parties[2].entity, R);
    tmp_match_name3  := batchservices.functions.LN_Property.fn_match_name(L.parties[3].entity, R);
    tmp_match_name4  := batchservices.functions.LN_Property.fn_match_name(L.parties[4].entity, R);
    tmp_match_name5  := batchservices.functions.LN_Property.fn_match_name(L.parties[5].entity, R);
    tmp_match_name := tmp_match_name1 OR tmp_match_name2 OR tmp_match_name3 OR tmp_match_name4 OR tmp_match_name5;
    SELF.match_name := tmp_match_name;                               
    tmp_match_street_address := (L.parties[1].prim_range = R.prim_range and R.prim_range <> '') AND
                                (L.parties[1].prim_name = R.prim_name AND R.prim_name <> '') AND
                                (L.parties[1].suffix = R.addr_suffix AND R.addr_suffix <> '') AND
                                (L.parties[1].predir = R.predir) AND
                                (L.parties[1].postdir = R.postdir);
    SELF.match_street_address := tmp_match_street_address;                                            
    tmp_match_city  := (L.parties[1].p_city_name = R.p_city_name and R.p_city_name <> '');                                                                
    SELF.match_city  := tmp_match_city;
    tmp_match_state :=  (L.parties[1].st = R.st AND R.st<> '');
    SELF.match_state := tmp_match_state;
    tmp_match_zip   :=  (L.parties[1].zip = R.z5 AND R.z5 <> '');
    SELF.match_zip   := tmp_match_zip;
    
    tmp_match_ssn1 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[1].entity, R); 
      tmp_match_ssn2 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[2].entity, R); 
      tmp_match_ssn3 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[3].entity, R); 
      tmp_match_ssn4 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[4].entity, R); 
      tmp_match_ssn5 := batchservices.functions.LN_Property.fn_match_ssn(L.parties[5].entity, R); 
      tmp_match_ssn := tmp_match_ssn1 OR tmp_match_ssn2 OR tmp_match_ssn3 OR tmp_match_ssn4 OR tmp_match_ssn5;
    SELF.match_ssn   := tmp_match_ssn;
    SELF.match_dob   := true;
    
      tmp_match_did1  :=  batchservices.functions.LN_Property.fn_match_did(L.parties[1].entity, R);  
      tmp_match_did2 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[2].entity, R); 
      tmp_match_did3 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[3].entity, R); 
      tmp_match_did4 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[4].entity, R); 
      tmp_match_did5 :=   batchservices.functions.LN_Property.fn_match_did(L.parties[5].entity, R); 
      tmp_match_did := tmp_match_did1 OR tmp_match_did2 OR tmp_match_did3 OR tmp_match_did4 OR tmp_match_did5;
    
    SELF.match_did := tmp_match_did;
                                   
    SELF.acctno      := L.acctno; // sets acctno
     nameV  :=  ((~(nameMatch_value)) OR (tmp_match_name));
     streetV := ((~(streetAddressMatch_value)) OR (tmp_match_street_address));
     cityV  :=  ((~(cityMatch_value)) OR (tmp_match_city));
     stateV :=  ((~(stateMatch_value)) OR (tmp_match_state));
     zipV   :=  ((~(zipMatch_value)) OR (tmp_match_zip));
     ssnV   :=  ((~(ssnMatch_value)) OR (tmp_match_ssn));
     didV   :=   ((~(didMatch_value)) OR (tmp_match_did));    
     SELF.matches   := nameV AND streetV AND cityV AND StateV AND zipV AND ssnV AND didV;      
     self.matchcodes := batchservices.functions.match_code_result(
                                   tmp_match_name, tmp_match_street_address,
                                   tmp_match_city, tmp_match_state,
                                   tmp_match_zip, tmp_match_ssn, FALSE,
                                                 tmp_match_did);  
     SELF := L;
     SELF := [];              
     // no DOB match value.
    END;
      
    ds_property_recs_plus_acctnos_trimmed_unmatched := join(ds_property_recs_plus_acctnos, 
                                                            ds_ready,
                  LEFT.acctno = RIGHT.acctno,                          
                 add_matchcodeValues(LEFT, RIGHT));      
                                                                                    // can we do better than err_search <> 0?
     ds_property_recs_plus_acctnos_trimmed := ds_property_recs_plus_acctnos_trimmed_unmatched(matches=TRUE or err_search <> 0);
    batchout := record(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes - error_code)
      batchShare.Layouts.shareErrors;
    end;
     ds_property_recs_plus_acctnos_tmp := project(ds_property_recs_plus_acctnos_trimmed,
                                            TRANSFORM(BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes,
                                            SELF.error_Code := 0; // these are all the good ones so set error
                                                                 // code accordingly.                                                                                                          
                                            SELF := LEFT));    
                                            
     
    /* ******************************* ADD 'TOO MANY MATCHES' RECORDS ****************************** */
    
    // Now, get all of the account numbers which complained of having too_many_matches (error_code 203)  
    // during the different autokey fetches. We'd like to return these records because they'll be a good
    // clue describing why a search failed for a particular input record.
    ds_too_many_results := DEDUP(SORT(p_mod.ds_fids(search_status = TOO_MANY_MATCHES), acctno), acctno);
    // Format for output those acctnos having too_many_matches.
    BatchServices.Layouts.LN_Property.rec_widest_plus_acctnos_plus_matchcodes xfm_recs_having_too_many_results(AutokeyB2_batch.Layouts.rec_output_IDs_batch l) := 
      TRANSFORM
        SELF.acctno     := l.acctno;
        SELF.error_code := l.search_status;
        SELF            := [];
      END;
      
    ds_too_many_formatted := PROJECT(ds_too_many_results, xfm_recs_having_too_many_results(LEFT));
    
    // Obtain only those records (1) having too many results for a particular autokey fetch and (2) having 
    // no matching property records otherwise.
    // ds_too_many_having_no_matching_property_recs := dedup(sort(JOIN(ds_too_many_formatted, ds_flattened_property_recs_with_matchcodes,
                                                    // LEFT.acctno = RIGHT.acctno,LEFT OUTER),acctno),acctno);
  
    // Rejoin to the property recs.        
    ds_all_recs := SORT(ds_property_recs_plus_acctnos_tmp  + 
                        ds_too_many_formatted,
                        acctno, -sortby_date);
                        
    // *** NOTE: we may change the sort field 'sortby_date' to 'recording_date' at some point. We'll see. ***
    //ds_property_recs_grouped := GROUP(SORT(ds_property_recs_plus_acctnos_tmp, acctno, -sortby_date), acctno);
    ds_property_recs_grouped := GROUP(SORT(if(isFCRA,ds_property_recs_plus_acctnos_tmp,ds_all_recs), acctno, -sortby_date), acctno);
    ds_top_property_recs := TOPN(ds_property_recs_grouped, max_results_per_acct, acctno);
    
    // Flatten the property records. Pre Dedup Sort
    ds_flat_final_recs := PROJECT(UNGROUP(ds_top_property_recs), 
                            BatchServices.xfm_Accurint_Property_make_flat(LEFT, formatted_values, counter));
    
    // data maybe suppressed due to alerts
    ds_flat_with_alerts := FFD.Mac.ApplyConsumerAlertsBatch(ds_flat_final_recs, alert_flags, StatementsAndDisputes, BatchServices.layout_Accurint_Property_batch_out_pre,inFFDOptionsMask);
		// add resolved LexId to the results for inquiry history logging support                    
    ds_flat_with_inquiry := FFD.Mac.InquiryLexidBatch(ds_ready, ds_flat_with_alerts, BatchServices.layout_Accurint_Property_batch_out_pre, 0);

    ds_flat_out := IF(isFCRA, ds_flat_with_inquiry, ds_flat_final_recs);
 
    ds_all_sort := sort(ds_flat_out,record_type,LN_PropertyV2.fn_strip_pnum(parcel_number),-sortby_date,fares_source_id,acctno);
    
    final_sort := sort(dedup(ds_all_sort,record_type,LN_PropertyV2.fn_strip_pnum(parcel_number),sortby_date,acctno),acctno);  

    consumer_statements := NORMALIZE(final_sort, LEFT.StatementsAndDisputes, 
                              TRANSFORM(FFD.Layouts.ConsumerStatementBatch, 
                              SELF.Acctno := left.Acctno,
                              SELF.SequenceNumber := left.SequenceNumber,
                              SELF := RIGHT));
    
    // consumer statements dataset contains information about disputed records as well as Statements.
    consumer_statements_prep := IF(isFCRA, FFD.prepareConsumerStatementsBatch(consumer_statements, pc_recs, inFFDOptionsMask));
    consumer_alerts  := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessagesBatch(pc_recs, alert_flags, inFFDOptionsMask));                                               
    consumer_statements_alerts := consumer_statements_prep + consumer_alerts;
		
    BatchShare.MAC_RestoreAcctno(ds_batch_in, consumer_statements_alerts, consumer_statements_acctno, false, false);
  
    // output(ds_property_recs_plus_acctnos_tmp, named('ds_property_recs_plus_acctnos_tmp'));
    // output(fids, named('ds_fids'));
     
    // output(ds_property_recs_plus_acctnos, named('ds_property_recs_plus_acctnos'));
    // output(ds_property_recs_plus_acctnos_trimmed_unmatched, named('ds_property_recs_plus_acctnos_trimmed_unmatched'));
    // output(ds_property_recs_plus_acctnos_trimmed, named('ds_property_recs_plus_acctnos_trimmed'));
    // output(ds_property_recs_plus_acctnos_tmp, named('ds_property_recs_plus_acctnos_tmp'));
    
    BatchShare.MAC_RestoreAcctno(ds_batch_in,final_sort, ds_output);  
    ut.mac_TrimFields(ds_output, 'ds_output', results);
    
    results_out := project(results, BatchServices.layout_Accurint_Property_batch_out);
    FFD.MAC.PrepareResultRecordBatch(results_out, record_out, consumer_statements_acctno, BatchServices.layout_Accurint_Property_batch_out);
  
    return record_out;
END;
