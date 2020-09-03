
IMPORT AutoStandardI, iesp, ut, doxie, Header, NID, Suppress, RiskWise, STD, TeaserSearchServices;

EXPORT Search_Records := MODULE
  EXPORT params := INTERFACE(
    AutoStandardI.InterfaceTranslator.lname_value.params,
    AutoStandardI.InterfaceTranslator.lname_set_value.params,
    AutoStandardI.InterfaceTranslator.fname_value.params,
    AutoStandardI.InterfaceTranslator.mname_value.params,
    AutoStandardI.InterfaceTranslator.city_value.params,
    AutoStandardI.InterfaceTranslator.state_value.params,
    AutoStandardI.InterfaceTranslator.zip_value.params,
    AutoStandardI.InterfaceTranslator.zip_val.params,
    AutoStandardI.InterfaceTranslator.pname_value.params,
    AutoStandardI.InterfaceTranslator.zipradius_value.params,
    AutoStandardI.InterfaceTranslator.dob_val.params,
    AutoStandardI.InterfaceTranslator.agelow_val.params,
    AutoStandardI.InterfaceTranslator.agehigh_val.params,
    AutoStandardI.InterfaceTranslator.phonetics.params,
    AutoStandardI.InterfaceTranslator.nicknames.params,
    // added line here
    AutoStandardI.InterfaceTranslator.did_value.params)
    EXPORT IncludeFullHistory := FALSE;
    EXPORT IncludeRelativeNames := FALSE;
    EXPORT AlwaysReturnRecords := FALSE;
    EXPORT IncludePhoneIndicator := FALSE;
    EXPORT IncludePhones := FALSE;

    EXPORT IncludePhoneNumber := FALSE;

    EXPORT RElaxedMiddleNameMatch := FALSE;
    EXPORT IncludeAllAddresses := FALSE;
    EXPORT WidenSearchResults := FALSE;
    EXPORT STRING12 PreferredUniqueId := '';
    EXPORT STRING32 applicationType := suppress.Constants.ApplicationTypes.Consumer;
    EXPORT SortAgeRange := FALSE;
  END;

  EXPORT val(params in_mod) := FUNCTION
    global_mod := AutoStandardI.GlobalModule();
    mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (global_mod);

    lname_value := AutoStandardI.InterfaceTranslator.lname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.lname_value.params));
    lname_set_value := AutoStandardI.InterfaceTranslator.lname_set_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.lname_set_value.params));
    fname_value := AutoStandardI.InterfaceTranslator.fname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.fname_value.params));
    mname_value := AutoStandardI.InterfaceTranslator.mname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.mname_value.params));
    city_value := AutoStandardI.InterfaceTranslator.city_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.city_value.params));
    state_value := AutoStandardI.InterfaceTranslator.state_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.state_value.params));
    zip_value := AutoStandardI.InterfaceTranslator.zip_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.zip_value.params));
    zip_val := AutoStandardI.InterfaceTranslator.zip_val.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.zip_val.params));
    pname_value := AutoStandardI.InterfaceTranslator.pname_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.pname_value.params));
    zipradius_value := AutoStandardI.InterfaceTranslator.zipradius_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.zipradius_value.params));
    dob_val := AutoStandardI.InterfaceTranslator.dob_val.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.dob_val.params));
    TmpAgelow_val := AutoStandardI.InterfaceTranslator.agelow_val.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.agelow_val.params));
    TmpAgehigh_val := AutoStandardI.InterfaceTranslator.agehigh_val.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.agehigh_val.params));
    phonetics := AutoStandardI.InterfaceTranslator.phonetics.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.phonetics.params));
    nicknames := AutoStandardI.InterfaceTranslator.nicknames.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.nicknames.params));
    // added line
    did_value := AutoStandardI.InterfaceTranslator.did_value.val(PROJECT(in_mod,AutoStandardI.InterfaceTranslator.did_value.params));

    in_yob := dob_val div 10000;
    in_mob := (dob_val div 100) % 100;
    in_day := dob_val % 100;

    UNSIGNED8 todays_date := (UNSIGNED8) STD.Date.today();

    UNSIGNED8 tmpYob_val_low := MAP(
    dob_val != 0 => dob_val div 10000,
    tmpAgehigh_val = 0 => 1900, // line changed
    (todays_date div 10000 - tmpAgehigh_val - 1));

    UNSIGNED8 tmpYob_val_high := MAP(
    dob_val != 0 => dob_val div 10000,
    tmpAgelow_val = 0 => todays_date div 10000, // line changed
    (todays_date div 10000 - tmpAgelow_val));

    UNSIGNED8 ageRangeYob_val_low := MAP(
    dob_val != 0 => dob_val div 10000,
    TmpAgehigh_val = 0 => 1900, // line changed
    (todays_date div 10000 - TmpAgehigh_val - 1));

    UNSIGNED8 ageRangeYob_val_high := MAP(
    dob_val != 0 => dob_val div 10000,
    TmpAgelow_val = 0 => todays_date div 10000, // line changed
    (todays_date div 10000 - TmpAgelow_val));

    agelow_val := IF (in_mod.SortAgeRange AND tmpAgelow_val > 0 AND TmpAgehigh_val > 0,
      0, TmpAgelow_val);

    agehigh_val := IF (in_mod.SortAgeRange AND TmpAgelow_val > 0 AND TmpAgehigh_val > 0,
      0, TmpAgeHigh_val);
    // reset values to what they were orginally
    yob_val_low := IF (in_mod.SortAgeRange AND agelow_val > 0 AND agehigh_val > 0,
      ageRangeYob_val_low, tmpYob_val_low);

    // reset values to what they were orginally
    yob_val_high := IF (in_mod.SortAgeRange AND agelow_val > 0 AND agehigh_val > 0,
      ageRangeYob_val_high, tmpYob_val_high);

    // ensure no overflow
    maxReturnCount := ut.Min2(iesp.ECL2ESP.Marshall.return_count, iesp.Constants.ThinRps.MaxCountResponseRecords);

    in_dph_lname := metaphonelib.DMetaPhone1(lname_value)[1..6];
    in_pfname := NID.PreferredFirstNew(fname_value);

    //use RiskWise key as its indexed on City and State, so can search if one of these elements is missing on search criteria
    zips_within_city := //LIMIT(
      RiskWise.Key_ZipCitySt(
        KEYED(city = city_value) AND KEYED(state_value = '' OR state = state_value));
      //,ut.limits.FETCH_KEYED);
    zips_within_city_strs := SET(PROJECT(zips_within_city, TRANSFORM({STRING5 zip}, SELF.zip := LEFT.zip5)),zip);
    zip_value_strs :=SET(PROJECT(DATASET(zip_value,{INTEGER4 zip}),TRANSFORM({STRING5 zip},SELF.zip:=INTFORMAT(LEFT.zip,5,1))),zip);

    state_set := MAP(state_value <> '' => [state_value],
      city_value <> '' => SET(zips_within_city, state),
      ALL);

    //keyed(st in state_set) and
    teaser_search(widen = FALSE) := MACRO
      KEYED(dph_lname = in_dph_lname) AND
      KEYED(lname IN lname_set_value) AND
      KEYED(in_mod.IncludeFullHistory OR isCurrent) AND
      KEYED(st in state_set) AND
      KEYED(fname_value = '' OR TeaserSearchServices.Functions.PrefFirstMatch2(pfname, fname_value)) AND
      KEYED(fname_value = '' OR fname = fname_value) AND
      KEYED(widen OR ((zip_val = '' OR zip = zip_val) AND
      (city_value = '' OR zip in zips_within_city_strs))) AND
      KEYED((dob_val = 0 AND agelow_val = 0 AND agehigh_val = 0) OR yob BETWEEN yob_val_low AND yob_val_high) AND
      KEYED(in_mod.RelaxedMiddleNameMatch OR (mname_value = '' OR minit = mname_value[1]))
    ENDMACRO;

    teaser_fuzzy_search(fuz_widen = FALSE) := MACRO
      KEYED(dph_lname = in_dph_lname) AND
      KEYED(phonetics OR lname IN lname_set_value) AND
      KEYED(in_mod.IncludeFullHistory OR isCurrent) AND
      KEYED(st in state_set) AND
      KEYED(fname_value = '' OR TeaserSearchServices.Functions.PrefFirstMatch2(pfname, fname_value)) AND
      KEYED(nicknames OR fname_value = '' OR fname = fname_value) AND
      KEYED(fuz_widen OR ((zipradius_value = 0 OR zip_value = [] OR zip in zip_value_strs) AND
        (zipradius_value <> 0 OR zip_val = '' OR zip = zip_val) AND
        (zipradius_value <> 0 OR city_value = '' OR zip in zips_within_city_strs))) AND
      KEYED((dob_val = 0 AND agelow_val = 0 AND agehigh_val = 0) OR yob BETWEEN yob_val_low AND yob_val_high) AND
      KEYED(in_mod.RelaxedMiddleNameMatch OR (mname_value = '' OR minit = mname_value[1]))
    ENDMACRO;

    teaser_key := Header.key_teaser_cnsmr_search;

    exact_recs := //LIMIT(
      teaser_key(teaser_search());
      //,ut.limits.FETCH_KEYED);

    fuzzy_recs := //LIMIT(
      teaser_key(teaser_fuzzy_search());
      //,ut.limits.FETCH_KEYED);

    exact_widen_recs := //LIMIT(
      teaser_key(teaser_search(in_mod.WidenSearchResults));
      //,ut.limits.FETCH_KEYED);

    fuzzy_widen_recs := //LIMIT(
      teaser_key(teaser_fuzzy_search(in_mod.WidenSearchResults));
      //,ut.limits.FETCH_KEYED);

    exact_limit := LIMIT(exact_recs,ut.limits.FETCH_KEYED, FAIL(203, doxie.ErrorCodes(203)),KEYED);

    exact_widen_limit := CHOOSEN(exact_recs + exact_widen_recs, ut.limits.FETCH_KEYED);

    // if always returning records
    // use a choosen to pick a large enough sample (10K for now), then
    // a topn to pick the best candidates
    exact_sample := CHOOSEN(exact_recs, ut.limits.FETCH_UNKEYED);
    exact_WO_sample := CHOOSEN(exact_recs + exact_widen_recs, ut.limits.FETCH_UNKEYED);

    use_fuzzy := (phonetics OR nicknames OR zipradius_value <> 0) AND DID_value = '';

      // if always returning records
    // use a choosen to pick a large enough sample (10K for now), then
    // a topn to pick the best candidates

    get_fuzzy_recs(DATASET(RECORDOF(Header.key_teaser_cnsmr_search)) fuzzed_recs,
      DATASET(RECORDOF(Header.key_teaser_cnsmr_search)) rec_limit,
      DATASET(RECORDOF(Header.key_teaser_cnsmr_search)) sample_recs,
      BOOLEAN WidenSearch=FALSE) := FUNCTION
      // only fail the fuzzy fetch as too broad if the exact fetch found none
      fuzzy_fail := IF(WidenSearch, CHOOSEN(fuzzed_recs,ut.limits.FETCH_KEYED),
        LIMIT(fuzzed_recs,ut.limits.FETCH_KEYED, FAIL(203, doxie.ErrorCodes(203)),KEYED));
      fuzzy_skip := IF(WidenSearch, CHOOSEN(fuzzed_recs,ut.limits.FETCH_KEYED),
        LIMIT(fuzzed_recs,ut.limits.FETCH_KEYED, SKIP, KEYED));
      fuzzy_limit_cands := IF(COUNT(rec_limit) > 0, fuzzy_skip, fuzzy_fail);

      // only need to take the fuzzy results if the exact matches don't provide as many as requested
      // need to allow a few extra since there can be up to maxReturnCount records per DID that could match the input criteria
      fuzzy_limit := IF(COUNT(rec_limit) < maxReturnCount * 5, fuzzy_limit_cands);
      fuzzy_limit_final := IF(use_fuzzy, fuzzy_limit);

      fuzzy_sample_cands := CHOOSEN(fuzzed_recs, ut.limits.FETCH_UNKEYED);
      fuzzy_sample := IF(COUNT(sample_recs) < maxReturnCount * 5, fuzzy_sample_cands);
      fuzzy_sample_final := IF(use_fuzzy, fuzzy_sample);

      // if AlwaysReturnRecords is requested, do a choosen and always return records;
      // otherwise, allow searches that produce more than the limit to fail if the search criteria are too broad
      recs_wch := IF(in_mod.AlwaysReturnRecords, sample_recs + fuzzy_sample_final,
        rec_limit + fuzzy_limit_final);

      recs_ddp := DEDUP(SORT(recs_wch, RECORD), RECORD);

      // final cleanup (doing what couldn't be done in the keyed conditions above)
      // 1. need to postfilter any wildly dissimilar last names when phonetics is enabled
      // 2. need to make sure that middle initial matches don't have different mnames
      // 3. need to see if a full dob provided that it doesn't mismatch
      recs_clean_pre := recs_ddp(
        (~phonetics OR datalib.namesimilar(lname,lname_value,1) <= 6) AND
        (in_mod.RelaxedMiddleNameMatch OR
        mname_value = '' OR mname = mname_value OR
        mname[1] = mname_value OR mname = mname_value[1]) AND
        (in_mob = 0 OR (dob div 100) % 100 = in_mob) AND
        (in_day = 0 OR (dob % 100) = in_day)
      );

      recs_clean := Suppress.MAC_SuppressSource(recs_clean_pre,mod_access);
      RETURN recs_clean;
    END;

    cleaned_recs := get_fuzzy_recs(fuzzy_recs, exact_limit, exact_sample);

    cleaned_recs_retried := get_fuzzy_recs(fuzzy_recs + fuzzy_widen_recs, exact_widen_limit, exact_WO_sample, in_mod.WidenSearchResults);
    //if the result set is less than maxReturnCount retry without city
    cleaned_recs_final := IF(COUNT(cleaned_recs) < maxReturnCount AND in_mod.WidenSearchResults, cleaned_recs_retried, cleaned_recs);

    recs_clean_tsr := PROJECT(cleaned_recs_final, Header.layout_teaser);

    // even though the teaser keys are built with pull file applied, the build cycles are different
    // so still need to pull in the query to account for recent additions.
    //
    // currently, we can only pull by DID; keys will need to be modified to preserve SSN so that
    // pulling by SSN can be implemented

    // add a single row of header.layout_teaser if did value is input directly
    // filter by number is already take care of by autostandardI interface transaltor in set of did_value
    did_rec := PROJECT(DATASET([{did_value}], doxie.layout_references),
      TRANSFORM(header.layout_teaser,
        SELF.did := LEFT.DID;
        SELF := []))(did <> 0);
    recs_clean_tsrWithdid := recs_clean_tsr && did_rec;

    Suppress.MAC_Suppress(recs_clean_tsrWithDID,recs_pull_tsr,in_mod.applicationType,Suppress.Constants.LinkTypes.DID,did);

    recs_grp := GROUP(SORT(recs_pull_tsr, did, -isCurrent), did);
    recs := ROLLUP(recs_grp, GROUP, TeaserSearchServices.Functions.combine(LEFT,ROWS(LEFT), in_mod.IncludeAllAddresses));

    // filter out minors from the final result
    recs_nominors := Doxie.compliance.MAC_FilterOutMinors(recs,uniqueid,dob_val,FALSE);

    recs_ageChecked := recs_nominors(EXISTS(dobs(age >= agelow_val AND
      (agehigh_val = 0 OR age <= agehigh_val))));

    recs_top := TOPN(recs_ageChecked,maxReturnCount,
      penalt, -Addresses[1].DateLastSeen.Year, -Addresses[1].DateLastSeen.Month,
      -totalRecords, Addresses[1].zip5, RECORD);
    // get historical names and addresses if requested
    recs_ref := PROJECT(recs_top, TRANSFORM(doxie.layout_references,
      SELF.did := (UNSIGNED6) LEFT.uniqueid));

    recs_history := TeaserSearchServices.Functions.historicalNamesAddrs(recs_ref, in_mod.IncludeAllAddresses,mod_access);
    recs_history_use := IF(in_mod.IncludeFullHistory, recs_history, recs_top);

    // add phone indicator if requested
    recs_phone := TeaserSearchServices.Functions.AddPhoneIndicator(recs_history_use, mod_access, in_mod.IncludePhones);
    recs_phone_use := IF(in_mod.IncludePhoneIndicator OR in_mod.IncludePhones,recs_phone, recs_history_use);

    // add relative names if requested
    with_rels := TeaserSearchServices.Functions.AddRelativeNames(recs_phone_use,in_mod.applicationType);
    Final_res := IF(in_mod.IncludeRelativeNames, with_rels, recs_phone_use);

    // now set a sequence # into sort for use later.
    filtered_final_res := PROJECT(final_res, TRANSFORM({RECORDOF(LEFT); INTEGER age; INTEGER seq;},
      dateofBirthDS := PROJECT(LEFT.DOBs, TRANSFORM(iesp.thinrolluppersonsearch.t_ThinRpsDOB, SELF := LEFT));
      age := dateOfBirthDS[1].age;
      SELF.age := age;
      SELF.seq := IF ( age >= TmpAgelow_val AND age <= TmpAgehigh_val AND age <> 0, COUNTER,0);
                                      // ^^^^ use orginal values here ^^^^^^^^^^^^^^
      SELF := LEFT;
    ));

    // now sort on the existence of seq value being > 0 which pushes the seq =0 below the other recs.
    tmpFinal_sortedAgeRange := SORT(filtered_final_res, 
      IF (seq <> 0, 0, 1),
      IF((INTEGER)UniqueId = (INTEGER)in_mod.PreferredUniqueId, 0, 1), penalt, -Addresses[1].DateLastSeen.Year,
      -Addresses[1].DateLastSeen.Month,-Addresses[1].DateLastSeen.Day, -totalRecords, RECORD);
    // now take out the SEQ/AGE fields to return to originalLayout
    final_res_ageRange := PROJECT(tmpFinal_sortedAgeRange, TRANSFORM(TeaserSearchServices.Layouts.records_plus,
      SELF := LEFT));                                               // ^^^^^ this is layout returned from historicalNamesAddrs FUNCTION call
                                                                    // which is the 'combine' transform

    //return standard output when no PreferredUniqueId entered, otherwise, return data with the PreferredUniqueId matching what the user entered a lexid
    tmpFinal_sorted := SORT(final_res,
      IF((INTEGER)UniqueId = (INTEGER)in_mod.PreferredUniqueId, 0, 1), penalt, -Addresses[1].DateLastSeen.Year,
      -Addresses[1].DateLastSeen.Month,-Addresses[1].DateLastSeen.Day, -totalRecords, RECORD);

    // and finally use the new sort order if the boolean and the 2 age range filters are set to true are > 0 respectvely.
    final_sorted := IF (in_mod.SortAgeRange AND tmpAgelow_val > 0 AND tmpAgeHigh_val > 0,
      final_res_ageRange, tmpFinal_sorted);

    final_out := PROJECT(final_sorted, TeaserSearchServices.Layouts.records);
    
    RETURN final_out;
  END;
END;
