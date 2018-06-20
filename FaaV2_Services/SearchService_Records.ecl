// takes id's (did's bdid's)...maybe aircraft number
// hits payload key...and then formats into layout expected ...sorts it
// after you fetch ID's...

import AutoStandardI, FaaV2_Services, ut, doxie, iesp, FCRA, FFD, Gateway;

export SearchService_Records := module
  export params := interface(
    FAAV2_Services.SearchService_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.glb_purpose.params,
    AutoStandardI.InterfaceTranslator.dppa_purpose.params,
    AutoStandardI.InterfaceTranslator.penalt_threshold_value.params,
    FCRA.iRules)
    export string25 city:= '';
  end;
  shared shared_val(params in_mod,boolean isFCRA = false) := function
  
    ms(string70 a, string70 b, string70 c) :=
      map(a = '' => b,
          b = '' => a,
          ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b); 
          
    // Get the IDs, pull the payload records and add Aircraft_number (n_number to them.
    ids := faav2_services.SearchService_IDs.val(in_mod,isFCRA);

    ds_best := project(ids,transform(doxie.layout_best,self:=left,self:=[]));

    search_ids := project (ids, FaaV2_Services.Layouts.search_id);
    
    //FCRA FFD  
    gateways := Gateway.Configuration.Get();
    boolean ShowConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_mod.FFDOptionsMask);
    
    //  Select the DID ( We are using the subject DID rather than the Best DID.) 
    ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,
                         (unsigned)in_mod.DID}],FFD.Layouts.DidBatch);
                         
    pc_recs := if(isFCRA,FFD.FetchPersonContext(ds_dids, gateways, FFD.Constants.DataGroupSet.Aircraft_Search, in_mod.FFDOptionsMask));
    
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);
    
    ds_flags := FFD.GetFlagFile (ds_best, pc_recs);
    
    recs := FaaV2_Services.Raw.getByAircraftId(search_ids, in_mod.applicationType, isFCRA, ds_flags, slim_pc_recs, in_mod.FFDOptionsMask);

    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_mod.FCRAPurpose, in_mod.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
   
     // Make Statements
    statement_output := if(isFCRA and ShowConsumerStatements, FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_mod.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
                                       
   recs_alpha_sort := sort(recs, lname, fname, mname, state, city, aircraft_id);                        
    // Calculate the penalty on the records
    recs_plus_pen := project(recs_alpha_sort,transform(FaaV2_Services.Layouts.rawrec,
      tempindvmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard := false;
        export city_field := trim(ms(left.p_city_name, left.v_city_name, in_mod.city),left,right);
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
        export suffix_field := left.addr_suffix;
        export sec_range_field := left.sec_range;
        export zip_field := left.zip;
        export city2_field := '';
        export county_field := left.county;
        export dob_field := '';
        export dod_field := '';
      end;
      
      tempbizmod := module(project(in_mod,AutoStandardI.LIBIN.PenaltyI_Biz.full,opt))
        export allow_wildcard := false;
        export bdid_field := '';
        export city_field := trim(ms(left.p_city_name, left.v_city_name, in_mod.city),left,right);
        export cname_field := left.compname;
        export fein_field := '';
        export phone_field := '';
        export pname_field := left.prim_name;
        export postdir_field := left.postdir;
        export prange_field := left.prim_range;
        export predir_field := left.predir;
        export state_field := left.state;
        export suffix_field := left.addr_suffix;
        export sec_range_field := left.sec_range;
        export zip_field := left.zip;
        export city2_field := '';
        export county_field := left.county;
      end;
      
      // The business info will only ever use the business address.
      tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);
      //tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val(tempbizmod);
      
      // did it this way cause address penalty (val_county and val_addr) 
      // was getting double counted if previous line above was used.
      tempPenaltBiz := AutoStandardI.LIBCALL_PenaltyI_Biz.val_bdid(tempbizmod) + 
                       AutoStandardI.LIBCALL_PenaltyI_Biz.val_biz_name(tempbizmod) +
                       AutoStandardI.LIBCALL_PenaltyI_Biz.val_fein(tempbizmod) +
                       AutoStandardI.LIBCALL_PenaltyI_Biz.val_phone(tempbizmod);
      
      // if its deepdive records don't apply the pentalty...or if did is provided
       
      self.penalt := if (left.isDeepDive or isFCRA, 0, tempPenaltIndv + tempPenaltBiz),
      self := left));

    // Format for output
    recs_fmt := FaaV2_Services.Functions.fnfaaSearchval(recs_plus_pen);
    
    mod_penalty := project (in_mod, AutoStandardI.InterfaceTranslator.penalt_threshold_value.params);
    unsigned2 pthreshold_translated := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val (mod_penalty);
    recs_pen := recs_fmt (_penalty <= pthreshold_translated);

    // sort by lname, fname etc..if search is not by aircraft Number.
    // otherwise sort returned is chronological in nature.
    recs_sort := if (in_mod.n_number = '', sort(recs_pen,if(AlsoFound,1,0), _penalty, Name.last,Name.first,Name.middle, CompanyName, 
                                          Address.state, Address.city,aircraft_id),
                                          sort(recs_pen,if(AlsoFound,1,0), _penalty, 
                                                -dateLastSeen.year, -dateLastSeen.month, -dateLastSeen.day, aircraft_id));
    
    tempresults_slim := if (suppress_results_due_alerts, dataset([],iesp.faaaircraft_Fcra.t_FcraAircraftRecord),
                           project(recs_sort, iesp.faaaircraft_Fcra.t_FcraAircraftRecord)); 
    
    FFD.MAC.PrepareResultRecord(tempresults_slim, final_results, statement_output, consumer_alerts, iesp.faaaircraft_Fcra.t_FcraAircraftRecord); 
    
    return final_results;
  end;
    
    export val(params in_mod) := project(shared_val(in_mod, FALSE).Records, iesp.faaaircraft.t_AircraftRecord);                             
    export fcra_val(params in_mod) := shared_val(in_mod, TRUE);    
    
end;
