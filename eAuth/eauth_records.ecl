IMPORT doxie, iesp, AutoStandardI, PersonReports, ut,VehicleV2_Services, LN_PropertyV2_Services, suppress;

out_rec := record (iesp.eauth.t_EAuthResponse)
  // dataset (layouts.question_matrix) ver;
  // dataset (iesp.share.t_Address) addr;
  //dataset (iesp.motorvehicle.t_MVReportRecord) veh;
  // dataset (layouts.slim_deeds) deeds;
  // dataset (layouts.slim_assessments) assess;
end;

// per every question:
unsigned1 ANSWERS_DEFAULT := 5;
unsigned1 ANSWERS_VALID := 3;
unsigned1 ANSWERS_MAX := iesp.Constants.EAUTHORIZE.MaxAnswers; //20

// atmost one DID, actually
EXPORT out_rec eauth_records (
  dataset (doxie.layout_references) dids,
  IParam.records param,
  boolean IsFCRA = false) := FUNCTION

  input_dids_set := SET (dids, did);

// --------------------------------------------------------------------------
// ------------------------------ Verify input ------------------------------
// --------------------------------------------------------------------------
  // set integer question id; verify input request, correct it, if required:
  int_id_rec := record
    iesp.eAuth.t_QuestionReq and not id;
    unsigned1 qid;
  end;
  q_project := project (param.questions, transform (int_id_rec, Self.qid := eAuth.GetQuestionID (Left.id); Self := Left));

  q_in := DEDUP (q_project, qid, ALL); // just on case (it is caller's responsibility, if something is lost here).

  layouts.question_matrix VerifyInput (int_id_rec L, recordof (eAuth.file_questions) R) := transform
    Self.qid := L.qid;
    Self.qname := R.qname;
    Self.prompt := R.prompt;
    Self.multiple_correct := param.GetMultipleCorrect and R.multiple_correct;

    // maximum number of all possible answers
    unsigned1 all_num := if (L.NumAnswers > 0 and L.NumAnswers <= ANSWERS_MAX and L.NumAnswers>=L.NumValid, L.NumAnswers, ANSWERS_DEFAULT);
    
    Self.answers_num := if(all_num>iesp.Constants.EAUTHORIZE.MaxAnswers,iesp.Constants.EAUTHORIZE.MaxAnswers,all_num);
    // number of valid answers cannot be more than number of all possible answers, but can be zero
    unsigned1 actual_valid_tmp := if (L.NumValid >= 0 and L.NumValid <= L.NumAnswers, L.NumValid, ut.min2 (all_num, ANSWERS_VALID));
    unsigned1 actual_valid := if(R.multiple_correct=true,actual_valid_tmp,if(actual_valid_tmp>1,1,actual_valid_tmp));
    Self.answers_valid := if(actual_valid>iesp.Constants.EAUTHORIZE.MaxInvalidAnswers,iesp.Constants.EAUTHORIZE.MaxInvalidAnswers,actual_valid);
  end;

  q_verified := JOIN (q_in, eAuth.file_questions,
                      Left.qid = Right.qid,
                      VerifyInput (Left, Right));

//  return q_verified;

