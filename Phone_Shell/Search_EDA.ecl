/* ************************************************************************
 * This function searches EDA by:                                          *
 * - Address, Same First Name:: Source: EDAFA                              *
 * - Address, Same Last Name:: Source: EDALA                              *
 * - Address, Same First and Last Name:: Source: EDAFLA                    *
 * - Address, Swapped First and Last Name:: Source: EDALFA                *
 * - Address, Unique Addresses by DID in last 6 months:: Source: EDACA    *
 * - DID:: Source: EDADID                                                  *
 * - Address, Same Last Name - Search Header by DID for unique addresses  *
 *       last seen within 5 years:: Source: EDAHistory                    *
 ************************************************************************ */

IMPORT dx_Gong, Phone_Shell, Risk_Indicators, RiskWise, UT, STD, doxie, Suppress;

todays_date := (string) STD.Date.Today();

EXPORT Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus Search_EDA (DATASET(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus) input, DATASET(Phone_Shell.Layouts.layoutUniqueAddresses) HeaderAddresses, UNSIGNED1 PhoneRestrictionMask,
          UNSIGNED2 PhoneShellVersion = 10, doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

 IncludeLexIDCounts := if(PhoneShellVersion >= 21, true, false); // LexID Counts/'all' attributes added in PhoneShell version 2.1

   /* ***************************************************************
    *               Get the EDA (Gong) Data by DID                  *
    *************************************************************** */
  key_history_did := dx_Gong.key_history_did();
  {Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, unsigned4 global_sid} searchByDID(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, key_history_did ri) := TRANSFORM
    SELF.global_sid := ri.global_sid;
    SElf.Gathered_Phone := TRIM(ri.phone10);

    matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone,
                                                      ri.name_first,            ri.name_last,            '',                            ri.Prim_Range,             ri.Prim_Name,              ri.Suffix,                 ri.P_City_Name,      ri.st,                ri.Z5,               '',                           '',                 ri.DID, ri.phone10);

    // Check the Phone Restriction Mask, only keep the phone if the mask is ok
    SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.name_last), 'EDADID', '');

    SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_first_seen);
    SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen);

    SELF.Sources.Source_Owner_Name_Prefix := ri.name_prefix;
    SELF.Sources.Source_Owner_Name_First   := ri.name_first;
    SELF.Sources.Source_Owner_Name_Middle := ri.name_middle;
    SELF.Sources.Source_Owner_Name_Last    := ri.name_last;
    SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
    SELF.Sources.Source_Owner_DID := (STRING)ri.DID;

  SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts, Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen), '');
  SELF.Sources.Source_Owner_All_DIDs := if(includeLexIDCounts, (string)ri.DID, '');

    didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
    nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
    addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
    ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;

    SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch  => Phone_Shell.Constants.Phone_Subject_Level.Subject,
                                                              didMatch AND addrMatch  => Phone_Shell.Constants.Phone_Subject_Level.Household,
                                                                                         Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);

    SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch      => 'Subject',
                                                              didMatch AND addrMatch      => 'Subject at Household',
                                                              ssnMatch                    => 'Associate By SSN',
                                                              addrMatch                   => 'Associate By Address',
                                                                                             'Associate'
                                                              );

    SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;

    // We should grab some EDA attribute while we are already hitting this key
    SELF.EDA_Characteristics.EDA_num_phones_indiv := 1; // This will be added in a Rollup under Phone_Shell.Gather_Phones
    phoneConnected := TRIM(ri.current_record_flag) IN ['Y', 'y'];
    SELF.EDA_Characteristics.EDA_num_phones_connected_indiv := IF(phoneConnected = TRUE, 1, 0); // This will be added in a Rollup under Phone_Shell.Gather_Phones
    SELF.EDA_Characteristics.EDA_num_phones_discon_indiv := IF(phoneConnected = FALSE, 1, 0); // This will be added in a Rollup under Phone_Shell.Gather_Phones
    daysFirst := ut.DaysApart(todays_date, ri.dt_first_seen);
    SELF.EDA_Characteristics.EDA_days_indiv_first_seen_with_phone := daysFirst;
    days := ut.DaysApart(todays_date, ri.dt_last_seen);
    SELF.EDA_Characteristics.EDA_is_discon_15_days := phoneConnected = FALSE AND days >= 0 AND days <= 15;
    SELF.EDA_Characteristics.EDA_is_discon_30_days := phoneConnected = FALSE AND days >= 0 AND days <= 30;
    SELF.EDA_Characteristics.EDA_is_discon_60_days := phoneConnected = FALSE AND days >= 0 AND days <= 60;
    SELF.EDA_Characteristics.EDA_is_discon_90_days := phoneConnected = FALSE AND days >= 0 AND days <= 90;
    SELF.EDA_Characteristics.EDA_is_discon_180_days := phoneConnected = FALSE AND days >= 0 AND days <= 180;
    SELF.EDA_Characteristics.EDA_is_discon_360_days := phoneConnected = FALSE AND days >= 0 AND days <= 360;

    SELF := le;
  END;

  byDID_unsuppressed := JOIN(Input, key_history_did, LEFT.DID <> 0 AND KEYED(LEFT.DID = RIGHT.L_DID) AND RIGHT.current_flag = TRUE AND (INTEGER)RIGHT.phone10 <> 0,
                                      searchByDID(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost)) (TRIM(Sources.Source_List) <> '');
  byDID := Suppress.Suppress_ReturnOldLayout(byDID_unsuppressed, mod_access, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
   /* ***************************************************************
    *     Get the EDA (Gong) Data by Unique Header Addresses        *
    *************************************************************** */
  key_history_address := dx_Gong.key_history_address();
  {Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, unsigned4 global_sid} searchByUniqueAddresses(Phone_Shell.Layouts.layoutUniqueAddresses le, key_history_address ri) := TRANSFORM
    SELF.global_sid := ri.global_sid;
    SELF.Clean_Input.seq := le.seq; // Need to save this to join back to the input data in a moment
    SELF.Gathered_Phone := TRIM(ri.phone10);

    SELF.Raw_Input.FirstName := STD.Str.ToUpperCase(TRIM(ri.name_first));
    SELF.Raw_Input.LastName := STD.Str.ToUpperCase(TRIM(ri.name_last));

    matchcode := Phone_Shell.Common.generateMatchcode(le.FirstName, le.LastName,    '', le.Prim_Range, le.Prim_Name, le.Addr_Suffix, le.City,       le.State, le.Zip5,  le.DateOfBirth, le.SSN, le.DID, le.HomePhone, le.WorkPhone,
                                                      ri.name_first, ri.name_last, '', ri.Prim_Range,  ri.Prim_Name,  ri.Suffix,      ri.P_City_Name,  ri.st,     ri.Z5,    '',              '',      ri.DID, ri.phone10);

    // If seen within last 5 years the last name must also match (fuzzy logic applied), if seen within last 6 months no need to match last name
    Source_List_Temp := MAP((INTEGER)le.DateLastSeen >= (INTEGER)(ut.date_math(todays_date, -1 * Phone_Shell.Constants.HeaderSixMonthsDate)[1..6])                                                  => 'EDACA',
                                    (INTEGER)le.DateLastSeen >= (INTEGER)(ut.date_math(todays_date, -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6]) AND
                                    Risk_Indicators.iid_constants.g(Risk_Indicators.LnameScore(STD.Str.ToUpperCase(TRIM(le.LastName)), STD.Str.ToUpperCase(TRIM(ri.name_last))))  => 'EDAHistory',
                                                                                                                                                                                                     '');
    // Check the Phone Restriction Mask, only keep the phone if the mask is ok
    SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.LastName, ri.name_last, anyAddress := TRUE), Source_List_Temp, '');

    SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_first_seen);
    SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen);

    SELF.Sources.Source_Owner_Name_Prefix := ri.name_prefix;
    SELF.Sources.Source_Owner_Name_First   := ri.name_first;
    SELF.Sources.Source_Owner_Name_Middle := ri.name_middle;
    SELF.Sources.Source_Owner_Name_Last    := ri.name_last;
    SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
  SELF.Sources.Source_Owner_DID := (STRING)ri.DID;

  SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts, Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen), '');
  SELF.Sources.Source_Owner_All_DIDs := if(includeLexIDCounts, (string)ri.DID, '');

    didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
    nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
    addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
    ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;

    SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch  => Phone_Shell.Constants.Phone_Subject_Level.Subject,
                                                              didMatch AND addrMatch  => Phone_Shell.Constants.Phone_Subject_Level.Household,
                                                                                         Phone_Shell.Constants.Phone_Subject_Level.LeadToSubject);

    SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch      => 'Subject',
                                                              didMatch AND addrMatch      => 'Subject at Household',
                                                              ssnMatch                    => 'Associate By SSN',
                                                              addrMatch                   => 'Associate By Address',
                                                                                             'Associate'
                                                              );

    SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;

    SELF := [];
  END;
  // Only search for addresses seen within the last 5 years - must match same last name, within 6 months doesn't have to match last name
  uniqueAddressSearchResultsAll_unsuppressed := JOIN(HeaderAddresses ((INTEGER)DateLastSeen >= (INTEGER)(ut.date_math((string) STD.Date.Today(), -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6])), key_history_address, TRIM(LEFT.Prim_Range) <> '' AND TRIM(LEFT.Prim_Name) <> '' AND TRIM(LEFT.Zip5) <> '' AND
                                                                                        KEYED(LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.State = RIGHT.st AND LEFT.Zip5 = RIGHT.Z5 AND LEFT.Sec_Range = RIGHT.Sec_Range) AND
                                                                                        LEFT.Predir = RIGHT.Predir AND LEFT.Addr_Suffix = RIGHT.Suffix AND (INTEGER)RIGHT.phone10 <> 0,
                                                                                  searchByUniqueAddresses(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
  uniqueAddressSearchResultsAll := Suppress.Suppress_ReturnOldLayout(uniqueAddressSearchResultsAll_unsuppressed, mod_access, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
  uniqueAddressSearchResults := DEDUP(SORT(uniqueAddressSearchResultsAll  (TRIM(Sources.Source_List) <> ''), Clean_Input.seq, Gathered_Phone, TRIM(Sources.Source_List), -TRIM(Sources.Source_List_Last_Seen), -TRIM(Sources.Source_List_First_Seen)), Clean_Input.seq, Gathered_Phone, Sources.Source_List);

  Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus combineInputAndUnique(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
    SELF.Gathered_Phone := ri.Gathered_Phone;

    SELF.Sources := ri.Sources;

    SELF.Raw_Phone_Characteristics := ri.Raw_Phone_Characteristics;

    SELF := le;
  END;

  byUniqueAddresses := JOIN(Input, uniqueAddressSearchResults, LEFT.Clean_Input.seq = RIGHT.Clean_Input.seq, combineInputAndUnique(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(RiskWise.max_atmost));

   /* ***************************************************************
    *            Get the EDA (Gong) Data by Address                *
    *************************************************************** */
  {Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus, unsigned4 global_sid} searchByInputAddress(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, key_history_address ri) := TRANSFORM
    SELF.global_sid := ri.global_sid;
    SELF.Gathered_Phone := TRIM(ri.phone10);

    matchcode := Phone_Shell.Common.generateMatchcode(le.Clean_Input.FirstName, le.Clean_Input.LastName, le.Clean_Input.StreetAddress1, le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Addr_Suffix, le.Clean_Input.City, le.Clean_Input.State, le.Clean_Input.Zip5, le.Clean_Input.DateOfBirth, le.Clean_Input.SSN, le.DID, le.Clean_Input.HomePhone, le.Clean_Input.WorkPhone,
                                                      ri.name_first,             ri.name_last,              '',                           ri.Prim_Range,              ri.Prim_Name,              ri.Suffix,                  ri.P_City_Name,      ri.st,                ri.z5,                '',                          '',                  ri.DID, ri.phone10);

    Source_List_Temp := MAP(le.Clean_Input.FirstName = ri.name_first AND le.Clean_Input.LastName = ri.name_last   => 'EDAFLA',
                            le.Clean_Input.FirstName = ri.name_last AND le.Clean_Input.LastName = ri.name_first   => 'EDALFA',
                            le.Clean_Input.FirstName = ri.name_first AND le.Clean_Input.LastName <> ri.name_last  => 'EDAFA',
                            le.Clean_Input.FirstName <> ri.name_first AND le.Clean_Input.LastName = ri.name_last  => 'EDALA',
                                                                                                                     '');

    // Check the Phone Restriction Mask, only keep the phone if the mask is ok
    SELF.Sources.Source_List := IF(Phone_Shell.Common.PhoneRestrictionMaskOK(PhoneRestrictionMask, matchcode, le.Clean_Input.LastName, ri.name_last, anyAddress := TRUE), Source_List_Temp, '');
    SELF.Sources.Source_List_First_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_first_seen);
    SELF.Sources.Source_List_Last_Seen := Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen);

    SELF.Sources.Source_Owner_Name_Prefix := ri.name_prefix;
    SELF.Sources.Source_Owner_Name_First   := ri.name_first;
    SELF.Sources.Source_Owner_Name_Middle := ri.name_middle;
    SELF.Sources.Source_Owner_Name_Last    := ri.name_last;
    SELF.Sources.Source_Owner_Name_Suffix := ri.name_suffix;
  SELF.Sources.Source_Owner_DID := (STRING)ri.DID;

  SELF.Sources.Source_List_All_Last_Seen := if(IncludeLexIDCounts, Phone_Shell.Common.parseDate((STRING)ri.dt_last_seen), '');
  SELF.Sources.Source_Owner_All_DIDs := if(IncludeLexIDCounts, (string)ri.DID, '');

    didMatch := STD.Str.Find(matchcode, 'L', 1) > 0;
    nameMatch := STD.Str.Find(matchcode, 'N', 1) > 0;
    addrMatch := STD.Str.Find(matchcode, 'A', 1) > 0;
    ssnMatch := STD.Str.Find(matchcode, 'S', 1) > 0;

    SELF.Raw_Phone_Characteristics.Phone_Subject_Level := MAP(didMatch AND nameMatch                  => Phone_Shell.Constants.Phone_Subject_Level.Subject,
                                                              didMatch AND addrMatch                  => Phone_Shell.Constants.Phone_Subject_Level.Household,
                                                              Source_List_Temp IN ['EDAFA', 'EDALA']  => Phone_Shell.Constants.Phone_Subject_Level.Household,
                                                                                                         Phone_Shell.Constants.Phone_Subject_level.LeadToSubject);

    SELF.Raw_Phone_Characteristics.Phone_Subject_Title := MAP(didMatch AND nameMatch      => 'Subject',
                                                              didMatch AND addrMatch      => 'Subject at Household',
                                                              Source_List_Temp IN ['EDAFA', 'EDALA'] => 'Subject at Household',
                                                              ssnMatch                    => 'Associate By SSN',
                                                              addrMatch                   => 'Associate By Address',
                                                                                             'Associate'
                                                              );

    SELF.Raw_Phone_Characteristics.Phone_Match_Code := matchcode;

    SELF := le;
  END;

  byAddressAll_unsuppressed := JOIN(Input, key_history_address, TRIM(LEFT.Clean_Input.Prim_Range) <> '' AND TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
                                                      KEYED(LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND LEFT.Clean_Input.State = RIGHT.st AND
                                                      LEFT.Clean_Input.Zip5 = RIGHT.Z5 AND LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range) AND
                                                      LEFT.Clean_Input.Predir = RIGHT.Predir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Suffix AND RIGHT.current_flag = TRUE AND (INTEGER)RIGHT.phone10 <> 0,
                                                      searchByInputAddress(LEFT, RIGHT), KEEP(RiskWise.max_atmost), ATMOST(2 * RiskWise.max_atmost));
  byAddressAll := Suppress.Suppress_ReturnOldLayout(byAddressAll_unsuppressed, mod_access, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus);
  // Don't keep the phones which didn't match on some part of the name
  byAddress := byAddressAll (TRIM(Sources.Source_List) <> '');

  Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus get_Alls(Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus le, Phone_Shell.Layout_Phone_Shell.Layout_Phone_Shell_Plus ri) := TRANSFORM
   self.Sources.Source_List_All_Last_Seen := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID,
                                                   le.Sources.Source_List_All_Last_Seen,
                                                   le.Sources.Source_List_All_Last_Seen + ',' + ri.Sources.Source_List_All_Last_Seen);
   self.Sources.Source_Owner_All_DIDs := if(le.Sources.Source_Owner_DID = ri.Sources.Source_Owner_DID,
                                               le.Sources.Source_Owner_All_DIDs,
                                               le.Sources.Source_Owner_All_DIDs + ',' + ri.Sources.Source_Owner_All_DIDs);
   self := le;
 end;

 sortedEDA := SORT((byDID + byUniqueAddresses + byAddress), Clean_Input.seq, Gathered_Phone, Sources.Source_List, -Sources.Source_List_Last_Seen, -Sources.Source_List_First_Seen, -LENGTH(TRIM(Raw_Phone_Characteristics.Phone_Match_Code)));

  final := if(IncludeLexIDCounts,
             ROLLUP(sortedEDA,
               left.Clean_Input.seq = right.Clean_Input.seq and
               left.Gathered_Phone = right.Gathered_Phone and
               left.Sources.Source_List = right.Sources.Source_List,
               get_Alls(left,right)),
             DEDUP(sortedEDA, Clean_Input.seq, Gathered_Phone, Sources.Source_List)
            );

  // OUTPUT(CHOOSEN(HeaderAddresses ((INTEGER)DateLastSeen >= (INTEGER)(ut.date_math((string) STD.Date.Today(), -1 * Phone_Shell.Constants.HeaderSearchDate)[1..6])), 100), NAMED('HeaderAddressesUsable'));
  // OUTPUT(CHOOSEN(HeaderAddresses ((INTEGER)DateLastSeen >= (INTEGER)(ut.date_math((string) STD.Date.Today(), -1 * Phone_Shell.Constants.HeaderSixMonthsDate)[1..6])), 100), NAMED('HeaderAddresses6Months'));
  // OUTPUT(CHOOSEN(uniqueAddressSearchResultsAll, 100), NAMED('uniqueAddressSearchResultsAll'));
  // OUTPUT(CHOOSEN(byUniqueAddresses, 100), NAMED('byUniqueAddresses'));

  RETURN(final);
END;
