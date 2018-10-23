import AutoStandardI, doxie_files, ut, doxie, suppress, iesp, NID, FCRA, FFD, Gateway;

export SearchService_Records := module

  export shared_val(CriminalRecords_Services.IParam.search in_params,
             boolean isFCRA = false) := function
    
    is_cnsmr := ut.IndustryClass.is_Knowx;
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_rec := if(isFCRA, project(dataset([{in_params.did}], doxie.layout_references), transform(doxie.layout_best, self:=left,self:=[])));
    
    //FCRA FFD 
    boolean showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
    
    // Select the DID ( We are using the subject DID rather than the Best DID.) 
    ds_dids := dataset([{FFD.Constants.SingleSearchAcctno,
                         (unsigned)in_params.did}],FFD.Layouts.DidBatch);
                         
    pc_recs := if(isFCRA, FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.Criminal_Offenders, in_params.FFDOptionsMask));
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);

    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA and alert_indicators.suppress_records;
    
    statements := if(isFCRA and showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := if(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
    
    ds_flags := if (isFCRA, FFD.GetFlagFile(did_rec, pc_recs), FCRA.compliance.blank_flagfile);

    // Don't send the slim PersonContext to ids
    ids := CriminalRecords_Services.SearchService_ids.val(in_params, isFCRA, ds_flags);
    
    recs := CriminalRecords_Services.Raw.getOffenderraw(ids, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask, is_cnsmr);
    
    // Filter by input date range if it was supplied
    ds_filt := recs(ut.isInRange(case_date,in_params.CaseFilingStartDate,in_params.CaseFilingEndDate));  
     
    recs_dtfilt := if(in_params.CaseFilingStartDate != '' or in_params.CaseFilingEndDate != '',ds_filt,recs);
     
    // ---- Non-Strict Match Logic ----

    unsigned2 pthreshold_translated := in_params.penalty_threshold;

    string2 ms(string2 st1,string2 st2, string2 st3,string2 in_state) := map(
      st1=in_state => st1,
      st2=in_state => st2,
      st3
    );
    CriminalRecords_Services.layouts.l_raw addPen(CriminalRecords_Services.layouts.l_raw L) := transform
      tempindvmod := module(project(in_params,AutoStandardI.LIBIN.PenaltyI_Indv.full,opt))
        export allow_wildcard  := false;
        export city_field    := L.p_city_name;
        export did_field    := L.did;
        export fname_field    := L.fname;
        export lname_field    := L.lname;
        export mname_field    := L.mname;
        export phone_field    := '';
        export pname_field    := L.prim_name;
        export postdir_field  := L.postdir;
        export prange_field    := L.prim_range;
        export predir_field    := L.predir;
        export ssn_field    := if(L.ssn_appended<>'',L.ssn_appended,L.ssn); 
        export state_field    := ms(
          ut.st2abbrev(stringlib.stringtouppercase(L.orig_state)),
          ut.st2abbrev(stringlib.stringtouppercase(L.place_of_birth)),
          L.st,
          in_params.state
        );
        export suffix_field    := L.addr_suffix;
        export sec_range_field := L.sec_range;
        export zip_field      := L.zip5;
        export city2_field    := L.v_city_name;
        export county_field    := ms(
          ut.st2abbrev(stringlib.stringtouppercase(L.county_name)),
          ut.st2abbrev(stringlib.stringtouppercase(L.County_Of_Origin)),
          L.county_name,
          in_params.county_in
        );
        export dob_field    := if(L.pty_typ='2',L.dob_alias,L.dob);
        export dod_field    := '';
      end;
      tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);

      tempPenaltOffKey := if(in_params.offender_key != '' and L.offender_key != in_params.offender_key, pthreshold_translated, 0);
      self.penalt := if(isFCRA, 0, tempPenaltIndv + tempPenaltOffKey); // add extra penalty if this was an offender_key search that mismatched
      self := L;
    end;
    recs_plus_pen_tmp := project(recs_dtfilt,addPen(left));
        
  // Filter by state and county, when specified
    search_st    := trim(StringLib.StringToUpperCase(in_params.state),left,right);
    search_FilingJurisdictionState    := trim(StringLib.StringToUpperCase(in_params.FilingJurisdictionState),left,right);
    search_county  := trim(StringLib.StringToUpperCase(in_params.county_in),left,right);
    
    do_st_search := search_st<>'';
    do_county_search := search_county<>'';
    do_st_county_search := do_st_search and do_county_search;
    
    recs_plus_pen_1  := MAP(do_st_county_search=> recs_plus_pen_tmp((search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) or 
                              search_st=stringlib.stringtouppercase(st)) and 
                              (stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(county_name) or
                              stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(County_Of_Origin))),
                           do_st_search     =>  recs_plus_pen_tmp(search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) or 
                                              search_st=stringlib.stringtouppercase(st)),
                           recs_plus_pen_tmp);


    recs_plus_pen := if(search_FilingJurisdictionState<>'',
                        recs_plus_pen_1(search_FilingJurisdictionState=ut.st2abbrev(stringlib.stringtouppercase(orig_state))),
                        recs_plus_pen_1);
                    

