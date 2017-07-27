IMPORT doxie, bankrupt,iesp, codes, Address;

out_rec := iesp.bankruptcy.t_BankruptcyReportRecord;
export out_rec transform_bankruptcy(dataset(Doxie.Layout_BK_output_ext) bankruptcies) := FUNCTION

  iesp.share.t_NameAndCompany SetDebtorNames (bankrupt.layout_bk_search_name L) := transform
    Self.Full := '';
    Self.First := L.debtor_fname;
    Self.Middle := L.debtor_mname;
    Self.Last := L.debtor_lname;
    Self.Suffix := L.debtor_name_suffix;
    Self.Prefix := L.debtor_title;
    Self.CompanyName := L.debtor_company; //str150, btw
  end;

  //set debtors' address (child transform)
  iesp.share.t_Address SetDebtorAddresses (bankrupt.layout_bk_search_addr L) := transform
    Self.StreetName := L.prim_name;
    Self.StreetNumber := L.prim_range;
    Self.StreetPreDirection := L.predir;
    Self.StreetPostDirection := L.postdir;
    Self.StreetSuffix := L.suffix;
    Self.UnitDesignation := L.unit_desig;
    Self.UnitNumber := L.sec_range;
    Self.StreetAddress1 := '';
    Self.StreetAddress2 := '';
    Self.State := L.st;
    Self.City := L.v_city_name; //? p_city_name
    Self.Zip5 := L.z5;
    Self.Zip4 := L.zip4;
    Self.County := L.county_name; //or str5 county
    Self.PostalCode := '';
    Self.StateCityZip := '';
  end;

  // by some reason layouts for debtors and others are not the same
  // debtors: main transform
  iesp.bankruptcy.t_BankruptcyDebtor SetDebtors (Doxie.layout_bk_child L) := transform
    Self.SSN := L.debtor_ssn;
    Self.Names := choosen (project (L.names, SetDebtorNames (Left)), iesp.Constants.BANKRPT.MaxPersonNames);
    Self.Addresses := choosen (project (L.addresses, SetDebtorAddresses (Left)), iesp.Constants.BANKRPT.MaxPersonAddresses);
		Self := [];
	end;


  // attroneys and trustees
  // raw data is used: we don't want to parse or clean at a run-time
  iesp.bankruptcy.t_BankruptcyPerson SetPerson (Doxie.layout_bk_output_ext L, integer C) := transform
    Self.Name := CHOOSE (C, L.attorney_name, L.attorney2_name, L.trustee_name); //str150

    // CHOOSE doesn't work for rows, therefore the hard way:
    Self.Address.StreetAddress1 := CHOOSE (C, L.attorney_address1, L.attorney2_address1, L.trustee_address1, '');
    Self.Address.StreetAddress2 := CHOOSE (C, L.attorney_address2, L.attorney2_address2, L.trustee_address2, '');
    Self.Address.State := CHOOSE (C, L.attorney_st, L.attorney2_st, L.trustee_st, '');
    Self.Address.City := CHOOSE (C, L.attorney_city, L.attorney2_city, L.trustee_city, '');
    Self.Address.Zip5 := CHOOSE (C, L.attorney_zip, L.attorney2_zip, L.trustee_zip, '');
    Self.Address.Zip4 := CHOOSE (C, L.attorney_zip4, L.attorney2_zip4, L.trustee_zip4, '');
 
    Self.Address.StreetNumber := CHOOSE (C, L.attorney_prim_range, L.attorney2_prim_range, L.trustee_prim_range, '');
    Self.Address.StreetPreDirection := CHOOSE (C, L.attorney_predir, L.attorney2_predir, L.trustee_predir, '');
    Self.Address.StreetName := CHOOSE (C, L.attorney_prim_name, L.attorney2_prim_name, L.trustee_prim_name, '');
    Self.Address.StreetSuffix := CHOOSE (C, L.attorney_addr_suffix, L.attorney2_addr_suffix, L.trustee_addr_suffix, '');
    Self.Address.StreetPostDirection := CHOOSE (C, L.attorney_postdir, L.attorney2_postdir, L.trustee_postdir, '');
    Self.Address.UnitDesignation := CHOOSE (C, L.attorney_unit_desig, L.attorney2_unit_desig, L.trustee_unit_desig, '');
    Self.Address.UnitNumber := CHOOSE (C, L.attorney_sec_range, L.attorney2_sec_range, L.trustee_sec_range, '');

		Self.Address := [];

    Self.Phone10 := CHOOSE (C, L.attorney_phone, L.attorney2_phone, L.trustee_phone); //str10
    Self.Fax := '';
    Self.EMail := '';
		Self := [];
  end;


  // MAIN TRANSFORM. V1 ECL TO V1 ESP  generally, it is extended and modified bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing
  out_rec toOut (Doxie.layout_bk_output_ext L) := transform
    Self.CourtName := L.court_name; //str50;
    Self.CourtCode := L.court_code; //str5;
    Self.JudgeName := if(L.judge_name<>'',L.judge_name,L.judges_identification); //str35
    Self.CaseNumber := L.case_number; //str7
    Self.OriginalCaseNumber := L.orig_case_number;  // str25
    Self.Chapter := L.chapter; //str3
    Self.OriginalChapter := L.orig_chapter; //str3
    Self.FilingStatus := L.filing_status; //str12

    Self.FilingDate         := iesp.ECL2ESP.toDatestring8 (L.date_filed);
    Self.OriginalFilingDate := iesp.ECL2ESP.toDatestring8 (L.orig_filing_date);
    Self.DischargeDate      := iesp.ECL2ESP.toDatestring8 (L.disposed_date); //?

    Self.Disposition := L.disposition; //str35
    Self.FilingType := codes.BANKRUPTCIES.FILING_TYPE(L.orig_filing_type);
    Self.FilerType := codes.BANKRUPTCIES.FILER_TYPE(L.filer_type);

//    boolean SelfRepresented := L. {xpath('SelfRepresented')};
    Self.AssetsForUnsecured := L.assets_no_asset_indicator = 'Y'; //str5 ???
//    Self.Liabilities := L.liabilities; //str20
//    Self.Assets := L.assets; //str20
//    Self.Exempt := L. {xpath('Exempt')};

    // meeting
    Self.Meeting.Date := iesp.ECL2ESP.toDatestring8 (L.meeting_date);
    Self.Meeting.Time := L.meeting_time;
    Self.Meeting.Address := [];

    Self.ComplaintDeadline := iesp.ECL2ESP.toDatestring8 (L.complaint_deadline);
    Self.ClaimsDeadline    := iesp.ECL2ESP.toDatestring8 (L.claims_deadline);

    Self.Debtors   := choosen (project (L.debtor_records, SetDebtors (Left)), iesp.Constants.BANKRPT.MaxDebtors); //PARTIES_PER_ROLLUP
    // no need to 'choosen', upto 2 attorneys and 1 trustee maximum
    Self.Trustees  := project (L, SetPerson (Left, 3)); 
//    Self.Attorneys := normalize (L, 2, SetPerson (Left, Counter)); - doesn't compile
    _attorney_1 := project (L, SetPerson (Left, 1));
    _attorney_2 := project (L, SetPerson (Left, 2));
    Self.Attorneys := (_attorney_1 + _attorney_2) (Name != '');

    Self := []; //SelfRepresented, Liabilities, Assets, Exempt
  end;

  RETURN project (bankruptcies, toOut (Left));
END;