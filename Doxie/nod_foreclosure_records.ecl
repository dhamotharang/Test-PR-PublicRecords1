IMPORT doxie, doxie_crs, iesp, Foreclosure_Services;

// NOD and foreclosure are in the same format, and the code accessing these data is essentially the same;

EXPORT nod_foreclosure_records (dataset (doxie.layout_references) dids, string ssn_mask, string app_type,
																																string5 industry_class = ''):= MODULE

  
  shared nMod := module (Foreclosure_Services.Raw.params)
    export string6 ssnmask := ssn_mask;
    export string32 ApplicationType := app_type;
		  export string5 IndustryClass := industry_class;
  end;

  // NOD is in the ESDL layout, jsut need to project it from report to search
  nod_raw := Foreclosure_Services.Raw.REPORT_VIEW.by_did (dids, nMod, TRUE);
  nod_exp := project (nod_raw, transform (iesp.foreclosure.t_ForeclosureSearchRecord, 
                                          self._penalty := 0, self.alsofound := false, self := left));
  EXPORT nod := sort (nod_exp, -RecordingDate, record);


  // Foreclosures are in non-ESDL, so we need to disassemble ESDL to crs
  raw_recs := Foreclosure_Services.Raw.REPORT_VIEW.by_did (dids, nMod, FALSE);

  doxie_crs.layout_foreclosure_report FormatForeclosure (iesp.foreclosure.t_ForeclosureReportRecord L) := transform
    Self.foreclosure_id := L.ForeclosureId;
    Self.court_case_nbr := L.CaseNumber;
    Self.deed_desc := L.DeedType;
    Self.document_desc := L.DocumentType;
    Self.situs1_prim_range := L.SiteAddress.StreetNumber;
    Self.situs1_predir := L.SiteAddress.StreetPreDirection;
    Self.situs1_prim_name := L.SiteAddress.StreetName;
    Self.situs1_addr_suffix := L.SiteAddress.StreetSuffix;
    Self.situs1_postdir := L.SiteAddress.StreetPostDirection;
    Self.situs1_unit_desig := L.SiteAddress.UnitDesignation;
    Self.situs1_sec_range := L.SiteAddress.UnitNumber;
    Self.situs1_p_city_name := L.SiteAddress.City;
    Self.situs1_v_city_name := L.SiteAddress.City;
    Self.situs1_st := L.SiteAddress.State;
    Self.situs1_zip := L.SiteAddress.Zip5;
    Self.situs1_zip4 := L.SiteAddress.Zip4;
    Self.filing_date := iesp.ECL2ESP.t_DateToString8 (L.FilingDate);
    Self.recording_date := iesp.ECL2ESP.t_DateToString8 (L.RecordingDate);
    Self.document_year := (string)L.DocumentYear;  
    Self.document_nbr := L.DocumentNumber;
    Self.document_book := L.DocumentBook;
    Self.document_pages := L.DocumentPages;  
    Self.date_of_default := iesp.ECL2ESP.t_DateToString8 (L.DateOfLoanDefault);
    Self.amount_of_default := L.AmountOfLoanDefault;  
    Self.auction_date := iesp.ECL2ESP.t_DateToString8 (L.AuctionDate);
    Self.auction_time := L.AuctionTime;
    Self.auction_street := L.AuctionLocation.StreetAddress1;
    Self.auction_city := L.AuctionLocation.City;
    Self.auction_state := L.AuctionLocation.State;
    Self.opening_bid := L.OpeningBid;
    Self.final_judgment_amount := L.FinalJudgmentAmount;  
    Self.lender_beneficiary_fname := L.Lender.Name.First;   
    Self.lender_beneficiary_lname := L.Lender.Name.Last;
    Self.lender_beneficiary_company_name := L.Lender.CompanyName;
    Self.trustee_name := L.Trustee;
    Self.title_company_name := L.TitleCompany;
    Self.attorney_name := L.Attorney;
    Self.attorney_phone_nbr := L.AttorneyPhoneNumber;
    Self.timezone := L.AttorneyTimeZone;
    Self.tract_subdivision_name := L.SubdivisionName;
    Self.property_desc := L.LandUsage;
    Self.parcel_number_parcel_id := L.ParcelNumber;
    Self.year_built := if (L.YearBuilt = 0, '', (string)L.YearBuilt);
    Self.current_land_value := L.CurrentLandValue;
    Self.current_improvement_value := L.CurrentImprovementValue;
    Self.lot_size := L.LandSize;
    Self.living_area_square_feet := L.LivingSize;
    Self.expanded_legal := L.LegalDescription;
//TODO: those 3:
    Self.legal_2 := '';
    Self.legal_3 := '';
    Self.legal_4 := '';
    ds_plaintiffs := project (L.Plaintiffs, transform (doxie_crs.layout_foreclosure_plaintiff,
                                                       Self.plaintiff := Left.value));
    Self.plaintiffs := sort (ds_plaintiffs, plaintiff); // make records' order deterministic
    ds_defendants := project (L.Defendants, transform (doxie_crs.layout_foreclosure_name,  
                                                       Self.title := Left.Name.Prefix,
                                                       Self.fname := Left.Name.First,
                                                       Self.mname := Left.Name.Middle,
                                                       Self.lname := Left.Name.Last,
                                                       Self.suffix := Left.Name.Suffix,
                                                       Self.company_name := Left.CompanyName,
                                                       Self.ssn := Left.SSN,
                                                       Self.did := Left.UniqueId));
    // keep the sorting order specific for comp report
    Self.defendants := sort (ds_defendants, company_name, fname, lname);
    // not used: L.Site2Address
  end;

  EXPORT foreclosure := sort (project (raw_recs, FormatForeclosure  (Left)), -recording_date, record);
END;