//******* Alternate way of filtering******************************
    // original code: - Will not get out of state criminal records
    
        // recs_plus_pen_1     := recs_plus_pen_tmp(
                           // (search_st='' or search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state))) AND
                           // (search_st='' or search_county='' or (search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) and 
                           // (stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(county_name) or 
                            // stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(County_Of_Origin))))
                                           // );
                                           
                                           
      // will get out of state criminal records                           
    
    // do_st_search:=if(search_st<>'',true,false);
    // do_county_search:=if(search_county<>'',true,false);
    // do_st_county_search:=if(do_st_search and do_county_search,true,false);
    
    // recs_plus_pen  := MAP(do_st_county_search=> recs_plus_pen_tmp((search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) or 
                              // search_st=stringlib.stringtouppercase(st)) and 
                              // (stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(county_name) or
                              // stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(County_Of_Origin))),
              // do_st_search     =>  recs_plus_pen_tmp(search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) or 
                               // search_st=stringlib.stringtouppercase(st)),
              // recs_plus_pen_tmp);
//*****************************************************************                
    
    // ---- Strict Match Logic ----
    recs_filt:=recs_plus_pen(penalt=0);
    // Filter by name matching
    search_fname  := AutoStandardI.InterfaceTranslator.fname_value.val(in_params);
    search_mname  := AutoStandardI.InterfaceTranslator.mname_value.val(in_params);
    search_lname  := AutoStandardI.InterfaceTranslator.lname_value.val(in_params);
    boolean search_mi := (length(trim(search_mname))=1);
    boolean preferred_fname(string fname) := NID.mod_PFirstTools.PFLeqPFR(search_fname, trim(fname,left,right));
    recs_strict := recs_filt((search_fname='' or search_fname=trim(fname,left,right) or (in_params.allownicknames and preferred_fname(fname))),
                             search_lname ='' or search_lname=trim(lname,left,right) or (in_params.phoneticmatch and metaphonelib.DMetaPhone1(search_lname)[1..6]=metaphonelib.DMetaPhone1(lname)[1..6]),
                             search_mname='' or search_mname=trim(mname,left,right) or (search_mi and search_mname[1]=mname[1])
                            );
          
    // ---- Suppression ----
    
    quality_recs := if(in_params.StrictMatch, recs_strict, recs_plus_pen(penalt <= pthreshold_translated));
    
    Suppress.MAC_Suppress(quality_recs,pull_1,in_params.ApplicationType,Suppress.Constants.LinkTypes.DID,did);
    Suppress.MAC_Suppress(pull_1,pull_2,in_params.ApplicationType,Suppress.Constants.LinkTypes.SSN,ssn);
    Suppress.MAC_Suppress(pull_2,pull_3,in_params.ApplicationType,,,Suppress.Constants.DocTypes.OffenderKey,offender_key);
    
    doxie.MAC_PruneOldSSNs(pull_3, out_f_p1, ssn, did, isFCRA);
    doxie.MAC_PruneOldSSNs(out_f_p1, out_f_p2, ssn_appended, did, isFCRA);

    doxie.MAC_Header_Field_Declare(isFCRA);
    suppress.MAC_Mask(out_f_p2, out_intm, ssn, blank, true, false);
    suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, true, false);

    // ---- Final formatting ----
    added_in_mod := project(in_params, functions.params);
    recs_fmt := CriminalRecords_Services.Functions.fnCrimSearchVal(out_mskd, added_in_mod);
    
    recs_sort := sort(
      recs_fmt,
      if(AlsoFound,1,0), _penalty, name.last, name.first, name.middle, name.suffix, -casefilingdate, record
    );
    
    tempresults_slim := if(suppress_results_due_alerts, dataset([],iesp.criminal_fcra.t_FcraCrimSearchRecord),
                           project(recs_sort, iesp.criminal_fcra.t_FcraCrimSearchRecord)); 
    
    FFD.MAC.PrepareResultRecord(tempresults_slim, final_results, statements, consumer_alerts, iesp.criminal_fcra.t_FcraCrimSearchRecord); 
    
    return final_results;

  end;
  
  export val(CriminalRecords_Services.IParam.search in_params) := project(shared_val(in_params, FALSE).Records, iesp.criminal.t_CrimSearchRecord);                             
  export fcra_val(CriminalRecords_Services.IParam.search in_params) := shared_val(in_params, TRUE);
  
end;