import AutoStandardI, doxie, iesp, suppress, FCRA, FFD, Gateway;

export Search_Records := module
  export params := interface(
    hunting_fishing_services.Search_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    AutoStandardI.InterfaceTranslator.ssn_mask_value.params,
    FCRA.iRules)
  end;
  export formatandFilterRawRecords(DATASET(hunting_fishing_services.Layouts.raw_rec) argRecords,params in_mod, boolean isFCRA = false):=function
    // Calculate the penalty on the records
    recs_plus_pen := project(argRecords,transform(hunting_fishing_services.Layouts.raw_rec,
      tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export fname_field    := left.fname;
        export mname_field    := left.mname;
        export lname_field    := left.lname;
        export prange_field   := left.prim_range;
        export predir_field   := left.predir;
        export pname_field    := left.prim_name;
        export suffix_field   := left.suffix;
        export postdir_field  := left.postdir;
        export sec_range_field := left.sec_range;
        export city_field     := left.p_city_name;      
        export city2_field    := left.city_name;
        export state_field    := left.st;
        export zip_field      := left.zip;
        export ssn_field      := left.best_ssn;  
        export did_field      := left.did_out;
        export dob_field      := '';
        export county_field   := left.county;
        export phone_field    := '';
      end;

      tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
      
      // if its deepdive or isFCRA, don't apply the penalty
      self.penalt := if (left.isDeepDive or isFCRA, 0, tempPenaltIndv),
      self := left));

    // ***** DID & SSN pulling and suppression ****
    Suppress.MAC_Suppress(recs_plus_pen,pull_dids,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did_out);
    Suppress.MAC_Suppress(pull_dids,pull_ssns,in_mod.applicationtype,Suppress.Constants.LinkTypes.SSN,best_ssn);
    doxie.MAC_PruneOldSSNs(pull_ssns, recs_pruned, best_ssn, did_out, isFCRA);

    // set the ssn_mask_value that is used in Suppress.MAC_Mask
    string6 ssn_mask_value := AutoStandardI.InterfaceTranslator.ssn_mask_value.val(project(in_mod,
                                     AutoStandardI.InterfaceTranslator.ssn_mask_value.params)); 

    suppress.MAC_Mask(recs_pruned, ssns_suppressed, best_ssn, blank, true, false);

    // Format for output
    recs_fmtd := hunting_fishing_services.Functions.fnHuntFishVal(ssns_suppressed, in_mod.city);

    // Sort.
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
    recs_sort := sort(recs_fmtd (_penalty <= pthreshold_translated),
                                          if(AlsoFound,1,0),
                                           _penalty,
                                          Name.Last,
                                          Name.First,
                                          Name.Middle,
                                          Address.State,
                                          Address.City,
                                          Address.Zip5,
                                          Address.StreetName,
                                          Address.StreetNumber,
                                          record);

    recs_proj := project(recs_sort, iesp.huntingfishing_fcra.t_FcraHuntFishRecord);

    //Uncomment lines below as needed to assist in debugging
    //output(ids,named('hfssrecs_ids'));
    //output(recs,named('hfssrecs_recs'));
    //output(recs_plus_pen, named('hfssrecs_recs_plus_pen'));
    //output(recs_pruned, named('hfssrecs_recs_pruned'));
    //output(recs_suppressed, named('hfssrecs_recs_suppressed'));
    //output(recs_fmtd, named('hfssrecs_recs_fmt'));
    //output(recs_sort, named('hfssrecs_recs_sort'));
    return recs_proj;
  end;
  export val(params in_mod, boolean isFCRA = false) := function
  
    // Get the IDs and pull the payload records
    ids := hunting_fishing_services.Search_IDs.val(in_mod, isFCRA);
    
    ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
    
    //FCRA FFD
    dsDIDs := dataset([{FFD.Constants.SingleSearchAcctno,(unsigned)in_mod.DID}], FFD.Layouts.DidBatch);
    
    pc_recs := if(isFCRA, FFD.FetchPersonContext(dsDIDs, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.Hunting_Fishing, in_mod.FFDOptionsMask));
    
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
    
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                                       
    ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs), FCRA.compliance.blank_flagfile);
    
    recs := Hunting_Fishing_Services.Raw.byRids(ids, isFCRA, ds_flags, slim_pc_recs, in_mod.FFDOptionsMask);
      
    recs_proj := if (suppress_results_due_alerts, dataset([], iesp.huntingfishing_fcra.t_FcraHuntFishRecord),
                     formatandFilterRawRecords(recs,in_mod, isFCRA));
    
    boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
    consumer_statements := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);

    FFD.MAC.PrepareResultRecord(recs_proj, final_rec, consumer_statements, consumer_alerts, iesp.huntingfishing_fcra.t_FcraHuntFishRecord);
    
    return final_rec;
  end;
end;
