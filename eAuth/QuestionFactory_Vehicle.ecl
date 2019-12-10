IMPORT iesp, VehicleV2_Services, std;

out_rec := layouts.question_ext;
ds_blank := dataset ([], out_rec);

export QuestionFactory_Vehicle := MODULE

  shared veh_rec := VehicleV2_Services.Layout_Report;//iesp.motorvehicle.t_MVReportRecord;

  shared veh_rec GetVehicleRow (dataset (veh_rec) veh) := function
    return choosen (veh, 1) [1];
  end;

  // Note that make_desc can be blank (!) in some records (veh key = 11785758469169168326, for instance)
  shared string GetVehicleName (string36 make, string36 model) := trim (make) + ' ' + trim (model);

 // VEHICLE QUESTIONS
  // ========================= WHICH OF THE FOLLOWING VEHICLES DO YOU OWN? ========================
  // returns a list of vehicles: may contain few current vehicles for a person (plus random)
  // ==============================================================================================
  export out_rec GetVehicles
    (string question, unsigned ans_all, unsigned ans_correct, dataset (veh_rec) veh_source) := function

    // fetch "correct" vehicles
    // veh_valid := veh_source (HistoryFlag = 'CURRENT', YearMake != 0, Make != '', Model != '');
    // veh_valid := veh_source (is_current, (integer4) model_year != 0, make_desc != '', model_desc != '');
    veh_valid_tmp := sort(veh_source ((integer4) model_year != 0, make_desc != '', model_desc != ''),if(is_current,0,1));
    veh_valid := if(exists(veh_valid_tmp(is_current)),veh_valid_tmp(is_current),veh_valid_tmp);
    //ds_correct := Functions.MAC_PICK_RANDOM_RECS (veh_valid, ans_correct) : INDEPENDENT;
    // unsigned cnt_actual := count (ds_correct);
    // boolean IsSufficient := cnt_actual > 0;

    res_correct_all := project (veh_valid, transform (iesp.eauth.t_Answer,
                                                   Self.Value := trim (Left.make_desc) + ' ' + trim (Left.model_desc); Self._IsValid := true));
    res_correct_tmp := dedup(sort(res_correct_all,value, _IsValid), value);

    // now randomly choose required number of vehicles, which will be used later as a qestion subject
    res_correct := Functions.MAC_PICK_RANDOM_RECS (res_correct_tmp, ans_correct);
    unsigned cnt_actual := count(res_correct);
    boolean IsSufficient := cnt_actual > 0;

    // fetch max number of records, since "real" data can be fetched here as well.
    fake_data := Functions.MAC_PICK_RANDOM_RECS (fake_files.cars, ans_all);

    ds_fakes := choosen (join (fake_data, res_correct, //no more than one rec on the Right
                               trim (Left.make_model) = Right.Value,
                               left only, atmost (1)), ans_all - cnt_actual);  // adjusted number of fake answers

    ds_fakes_fmt := project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := Left.make_model, Self._IsValid := false));
    ds_combined := if(ans_correct=0, ds_fakes_fmt ,res_correct + ds_fakes_fmt);


    ds_rand := Functions.MAC_PICK_RANDOM_RECS (ds_combined, ans_all);

    // return dataset ([{cnt_actual = 0 and ans_correct > 0, prompt_upd, ds_rand}], out_rec);
    boolean is_multiple := cnt_actual >1 and ans_correct > 1;
    return if (~IsSufficient, ds_blank,
               dataset ([{question, is_multiple, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;


  // =============================== WHAT YEAR IS YOUR %S? ========================================
  // %S = <vehicle description> ???
  // returns a list of years vehicle could be purchased: (up to) one actual plus random
  // ==============================================================================================
  export out_rec GetVehicleYear
    (string question, unsigned ans_all, unsigned ans_correct, dataset (veh_rec) veh_source) := function

    // fetch "valid" vehicles
    // veh_valid := veh_source (HistoryFlag = 'CURRENT', YearMake != 0, Make != '', Model != '');
    // veh_valid := veh_source (is_current, (integer4) model_year != 0, make_desc != '', model_desc != '');
    veh_valid_tmp := sort(veh_source ((integer4) model_year != 0, make_desc != '', model_desc != ''),if(is_current,0,1));
    veh_valid := if(exists(veh_valid_tmp(is_current)), veh_valid_tmp(is_current), veh_valid_tmp);

    // now randomly choose single vehicle, which will be used later as a qestion subject
    ds_correct := Functions.MAC_PICK_RANDOM_RECS (veh_valid, 1) : INDEPENDENT;
    unsigned cnt_actual := count (ds_correct);
    vehicle_name := GetVehicleName (ds_correct[1].make_desc, ds_correct[1].model_desc);
    boolean IsSufficient := (cnt_actual > 0) and (trim (vehicle_name) != '');

    // fetch max number of records, since "real" data can be fetched here as well.
    fake_data := Functions.MAC_PICK_RANDOM_RECS (fake_files.car_years, ans_all);

    ds_fakes := choosen (join (fake_data, ds_correct, //no more than one rec on the Right
                               Left.year_make = (integer4) Right.model_year,
                               left only, atmost (1)), ans_all - ans_correct);  // adjusted number of fake answers

    // ds_combined := project (ds_correct, transform (iesp.eauth.t_Answer, Self.Value := (string) Left.YearMake, Self._IsValid := true)) +
                   // project (ds_fakes,   transform (iesp.eauth.t_Answer, Self.Value := (string) Left.year_make, Self._IsValid := false));
    ds_correct_fmt := project (ds_correct, transform (iesp.eauth.t_Answer, Self.Value := (string) Left.model_year, Self._IsValid := true));
    ds_fakes_fmt := project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := (string) Left.year_make, Self._IsValid := false));
    ds_combined :=  if(ans_correct=0, ds_fakes_fmt, ds_correct_fmt + ds_fakes_fmt);


    ds_rand := Functions.MAC_PICK_RANDOM_RECS (ds_combined, ans_all);

    prompt_upd := StringLib.StringFindReplace (question, '%s', vehicle_name);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;



  // =============================== WHAT COLOR IS YOUR %S? ========================================
  // %S = <vehicle description> ???
  // returns a list of possible vehicle colors: (up to) one actual plus random
  // ==============================================================================================
  export out_rec GetVehicleColor
    (string question, unsigned ans_all, unsigned ans_correct, dataset (veh_rec) veh_source) := function

    // fetch "valid" vehicles
    // veh_valid := veh_source (HistoryFlag = 'CURRENT', VehicleSpecification.MajorColor != '', Make != '', Model != '');
    // veh_valid := veh_source (is_current, (integer4) model_year != 0, make_desc != '', model_desc != '');
    veh_valid_tmp := sort(veh_source ((integer4) model_year != 0, make_desc != '', model_desc != ''), if(is_current,0,1));
    veh_valid := if(exists(veh_valid_tmp(is_current)), veh_valid_tmp(is_current), veh_valid_tmp);

    // now randomly choose single vehicle, which will be used later as a qestion subject
    ds_correct := Functions.MAC_PICK_RANDOM_RECS (veh_valid, 1) : INDEPENDENT;
    res_correct := project (ds_correct, transform (iesp.eauth.t_Answer,
                                                   Self.Value := trim (Left.major_color_desc); Self._IsValid := true));
    unsigned cnt_actual := count (ds_correct(major_color_desc<>''));
    vehicle_name := GetVehicleName (ds_correct[1].make_desc, ds_correct[1].model_desc);
    boolean IsSufficient := (cnt_actual > 0) and (trim (vehicle_name) != '');

    // fetch max number of records, since "real" data can be fetched here as well.
    fake_data := Functions.MAC_PICK_RANDOM_RECS (fake_files.colors, ans_all);

    ds_fakes := choosen (join (fake_data, res_correct, //no more than one rec on the Right
                               Left.color = Right.Value,
                               left only, atmost (1)), ans_all - cnt_actual);  // adjusted number of fake answers

    ds_fakes_fmt := project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := Left.color, Self._IsValid := false));

    ds_combined := if(ans_correct=0, ds_fakes_fmt, res_correct + ds_fakes_fmt);


    ds_rand := Functions.MAC_PICK_RANDOM_RECS (ds_combined, ans_all);

    prompt_upd := StringLib.StringFindReplace (question, '%s', vehicle_name);

    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, false, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;



  // ============================ WHO IS THE LIEN/LEASE HOLDER FOR YOUR %S ========================
  // %S = <vehicle description> ???
  // returns a list of lien/lease holders: (up to) one actual plus random
  // ==============================================================================================
  shared boolean IsLienholder (string name) := function
    name_cleaned := trim (name);
    // this replicates (and possibly extends) Moxie behaviour
    is_invalid := (name_cleaned = '') or
                  (name_cleaned = 'NOT ON FILE') or
                  (stringlib.StringFind (name, 'LIENHOLDER NUMBER', 1) = 1) or
                  (name_cleaned = 'NO ACTIVE LIENS ON FILE');
    return ~is_invalid;
  end;

  export out_rec GetVehicleLienHolders
    (string question, unsigned ans_all, unsigned ans_correct, dataset (veh_rec) veh_source) := function

    // fetch "valid" vehicles
    // valid_vehicles := veh_source (HistoryFlag = 'CURRENT', Functions.IsValidDate (Title.TitleIssueDate), Make != '', Model != '');
    valid_vehicles_tmp := sort(veh_source (exists (lienholders (IsLienholder (Append_Clean_CName)))), if(is_current,0,1));
    valid_vehicles := if(exists(valid_vehicles_tmp(is_current)), valid_vehicles_tmp(is_current), valid_vehicles_tmp);

    // now randomly choose single vehicle, which will be used later as a qestion subject
    ds_correct := Functions.MAC_PICK_RANDOM_RECS (valid_vehicles, 1) : INDEPENDENT;
    vehicle_name := GetVehicleName (ds_correct[1].make_desc, ds_correct[1].model_desc);
    boolean IsSufficient := trim (vehicle_name) != '';

    res_correct := project (ds_correct, transform (iesp.eauth.t_Answer,
                                                   Self.Value := trim (Left.lienholders[1].Append_Clean_CName); Self._IsValid := true));

    unsigned cnt_actual := count (ds_correct);

    // fetch max number of records, since "real" data can be fetched here as well.
    fake_data := Functions.MAC_PICK_RANDOM_RECS (fake_files.leasors, ans_all);

    ds_fakes := choosen (join (fake_data, res_correct, //no more than one rec on the Right
                               Left.name = Right.Value,
                               left only, atmost (1)), ans_all - ans_correct);  // adjusted number of fake answers

    ds_fakes_fmt := project (ds_fakes, transform (iesp.eauth.t_Answer, Self.Value := Left.name, Self._IsValid := false));

    ds_combined := if(ans_correct=0, ds_fakes_fmt, res_correct + ds_fakes_fmt);


    ds_rand := Functions.MAC_PICK_RANDOM_RECS (ds_combined, ans_all);

    prompt_upd := StringLib.StringFindReplace (question, '%s', vehicle_name);

    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, false, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;


  // ============================= WHEN DID YOU PURCHASE/LEASE YOUR %S? ===========================
  // %S = <vehicle description> ???
  // returns a list of vehicles: may contain few current vehicles for a person (plus random)
  // ans_correct can be either 0 or 1
  // ==============================================================================================
  export out_rec GetVehiclePurchaseDate
    (string question, unsigned ans_all, unsigned ans_correct, dataset (veh_rec) veh_source) := function
