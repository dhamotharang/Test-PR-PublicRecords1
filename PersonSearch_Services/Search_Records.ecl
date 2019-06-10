import AutoStandardI, ut, doxie, CriminalRecords_Services, PhonesFeedback, AddressFeedback, PhonesFeedback_Services, AddressFeedback_Services;

export Search_Records := module
  export params := interface(
    PersonSearch_Services.Search_IDs.params,
    AutoStandardI.LIBIN.PenaltyI_Indv.base,
    AutoStandardI.InterfaceTranslator.any_addr_error_value.params,
    AutoStandardI.InterfaceTranslator.addr_suffix_value.params,
    AutoStandardI.InterfaceTranslator.all_dids.params,
    doxie.IDataAccess)
    export DataPermissionMask := ''; //conflicting definition
    export IncludeBankruptcies := false;
    export IncludeSourceDocCounts := false;
    export IncludePriorAddresses := false;
    export returnAlsoFound := false;
    export includeSSNHri := false;
    export includeAddrHri := false;
    export includePhoneHri := false;
    export allowPartialSSNMatch := false;
    export allowEditDist := false;
    export IncludeAlternatePhonesCount := false;
    export IncludePhonesPlus := false;
    export IncludeCriminalIndicators := false;
    export EnhancedSort := false;
    export IncludePhonesFeedback := false;
    export IncludeAddressFeedback := false;
    export unsigned SourceDocFilter := 0;
    // Added for the FDN project, 1 new input option & 3 required input fields ???
    export IncludeFraudDefenseNetwork  := false;
    export unsigned6 FDNinput_gcid     := 0;
    export unsigned2 FDNinput_indtype  := 0;
    export unsigned6 FDNinput_prodcode := 0;
  end;

  export val(params in_mod) := function

    mod_access := PROJECT (in_mod, doxie.IDataAccess);
    // Need to perform checkNameVariants functionality on a conditional basis
    //
    // from the Moxie documentation:
    // If <check-name-variants> is specified, if the search fails to find any results with the specified name,
    // alternate spellings of the first and last name will be searched.

    // first with checknamevariants forced off, since it should only be used if no records found without it
    in_mod_novariants := module(project(in_mod, params))
      export checknamevariants := false;
    end;

    dids_novariants := PersonSearch_Services.Search_IDs.val(in_mod_novariants);

    raw_in_mod_novariants := module(project(in_mod_novariants, PersonSearch_Services.Raw.Search_View.params,opt))
    end;

    recs_from_raw_novariants := PersonSearch_Services.Raw.Search_View.byDID(dids_novariants, raw_in_mod_novariants);

    // now with the unaltered input, although only need to do so if checknamevariants was actually requested
    // as well as some name input criteria provided
    dids := PersonSearch_Services.Search_IDs.val(in_mod);

    raw_in_mod := module(project(in_mod, PersonSearch_Services.Raw.Search_View.params,opt))
    end;

    recs_from_raw := PersonSearch_Services.Raw.Search_View.byDID(dids, raw_in_mod);

    variantsUsed := not exists(recs_from_raw_novariants);

    use_mod := module(project(in_mod,params))
      export checknamevariants := variantsUsed;
    end;

    use_recs := if(exists(recs_from_raw_novariants), recs_from_raw_novariants,
                   if(in_mod.checknamevariants and
                      (in_mod.firstname <>'' or in_mod.lastname <> '' or in_mod.UnParsedFullName<> ''), recs_from_raw));



    use_recs roll(use_recs l, use_recs r) := TRANSFORM

      self.penalt := IF( l.penalt<r.penalt, l.penalt,r.penalt );
      self.mname := IF( length(trim(l.mname)) > length(trim(r.mname)), l.mname, r.mname);
      self.title := IF( length(trim(l.title)) > length(trim(r.title)), l.title, r.title);
      self.name_suffix := IF( length(trim(l.name_suffix)) > length(trim(r.name_suffix)), l.name_suffix, r.name_suffix);
      self.tnt := IF(doxie.tnt_score(l.tnt) < doxie.tnt_score(r.tnt), l.tnt, r.tnt);
      self.first_seen := IF(l.first_seen > 0 and l.first_seen < r.first_seen, l.first_seen, r.first_seen);
      self.last_seen := IF(l.last_seen > r.last_seen, l.last_seen, r.last_seen);
      self.predir := IF( length(trim(l.predir)) > length(trim(r.predir)), l.predir, r.predir);
      self.suffix := IF( length(trim(l.suffix)) > length(trim(r.suffix)), l.suffix, r.suffix);
      self.postdir := IF( length(trim(l.postdir)) > length(trim(r.postdir)), l.postdir, r.postdir);
      self.unit_desig := IF( length(trim(l.unit_desig)) > length(trim(r.unit_desig)), l.unit_desig, r.unit_desig);
      self.sec_range := IF( length(trim(l.sec_range)) > length(trim(r.sec_range)), l.sec_range, r.sec_range);
      self.city_name := IF( length(trim(l.city_name)) > length(trim(r.city_name)), l.city_name, r.city_name);
      self.phone := if(TRIM(l.phone) <> '', l.phone,r.phone);
      self.listed_phone := if(TRIM(l.listed_phone) <> '', l.listed_phone,r.listed_phone);
      self.listed_name := if(TRIM(l.listed_name) <> '', l.listed_name,r.listed_name);
      self.dob := IF(l.dob>r.dob,l.dob, r.dob); // better date is the more populated one
      self.age := IF(l.dob>r.dob,l.age, r.age); // Not a typo, taking age from 'best' dob
      self.dead_age := IF(l.dob>r.dob,l.dead_age, r.dead_age); // Not a typo, taking age from 'best' dob
      self.ssn := if(l.ssn <> '', l.ssn,r.ssn);
      self.ssn_issue_early := IF(l.ssn_issue_early <> 0, l.ssn_issue_early, r.ssn_issue_early);
      self.ssn_issue_last := IF(l.ssn_issue_last <> 0, l.ssn_issue_last, r.ssn_issue_last);
      self.ssn_issue_place := IF(l.ssn_issue_place <> '', l.ssn_issue_place, r.ssn_issue_place);
      self.ssn_valid_issue := IF(l.ssn_valid_issue <> '', l.ssn_valid_issue, r.ssn_valid_issue);
      self.valid_ssn := IF( length(trim(l.ssn))>length(trim(r.ssn)) or length(trim(l.ssn))=length(trim(r.ssn)) and
                            r.valid_ssn='M', l.valid_ssn, r.valid_ssn);
      self.ssn_issue_early_fulldate := IF(l.ssn_issue_early_fulldate <> 0, l.ssn_issue_early_fulldate, r.ssn_issue_early_fulldate);
      self.ssn_issue_last_fulldate := IF(l.ssn_issue_last_fulldate <> 0, l.ssn_issue_last_fulldate, r.ssn_issue_last_fulldate);;
      self.ssn_issue_state := IF(l.ssn_issue_state <> '', l.ssn_issue_state, r.ssn_issue_state);
      self.comp_prop_count := max(l.comp_prop_count,r.comp_prop_count);
      self.veh_cnt := max(l.veh_cnt,r.veh_cnt);
      self.prof_count := max(l.prof_count,r.prof_count);
      self.corp_affil_count := max(l.corp_affil_count,r.corp_affil_count);
      self.phonesplus_count := max(l.phonesplus_count,r.phonesplus_count);
      self.email_count := max(l.email_count,r.email_count);
      self.phones := if (exists(l.phones), l.phones, r.phones);
      self.rids := l.rids + r.rids;
      self := l;
    END;
    // apply bpssearch filtering/rolling up
    recs_rolled_phone := rollup(sort(use_recs,did,lname,fname,prim_range,prim_name,st,zip,sec_range,mname,name_suffix,ssn,
                               dob,phone,listed_phone,listed_name),
                         left.did = right.did and
                         left.lname = right.lname and
                         left.fname = right.fname and
                         left.prim_range = right.prim_range and
                         left.prim_name = right.prim_name and
                         left.st = right.st and
                         left.zip = right.zip and
                         ut.Sec_Range_EQ(left.sec_range, right.sec_range) < 10 and
                         (left.mname = right.mname or ut.lead_contains(left.mname,right.mname)) and
                         left.name_suffix = right.name_suffix and
                         ut.NNEQ_SSN(left.ssn,right.ssn) and
                         ut.NNEQ_Date(left.dob,right.dob) and
                         ut.NNEQ_Phone(left.phone,right.phone) and
                         ut.NNEQ_Phone(left.listed_phone,right.listed_phone) and
                         ut.NNEQ(left.listed_name,right.listed_name),roll(LEFT,RIGHT));
    recs_rolled_nophone := rollup(sort(use_recs,did,lname,fname,prim_range,prim_name,st,zip,sec_range,mname,name_suffix,ssn,
                               dob/*,phone,listed_phone,listed_name*/),
                         left.did = right.did and
                         left.lname = right.lname and
                         left.fname = right.fname and
                         left.prim_range = right.prim_range and
                         left.prim_name = right.prim_name and
                         left.st = right.st and
                         left.zip = right.zip and
                         ut.Sec_Range_EQ(left.sec_range, right.sec_range) < 10 and
                         (left.mname = right.mname or ut.lead_contains(left.mname,right.mname)) and
                         left.name_suffix = right.name_suffix and
                         ut.NNEQ_SSN(left.ssn,right.ssn) and
                         ut.NNEQ_Date(left.dob,right.dob)/* and
                         ut.NNEQ_Phone(left.phone,right.phone) and
                         ut.NNEQ_Phone(left.listed_phone,right.listed_phone) and
                         ut.NNEQ(left.listed_name,right.listed_name)*/,roll(LEFT,RIGHT));

    recs_rolled := if (in_mod.IncludePhonesPlus or in_mod.IncludeAlternatePhonesCount, recs_rolled_nophone, recs_rolled_phone);

    ssnOnly := Functions.ssnOnly.val(project(use_mod, Functions.ssnOnly.params));
    allRecs := Functions.allDidRecs.val(project(use_mod, Functions.allDidRecs.params));

    // apply final sort order
    //
    // Note -- these formerly were quite different but have nearly converged now.
    // will leave them separate for now, but may have an opportunity to have a single sort order at some point

    phone_value := AutoStandardI.InterfaceTranslator.phone_value.val(project(use_mod,AutoStandardI.InterfaceTranslator.phone_value.params));

    // for an SSN only search, only sort the best subject to the top (those with valid_ssn='G')
    // all others should sort by the remaining sort criteria

    // change the all_recs sort to use the lowest penalty for the records in the DID group ahead
    // of the tnt_score and address dates.   This effectively puts the 'best record for the
    // best matching subject' on the top of the results.
    final_recs_grp := group(sort(recs_rolled, did, penalt), did);

    // establish the lowest penalty for each set of records with the same DID
    final_recs_grp getLowestPenGroup(final_recs_grp le, final_recs_grp ri) := transform
      firstPass := (unsigned)le.did = 0;
      // since the records are sorted by ascending penalty per group, use right's penalt on the first pass
      // (by definition lowest for the group), then carry that across all of the group's records
      self.group_min_penalt := if(firstPass, ri.penalt, le.group_min_penalt);
      self := ri;
    end;
    final_recs_grp_pen := ungroup(iterate(final_recs_grp, getLowestPenGroup(LEFT, RIGHT)));

    // use grp_pen to put the best matched subject's records on top
    std_recs_sort := sort(final_recs_grp_pen, if(ssnOnly, IF(valid_ssn = 'G', 0, 1), 0), group_min_penalt,
                      doxie.tnt_score(tnt),
                      // special rule to address update frequency issues of EDA data that has less
                      // populated fname and street elements.  Needs to be ahead of last_seen test
                      // to prevent EDA records from displaying on top of the results early in a given month before
                      // header data has updated
                      IF(doxie.tnt_score(tnt) = 1 and (prim_name = '' or length(trim(fname)) <= 1), 1, 0),
                      -last_seen,
                      // prefer populated street addresses over city/st only (common EDA address variant)
                      IF(prim_name <> '', 0, 1),
                      // prefer full first names over first initial (common EDA name variant)
                      IF(length(trim(fname)) > 1, 0, 1),
                      -first_seen,lname, fname, mname, name_suffix,
                      prim_name, prim_range,record);

    // #123075: using enhanced sort to mimic HFS sorting in doxie.header_presentation.
    ssn_value := AutoStandardI.InterfaceTranslator.ssn_value.val(project(use_mod,AutoStandardI.InterfaceTranslator.ssn_value.params));
    high_valid_ssn := 100; // default high value; lowest is best
    srchedSSNMatch(string9 ssn) := ssn_value <> '' and ssn_value = ssn;
    enhanced_recs_sort := sort(final_recs_grp_pen,
                               penalt, if(srchedSSNMatch(ssn), doxie.valid_ssn_score(valid_ssn), high_valid_ssn),
                               doxie.tnt_score(tnt), -MAX(first_seen, last_seen),
                               phone<>listed_phone, lname, fname, mname, prim_range, did, phone, rid);

    all_recs_sort := if(in_mod.EnhancedSort, enhanced_recs_sort, std_recs_sort);

    other_recs_sort := sort(final_recs_grp_pen,
                      if(phone_value <> '', 0, penalt),
                      doxie.tnt_score(tnt),
                      lname, fname, mname, name_suffix,
                      -last_seen,-first_seen, prim_name, prim_range, record);

    // if include prior addresses is set, keep them all; otherwise keep only the first record
    all_recs_lim := if(use_mod.IncludePriorAddresses or in_mod.includealldidrecords, all_recs_sort, choosen(all_recs_sort, 1));

    recs_wch := if(allRecs or ssnOnly, all_recs_lim, other_recs_sort);

    //lookup bankruptcy info if requested
    macros.add_bankruptcy_info(recs_wch, recs, Layouts.headerRecordBK, use_mod.IncludeBankruptcies);

    // needed for the macro
    score_threshold_value := in_mod.scorethreshold;
    doxie.MAC_Add_WeAlsoFound(recs, recs_waf, mod_access);

    recs_plus_waf := if(use_mod.returnAlsoFound, recs_waf, recs);

    // add crim indicators
    recsIn := PROJECT(recs_plus_waf,TRANSFORM({Layouts.headerRecordExt,STRING12 UniqueId, STRING10 phone_fb},
                                               SELF.UniqueId:=LEFT.did,
                                               SELF.phone_fb:=if(left.listed_phone<>'', left.listed_phone, left.phone),
                                               SELF:=LEFT,SELF:=[]));
    CriminalRecords_Services.MAC_Indicators(recsIn,recsCrim);
    recs_plus_crim := IF(in_mod.IncludeCriminalIndicators,recsCrim,recsIn);

    PhonesFeedback_Services.Mac_Append_Feedback(recs_plus_crim
                                              ,UniqueId
                                              ,phone_fb
                                              ,recs_phnFB
                                              ,phone_feedback
                                              );
    recs_plus_phnFB := if(in_mod.IncludePhonesFeedback, recs_phnFB, recs_plus_crim);

    AddressFeedback_Services.MAC_Append_Feedback(recs_plus_phnFB,
                                                 recs_addrFB,
                                                 address_feedback);

    recs_plus_addrFB := if(in_mod.IncludeAddressFeedback, recs_addrFB, recs_plus_phnFB);

    recs_to_use := PROJECT(recs_plus_addrFB,Layouts.headerRecordExt);

    // This section of coding immediately below was added for the FDN project.
    // Set shorter alias names to be passed into new function
    boolean FDNContDataPermitted := doxie.compliance.use_FdnContributoryData(mod_access.DataPermissionMask);
    boolean FDNInqDataPermitted  := ~doxie.compliance.isFdnInquiry(mod_access.DataRestrictionMask);


    // Added coding to check for FDN data here, depending upon if FDN was asked for.
    // If it was, call the new function to check for the data and set the new indicators.
    ds_recs_to_use_fdn := if(use_mod.IncludeFraudDefenseNetwork,
                             PersonSearch_Services.Functions.func_FdnCheckSearchRecs(
                                 recs_to_use,
                                 use_mod.FDNinput_gcid,
                                 use_mod.FDNinput_indtype,
                                 use_mod.FDNinput_prodcode,
                                 FDNContDataPermitted,
                                 FDNInqDataPermitted),
                             //Otherwise just pass along the recs_to_use dataset
                             recs_to_use);

    // Format recs for XML output
    phoneSearch := Functions.phoneSearch.val(project(use_mod, Functions.phoneSearch.params));
    recs_fmtd := PersonSearch_Services.Functions.xformSearchRecs(ds_recs_to_use_fdn,
                                                                 use_mod.returnAlsoFound,
                                                                 phoneSearch,
                                                                 use_mod.IncludeSourceDocCounts,
                                                                 use_mod.IncludeAlternatePhonesCount,
                                                                 use_mod.IncludePhonesPlus,
                                                                 use_mod.IncludePhonesFeedback,
                                                                 use_mod.SourceDocFilter
                                                                 );
    // For debugging, uncomment as needed
    //output(recs_to_use, named('recs_to_use'));
    //output(ds_recs_to_use_fdn, named('ds_recs_to_use_fdn'));

    return recs_fmtd;
  end;

end;