// --------------------------------------------------------------------------
// ------------------------- Fetch personal records -------------------------
// --------------------------------------------------------------------------
  // best records
  pers := PersonReports.Person_records (dids, module (project (param, PersonReports.input.personal, opt)) end, IsFCRA);
  ds_best := pers.bestrecs;  //doxie.layout_best

  // Note: addresses must be sorted from most recent to the oldest one.
  // Need only properly cleaned addresses here, hence, zip4
  addr_timeline := choosen (pers.SubjectShortAddresses (Zip4 != ''),  iesp.Constants.EAUTHORIZE.MaxAddress): GLOBAL;
  addr_slim := project (addr_timeline,  transform (iesp.share.t_Address, Self := Left));

  // relatives
  p_relatives  := choosen (pers.RelativesSlim,  iesp.constants.BR.MaxRelatives);
  iesp.share.t_Identity GetSlimRelatives (iesp.bpsreport.t_BpsReportRelativeSlim L) := transform // or even iesp.share.t_Name
    // pick first from variety of identities (can take random as well)
    Self := project (choosen(L.AKAs,1)[1], transform (iesp.share.t_Identity, Self := Left));
  end;
  rel_slim := project (p_relatives, GetSlimRelatives (Left)) : GLOBAL;

  
  // -------------------------- SSN patch ------------------------------------
  // Need a special patch for the case when input SSN can be resolved to more than one DID
  // (for examle, see SSN for did=2328990893): best SSN may be different in this case.
  // To bypass it I will create a "fake" AKA, having issue/location data for the input SSN.
  string9 ssn_input := AutoStandardI.InterfaceTranslator.ssn_value.val (param);
  unsigned6 this_did := dids[1].did;

  ssn_map := doxie.Key_SSN_Map (keyed (ssn5 =ssn_input[1..5]), keyed (ssn_input[ 6..9] between start_serial AND end_serial)); 

  iesp.share.t_SSNInfoEx FormatSSN (doxie.Key_SSN_Map R) := TRANSFORM
    r_end := IF (R.end_date='20990101', 0, (unsigned4) R.end_date);
    Valid := 'M'; // fake value: to generate "maybe" if this input ssn is chosen eventually
		Self.Valid						:= if(Suppress.dateCorrect.do(ssn_input).needed, 'G', Valid);
		Self.IssuedStartDate	:= iesp.ECL2ESP.toDate(Suppress.dateCorrect.sdate_u4(ssn_input, (integer)R.start_date));
		Self.IssuedEndDate		:= iesp.ECL2ESP.toDate(Suppress.dateCorrect.edate_u4(ssn_input, r_end));
		Self.IssuedLocation		:= Suppress.dateCorrect.state(ssn_input, R.state);
    Self := [];
  END;
  ssn_patch := project (limit (ssn_map, 1, skip), FormatSSN (Left));

  iesp.share.t_Identity SetIdentityPatch () := transform
    Self.SSNInfo := ssn_patch[1];
    Self := [];
  end;
  aka_patch := dataset ([SetIdentityPatch ()]); 
  // patch is ready

  // fetch "best" AKA no matter whether it has enough data or not. Query will return "insufficient", if best AKA has invalid SSN
  p_akas := choosen (pers.Akas, 1);
  ssn_aka := p_akas[1].SSNInfo.SSN;
  boolean UseInputSSN := (ssn_input != '') and (ssn_input != ssn_aka);
  aka_slim := if (UseInputSSN, aka_patch, project (p_akas, transform (iesp.share.t_Identity, Self := Left))) : GLOBAL;


  // property
	fids := LN_PropertyV2_Services.Raw.get_fids_from_dids (dids);
  raw_property := LN_PropertyV2_Services.resultFmt.widest_view.get_by_fid(fids);

  // all property questions require some sort of address line-1
  // ... but it seems that we need "current" properties only, no matter address or no.
  //raw_deeds := raw_property.prop_deeds_all;// (PropertyAddress.StreetName != '' and PropertyAddress.StreetNumber !='');

  pr_deeds := raw_property (fid_type = 'D', exists (parties (party_type = 'O' or party_type = 'S')));
  pr_assess := raw_property (fid_type = 'A');

  eAuth.layouts.slim_party GetPartyInfo (LN_PropertyV2_Services.layouts.parties.entity L, string120 cname_adjusted) := transform
    Self.Full  := L.fname + ' ' + L.lname;
    Self.First := L.fname;
    Self.Middle := L.mname;
    Self.Last := L.lname;
    Self.Suffix := L.name_suffix;
    Self.Prefix := L.title;
    Self.CompanyName := cname_adjusted;
    Self.did := (unsigned6) L.did;
  end;

  eAuth.layouts.slim_deeds GetSlimDeeds (LN_PropertyV2_Services.layouts.combined.widest L) := transform
    Self.ln_fares_id := L.ln_fares_id; // for debug purposes
    deed := L.deeds[1];
    prop := L.parties (party_type = 'P')[1];
    seller :=  L.parties (party_type = 'S')[1];

    Self.SalePrice := iesp.ECL2ESP.FormatDollarAmount (deed.sales_price);
    Self.DocumentType := deed.document_type_desc;
    unsigned4 sale_date := (unsigned4) if (deed.contract_date != '', deed.contract_date, deed.recording_date);
    Self.SaleDate := iesp.ECL2ESP.toDate (sale_date);
    Self.PropertyAddress := iesp.ECL2ESP.SetAddress (prop.prim_name, prop.prim_range, prop.predir, prop.postdir, prop.suffix, 
                                  prop.unit_desig, prop.sec_range, prop.v_city_name, prop.st, 
                                  prop.zip, prop.zip4, prop.county_name);