// veh_valid := veh_source (is_current, (integer4) model_year != 0, make_desc != '', model_desc != '');
    // fetch "valid" vehicles (TODO: current only?)
    valid_vehicles_tmp := sort(veh_source (Functions.IsValidDate (iesp.ECL2ESP.toDate ((unsigned4) owners[1].Ttl_Latest_Issue_Date)), make_desc != '', model_desc != ''), if(is_current,0,1));
    valid_vehicles:=if(exists(valid_vehicles_tmp(is_current)), valid_vehicles_tmp(is_current), valid_vehicles_tmp);

    // now randomly choose single vehicle, which will be used later as a qestion subject
    ds_correct := Functions.MAC_PICK_RANDOM_RECS (valid_vehicles, 1) : INDEPENDENT;
    vehicle_name := GetVehicleName (ds_correct[1].make_desc, ds_correct[1].model_desc);
    boolean IsSufficient := trim (vehicle_name) != '';

    real_year  := iesp.ECL2ESP.toDate ((unsigned4) ds_correct[1].owners[1].Ttl_Latest_Issue_Date).Year;
    real_month := iesp.ECL2ESP.toDate ((unsigned4) ds_correct[1].owners[1].Ttl_Latest_Issue_Date).Month;
    currentYear := (unsigned)(((STRING8)Std.Date.Today())[1..4]);
    month_Name := Functions.months_set [real_month];
    ds_correct_rec := dataset ([{month_Name + ' ' + (string4) real_year, true}], iesp.eauth.t_Answer);

    // generate array of fake years/months
    rec := record
      unsigned year;
      unsigned month;
      unsigned r_correct := 0; // to keep randomly generated position of a correct answer
    end;
    // seed for normalize
    ds_init := dataset ([{0, 0, if (ans_correct > 0, Functions.GetRandom (ans_all) + 1, 0)}], rec);

    // this can include one extra record (in case ans_correct > 0)
    rec GenerateFakes () := transform
      Self.year := currentYear - Functions.GetRandom (10);
      Self.month := Functions.GetRandom (12) + 1;
    end;
    ds_fakes_tmp := normalize (ds_init, ans_all - if (ans_correct > 0, 1, 0), GenerateFakes ());

    iesp.eauth.t_Answer AdjustDates (rec L) := transform
      v_year  := if (L.year = real_year, L.year-1, L.year);
      v_month := L.month;
      Self.Value := Functions.months_set [v_month] + ' ' + (string4) v_year;
      Self._IsValid := false;
    end;
    ds_fakes := project (ds_fakes_tmp, AdjustDates (Left));
    ds_combined := if (ans_correct > 0, ds_fakes + ds_correct_rec, ds_fakes);
    ds_rand := Functions.MAC_PICK_RANDOM_RECS (ds_combined, ans_all);

    prompt_upd := StringLib.StringFindReplace (question, '%s', vehicle_name);
    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, false, ds_rand & Functions.none_of_above (ans_correct=0)}], out_rec));
  end;

END;