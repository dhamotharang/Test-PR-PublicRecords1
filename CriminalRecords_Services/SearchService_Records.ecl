IMPORT AutoStandardI, ut, doxie, suppress, iesp, NID, FCRA, FFD, Gateway, STD;

EXPORT SearchService_Records := MODULE

  EXPORT shared_val(CriminalRecords_Services.IParam.search in_params,
             BOOLEAN isFCRA = FALSE) := FUNCTION
    
    is_cnsmr := in_params.isConsumer();
    // corrections on FCRA side require using overrides flag file. If isFCRA, then we have a DID in incoming in_params
    did_rec := IF(isFCRA, PROJECT(DATASET([{in_params.did}], doxie.layout_references), TRANSFORM(doxie.layout_best, SELF:=LEFT,SELF:=[])));
    
    //FCRA FFD
    BOOLEAN showConsumerStatements := FFD.FFDMask.isShowConsumerStatements(in_params.FFDOptionsMask);
    
    // Select the DID ( We are using the subject DID rather than the Best DID.)
    ds_dids := DATASET([{FFD.Constants.SingleSearchAcctno,
                         (UNSIGNED)in_params.did}],FFD.Layouts.DidBatch);
                         
    pc_recs := IF(isFCRA, FFD.FetchPersonContext(ds_dids, Gateway.Configuration.Get(), FFD.Constants.DataGroupSet.Criminal_Offenders, in_params.FFDOptionsMask));
    slim_pc_recs := FFD.SlimPersonContext(pc_recs);

    alert_indicators := FFD.ConsumerFlag.getAlertIndicators(pc_recs, in_params.FCRAPurpose, in_params.FFDOptionsMask)[1];
    suppress_results_due_alerts := isFCRA AND alert_indicators.suppress_records;
    
    statements := IF(isFCRA AND showConsumerStatements,FFD.prepareConsumerStatements(pc_recs), FFD.Constants.BlankConsumerStatements);
    consumer_alerts := IF(isFCRA, FFD.ConsumerFlag.prepareAlertMessages(pc_recs, alert_indicators, in_params.FFDOptionsMask), FFD.Constants.BlankConsumerAlerts);
    
    ds_flags := IF (isFCRA, FFD.GetFlagFile(did_rec, pc_recs), FCRA.compliance.blank_flagfile);

    // Don't send the slim PersonContext to ids
    ids := CriminalRecords_Services.SearchService_ids.val(in_params, isFCRA, ds_flags);
    
    recs := CriminalRecords_Services.Raw.getOffenderraw(ids, isFCRA, ds_flags, slim_pc_recs, in_params.FFDOptionsMask, is_cnsmr);
    
    // Filter by input date range if it was supplied
    ds_filt := recs(ut.isInRange(case_date,in_params.CaseFilingStartDate,in_params.CaseFilingEndDate));
     
    recs_dtfilt := IF(in_params.CaseFilingStartDate != '' OR in_params.CaseFilingEndDate != '',ds_filt,recs);
     
    // ---- Non-Strict Match Logic ----

    UNSIGNED2 pthreshold_translated := in_params.penalty_threshold;

    STRING2 ms(STRING2 st1,STRING2 st2, STRING2 st3,STRING2 in_state) := MAP(
      st1=in_state => st1,
      st2=in_state => st2,
      st3
    );
    CriminalRecords_Services.layouts.l_raw addPen(CriminalRecords_Services.layouts.l_raw L) := TRANSFORM
      tempindvmod := MODULE(PROJECT(in_params,AutoStandardI.LIBIN.PenaltyI_Indv.full,OPT))
        EXPORT allow_wildcard := FALSE;
        EXPORT city_field := L.p_city_name;
        EXPORT did_field := L.did;
        EXPORT fname_field := L.fname;
        EXPORT lname_field := L.lname;
        EXPORT mname_field := L.mname;
        EXPORT phone_field := '';
        EXPORT pname_field := L.prim_name;
        EXPORT postdir_field := L.postdir;
        EXPORT prange_field := L.prim_range;
        EXPORT predir_field := L.predir;
        EXPORT ssn_field := IF(L.ssn_appended<>'',L.ssn_appended,L.ssn);
        EXPORT state_field := ms(
          ut.st2abbrev(STD.STR.ToUpperCase(L.orig_state)),
          ut.st2abbrev(STD.STR.ToUpperCase(L.place_of_birth)),
          L.st,
          in_params.state
        );
        EXPORT suffix_field := L.addr_suffix;
        EXPORT sec_range_field := L.sec_range;
        EXPORT zip_field := L.zip5;
        EXPORT city2_field := L.v_city_name;
        EXPORT county_field := ms(
          ut.st2abbrev(STD.STR.ToUpperCase(L.county_name)),
          ut.st2abbrev(STD.STR.ToUpperCase(L.County_Of_Origin)),
          L.county_name,
          in_params.county_in
        );
        EXPORT dob_field := IF(L.pty_typ='2',L.dob_alias,L.dob);
        EXPORT dod_field := '';
      END;
      tempPenaltIndv := AutoStandardI.LIBCALL_PenaltyI_Indv.val(tempindvmod);

      tempPenaltOffKey := IF(in_params.offender_key != '' AND L.offender_key != in_params.offender_key, pthreshold_translated, 0);
      SELF.penalt := IF(isFCRA, 0, tempPenaltIndv + tempPenaltOffKey); // add extra penalty IF this was an offender_key search that mismatched
      SELF := L;
    END;
    recs_plus_pen_tmp := PROJECT(recs_dtfilt,addPen(LEFT));
        
  // Filter by state and county, when specified
    search_st := TRIM(STD.STR.ToUpperCase(in_params.state),LEFT,RIGHT);
    search_FilingJurisdictionState := TRIM(STD.STR.ToUpperCase(in_params.FilingJurisdictionState),LEFT,RIGHT);
    search_county := TRIM(STD.STR.ToUpperCase(in_params.county_in),LEFT,RIGHT);
    
    do_st_search := search_st<>'';
    do_county_search := search_county<>'';
    do_st_county_search := do_st_search AND do_county_search;
    
    recs_plus_pen_1 := MAP(do_st_county_search=> recs_plus_pen_tmp((search_st=ut.st2abbrev(STD.STR.ToUpperCase(orig_state)) OR
                              search_st=STD.STR.ToUpperCase(st)) AND
                              (STD.STR.ToUpperCase(search_county)=STD.STR.ToUpperCase(county_name) OR
                              STD.STR.ToUpperCase(search_county)=STD.STR.ToUpperCase(County_Of_Origin))),
                           do_st_search => recs_plus_pen_tmp(search_st=ut.st2abbrev(STD.STR.ToUpperCase(orig_state)) OR
                                              search_st=STD.STR.ToUpperCase(st)),
                           recs_plus_pen_tmp);


    recs_plus_pen := IF(search_FilingJurisdictionState<>'',
                        recs_plus_pen_1(search_FilingJurisdictionState=ut.st2abbrev(STD.STR.ToUpperCase(orig_state))),
                        recs_plus_pen_1);
                    