//    seller :=  choosen (L.parties (party_type = 'S'), 1);
    // "cleaned" company name is not very reliable (see did=002023746772), going to use "original" instead
    // "normalize" probably would be more "correct", but considering structure of layouts.parties,
    // and assuming that company is always one, the following is much more simple:
    ent := seller.entity[1];
    nms := seller.orig_names[1];
    cname := if ((nms.id_code = 'CO') or (ent.lname = ''), nms.orig_name, '');
    Self.Sellers := choosen (project (seller.entity, GetPartyInfo (Left, cname)), iesp.Constants.PROP.MaxSellers);
    Self.srt_date := sale_date;
  end;
  // now, we will need only properties, which were bought by a subject (GRANT DEED sold are not counted)
  raw_deeds := sort (project (pr_deeds, GetSlimDeeds (Left)), -srt_date)
    (~exists (Sellers (did in input_dids_set)));

  eAuth.layouts.slim_assessments GetSlimAssessments (LN_PropertyV2_Services.layouts.combined.widest L) := transform
    Self.ln_fares_id := L.ln_fares_id; // for debug purposes
    assess := L.assessments[1];
    prop := L.parties (party_type = 'P')[1];
    buyer := L.parties (party_type = 'O')[1]; // "Assessee"

    Self.YearBuilt := (integer) assess.year_built;
    liv_sq_feet := (integer) assess.fares_living_square_feet;
    Self.LivingSize := if (liv_sq_feet > 0, iesp.ECL2ESP.InsertPlaceHolders (assess.fares_living_square_feet), '');
    Self.LandUsage := assess.standardized_land_use_desc;
    Self.TaxYear := (integer) assess.tax_year; //need for sorting
    Self.PropertyAddress := iesp.ECL2ESP.SetAddress (prop.prim_name, prop.prim_range, prop.predir, prop.postdir, prop.suffix, 
                                  prop.unit_desig, prop.sec_range, prop.v_city_name, prop.st, 
                                  prop.zip, prop.zip4, prop.county_name);
    boolean IsOwner := ((unsigned6) buyer.entity[1].did IN input_dids_set) or ((unsigned6) buyer.entity[2].did IN input_dids_set);
    Self.IsSubjectOwned := false; //IsOwner; //not used so far, left just for a case
    Self.srt_date := (unsigned4) if (assess.sale_date != '', assess.sale_date, assess.recording_date);
  end;
  raw_assess := sort (project (pr_assess, GetSlimAssessments (Left)), -IsSubjectOwned, -srt_date, -TaxYear);

  // Note: property must be sorted by some kind of date (most recent first)
  p_deeds  := choosen (raw_deeds,  iesp.Constants.BR.MaxDeeds) : GLOBAL;
  p_assess := choosen (raw_assess, iesp.Constants.BR.MaxAssessments) : GLOBAL;


  // vehicle
  report_mod := VehicleV2_Services.IParam.getReportModule();  
  p_vehicles := choosen(VehicleV2_Services.raw.get_vehicle_crs_report (report_mod, dids), iesp.Constants.BR.MaxVehicles)
  : GLOBAL;  
//TODO: check use current only HistoryFlag = 'CURRENT'


