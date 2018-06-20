IMPORT doxie, suppress, BIPV2, LN_PropertyV2_Services, FCRA, FFD, Gateway, iesp;

EXPORT SearchService_records (unsigned6 search_did=0,integer1 
                                nonSS = Suppress.Constants.NonSubjectSuppression.doNothing, 
                                boolean isFCRA = false,
                                FCRA.iRules in_params = module(FCRA.iRules) end ) :=
  FUNCTION
  
    boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
    gateways := Gateway.Configuration.Get();
    
    //determine records to display
    ids_0 := SearchService_ids();
    
    dids := dataset([{search_did}], doxie.layout_references);
    by_did := project(LN_PropertyV2_Services.Raw.get_fids_from_dids(dids,isFCRA),transform(layouts.search_fid, 
                            self.isDeepDive := false,  self.search_did := search_did, self.ln_fares_id := left.ln_fares_id)); 
    ids:= if (isFCRA,by_did,ids_0); 
    
    ids_1:= project(ids,transform(LN_PropertyV2_Services.layouts.search_fid, self.search_did := search_did, self := left)); 
    
    // FFD 
    // 1) we are using the subject DID rather than the Best DID 
    ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)search_did}],FFD.Layouts.DidBatch);
    
    // 2) Call the person context    
    pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gateways, FFD.Constants.DataGroupSet.Property, in_params.FFDOptionsMask));
    
    // 3) Slim down the PersonContext         
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
    
    ds_best := project(ds_dids, transform(doxie.layout_best, self.did := left.did, self:=[]));
    ds_flags := if(isFCRA, FFD.GetFlagFile(ds_best, pc_recs));
	
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

    results_0 := LN_PropertyV2_Services.resultFmt.narrow_view.get_by_sid(ids_1,nonSS,isFCRA,slim_pc_recs,in_params.FFDOptionsMask, ds_flags);

    // Robustness Score Sorting
    results_srt := if(LN_PropertyV2_Services.input.RobustnessScoreSorting,sort(results_0,-key_robustness_score,-total_robustness_score),results_0);
    
    results := if(suppress_results_due_alerts, dataset([],LN_PropertyV2_Services.layouts.combined.narrow), results_srt);

    consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
        
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                                       
    FFD.MAC.PrepareResultRecord(results, combined_out, consumer_statements, consumer_alerts, LN_PropertyV2_Services.layouts.combined.narrow);
     
    RETURN combined_out;
    
END;