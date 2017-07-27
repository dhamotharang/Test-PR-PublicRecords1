IMPORT iesp, ut;

out_rec := layouts.question_ext;
ds_blank := dataset ([], out_rec);

export QuestionFactory_Property := MODULE

   // PROPERTY QUESTIONS
  shared deeds_rec  := layouts.slim_deeds; //iesp.propdeed.t_DeedReportRecord;
  shared assess_rec := layouts.slim_assessments; //iesp.propassess.t_AssessReportRecord;

  // returns "current" deed(s)
  // Note that DEEDS for subject selling a property is filtered at the top level
  shared deeds_rec GetCurrentDeeds (dataset (deeds_rec) prop) := function
    // have to choose the "best" GRANT DEED, if there are more than one for the same property:
    // let's try to give a preference to a "latest grant deed with a sale price (if any)"
    // see case of did=001425830909
    grant_deeds := prop (stringlib.StringToUpperCase (trim (DocumentType)) = 'GRANT DEED');
    preferred := grant_deeds (SalePrice != '');
    return choosen (if (exists (preferred), preferred, grant_deeds), 1);
  end;

  // returns "current" assessment(s)
  shared assess_rec GetCurrentAssessments (dataset (assess_rec) prop) := function
    return choosen (prop, 1);
  end;

  //this is to isolate required property; function will be redundant after proper testing
  shared deeds_rec GetDeedRow (dataset (deeds_rec) prop) := function
    return choosen (prop, 1) [1];
  end;

  shared assess_rec GetAssessmentRow (dataset (assess_rec) prop) := function
    return choosen (prop, 1) [1];
  end;


  // =============== WHAT IS THE APPROXIMATE TOTAL SQUARE FOOTAGE OF YOUR HOME AT %S? =============
  // property2: %S = <current property>
  // ==============================================================================================

  // returns footage in whole thousands, may depend on the input format
  shared integer atoi (string str_in) := function
    return (integer) stringlib.StringFilterOut (str_in, ',$');
  end;

  // returns formatted footage string (for example, adding ',' delimeterm, etc.)
  shared string GetFootageString (unsigned footage) := iesp.ECL2ESP.InsertPlaceHolders ((string) (footage));


  export out_rec GetPropertyFootage (string question, unsigned ans_all, unsigned ans_correct,
                                     dataset (assess_rec) prop) := function
    // verify property input record for this particular question:
    prop_valid := GetCurrentAssessments (prop (atoi (LivingSize) > 0)); // most recent, if any
    prop_row := GetAssessmentRow (prop_valid);
    prop_addr := Functions.FormatAddressLine1 (prop_row.PropertyAddress);
    boolean IsSufficient := exists (prop_valid) and (trim (prop_addr) != '');

    unsigned norm := 1000; // or 1, if input string in thousands already
    unsigned f_size := atoi (prop_row.LivingSize);

    // ensure that actual size will hit one of the intervals (except smallest and largest)
    // calculate the beginning and end of the interval; 
    unsigned step := 500;
    unsigned1 num_iter := 4;
    integer random_iter := Functions.GetRandom (num_iter) : independent;
    integer  begin_i := (unsigned)(f_size / norm) * norm - (step * random_iter);
    unsigned start_pos := if (begin_i < 1, norm, (unsigned) begin_i);
    unsigned end_pos := start_pos + step*(num_iter-1); // first iteration will be spent for "... less than ..."

    // something to feed to normalize
    first_line := dataset ([{GetFootageString (start_pos) + ' or less', f_size <= start_pos}], iesp.eauth.t_Answer);

    iesp.eauth.t_Answer AddIntervals (iesp.eauth.t_Answer L, integer C) := transform
      unsigned high := start_pos + (C-1)*step;
      unsigned low  := high - step + 1;
      Self.Value := if (C=1, L.value, GetFootageString (low) + ' - ' + GetFootageString (high));
      Self._IsValid := if (C=1, L._IsValid, (f_size >= low) and (f_size <= high));
    end;

    answers := normalize (first_line, num_iter, AddIntervals (Left, counter)) &
               dataset ([{'Over ' + GetFootageString (end_pos), f_size > end_pos},
			{'I don\'t know', false}], iesp.eauth.t_Answer);

    prompt_upd := StringLib.StringFindReplace (question, '%s', prop_addr);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, answers}], out_rec));
  end;


  // ======================== HOW MUCH DID YOU PAY FOR YOUR HOME AT %S? ===========================
  // property3: %S = <current property>
  // ==============================================================================================
  // returns formatted footage string (for example, adding ',' delimeterm, etc.)
  shared string GetPriceString (unsigned price) := iesp.ECL2ESP.InsertPlaceHolders ((string) (price));

  export out_rec GetPropertyPriceRange (string question, unsigned ans_all, unsigned ans_correct,
                                        dataset (deeds_rec) prop) := function

    // verify property input record for this particular question:
    prop_valid := GetCurrentDeeds (prop (atoi (SalePrice) > 0));  // most recent "sale/buy" deeds, if any
    prop_row := GetDeedRow (prop_valid);
    prop_addr := Functions.FormatAddressLine1 (prop_row.PropertyAddress);

    unsigned price := atoi (prop_row.SalePrice);
    boolean IsSufficient := exists (prop_valid) and (trim (prop_addr) != '');

    // ensure that actual price will hit one of the intervals (except smallest and largest)
    // calculate the beginning of the interval; 
    unsigned1 num_iter := 4;
    unsigned step := if (price < 1000000, 50000, 500000);
    unsigned norm := if (price < 1000000, power (10, 4), power (10, 5));

    integer random_iter := Functions.GetRandom (num_iter) : independent;
    integer begin_i := ((unsigned)price / norm) * norm - (step * random_iter);
    unsigned start_pos := if (begin_i < 1, 2 * step, begin_i);
    unsigned end_pos := start_pos + step*(num_iter-1); // first iteration will be spent for "... less than ..."

    first_line := dataset ([{GetPriceString (start_pos) + ' or less', price <= start_pos}], iesp.eauth.t_Answer);
    iesp.eauth.t_Answer AddIntervals (iesp.eauth.t_Answer L, integer C) := transform
      unsigned high := start_pos + (C-1)*step;
      unsigned low  := high - step + 1;
      
      Self.Value := if (C=1, L.value, GetPriceString (low) + ' - ' + GetPriceString (high));
      Self._IsValid := if (C=1, L._IsValid, (price >= low) and (price <= high));
    end;
    answers := normalize (first_line, num_iter, AddIntervals (Left, counter)) &
               dataset ([{'Over ' + GetPriceString (end_pos), price > end_pos},
			{'I don\'t know', false}], iesp.eauth.t_Answer);

    prompt_upd := StringLib.StringFindReplace (question, '%s', prop_addr);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, answers}], out_rec));
  end;


  // ==================== FROM WHOM DID YOU PURCHASE YOUR RESIDENCE AT %S? ========================
  // property4: %S = <current property>
  // ==============================================================================================
  export out_rec GetPropertySeller (string question, unsigned ans_all, unsigned ans_correct,
                                    dataset (deeds_rec) prop) := function

    // verify property input record for this particular question:
    prop_valid := GetCurrentDeeds (prop (exists (Sellers)));  // most recent "sale/buy" deeds, if any
    prop_row := GetDeedRow (prop_valid);
    prop_addr := Functions.FormatAddressLine1 (prop_row.PropertyAddress);

    boolean IsSufficient := ((ans_correct=0) or (ans_correct=1)) and exists (prop_valid) and (trim (prop_addr) != '');

    // seems like ans_correct can be [0,1] only
    Functions.MAC_RANDOM (prop_row.Sellers, if (ans_correct = 0, 0, 1), ds_correct); // random seller
    string SellerName := if (ds_correct[1].CompanyName != '', ds_correct[1].CompanyName, ds_correct[1].Full);
    unsigned cnt_actual := count (ds_correct);

    Functions.MAC_RANDOM (fake_files.people1, ans_all - cnt_actual, ds_fake);
    // skip comparing fake to real: probability is virtually zero

    ds_combined := if (cnt_actual > 0, dataset ([{SellerName, true}], iesp.eauth.t_Answer), dataset ([], iesp.eauth.t_Answer)) +
                   project (ds_fake, transform (iesp.eauth.t_Answer, Self.Value := Left.full_name, Self._IsValid := false));

   Functions.MAC_RANDOM (ds_combined, ans_all, ds_rand);
  
    prompt_upd := StringLib.StringFindReplace (question, '%s', prop_addr);
    //is_multiple := (cnt_actual > 1) and (ans_correct > 1);
    return if (~IsSufficient, ds_blank,
               dataset ([{prompt_upd, false /*is_multiple*/, ds_rand & Functions.none_of_above (ans_correct = 0)}], out_rec));
  end;


  // ======================== WHEN DID YOU PURCHASE YOUR HOME AT %S? =============================
  // property5: %S = <current property>
  // ==============================================================================================
 
  // returns formatted date string; adjusted in the case if accidentally coincide with real date
  string GetAdjustedDate (unsigned year, unsigned month, boolean needs_adjustment) := function
    adj_month := if (needs_adjustment, if (month = 12, 1, month + 1), month);
    adj_year  := if (needs_adjustment, year - 1, year);
    return  Functions.months_set [adj_month] + ' ' + (string) adj_year;
  end;

  export out_rec GetPropertyPurchasedDates (string question, unsigned ans_all, unsigned ans_correct,
                                            dataset (deeds_rec) prop) := function

    // verify property input record for this particular question:
    prop_valid := GetCurrentDeeds (prop (Functions.IsValidDate (SaleDate)));  // most recent "sale/buy" deeds, if any
    prop_row := GetDeedRow (prop_valid);
    prop_addr := Functions.FormatAddressLine1 (prop_row.PropertyAddress);

    boolean IsSufficient := exists (prop_valid) and (trim (prop_addr) != '');

    f_sale := prop_row.SaleDate;

    // save random row number of a correct answer (may not be the last).
    // unsigned r_correct := Functions.GetRandom (ans_all-1) + 1 : independent;
    unsigned ans_fake := ans_all-2;//if (ans_correct = 0, ans_all-2, ans_all-1);//

    // to guarantee that no correct answers will be generated accidentally, first create random dates:
    iesp.eauth.t_Answer CreateFakeDates (iesp.eauth.t_Answer L) := transform
      r_year := f_sale.Year - Functions.GetRandom (10);
      r_month := Functions.GetRandom (12) + 1;
      Self.Value := GetAdjustedDate (r_year, r_month, (r_year = f_sale.Year) and (r_month = f_sale.Month)); 
      Self._IsValid := false;
    end;
    fake_answers_tmp := normalize (dataset ([{'',false}], iesp.eauth.t_Answer), ans_fake+1, CreateFakeDates (Left)); //-correct, -"don't know"

    correct_date := dataset ([{GetAdjustedDate (f_sale.Year, f_sale.Month, false), true}], iesp.eauth.t_Answer);
   fake_answers:=choosen(join(fake_answers_tmp,correct_date,left.value=right.value,transform(iesp.eauth.t_Answer,self:=left),left only),ans_fake);
   
   ds_combined:=fake_answers + correct_date;//choosen(dedup(sort(fake_answers + correct_date,Value,if(_IsValid,0,1)),Value),ans_all-1);
   Functions.MAC_RANDOM (ds_combined, ans_all-1, shuffle_dates);
	
    answers := shuffle_dates & dataset ([{'I don\'t know', false}], iesp.eauth.t_Answer);

    prompt_upd := StringLib.StringFindReplace (question, '%s', prop_addr);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, answers}], out_rec));
  end;



  // ============================= WHAT TYPE OF RESIDENCE IS %S? ==================================
  // property6: %S = <current property>
  // ==============================================================================================
  export out_rec GetPropertyTypes (string question, unsigned ans_all, unsigned ans_correct, 
                                   dataset (assess_rec) prop) := function

    // verify property input record for this particular question:
    prop_valid := GetCurrentAssessments (prop (LandUsage != ''));  // most recent assessment, if any
    prop_row := GetAssessmentRow (prop_valid);
    prop_addr := Functions.FormatAddressLine1 (prop_row.PropertyAddress);

    f_usage := stringlib.StringToUpperCase (trim (prop_row.LandUsage));
    boolean IsSufficient := exists (prop_valid) and (trim (prop_addr) != '');

    prop_types := dataset ([
      //TODO: what's with the PLANNED UNIT DEVELOPMENT?
      {'Single Family Residence', (f_usage = 'SFR') or (f_usage = 'SINGLE FAMILY RESIDENCE') or (f_usage = 'SINGLE FAMILY RESIDENTIAL')}, 
      // I've seen some "CONDOMINIUM (RESIDENTIAL)"
      {'Condominium', (f_usage = 'CONDO') or (f_usage = 'CONDOMINIUM') or stringlib.StringFind (f_usage, 'CONDOMINIUM', 1) > 0},
      {'Townhome', (f_usage = 'TOWNHOME') or (f_usage = 'TOWNHOUSE')},
      {'Apartment', f_usage = 'APARTMENT'}
    ], iesp.eauth.t_Answer);

    // add "none of the above"
    answers := prop_types & Functions.none_of_above (~exists (prop_types (_IsValid)));

    prompt_upd := StringLib.StringFindReplace (question, '%s', prop_addr);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, answers}], out_rec));
  end;


  // ========================== WHEN WAS THE BUILDING AT %S BUILT? ================================
  // property7: %S = <current property>
  // ==============================================================================================

  // 'ans_all' is not honored; 'ans_correct' is either 0 or 1
  export out_rec GetPropertyBuiltDate (string question, unsigned ans_all, unsigned ans_correct,
                                       dataset (assess_rec) prop) := function
    // validate input and property records for this particular question:
    valid_input := ((ans_correct =0) or (ans_correct =1)) and (ans_all > 0);
    prop_valid := GetCurrentAssessments (prop (YearBuilt > 0));  // most recent assessment, if any
    prop_row := GetAssessmentRow (prop_valid);
    prop_addr := Functions.FormatAddressLine1 (prop_row.PropertyAddress);

    f_yearbuilt := prop_row.YearBuilt;
    boolean IsSufficient := valid_input and exists (prop_valid) and (trim (prop_addr) != '');

    currentYear := (unsigned)(ut.getDate [1..4]);

    // something to feed to normalize
    fake_line := dataset ([{'', false}], iesp.eauth.t_Answer);

    // "transform" wouldn't allow use of independent, 
    // I will need at least 2 randoms here: from [0..9] and [0..29]
    rand_10 := Functions.GetRandom (10) : independent;
    rand_30 := Functions.GetRandom (30) : independent;
    iesp.eauth.t_Answer SetYearRange (iesp.eauth.t_Answer L, integer C) := transform
      unsigned range_low  := choose (C,  1, 11, 21, 51, 0);
      unsigned range_high := choose (C, 10, 20, 50, 80, 0);
      unsigned year_low  := currentYear - range_high;
      unsigned year_high := currentYear - range_low;

      r_year := if (C < 3, rand_10, rand_30);
      unsigned rand_year := currentYear - (range_low + r_year); 

      // increment (or decrement) actual year (used in case when NO correct answers required).
      unsigned year_adjusted := if (f_yearbuilt <year_high, f_yearbuilt + 1, f_yearbuilt + 1);

      // check whether real year fits into the this iteration range:
      boolean this_range := (f_yearbuilt >= year_low) and (f_yearbuilt <= year_high);

      year_value := if (ans_correct > 0, 
                        if (this_range, f_yearbuilt, rand_year),
                        if (rand_year = f_yearbuilt, year_adjusted, rand_year));

      // handle "None of the above" (can be true and false as well) separately:
      Self.Value := if (C = 5, 'None of the above', (string) year_value);
      Self._IsValid := if (C = 5, ans_correct = 0, year_value = f_yearbuilt);
    end;

    answers := normalize (fake_line, 5, SetYearRange (Left, counter)); // counting "I don't know"

    prompt_upd := StringLib.StringFindReplace (question, '%s', prop_addr);
    return if (~IsSufficient, ds_blank, dataset ([{prompt_upd, false, answers}], out_rec));
  end;



 
END;