IMPORT AutoStandardI, iesp, doxie, FCRA, FFD, Alerts, Gateway, SexOffender_Services;

EXPORT Search_Records := MODULE
  EXPORT getRecordsAndApplyRules(DATASET (SexOffender_Services.layouts.search) spks,
                                SexOffender_Services.IParam.search in_mod,
                                BOOLEAN isFCRA = FALSE,
                                DATASET(fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile,
                                DATASET (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim
                                ) := FUNCTION
                                                
    recs_from_raw := SexOffender_Services.Raw.Search_View.bySPK(spks, in_mod, isFCRA, flagfile, slim_pc_recs);
    
    // Filter first using the penalty threshold
    mod_penalty := PROJECT (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    UNSIGNED2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
    recs_pen := recs_from_raw (penalt <= pthreshold_translated OR isDeepDive);

    // Only keep the one record for a spk that is the main name record (name_type=0)
    recs_filtered := recs_pen(name_type='0');

    // Format recs for searchservice XML output
    added_functions_in_mod := PROJECT(in_mod, SexOffender_Services.IParam.functions_params);
    recs_fmtd := SexOffender_Services.search_functions.fnSearchVal(recs_filtered,
                                                                   added_functions_in_mod,
                                                                   isFCRA,,
                                                                   slim_pc_recs,
                                                                   in_mod.FFDOptionsMask);
    // Sort into final order for returning.
    recs_sort := SORT(recs_fmtd,IF(AlsoFound,1,0),
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
                                RECORD);

    // Do a "CHOOSEN" to limit the returned output records to the current max value of 2000.
    recs_proj := CHOOSEN(recs_sort, iesp.Constants.SEXOFF_MAX_COUNT_SEARCH_RESPONSE_RECORDS);
    
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
    RETURN recs_proj;
  END;

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

  SHARED shared_val(SexOffender_Services.IParam.search in_mod,
             BOOLEAN isFCRA = FALSE) := FUNCTION
  
    // Get the Seisint Primary Key number(s) depending upon what data was entered in the
    // input search fields.
    spks := SexOffender_Services.Search_IDs.val(in_mod, isFCRA);
    
    // Get the records from raw using the Seisint Primary Key numbers.
    // They will have penalty set and ssns & dids checked/pulled in SexOffender_Services.raw.
    
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_best := DATASET([TRANSFORM (doxie.layout_best, SELF.did := (UNSIGNED6) in_mod.did, SELF:=[])]);
    
    //FCRA FFD
    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
      
    dsDIDs := DATASET([{FFD.Constants.SingleSearchAcctno,(UNSIGNED)in_mod.DID}],
                                                                FFD.Layouts.DidBatch);
    pc_recs := IF(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.SexOffender, in_mod.FFDOptionsMask));
   
    slim_pc_recs :=FFD.SlimPersonContext(pc_recs);
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;

    consumer_statements := IF(isFCRA AND showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                                          
    ds_flags := IF (IsFCRA, FFD.GetFlagFile(did_best, pc_recs), FCRA.compliance.blank_flagfile);
    
    results := getRecordsAndApplyRules(spks, in_mod, isFCRA, ds_flags, slim_pc_recs);
    filterResults := IF(in_mod.filterRecsByAltAddr,filterRecsByAltAddresses(in_mod,results),results);
    
    // set the maxresults_val that is used in Alerts.mac_ProcessAlerts
    UNSIGNED8 maxresults_val := iesp.Constants.SEXOFF_MAX_COUNT_SEARCH_RESPONSE_RECORDS;
  
    // Do the Alert processing
    Alerts.mac_ProcessAlerts(filterResults,SexOffender_Services.alert,alert_results);
    // Project the output of alert processing onto the appropriate Sex Offender Search
    // Response Offender record layout, removing the fields used for alert hash calculation
    // only.
    recs := IF(suppress_results_due_alerts, DATASET([], iesp.sexualoffender_fcra.t_FcraOffenderRecord),
               PROJECT(alert_results, iesp.sexualoffender_fcra.t_FcraOffenderRecord));
       
    FFD.MAC.PrepareResultRecord(recs, final_results, consumer_statements, consumer_alerts, iesp.sexualoffender_fcra.t_FcraOffenderRecord);
    
    RETURN final_results;
  END;
  
  EXPORT val(SexOffender_Services.IParam.search in_mod) := PROJECT(shared_val(in_mod, FALSE).Records, iesp.sexualoffender.t_OffenderRecord);
  EXPORT fcra_val(SexOffender_Services.IParam.search in_mod) := shared_val(in_mod, TRUE);

END;
