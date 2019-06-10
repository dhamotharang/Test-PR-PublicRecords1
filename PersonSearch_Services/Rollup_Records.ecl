import AutoStandardI, iesp, doxie, Driversv2_Services, DriversV2, AddressFeedback_Services, AddressFeedback;

export Rollup_Records := module
  export params := interface(
    PersonSearch_Services.Search_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
    AutoStandardI.InterfaceTranslator.all_dids.params,
    doxie.IDataAccess)
    export string DataPermissionMask := ''; //conflicting definition; instead of '00000000000000' as in AutoStandardI.Constants.DataPermissionMask_default
    export IncludeBankruptcies := false;
    export IncludeSourceDocCounts := false;
    export includeAlsoFound := false;
    export includeSSNHri := false;
    export includeAddrHri := false;
    export includePhoneHri := false;
    export IncludeAlternatePhonesCount := false;
    export allowPartialSSNMatch := false;
    export allowEditDist := false;
    export includeDLInfo := false;
    export string DLState_Value := '';
    export string DLNumber_Value := '';
    export boolean noFail := false;
    export boolean IncludePhonesFeedback := false;
    export boolean IncludeAddressFeedback := false;
    export unsigned SourceDocFilter := 0;
    // Added for the FDN project, 1 new input option & 3 required input fields
    export IncludeFraudDefenseNetwork  := false;
    export unsigned6 FDNinput_gcid     := 0;
    export unsigned2 FDNinput_indtype  := 0;
    export unsigned6 FDNinput_prodcode := 0;
  end;

  export val(params in_mod) := function

    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
    // Need to perform checkNameVariants functionality on a conditional basis
    //
    // from the Moxie documentation:
    // If <check-name-variants> is specified, if the search fails to find any results with the specified name,
    // alternate spellings of the first and last name will be searched.

    // first with checknamevariants forced off, since it should only be used if no records found without it

    in_mod_novariants := module(project(in_mod, params))
      export checknamevariants := false;
      export noFail := true;
    end;

    dids_novariants := PersonSearch_Services.Search_IDs.val(in_mod_novariants);

    raw_in_mod_novariants := module(project(in_mod_novariants, PersonSearch_Services.Raw.Rollup_View.params,opt))
      export noFail := true;
    end;

    recs_from_raw_novariants := PersonSearch_Services.Raw.Rollup_View.byDID(dids_novariants, raw_in_mod_novariants, in_mod.IncludeSourceDocCounts);

    // now with the unaltered input, although only need to do so if checknamevariants was actually requested
    // as well as some name input criteria provided
    dlSearch :=in_mod.DLNumber_Value <> '' and in_mod.DLState_Value <> '';
    DLraw_dids := if(dlSearch,project(dedup(sort(DriversV2.Key_DL_Number(s_dl=in_mod.DLNumber_Value,orig_state=in_mod.DLState_Value,did >0),did),did),doxie.layout_references_hh));
    dlFound := dlSearch and count(DLraw_dids) > 0;
    header_dids := if(not dlFound,PersonSearch_Services.Search_IDs.val(in_mod));
    dids := if(dlFound,dedup(sort(DLraw_dids,did),did),header_dids);
    in_mod_DL := module(project(in_mod, PersonSearch_Services.Raw.Rollup_View.params,opt));
      export includeDailies := false;
      export reduceddata := true;
    end;
    raw_in_mod := module(project(in_mod, PersonSearch_Services.Raw.Rollup_View.params,opt));
    end;

    recs_from_raw_dids := if(dlFound,
                              PersonSearch_Services.Raw.Rollup_View.byDID(dids, in_mod_DL, in_mod.IncludeSourceDocCounts),
                              PersonSearch_Services.Raw.Rollup_View.byDID(dids, raw_in_mod, in_mod.IncludeSourceDocCounts));
    recs_filtered_by_DL := join(recs_from_raw_dids,dids,(integer)left.did = right.did,transform(Layouts.rollupRecord,self:=left));

    recs_from_raw := if(dlFound,recs_filtered_by_DL,recs_from_raw_dids);

    variantsUsed := not exists(recs_from_raw_novariants);

    use_mod := module(project(in_mod,params))
      export checknamevariants := variantsUsed;
    end;

    use_recs := if(dlFound,recs_from_raw,
                  if(exists(recs_from_raw_novariants), recs_from_raw_novariants,
                   if(in_mod.checknamevariants and
                      (in_mod.firstname <>'' or in_mod.lastname <> '' or in_mod.UnParsedFullName<> ''), recs_from_raw)));

    // apply final sort order
    temp_ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(use_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));

    ssn_recs_sort := sort(recs_from_raw, penalt, IF(ssns[1].valid_ssn = 'G', 0, 1), doxie.tnt_score(tnt),
                          -last_seen,-first_seen,
                          names[1].lname, names[1].fname, names[1].mname, names[1].name_suffix,
                          prim_name, prim_range,record);

    other_recs_sort := sort(recs_from_raw, penalt, doxie.tnt_score(tnt),
                            names[1].lname, names[1].fname, names[1].mname, names[1].name_suffix,
                            prim_name, prim_range,-last_seen,-first_seen,record);

    recs := if(temp_ssn_value <> '', ssn_recs_sort, other_recs_sort);

    // needed for the macro
    score_threshold_value := AutoStandardI.InterfaceTranslator.score_threshold_value.val(project(use_mod,AutoStandardI.InterfaceTranslator.score_threshold_value.params));
    doxie.MAC_Add_WeAlsoFound(recs, recs_waf, mod_access);
    recs_plus_waf := if(use_mod.includeAlsoFound, recs_waf, recs);

    MyDlDids := project(recs_plus_waf,transform(DriversV2_Services.layouts.did, Self.did :=(integer)left.did));
    MyDLSeqs := DriversV2_Services.DLRaw.get_seq_from_dids(MyDlDids);
    MyDLRaw := DriversV2_Services.DLRaw.narrow_view.by_seq(MyDLSeqs);
    DriversV2_Services.layouts.result_narrow rollDLs(DriversV2_Services.layouts.result_narrow l,dataset(DriversV2_Services.layouts.result_narrow) allrows) := TRANSFORM
      self.lic_issue_date := min(allrows(dl_number=l.dl_number,orig_state=l.orig_state,lic_issue_date>0),lic_issue_date);
      self.expiration_date := max(allrows(dl_number=l.dl_number,orig_state=l.orig_state,expiration_date>0),expiration_date);
      SELF := l;
    END;
    MyDLResults := sort(rollup(group(project(MyDLRaw,DriversV2_Services.layouts.result_narrow),dl_number,orig_state),group,rollDLs(left,rows(left))),history_name);
    Layouts.DlRecPlusDid slimDLs(DriversV2_Services.layouts.result_narrow l) := TRANSFORM
      self.did := (string)l.did;
      self.dl_num := l.dl_number;
      self.dl_st := l.orig_state;
      self.earliest_lic_issue_date := l.lic_issue_date;
      self.latest_expiration_date := l.expiration_date;
    END;
    MyDLResultsSlim := project(MyDLResults, slimDLs(left));
    Layouts.DlRecDataset makeChildDs(Layouts.DlRecPlusDid l, dataset(Layouts.DlRecPlusDid) r) := transform
      self.did := (string)intformat ((integer) l.did, 12, 1);
      self.dls := choosen(project(r(did=l.did),layouts.DlRec),iesp.Constants.BPS.ROLLUP_MAX_COUNT_DLS);
    end;
    MyDLDataset := rollup(group(MyDLResultsSlim,did),group,makechildDs(left, rows(left)));
    Layouts.rollupRecord appendDls(Layouts.rollupRecord l, Layouts.DlRecDataset r):= transform
      self.dls := r.dls;
      self := l;
    end;
    recs_dls := join(recs_plus_waf,MyDLDataset,left.did=right.did,appendDls(left,right),left outer);

    recs_to_use := if(use_mod.includeDLInfo, recs_dls, recs_plus_waf);

    AddressFeedback_Services.MAC_Append_Feedback(recs_to_use,
                                                 recs_to_useAddrFB,
                                                 address_feedback);

    recs_to_use_plus_addrFB := if(in_mod.IncludeAddressFeedback, recs_to_useAddrFB, recs_to_use);

    // This section of coding immediately below was added for the FDN project.
    // Set shorter alias names to be passed into new function
    boolean FDNContDataPermitted := doxie.compliance.use_FdnContributoryData(mod_access.DataPermissionMask);
    boolean FDNInqDataPermitted  := ~doxie.compliance.isFdnInquiry(mod_access.DataRestrictionMask);

    // Add coding to check for FDN data here, depending upon if FDN was asked for.
    // If it was, call the new function to check for the data and set the new indicators.
    ds_recs_to_use_fdn := if(use_mod.IncludeFraudDefenseNetwork,
                             PersonSearch_Services.Functions.func_FdnCheckRollupRecs(
                                 recs_to_use_plus_addrFB,
                                 use_mod.FDNinput_gcid,
                                 use_mod.FDNinput_indtype,
                                 use_mod.FDNinput_prodcode,
                                 FDNContDataPermitted,
                                 FDNInqDataPermitted),
                             //Otherwise just pass along the recs_to_use dataset
                             recs_to_use);

    // Format recs for XML output
    recs_fmtd := PersonSearch_Services.Functions.xformRollupRecs(ds_recs_to_use_fdn,
                                                                 use_mod.includeAlsoFound,
                                                                 use_mod.IncludeSourceDocCounts,
                                                                 use_mod.IncludeAlternatePhonesCount,
                                                                 use_mod.IncludePhonesFeedback,
                                                                 use_mod.SourceDocFilter);

    // For debugging, uncomment as needed
    //output(recs_to_use, named('recs_to_use'));
    //output(ds_recs_to_use_fdn, named('ds_recs_to_use_fdn'));

    return recs_fmtd;

  end;

end;