// --------------------------------------------------------------------------
// ---------------------------- Create response -----------------------------
// --------------------------------------------------------------------------
  res_blank := dataset ([], layouts.question_ext);

  iesp.eAuth.t_QuestionResp GetQuestions (layouts.question_matrix L) := function

    question := MAP (

        // address questions
        L.qid = Constants.QID.COUNTY1 => QuestionFactory_address.GetCounties         (L.prompt, L.answers_num, L.answers_valid, addr_slim),
        L.qid = Constants.QID.ZIP1    => QuestionFactory_address.GetZipsForAddress   (L.prompt, L.answers_num, L.answers_valid, addr_slim),
        L.qid = Constants.QID.CITY1   => QuestionFactory_address.GetCitiesForAddress (L.prompt, L.answers_num, L.answers_valid, addr_slim, Constants.TIMELINE.CURRENT),
        L.qid = Constants.QID.CITY2   => QuestionFactory_address.GetCitiesForCounty  (L.prompt, L.answers_num, L.answers_valid, addr_slim, Constants.TIMELINE.CURRENT),
        L.qid = Constants.QID.CITY3   => QuestionFactory_address.GetCitiesForAddress (L.prompt, L.answers_num, L.answers_valid, addr_slim, Constants.TIMELINE.PREVIOUS),
        L.qid = Constants.QID.CITY4   => QuestionFactory_address.GetCitiesForCounty  (L.prompt, L.answers_num, L.answers_valid, addr_slim, Constants.TIMELINE.PREVIOUS),
        L.qid = Constants.QID.CITY5   => QuestionFactory_address.GetCitiesForAddress (L.prompt, L.answers_num, L.answers_valid, addr_slim, Constants.TIMELINE.OLDEST),
        L.qid = Constants.QID.ADDRESS1=> QuestionFactory_address.GetAddresses        (L.prompt, L.answers_num, L.answers_valid, addr_slim),
        L.qid = Constants.QID.CITY6   => QuestionFactory_address.GetCity6Answers     (L.prompt, L.answers_num, L.answers_valid, addr_slim),

        // property questions
        L.qid = Constants.QID.PROPERTY1 => QuestionFactory_Address.GetAddressOccupation   (L.prompt, L.answers_num, L.answers_valid, addr_timeline),
        L.qid = Constants.QID.PROPERTY2 => QuestionFactory_Property.GetPropertyFootage    (L.prompt, L.answers_num, L.answers_valid, p_assess),
        L.qid = Constants.QID.PROPERTY3 => QuestionFactory_Property.GetPropertyPriceRange (L.prompt, L.answers_num, L.answers_valid, p_deeds),
        L.qid = Constants.QID.PROPERTY4 => QuestionFactory_Property.GetPropertySeller     (L.prompt, L.answers_num, L.answers_valid, p_deeds),

        L.qid = Constants.QID.PROPERTY5 => QuestionFactory_Property.GetPropertyPurchasedDates (L.prompt, L.answers_num, L.answers_valid, p_deeds),
        L.qid = Constants.QID.PROPERTY6 => QuestionFactory_Property.GetPropertyTypes      (L.prompt, L.answers_num, L.answers_valid, p_assess),
        L.qid = Constants.QID.PROPERTY7 => QuestionFactory_Property.GetPropertyBuiltDate  (L.prompt, L.answers_num, L.answers_valid, p_assess),

        // vehicle questions
        L.qid = Constants.QID.VEHICLE1 => QuestionFactory_Vehicle.GetVehicles     (L.prompt, L.answers_num, L.answers_valid, p_vehicles),
        L.qid = Constants.QID.VEHICLE2 => QuestionFactory_Vehicle.GetVehicleYear  (L.prompt, L.answers_num, L.answers_valid, p_vehicles),
        L.qid = Constants.QID.VEHICLE3 => QuestionFactory_Vehicle.GetVehicleColor (L.prompt, L.answers_num, L.answers_valid, p_vehicles),
        L.qid = Constants.QID.VEHICLE4 => QuestionFactory_Vehicle.GetVehicleLienHolders  (L.prompt, L.answers_num, L.answers_valid, p_vehicles),
        L.qid = Constants.QID.VEHICLE5 => QuestionFactory_Vehicle.GetVehiclePurchaseDate (L.prompt, L.answers_num, L.answers_valid, p_vehicles),

        // All others
        L.qid = Constants.QID.PEOPLE1 => QuestionFactory_Misc.GetPeople (L.prompt, L.answers_num, L.answers_valid, rel_slim),
        L.qid = Constants.QID.SSN1    => QuestionFactory_Misc.GetSSNStates (L.prompt, L.answers_num, L.answers_valid, aka_slim),
        res_blank);

    // here we can, for example, SKIP "blank questions" or put "insufficient data"...
    iesp.eAuth.t_QuestionResp m_transform  := transform
      mchoice := question [1]; // always return at most 1 row
      Self.Id :=   L.qname;
      self.MultipleCorrect :=param.GetMultipleCorrect and mchoice.MultipleCorrect;
      Self := mchoice;
    end;
    return m_transform;
  end;

  questions_ready := project (q_verified, GetQuestions (Left));
  // return questions_ready;

  // get it all together. Some SSN fields are taken from first AKAs of a person; DOD info -- from best file
  set of string ssn_valid_set := ['G', 'YES', 'Y'];
  set of string ssn_invalid_set := ['B', 'O', 'NO', 'N'];

  out_rec Format () := TRANSFORM
    L := ds_best[1];
    Self._Header := iesp.ECL2ESP.GetHeaderRow ();
    Self.DOB := iesp.ECL2ESP.toDate (IF (param.GetDOB, L.dob, 0)); // typecast from integer4 to unsigned4
    Self.DOD := iesp.ECL2ESP.toDatestring8 (IF (param.GetDOD, L.dod, ''));

    blank_date := ROW ({0,0,0}, iesp.share.t_Date);

    aka_ssn := aka_slim[1].SSNInfo;
    Self.SSNIssuedStartDate := if (param.VerifySSN, aka_ssn.IssuedStartDate, blank_date);
    Self.SSNIssuedEndDate   := if (param.VerifySSN, aka_ssn.IssuedEndDate, blank_date);
    Self.Deceased := param.IsDeceased and (L.dod != '');

    Self.SSNValid := if (param.VerifySSN, 
                         map (stringlib.StringToUpperCase(aka_ssn.Valid) IN  ssn_valid_set => 'yes', 
                              stringlib.StringToUpperCase(aka_ssn.Valid) IN  ssn_invalid_set => 'no', 
                              'maybe'), '');
    Self.Questions := choosen (questions_ready, iesp.Constants.EAUTHORIZE.MaxQuestions);
    
    // debug output
    // Self.ver := q_verified;
    // Self.addr := addr_slim;
//    Self.veh := p_vehicles;
    // Self.deeds := p_deeds;
    // Self.assess := p_assess;
  end;

  result := dataset ([Format ()]);
  return result;
END;
