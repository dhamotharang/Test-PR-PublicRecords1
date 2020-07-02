import AddressReport_Services, AddrBest, iesp, ut, Census_Data, NID, doxie, header, header_quick, utilfile, Suppress, std, dx_header;

EXPORT AddressSummaryService_Functions := MODULE
  // Helper Functions
  SHARED ut_get_date_YYYYMM := ((STRING8)Std.Date.Today())[1..6];
  SHARED name_regex(string in_name_part) := REGEXREPLACE('\\W', in_name_part, ' ');
  SHARED upper_case(string in_ToUpper) := StringLib.StringToUpperCase(in_ToUpper);
  SHARED trim_all(string in_trim_all) := TRIM(upper_case(in_trim_all), ALL);
  SHARED trim_lr(string in_trim_lr) := TRIM(upper_case(in_trim_lr), LEFT, RIGHT);
  SHARED pref_fname(string in_fname) := NID.PreferredFirstNew(in_fname, true);
  SHARED split_lname(string in_lname, integer in_section) := Std.Str.SplitWords(in_lname, ' ')[in_section];

  SHARED fnVerifiedName(integer in_did, doxie.IDataAccess mod_access, string in_fname, string in_mname, string in_lname, string in_name_suffix,
               string in_prim_range, string in_predir, string in_prim_name, string in_suffix,
               string in_postdir, string in_sec_range, string in_city_name, string in_st, string in_zip
               ) := FUNCTION
    
    // Constants - Set for exact name check
    in_name_first_regex_all := trim_all(name_regex(in_fname));
    in_name_last_regex_all := trim_all(name_regex(in_lname));
    // Constants - Set for nick name check
    in_name_first_regex_lr_pref := pref_fname(trim_lr(name_regex(in_fname)));
    // Constants - Set for dual part lastname check
    in_name_last_regex_lr_split1 := split_lname(trim_lr(name_regex(in_lname)), 1);
    in_name_last_regex_lr_split2 := split_lname(trim_lr(name_regex(in_lname)), 2);

    // util header helper functions (from DidVille.All_recs)
    unsigned3 add4(unsigned3 dt) := if ((dt+4) % 100 > 12, dt + 104 - 12, dt+4);
    unsigned3 todaydate := (unsigned3)((integer)Std.Date.Today() div 100);
    unsigned3 lesser(unsigned3 dt2) := if (add4(dt2) < todaydate, add4(dt2),todaydate);

    // search header files by did
    address_summary_rec_ext := record
      Layouts.AddressSummaryHeaderSlim_layout;
      unsigned did;
      unsigned rid;
      // for suppressions
      UNSIGNED4 global_sid;
        UNSIGNED8 record_sid;
    end;
    header_slim0 := project(dx_header.key_header()(KEYED(s_did = in_did)), address_summary_rec_ext);
    header_slim_filt := Header.FilterDMVInfo(header_slim0);
    header_slim := project(if(mod_access.suppress_dmv, header_slim_filt, header_slim0), address_summary_rec_ext);
    quick_slim := project(header_quick.key_DID(KEYED(did = in_did)), Layouts.AddressSummaryHeaderSlim_layout);
    util_slim := project(utilfile.Key_Util_Daily_Did(KEYED(s_did = in_did)),transform(Layouts.AddressSummaryHeaderSlim_layout,
                                                                               self.dt_first_seen := (unsigned3)left.date_first_seen div 100;
                                                                               self.dt_last_seen := if((unsigned3)left.date_first_seen div 100=0,0,lesser((unsigned3)left.date_first_seen div 100));
                                                                               self.dt_vendor_last_reported := self.dt_last_seen;
                                                                               self.suffix := left.addr_suffix;
                                                                               self.city_name := left.v_city_name;
                                                                               self := left;));

    header_slim_recs:= PROJECT(Suppress.MAC_SuppressSource(header_slim, mod_access), Layouts.AddressSummaryHeaderSlim_layout);

    // combine header results
    header_names := header_slim_recs + quick_slim + util_slim;
    
    // limit header results to only names for the input address
    header_names_per_addr := header_names(prim_range = in_prim_range,
                                          predir = in_predir,
                                          prim_name = in_prim_name,
                                          suffix = in_suffix,
                                          postdir = in_postdir,
                                          sec_range = in_sec_range,
                                          city_name = in_city_name,
                                          st = in_st,
                                          zip = in_zip);
    
    // dedupe the names - only worry about fname and lname since they are used for verification
    header_names_distinct := dedup(sort(header_names_per_addr,
                                        fname, lname, -dt_last_seen, -dt_first_seen, -dt_vendor_last_reported),
                                   fname, lname);
    
    // apply name verification filtering
    header_names_verified := header_names_distinct(
                              (in_name_first_regex_all != '' OR in_name_last_regex_all != '')
                              AND
                               ((in_name_first_regex_all = trim_all(name_regex(fname))) OR
                                (in_name_first_regex_lr_pref = pref_fname(trim_lr(name_regex(fname)))))
                               AND
                               ((in_name_last_regex_all = trim_all(name_regex(lname))) OR
                                (in_name_last_regex_lr_split1 != '' AND (in_name_last_regex_lr_split1 = split_lname(trim_lr(name_regex(lname)), 1) OR
                                                                         in_name_last_regex_lr_split1 = split_lname(trim_lr(name_regex(lname)), 2))) OR
                                (in_name_last_regex_lr_split2 != '' AND (in_name_last_regex_lr_split2 = split_lname(trim_lr(name_regex(lname)), 1) OR
                                                                         in_name_last_regex_lr_split2 = split_lname(trim_lr(name_regex(lname)), 2)))));

    // keep the most recent verified name (only need one result)
    best_header_name_verified := choosen(sort(header_names_verified, -dt_last_seen, -dt_first_seen, -dt_vendor_last_reported),1);
    
    // return the verified name if it exists, otherwise return no name info and set IsVerified (4th field in layout) to FALSE
    VerifiedName := if(EXISTS(best_header_name_verified),
                       project(best_header_name_verified, Layouts.AddressSummaryVerifiedName_layout),
                       dataset([{'', '', '', '', FALSE}], Layouts.AddressSummaryVerifiedName_layout));
    
    RETURN VerifiedName;
  END;

  EXPORT fnBestAddressWithSummary(dataset(AddrBest.Layout_BestAddr.best_Out_common) ds_in_ab,
                                  iesp.addresssummary.t_AddressSummaryRequest ds_in_as,
                                  doxie.IDataAccess mod_access) := FUNCTION
    // Constants - First Row
    ds_in_as_first_row := ds_in_as.SearchBy;
    
    Layouts.BestAddressWithResponseCode_layout xfrm_AddressSummaryRules(AddrBest.Layout_BestAddr.best_Out_common L) := transform
      VerifiedName := fnVerifiedName(L.did, mod_access, ds_in_as_first_row.Name.First, ds_in_as_first_row.Name.Middle, ds_in_as_first_row.Name.Last, ds_in_as_first_row.Name.Suffix,
                                     L.prim_range, L.predir, L.prim_name, L.suffix, L.postdir, L.sec_range, L.p_city_name, L.st, L.z5)[1];
      
      is_name_match := VerifiedName.IsVerified;
      SELF.name_first := if(is_name_match, VerifiedName.fname, L.name_first);
      SELF.name_middle := if(is_name_match, VerifiedName.mname, L.name_middle);
      SELF.name_last := if(is_name_match, VerifiedName.lname, L.name_last);
      SELF.name_suffix := if(is_name_match, VerifiedName.name_suffix, L.name_suffix);
      
      is_addr_match := ((ds_in_as_first_row.Address.StreetNumber = L.prim_range)
                       AND
                       (trim_lr(ds_in_as_first_row.Address.StreetName) = L.prim_name)
                       AND
                       (AddressReport_Services.Constants.Clean_Street_Direction(trim_lr(ds_in_as_first_row.Address.StreetPostDirection)) = L.postdir)
                       AND
                       ((trim_lr(ds_in_as_first_row.Address.State) = L.st)
                        AND
                        ((ds_in_as_first_row.Address.Zip5 = L.z5 AND trim_lr(ds_in_as_first_row.Address.City) = L.p_city_name)
                          OR
                          (ds_in_as_first_row.Address.Zip5 != L.z5 AND trim_lr(ds_in_as_first_row.Address.City) = L.p_city_name)
                          OR
                          (trim_lr(ds_in_as_first_row.Address.City) != L.p_city_name AND ds_in_as_first_row.Address.Zip5 = L.z5)))
                       AND
                       (L.predir = '' OR AddressReport_Services.Constants.Clean_Street_Direction(trim_lr(ds_in_as_first_row.Address.StreetPreDirection)) = L.predir)
                       AND
                       (L.suffix = '' OR ds_in_as_first_row.Address.StreetSuffix = '' OR AddressReport_Services.Constants.Clean_Street_Suffix(trim_lr(ds_in_as_first_row.Address.StreetSuffix)) = L.suffix)
                       AND
                       (L.sec_range = '' OR ds_in_as_first_row.Address.UnitNumber = L.sec_range));
      
      is_within_90_days := (ut.MonthsApart(L.addr_dt_last_seen[1..6], ut_get_date_YYYYMM) <= 2);
      
      SELF.ResponseCode := if(is_name_match AND is_addr_match AND is_within_90_days, 'F3', 'F');
      SELF.addr_dt_first_seen := if(L.addr_dt_last_seen in ['','0','000000'],'',L.addr_dt_first_seen);
      
      SELF := L;
    END;
    
    BestAddressWithSummary := project(ds_in_ab, xfrm_AddressSummaryRules(LEFT));
    RETURN BestAddressWithSummary;
  END;

  EXPORT fnAddressSummary(dataset(Layouts.BestAddressWithResponseCode_layout) in_recs) := FUNCTION
    iesp.addresssummary.t_AddressSummaryRecord xfrm_AddressSummaryRecord(in_recs l) := TRANSFORM
      StreetAddress1 := StringLib.StringCleanSpaces(l.prim_range + ' ' +
                                                    l.predir + ' ' +
                                                    l.prim_name + ' ' +
                                                    l.suffix + ' ' +
                                                    l.postdir);
      StreetAddress2 := StringLib.StringCleanSpaces(l.unit_desig + ' ' +
                                                    l.sec_range);
    
      SELF.Address := iesp.ECL2ESP.SetAddress(l.prim_name, l.prim_range, l.predir, l.postdir,
                                              l.suffix, l.unit_desig, l.sec_range, l.p_city_name,
                                              l.st, l.z5, l.zip4, l.county_name, '', StreetAddress1,
                                              StreetAddress2, '');
      SELF.DateFirstSeen := iesp.ECL2ESP.toDatestring8(l.addr_dt_first_seen);
      SELF.DateLastSeen := iesp.ECL2ESP.toDatestring8(l.addr_dt_last_seen);
    END;
    
    in_recs add_county(in_recs le, census_data.Key_Fips2County ri) := TRANSFORM
      SELF.County_name := ri.county_name;
      SELF := le;
    END;

    in_recs_withCounty := join(in_recs, Census_Data.Key_Fips2County,
                               LEFT.st<>'' AND LEFT.fips_county<>'' AND
                               KEYED(LEFT.st = right.state_code) and
                               KEYED(LEFT.fips_county = RIGHT.county_fips),
                               add_county(LEFT,RIGHT),LEFT OUTER,KEEP(1));
                     
    AddressSummaryRecord := project(in_recs_withCounty, xfrm_AddressSummaryRecord(LEFT));
    AddressSummaryRecord_fltr := dedup(sort(AddressSummaryRecord, -DateLastSeen, -DateFirstSeen, record), record);
    RETURN AddressSummaryRecord_fltr;
  END;

  EXPORT fnVerifiedData(Layouts.BestAddressWithResponseCode_layout in_recs) := FUNCTION
    iesp.addresssummary.t_VerifiedData xfrm_VerifiedData() := TRANSFORM
      SELF.Name := iesp.ecl2esp.setNameFields(in_recs.name_first, in_recs.name_middle, in_recs.name_last,'',in_recs.name_suffix,'');
      SELF.AddressSummary := fnAddressSummary(dataset(in_recs))[1];
      SELF.Phone := in_recs.phone10;
      SELF.DOB := iesp.ECL2ESP.toDatestring8(in_recs.dob);
      SELF.SSN := in_recs.ssn;
    END;
                       
    VerifiedData := row(xfrm_VerifiedData());
    RETURN VerifiedData;
  END;
  
  EXPORT fnAddressSummaryResult(iesp.addresssummary.t_AddressSummaryRequest in_recs,
                                dataset(Layouts.BestAddressWithResponseCode_layout) ab_recs_in,
                                unsigned MaxPreviousAddressCount = iesp.constants.AddressSummaryConstants.MaxPreviousAddressRecords) := FUNCTION
    // Constants
    ab_recs := CHOOSEN(dedup(sort(ab_recs_in, -ResponseCode, -addr_dt_last_seen, -addr_dt_first_seen, record), record),MaxPreviousAddressCount);
    PreviousAddressCount := count(ab_recs);
    AddressSummaryResponseCode := ab_recs[1].ResponseCode;
    
    iesp.addresssummary.t_AddressSummaryResult xfrm_AddressSummaryResult() := TRANSFORM
      SELF.InputEcho := in_recs.SearchBy;
      SELF.ResponseCode := if(PreviousAddressCount > 0, AddressSummaryResponseCode, 'F0');
      SELF.VerifiedData := if(PreviousAddressCount > 0 AND AddressSummaryResponseCode = 'F3', fnVerifiedData(ab_recs[1]));
      SELF.PreviousAddressReturnCount := PreviousAddressCount;
      SELF.PreviousAddresses := if(PreviousAddressCount > 0, fnAddressSummary(ab_recs));
    END;

    AddressSummaryResult := row(xfrm_AddressSummaryResult());
    RETURN AddressSummaryResult;
  END;

END;
