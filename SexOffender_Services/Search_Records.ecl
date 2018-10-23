import AutoStandardI,iesp, doxie, FCRA, FFD, Alerts, Gateway, SexOffender_Services;

export Search_Records := module
  export getRecordsAndApplyRules(dataset (SexOffender_Services.layouts.search) spks,
                                SexOffender_Services.IParam.search in_mod,
                                boolean isFCRA = false,
                                dataset(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                                dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
                                integer8 inFFDOptionsMask = 0) := function
                                                
    recs_from_raw := SexOffender_Services.Raw.Search_View.bySPK(spks, in_mod, isFCRA, flagfile, slim_pc_recs, inFFDOptionsMask);
    
    // Filter first using the penalty threshold
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
    recs_pen := recs_from_raw (penalt <= pthreshold_translated or isDeepDive);

    // Only keep the one record for a spk that is the main name record (name_type=0)
    recs_filtered := recs_pen(name_type='0');

    // Format recs for searchservice XML output
     added_functions_in_mod := project(in_mod, SexOffender_Services.IParam.functions_params);
    recs_fmtd := SexOffender_Services.search_functions.fnSearchVal(recs_filtered,
                                                                   added_functions_in_mod,
                                                                   isFCRA,,
                                                                   slim_pc_recs,
                                                                   inFFDOptionsMask); 
    // Sort into final order for returning. 
    recs_sort := sort(recs_fmtd,if(AlsoFound,1,0),
                                _penalty,
                                SecondaryPenalty,
                                Name.Last,
                                Name.First,
                                Name.Middle,
                                Address.State,
                                Address.City,
                                Address.Zip5,
                                Address.StreetName,
                                Address.StreetNumber,
                                record);

    // Do a "CHOOSEN" to limit the returned output records to the current max value of 2000.
    recs_proj := choosen(recs_sort, iesp.Constants.SEXOFF_MAX_COUNT_SEARCH_RESPONSE_RECORDS);
    
    //Uncomment lines below as needed to assist in debugging
    //output(spks,named('sr_spks'));
    //output(in_mod.nodeepdive,named('sr_nodeepdive'));
    //output(in_mod.penalty_threshold,named('sr_inmod_pen_th'));
    //output(recs_from_raw,named('sr_recs_from_raw'));
    //output(recs_pen, named('sr_recs_pen'));
    //output(recs_filtered, named('sr_recs_filtered'));
    //output(recs_fmtd, named('sr_recs_fmt'));
    //output(recs_sort, named('sr_recs_sort'));
    //output(recs_proj, named('sr_recs_proj'));
    return recs_proj;
  end;

  EXPORT filterRecsByAltAddresses(SexOffender_Services.IParam.search inMod,
         DATASET(SexOffender_Services.Layouts.t_OffenderRecord_plus) Recs) := FUNCTION
    tmpRec := {SET OF STRING1 addrTypes;Recs};
    tmpRecs := PROJECT(Recs,TRANSFORM(tmpRec,SELF.addrTypes:=SET(LEFT.AlternativeAddresses,AddressType),SELF:=LEFT,SELF:=[]));
    filRecs := tmpRecs(
      IF(inMod.include_unregaddrs,'B','') IN addrTypes OR
      IF(inMod.include_histaddrs ,'H','') IN addrTypes OR
      IF(inMod.include_assocaddrs,'R','') IN addrTypes); 
    doFilter := NOT inMod.include_regaddrs AND (inMod.include_unregaddrs OR inMod.include_histaddrs OR inMod.include_assocaddrs);
    RETURN IF(doFilter,PROJECT(filRecs,SexOffender_Services.Layouts.t_OffenderRecord_plus),Recs);
  END;

  shared shared_val(SexOffender_Services.IParam.search in_mod,
             boolean isFCRA = false) := function
  
    // Get the Seisint Primary Key number(s) depending upon what data was entered in the 
    // input search fields.
    spks := SexOffender_Services.Search_IDs.val(in_mod, isFCRA);
    
    // Get the records from raw using the Seisint Primary Key numbers. 
    // They will have penalty set and ssns & dids checked/pulled in SexOffender_Services.raw.
    
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_best := dataset([transform (doxie.layout_best, self.did := (unsigned6) in_mod.did, self:=[])]);
    
    //FCRA FFD
    boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
      
    dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)in_mod.DID}],
                                                                FFD.Layouts.DidBatch);
    pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.SexOffender, in_mod.FFDOptionsMask));
   
    slim_pc_recs :=FFD.SlimPersonContext(pc_recs);
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;

    consumer_statements := if(isFCRA and showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                                          
    ds_flags := if (IsFCRA, FFD.GetFlagFile(did_best, pc_recs), FCRA.compliance.blank_flagfile);
    
    results := getRecordsAndApplyRules(spks, in_mod, isFCRA, ds_flags, slim_pc_recs, in_mod.FFDOptionsMask);
    filterResults := IF(in_mod.filterRecsByAltAddr,filterRecsByAltAddresses(in_mod,results),results);
    
       // set the maxresults_val that is used in Alerts.mac_ProcessAlerts
    unsigned8 maxresults_val := iesp.Constants.SEXOFF_MAX_COUNT_SEARCH_RESPONSE_RECORDS;
  
    // Do the Alert processing
    Alerts.mac_ProcessAlerts(filterResults,SexOffender_Services.alert,alert_results);
    // Project the output of alert processing onto the appropriate Sex Offender Search 
    // Response Offender record layout, removing the fields used for alert hash calculation
    // only.
    recs := if(suppress_results_due_alerts, dataset([], iesp.sexualoffender_fcra.t_FcraOffenderRecord), 
               project(alert_results, iesp.sexualoffender_fcra.t_FcraOffenderRecord));
       
    FFD.MAC.PrepareResultRecord(recs, final_results, consumer_statements, consumer_alerts, iesp.sexualoffender_fcra.t_FcraOffenderRecord); 
    
    return final_results;    
  end;
  
  export val(SexOffender_Services.IParam.search in_mod) := project(shared_val(in_mod, FALSE).Records, iesp.sexualoffender.t_OffenderRecord);                             
  export fcra_val(SexOffender_Services.IParam.search in_mod) := shared_val(in_mod, TRUE);

end;