//******* Alternate way of filtering******************************
    // original code: - Will not get out of state criminal records
    
        // recs_plus_pen_1 := recs_plus_pen_tmp(
                           // (search_st='' or search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state))) AND
                           // (search_st='' or search_county='' or (search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) and
                           // (stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(county_name) or
                            // stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(County_Of_Origin))))
                                           // );
                                           
                                           
      // will get out of state criminal records
    
    // do_st_search:=if(search_st<>'',true,false);
    // do_county_search:=if(search_county<>'',true,false);
    // do_st_county_search:=if(do_st_search and do_county_search,true,false);
    
    // recs_plus_pen := MAP(do_st_county_search=> recs_plus_pen_tmp((search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) or
                              // search_st=stringlib.stringtouppercase(st)) and
                              // (stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(county_name) or
                              // stringlib.stringtouppercase(search_county)=stringlib.stringtouppercase(County_Of_Origin))),
              // do_st_search => recs_plus_pen_tmp(search_st=ut.st2abbrev(stringlib.stringtouppercase(orig_state)) or
                               // search_st=stringlib.stringtouppercase(st)),
              // recs_plus_pen_tmp);
//*****************************************************************
    
    // ---- Strict Match Logic ----
    recs_filt:=recs_plus_pen(penalt=0);
    // Filter by name matching
    search_fname := AutoStandardI.InterfaceTranslator.fname_value.val(in_params);
    search_mname := AutoStandardI.InterfaceTranslator.mname_value.val(in_params);
    search_lname := AutoStandardI.InterfaceTranslator.lname_value.val(in_params);
    BOOLEAN search_mi := (LENGTH(TRIM(search_mname))=1);
    BOOLEAN preferred_fname(STRING fname) := NID.mod_PFirstTools.PFLeqPFR(search_fname, TRIM(fname,LEFT,RIGHT));
    recs_strict := recs_filt((search_fname='' OR search_fname=TRIM(fname,LEFT,RIGHT) OR (in_params.allownicknames AND preferred_fname(fname))),
                             search_lname ='' OR search_lname=TRIM(lname,LEFT,RIGHT) OR (in_params.phoneticmatch AND metaphonelib.DMetaPhone1(search_lname)[1..6]=metaphonelib.DMetaPhone1(lname)[1..6]),
                             search_mname='' OR search_mname=TRIM(mname,LEFT,RIGHT) OR (search_mi AND search_mname[1]=mname[1])
                            );
          
    // ---- Suppression ----
    
    quality_recs := IF(in_params.StrictMatch, recs_strict, recs_plus_pen(penalt <= pthreshold_translated));
    
    Suppress.MAC_Suppress(quality_recs,pull_1,in_params.application_type,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);
    Suppress.MAC_Suppress(pull_1,pull_2,in_params.application_type,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);
    Suppress.MAC_Suppress(pull_2,pull_3,in_params.application_type,,,Suppress.Constants.DocTypes.OffenderKey,offender_key, isFCRA := isFCRA);
    
    doxie.MAC_PruneOldSSNs(pull_3, out_f_p1, ssn, did, isFCRA);
    doxie.MAC_PruneOldSSNs(out_f_p1, out_f_p2, ssn_appended, did, isFCRA);

    suppress.MAC_Mask(out_f_p2, out_intm, ssn, blank, TRUE, FALSE, maskVal := in_params.ssn_mask);
    suppress.MAC_Mask(out_intm, out_mskd, ssn_appended, blank, TRUE, FALSE, maskVal := in_params.ssn_mask);

    // ---- Final formatting ----
    ds_with_offenses := CriminalRecords_Services.Functions.fnAppendOffenses(out_mskd,in_params,isFCRA);
    recs_fmt := CriminalRecords_Services.Functions.fnCrimSearchVal(ds_with_offenses);
    
    recs_sort := SORT(
      recs_fmt,
      IF(AlsoFound,1,0), _penalty, name.last, name.FIRST, name.middle, name.suffix, -casefilingdate, RECORD
    );
    
    tempresults_slim := IF(suppress_results_due_alerts, DATASET([],iesp.criminal_fcra.t_FcraCrimSearchRecord),
                           PROJECT(recs_sort, iesp.criminal_fcra.t_FcraCrimSearchRecord));
    
    FFD.MAC.PrepareResultRecord(tempresults_slim, final_results, statements, consumer_alerts, iesp.criminal_fcra.t_FcraCrimSearchRecord);
    
    RETURN final_results;

  END;
  
  EXPORT val(CriminalRecords_Services.IParam.search in_params) := PROJECT(shared_val(in_params, FALSE).Records, iesp.criminal.t_CrimSearchRecord);
  EXPORT fcra_val(CriminalRecords_Services.IParam.search in_params) := shared_val(in_params, TRUE);
  
END;
