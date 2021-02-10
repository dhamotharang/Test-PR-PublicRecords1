IMPORT AutoStandardI, CCW_services, ut, doxie, iesp, Suppress, FCRA, FFD, Gateway;

EXPORT SearchService_Records := MODULE
  EXPORT params := INTERFACE(
    CCW_services.SearchService_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
    AutoStandardI.InterfaceTranslator.industry_class_value.params,
    FCRA.iRules
    )
  END;

  // penalize, suppress/mask sensitive data
  EXPORT getFormatedRecords (
    DATASET(CCW_services.layouts.rawrec) recs,
    params in_mod,
    BOOLEAN skip_penalizing = FALSE,
    BOOLEAN isFCRA = FALSE) := FUNCTION
                                       
    // pull out dids which are in the file
    Suppress.MAC_Suppress(recs,recs_did_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did_out, isFCRA := isFCRA);
    // pull out ssn's which are in pull ssn file
    Suppress.MAC_Suppress(recs_did_pulled,recs_ssn_pulled,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,best_ssn, isFCRA := isFCRA);
   
    // Calculate the penalty on the records
    recs_plus_pen := PROJECT (recs_ssn_pulled, TRANSFORM(CCW_services.Layouts.rawrec,
      tempindvmod := MODULE(PROJECT(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
        EXPORT allow_wildcard := FALSE;
        EXPORT city_field := LEFT.city_name; //TRIM(ms(LEFT.p_city_name, LEFT.v_city_name, in_mod.city),LEFT,RIGHT);
        EXPORT did_field := LEFT.did_out;
        EXPORT fname_field := LEFT.fname;
        EXPORT lname_field := LEFT.lname;
        EXPORT mname_field := LEFT.mname;
        EXPORT phone_field := '';
        EXPORT pname_field := LEFT.prim_name;
        EXPORT postdir_field := LEFT.postdir;
        EXPORT prange_field := LEFT.prim_range;
        EXPORT predir_field := LEFT.predir;
        EXPORT ssn_field := LEFT.best_ssn;
        EXPORT state_field := LEFT.st;
        EXPORT suffix_field := LEFT.suffix;
        EXPORT sec_range_field := LEFT.sec_range;
        EXPORT zip_field := LEFT.zip;
        EXPORT city2_field := '';
        EXPORT county_field := LEFT.county;
        EXPORT dob_field := LEFT.dob;
        EXPORT dod_field := '';
      END;
      
      // The business info will only ever use the business address.
      tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
      // if its deepdive records or isFCRA is true don't apply the penalty...
      SELF.penalt := IF (LEFT.isDeepDive OR skip_penalizing, 0, tempPenaltIndv); // no business penalty
      SELF := LEFT;
    ));

    // mask SSN
    STRING6 ssn_mask_value := 
      AutoStandardI.InterfaceTranslator.ssn_mask_val.val(PROJECT(in_mod,
        AutoStandardI.InterfaceTranslator.ssn_mask_val.params));
    Suppress.MAC_Mask(recs_plus_pen, recs_plus_pen_out, best_ssn, blank, TRUE, FALSE);
    
    // Format for output
    recs_fmt := CCW_services.Functions.fnCCWSearchval(recs_plus_pen_out);
        
    mod_penalty := PROJECT (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    UNSIGNED2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
    recs_pen := recs_fmt (_penalty <= pthreshold_translated);

    // sort by lname, fname etc..if search is not by aircraft Number.
    // otherwise sort returned is chronological in nature.
    recs_sort := SORT(recs_pen, IF(AlsoFound,1,0), _penalty,
      Name.Last, Name.First, Name.Middle, ssn,
      -Permit.RegistrationDate.year, -Permit.RegistrationDate.month, -Permit.RegistrationDate.day,
      RECORD);
    
    tempresults_slim := PROJECT(recs_sort, iesp.concealedweapon_fcra.t_FcraWeaponRecord);
    RETURN tempresults_slim;
  END;
  
  // search entry point
  EXPORT search(params in_mod, BOOLEAN isFCRA = FALSE) := FUNCTION
    
    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
                                       
    // get RIDs from input criteria.
    ids := CCW_services.SearchService_IDs.val(in_mod, isFCRA);
   
   //Get FCRA files
    ds_best := PROJECT(ids,TRANSFORM(doxie.layout_best,SELF:=LEFT,SELF:=[]));
    
    //FCRA FFD
    // we are using the subject DID rather than the Best DID
    ds_dids := DATASET([{FFD.Constants.SingleSearchAcctno,(UNSIGNED)in_mod.DID}],FFD.Layouts.DidBatch);
    
    pc_recs := IF(isFCRA, FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(), 
      FFD.Constants.DataGroupSet.CCW, in_mod.FFDOptionsMask));
    
    ds_flags := IF(isFCRA, FFD.GetFlagFile (ds_best, pc_recs));
    
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;
    
    // Send the DID and show disputed inside
    BOOLEAN isCNSMR := in_mod.IndustryClass = ut.IndustryClass.Knowx_IC; // D2C - consumer restriction
    recs := CCW_Services.Raw.byRids(ids, isFCRA, ds_flags, slim_pc_recs, in_mod.FFDOptionsMask, isCNSMR);
    final_recs := IF(~suppress_results_due_alerts, 
      getFormatedRecords (recs, in_mod, skip_penalizing := isFCRA, isFCRA := isFCRA), //don't penalize on FCRA side
      DATASET([],iesp.concealedweapon_fcra.t_FcraWeaponRecord));
                     
    // 5) Make the statements
    // Here we are interested only in the record statements or consumer level statements.
    consumer_statements := IF(isFCRA AND showConsumerStatements, 
      FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

    // process alerts coming from PersonContext
    consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), 
      FFD.Constants.BlankConsumerAlerts);
    
    FFD.MAC.PrepareResultRecord(final_recs, rec_out, consumer_statements, consumer_alerts, 
      iesp.concealedweapon_fcra.t_FcraWeaponRecord);
     
    RETURN rec_out;
  END;

  // report entry: if subject is (or subjects are) already found
  EXPORT report (DATASET (doxie.layout_references) dids,
                 params in_mod,
                 BOOLEAN isFCRA = FALSE,
                 DATASET (fcra.Layout_override_flag) flagfile = fcra.compliance.blank_flagfile
                 ) := FUNCTION
    // get internal IDs
    ids := CCW_Services.raw.byDIDs (PROJECT (dids, CCW_services.Layouts.search_did), isFCRA);
   
    // get raw records; overrides are applied inside
    BOOLEAN isCNSMR := in_mod.IndustryClass = ut.IndustryClass.Knowx_IC; // D2C - consumer restriction
    recs := CCW_Services.raw.byRids (ids, isFCRA, flagfile, , , isCNSMR);
    final_recs := getFormatedRecords (recs, in_mod, skip_penalizing := TRUE, isFCRA := isFCRA);
    
    RETURN final_recs;
  END;

END;
