import AutoStandardI, FaaV2_PilotServices, ut, doxie, iesp, suppress, fcra, FFD, Gateway;

export SearchService_Records := module
  export params := interface(
    FAAV2_PilotServices.SearchService_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    FCRA.iRules)
  end;
  
  shared shared_val(params in_mod,boolean isFCRA = false) := function
  
    ms(string70 a, string70 b, string70 c) :=
      map(a = '' => b,
          b = '' => a,
          ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b); 
        
    //FCRA FFD 
    gateways := Gateway.Configuration.Get();
    boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
    
    // Get the IDs, pull the payload records 
    ids := faav2_pilotServices.SearchService_IDs.val(in_mod,isFCRA);
    // deep dive info is in the attribute ids one line above.
    
   //Get FCRA files
    ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));
    
    //FCRA FFD
    // Select the DID ( We are using the subject DID rather than the Best DID.) 
    ds_dids := dataset([{FFD.Constants.SingleSearchAcctno, (unsigned)in_mod.DID}], FFD.Layouts.DidBatch);
    
    data_groups := [FFD.Constants.DataGroups.PILOT_REGISTRATION, FFD.Constants.DataGroups.PERSON];
    
    pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, gateways, data_groups, in_mod.FFDOptionsMask));

    slim_pc_recs :=  FFD.SlimPersonContext(pc_recs);

    ds_flags := if(isFCRA, FFD.GetFlagFile (ds_best, pc_recs));
    
    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
    
    Suppress.MAC_Suppress(ids,ids_tmp,in_mod.applicationtype,Suppress.Constants.LinkTypes.DID,did);
    
    // join to payload key.    
    // added condition to limit our records coming back.
    recs := faav2_pilotservices.raw.joinByAirmenId(ids_tmp,in_mod.applicationtype,isFCRA, ds_flags, slim_pc_recs, in_mod.FFDOptionsMask);
    
    statement_output := if(IsFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
    
    // Calculate the penalty on the records
    recs_plus_pen := project(recs,transform(FaaV2_PilotServices.Layouts.Pilotrawrec,
      tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export city_field := trim(ms(left.p_city_name, left.v_city_name, left.city),left,right);
        export did_field := left.did_out;
        export fname_field := left.fname;
        export lname_field := left.lname;
        export mname_field := left.mname;
        export phone_field := '';
        export pname_field := left.prim_name;
        export postdir_field := left.postdir;
        export prange_field := left.prim_range;
        export predir_field := left.predir;
        // ssn penalty will always be 0 since ssn is not an input.
        export ssn_field := '';
        export state_field := left.state;
        export suffix_field := left.suffix;
        export sec_range_field := left.sec_range;
        export zip_field := left.zip;
        export city2_field := '';
        export county_field := left.county;
        export dob_field := '';
        export dod_field := '';
      end;
      
      // The business info will only ever use the business address.
      tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
      
      // if its deepdive records don't apply the pentalty...
       
      self.penalt := if (left.isDeepDive or isFCRA, 0, tempPenaltIndv),
      self := left));

    // filter by penalty
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
    recs_clean := recs_plus_pen (penalt <= pthreshold_translated);
      
    // Format for output
          
    recs_fmt := FaaV2_PilotServices.functions.fnfaaPilotSearchval(recs_clean);
    
    //TODO: sorting order is questionable: airmen_id is just a sequence not relevant to an "airman"
    recs_sort := sort(recs_fmt,if(AlsoFound,1,0),_penalty,Name.last,Name.first,Name.middle,
                                          Address.state, Address.city,airmen_id);
    
    tempresults_slim := if(suppress_results_due_alerts, dataset([],iesp.faapilot_Fcra.t_FcraPilotRecord),
                          project(recs_sort, iesp.faapilot_Fcra.t_FcraPilotRecord)); 
    
    FFD.MAC.PrepareResultRecord(tempresults_slim, final_results, statement_output, consumer_alerts, iesp.faapilot_Fcra.t_FcraPilotRecord); 
    
    return final_results;
  end;
    
  export val(params in_mod) := project(shared_val(in_mod, FALSE).Records, iesp.faapilot.t_PilotRecord);                             
  export fcra_val(params in_mod) := shared_val(in_mod, TRUE);    
    
end;
