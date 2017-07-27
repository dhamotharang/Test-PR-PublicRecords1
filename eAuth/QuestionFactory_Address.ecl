IMPORT doxie, PersonReports, iesp, Census_Data, RiskWise, ut;

out_rec := layouts.question_ext;
ds_blank := dataset ([], out_rec);

export QuestionFactory_Address := MODULE

 // =============== IN WHICH OF THE COUNTIES BELOW HAVE YOU LIVED? ====================
  // county1. Returns specified number of counties a pesrson ever lived plus random
  // ===================================================================================
  export out_rec GetCounties (string question, unsigned ans_all, unsigned ans_correct,
                              dataset (iesp.share.t_Address) addr_source) := function
    // validate input
    valid_input := (ans_correct >=0) and (ans_correct <=ans_all) and (ans_all > 0);
    addr_ddp := dedup (addr_source (County != ''), County, ALL);
    boolean IsSufficient := valid_input and exists (addr_ddp);

    // at that point we have valid input and at least one correct county
   Functions.MAC_RANDOM (addr_ddp, ans_correct, ds_correct);
    unsigned cnt_actual := count (ds_correct);

    // fetch max number of records, since "real" data can be fetched here as well.
   Functions.MAC_RANDOM (fake_files.counties, ans_all, fake_data);

    //remove "real" counties from fake
    ds_fakes := choosen (join (fake_data, addr_ddp, 
                               Left.county = Right.County,
                               left only, atmost (1)), ans_all - cnt_actual);  // adjusted number of fake answers

    ds_combined := project (ds_correct, transform (iesp.eauth.t_Answer, Self.Value := Left.County, Self._IsValid := true)) +
                   project (ds_fakes,   transform (iesp.eauth.t_Answer, Self.Value := Left.County, Self._IsValid := false));

   Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand); //shuffle

    boolean is_multiple := (cnt_actual >1) and (ans_correct > 1);
    return if (~IsSufficient, ds_blank,
               dataset ([{question, is_multiple, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;




  // ================================= IN WHICH OF THE CITIES BELOW IS %S? ========================
  // shared between city1, city3, city5: %s = <current address> or <prior address> or <oldest address on record>
  // (can be the same, indeed)
  // returns a list of cities: up to one correct for a person's address (plus random)
  // ==============================================================================================
  export out_rec GetCitiesForAddress (string question, unsigned ans_all, unsigned ans_correct, 
                                      dataset (iesp.share.t_Address) addr_source, unsigned1 timeline) := function
    // validate input
    valid_input := ((ans_correct =0) or (ans_correct =1)) and (ans_all > 0);
    // choose the appropriate address record
    unsigned rec_choice := map (timeline = Constants.TIMELINE.PREVIOUS => 2,
                                timeline = Constants.TIMELINE.OLDEST => count (addr_source),
                                1);
    ds_correct := choosen (addr_source, 1, rec_choice);
    street_name := Functions.FormatAddressLine1 (ds_correct[1]);
    boolean IsSufficient := valid_input and (street_name != '');

    // at that point we have valid input and exactly one correct address
    // fetch max number of records, since "real" data can be fetched here as well.
    //Functions.MAC_RANDOM (fake_files.cities, ans_all, fake_data);
   Functions.MAC_RANDOM (fake_files.citystate, ans_all, fake_data);

    //remove "real" cities from fake
    ds_fakes := join (fake_data, ds_correct, //no more than one rec on the Right
                      Left.city = Right.City,
                      left only, atmost (1));

    ds_combined := choosen (project (ds_correct, transform (iesp.eauth.t_Answer, Self.Value := Functions.FormatAddressLine2 (Left.city, Left.state), Self._IsValid := true)),
                            ans_correct) +
                   choosen (project (ds_fakes,   transform (iesp.eauth.t_Answer, Self.Value := Functions.FormatAddressLine2 (Left.city, Left.state), Self._IsValid := false)),
                            ans_all - ans_correct);
   Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand); // shuffle
  
    prompt_upd := StringLib.StringFindReplace (question, '%s', street_name);
    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, false, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;



  // ================================= WHICH ZIP CODE IS VALID FOR %S? ============================
  // zip1: %s = <current address>
  // returns a list of ZIP codes: up to one correct for a person's address (plus random)
  // ==============================================================================================
  export out_rec GetZipsForAddress (string question, unsigned ans_all, unsigned ans_correct,
                                    dataset (iesp.share.t_Address) addr_source) := function
    // validate input
    valid_input := ((ans_correct =0) or (ans_correct =1)) and (ans_all > 0);
    ds_correct := choosen (addr_source, 1);
    street_name := Functions.FormatAddressLine1 (ds_correct[1]);
    boolean IsSufficient := valid_input and (street_name != '');

    // at that point we have valid input and exactly one valid address
    // fetch max number of records, since "real" data can be fetched here as well.
   Functions.MAC_RANDOM (eAuth.fake_files.zips, ans_all, fake_data);

    //remove "real" cities from fake
    ds_fakes :=  join (fake_data, ds_correct, //no more than one rec on the Right
                       Left.zip = Right.Zip5,
                       left only, atmost (1));  // adjusted number of fake answers

    ds_combined := choosen (project (ds_correct, transform (iesp.eauth.t_Answer, Self.Value := Left.Zip5, Self._IsValid := true)),
                            ans_correct) +
                   choosen (project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := Left.zip, Self._IsValid := false)),
                            ans_all - ans_correct);
   Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand); //shuffle
  
    prompt_upd := StringLib.StringFindReplace (question, '%s', street_name);
    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, false, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;


  // ========================== WHICH OF THE CITIES BELOW ARE IN %S COUNTY?  ======================
  // Shared between city2, city4: %S = <county of residence> or <county of prior residence> (can be the same!)
  // returns a list of cities: may contain few correct ones for a person's county (plus random)
  // ==============================================================================================
  // Update: only cities where subject actually lived can be returned!
  // Moxie also tries to fill in "false answers" with subject's addresses (up to ans_correct)

  // returns the list of correct cities for the county; need it for deduping fakes
  shared {string25 city} GetCorrectCitiesByCounty (string name_county, string2 state_abbr) := function
    //first get zips (LOS ANGELES, CA has the most -- 526)
    unsigned keep_num := 600;
    zips := limit (Census_Data.Key_CountySt_Zip (keyed (county_name = name_county), keyed (state_code = state_abbr)),
                   keep_num);

    //then get cities by zips (why this index is not in doxie?); adjust for alternative city names
    cities := limit (RiskWise.Key_CityStZip (zip5 in SET (zips, zip5)), keep_num*10);
    res_slim := project (cities, {string25 city});
    return dedup (res_slim, ALL);
  end;


  export out_rec GetCitiesForCounty (string question, unsigned ans_all, unsigned ans_correct, 
                                     dataset (iesp.share.t_Address) addr_source,
                                     unsigned1 timeline = Constants.TIMELINE.CURRENT) := function
    // validate input
    valid_input := (ans_correct >=0) and (ans_all > 0);
    // fetch at least one "correct" city
    addr_county := choosen (addr_source (County != ''), 1, if (timeline = Constants.TIMELINE.CURRENT, 1, 2))[1];
    string county_name := addr_county.County;
    string city_name := addr_county.City;
    boolean IsSufficient := valid_input and (city_name != ''); // primitive test for whether we have valid address

    // fetch all subject's cities from this county (in case when multiple correct requested)
    addr_this_county := addr_source (County=county_name, City != '');
    correct_cities := dedup(sort(project (addr_this_county, {string25 city}),city),city);

    // choose other valid cities from the county. 'city_name' must be in the output in any case,
    // so it's excluded here (makes difference when current and previous counties are the same)
    Functions.MAC_RANDOM (correct_cities (city != city_name), ans_correct-1, other_correct_cities);
    ds_correct := map (ans_correct =1 => dataset ([{city_name}], {string25 city}), 
                       ans_correct >1 => dataset ([{city_name}], {string25 city}) + other_correct_cities, // take "most correct" first
                       dataset ([], {string25 city}));

    // need to know the exact (vs. desired) number of correct cities; zero only if ans_correct=0
    unsigned cnt_actual := count (ds_correct);

    // all cities belonging to this county; need it for deduping with "false answers"
    all_county_cities := GetCorrectCitiesByCounty (county_name, addr_county.State);

    // all other cities for this subject
    addr_other_cities := dedup(sort(project (addr_source (County != '', County != county_name, City != city_name), {string25 city}),city),city);
    // Simple filter by city generally won't work, since a city can belong to different counties
    // See ATLANTA for did=000566557513; also could be historical data rasons
    subject_cities := join (addr_other_cities, all_county_cities + ds_correct,
                                 Left.City = Right.city,
                                 left only);

    // fetch fake cities: max number of records, since "real" data can be fetched here as well.
    Functions.MAC_RANDOM (fake_files.cities, ans_all + count (all_county_cities), fake_data);

    //remove "real" cities from fake
    fake_cities := join (fake_data, all_county_cities + subject_cities, //no more than one rec on the Right
                         Left.city = Right.City,
                         left only);  // adjusted number of fake answers

    ds_combined := project (ds_correct, transform (iesp.eauth.t_Answer, Self.Value := Left.City, Self._IsValid := true)) +
                   choosen (project (subject_cities & fake_cities, transform (iesp.eauth.t_Answer, Self.Value := Left.city, Self._IsValid := false)),
                            ans_all - cnt_actual);

    Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand); //shuffle
  
    prompt_upd := StringLib.StringFindReplace (question, '%s', trim (county_name));
    boolean is_multiple := (cnt_actual >1);
    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, is_multiple, ds_rand & Functions.none_of_above (cnt_actual = 0)}], out_rec));
  end;


  // ===================== AT WHICH OF THE FOLLOWING ADDRESSES HAVE YOU LIVED? ====================
  // address1
  // returns a list of addresses: may contain any number of addresses a person ever lived (plus random)
  // ==============================================================================================
  export out_rec GetAddresses (string question, unsigned ans_all, unsigned ans_correct,
                               dataset (iesp.share.t_Address) addr_source) := function

    // validate input
    valid_input := (ans_correct >=0) and (ans_all > 0);

    // dedup same address
    // addr_ddp := dedup (addr_source, Zip5, StreetNumber, StreetName, UnitNumber, ALL);
    addr_ddp := dedup (addr_source, Zip5, StreetNumber, StreetName, ALL);
   Functions.MAC_RANDOM (addr_ddp, ans_correct, ds_correct);
    unsigned cnt_actual := count (ds_correct);
    boolean IsSufficient := valid_input and (cnt_actual > 0 or ans_correct=0);

    // transform first, otherwise subsequent join will look ugly
    iesp.eauth.t_Answer SetSlimAddress (iesp.share.t_Address L) := transform
      Self.Value := Functions.FormatAddressLine1 (L);
      Self._IsValid := true;
    end;
    res_correct := project (ds_correct, SetSlimAddress (Left));

    // fetch max number of records, since "real" data can be fetched here as well.
   Functions.MAC_RANDOM (fake_files.addresses, ans_all, fake_data);

    //remove "real" addresses from fake (TODO: may be redundant if we quarantee that fake addresses are really fake ones)
    ds_fakes := choosen (join (fake_data, res_correct, //no more than one rec on the Right
                               trim (Left.address) = Right.Value,
                               left only, atmost (1)), ans_all - cnt_actual); // adjusted number of fake answers

    ds_combined := res_correct +
                   project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := Left.address, Self._IsValid := false));
   Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand); //shuffle
    boolean is_multiple := cnt_actual >1;
    return if (~IsSufficient, ds_blank,
               dataset ([{question, is_multiple, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;



  // =========================== IN WHAT CITY IS EACH OF THE FOLLOWING ADDRESSES? =================
  // city6: very specific: fills in completely different structures
  // returns a list of correct [address line_1 + city] answers plus list of invalid cities
  // ==============================================================================================
  // shared Functions.FormatAddressLine2 (string city, string st) := trim (city) + ', ' + trim (st);

  export GetCity6Answers (string question, unsigned ans_all, unsigned ans_correct, 
                          dataset (iesp.share.t_Address) addr_source) := function
    // validate input
    valid_input := (ans_correct >=0) and (ans_correct <= ans_all);

    // make it slim and dedup: will need format later anyway.
    // Note, unit numbers are not considered for dedup purposes...
    iesp.eauth.t_SubQuestion SetSlimAddress (iesp.share.t_Address L) := transform
      Self.Prompt := Functions.FormatAddressLine1 (L);
      Self.Answer := Functions.FormatAddressLine2 (L.City, L.State); 
    end;
    ds_slim := project (addr_source, SetSlimAddress (Left));
    ds_correct := choosen (dedup (ds_slim, ALL) (Prompt != ''), ans_correct);
    unsigned cnt_actual := count (ds_correct);
    boolean IsSufficient := valid_input and (cnt_actual > 0);


    // fetch maximum number of records, since "correct" city+state can be fetched here as well.
   Functions.MAC_RANDOM (fake_files.citystate, ans_all, fake_data);

    iesp.share.t_StringArrayItem SetSlimCity (recordof (fake_data) L) := transform
      Self.value := Functions.FormatAddressLine2 (L.city, L.state);
    end;
    fake_cities := project (fake_data, SetSlimCity (Left));

    //remove "real" cities from fake

    ds_invalid_cities := choosen (join (fake_cities, ds_correct,
                                  // hate to compare compound strings, but here it seems to be under my control   
                                  Left.value = Right.Answer,
                                  transform (iesp.share.t_StringArrayItem, Self.value := Left.value),
                                  left only), ans_all - cnt_actual); // adjusted number of fake cities

    return if (~IsSufficient, ds_blank,
               dataset ([{question, cnt_actual > 0, [], ds_correct, ds_invalid_cities}], out_rec));
  end;


  // This belonged to property factory before, but using header addresses makes much more sense
  // ================================= HOW LONG HAVE YOU LIVED AT %S? =============================
  // property1: %S = <current property>
  // ==============================================================================================
  export out_rec GetAddressOccupation (string question, unsigned ans_all, unsigned ans_correct,
                                       dataset (PersonReports.layouts.t_AddressTimeLine) addr_source) := function
    // validate input
    valid_input := ((ans_correct =0) or (ans_correct =1)) and (ans_all > 0);
    ds_correct := choosen (addr_source, 1); //most recent
    date := ds_correct[1].DateFirstSeen;
    street_name := Functions.FormatAddressLine1 (project (ds_correct, iesp.share.t_Address)[1]);
    boolean IsSufficient := valid_input and (street_name != '') and (date.Year != 0);

    years := ut.GetAgeI (date.Year * 10000 + date.Month * 100 + date.Day);
    answers_date_full := dataset ([
     {'Less than 2 years', years < 2},
     {'2 - 3 years',  years = 2},
     {'3 - 4 years',  years = 3},
     {'4 - 5 years',  years = 4},
     {'Over 5 years', years >= 5},
     {'I don\'t know', false} //at this point we necessarily have valid 'years' calculated
    ], iesp.eauth.t_Answer);
    
    // if we don't have a month, then an error can be up to one year, so intervals should be at least 2 years
    years_adjusted := if (date.Month = 0, years - 1, years);

    // depending on whether we have odd or even adjusted year, corresponding sliding scale should be used.
    answers_date_even := dataset ([
     {'Less than 2 years', false},    // 0 will fall into regular scale above
     {'2 - 4 years',   years_adjusted = 2},  // actually 2 or 3
     {'4 - 6 years',   years_adjusted = 4},  // actually 4 or 5
     {'6 - 8 years',   years_adjusted = 6},  // actually 6 or 7
     {'8 - 10 years',  years_adjusted = 8},  // actually 8 or 9
     {'Over 10 years', years_adjusted >= 10},
     {'I don\'t know', false} //at this point we necessarily have valid 'years' calculated
    ], iesp.eauth.t_Answer);

    answers_date_odd := dataset ([
     {'Less than 1 years', false},   // this will also fall into regular scale above
     {'1 - 3 years',  years_adjusted = 1}, // actually 1 or 2
     {'3 - 5 years',  years_adjusted = 3}, // actually 3 or 4
     {'5 - 7 years',  years_adjusted = 5}, // actually 5 or 6
     {'7 - 9 years',  years_adjusted = 7}, // actually 7 or 8
     {'Over 9 years', years_adjusted >= 9},
     {'I don\'t know', false} //at this point we necessarily have valid 'years' calculated
    ], iesp.eauth.t_Answer);

    
    answers := if (date.Month = 0 and years_adjusted != 0, 
                   if (years_adjusted %2 = 0, answers_date_even, answers_date_odd),
                   answers_date_full);

    prompt_upd := StringLib.StringFindReplace (question, '%s', street_name);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, answers}], out_rec));
  end;
  
END;