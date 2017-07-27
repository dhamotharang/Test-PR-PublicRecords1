IMPORT bankruptcyv3_services, iesp;

// Transform ECL bankruptcy V3 to an ESDL bankruptcy V3

// NB: ESDL V3 format has a lot of fields having names with suffix "_2", which are generally ignored here
// NB: A lot of transforms are the same as for V2 (SetStatusHistory, SetComments, etc.)

in_rec := bankruptcyv3_services.layouts.layout_rollup;

EXPORT iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord transform_bankruptcy_v3 (dataset(in_rec) bankruptcies) := FUNCTION

  iesp.bankruptcy.t_BankruptcyReport3Name SetNameV3 (BankruptcyV3_Services.layouts.layout_name L) := transform
    // string62 Full {xpath('Full')};
    Self.First := L.fname;
    Self.Middle := L.mname;
    Self.Last := L.lname;
    Self.Suffix := L.name_suffix;
    // string3 Prefix {xpath('Prefix')};
    Self.CompanyName := L.cname; // TODO: check
    Self._Type := L.debtor_type;
    Self.did := L.did;
    Self.UniqueId := L.did;
		// other data available:
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_name;
    Self := [];
  end;

  iesp.share.t_Address SetAddresses (BankruptcyV3_Services.layouts.layout_address L) := transform
    Self.StreetName := L.prim_name;
    Self.StreetNumber := L.prim_range;
    Self.StreetPreDirection := L.predir;
    Self.StreetPostDirection := L.postdir;
    Self.StreetSuffix := L.addr_suffix;
    Self.UnitDesignation := L.unit_desig;
    Self.UnitNumber := L.sec_range;
    Self.StreetAddress1 := '';
    Self.StreetAddress2 := '';
    Self.State := L.st;
    Self.City := L.p_city_name; // or v_city_name
    Self.Zip5 := L.zip;
    Self.Zip4 := L.zip4;
    Self.County := '';
    Self.PostalCode := '';
    Self.StateCityZip := '';
  end;

  iesp.share.t_PhoneTimeZone SetPhonesEx (BankruptcyV3_Services.layouts.layout_phone L) := transform
    Self.Phone10 := L.phone;
    Self.TimeZone := L.timezone;
  end;

  iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsDebtor SetDebtors3 (BankruptcyV3_Services.layouts.layout_party L) := transform
    Self.BusinessId := L.bdid;
    Self.UniqueId := L.did;
    Self.PersonFilterId := L.person_filter_id;
    Self.DebtorType := L.debtor_type_1; // OR debtor_type
    Self.FilingType := L.filing_type;
    Self.SSN := L.ssn;
    Self.AppendedSSN := L.app_ssn;
    Self.SSNMatch := L.ssnMatch;
    Self.SSNMSrc := L.ssnSrc;
    Self.TaxId := L.tax_id;
    Self.AppendedTaxId := L.app_tax_id;
    Self.DCodeDesc := L.dCodeDesc;
    Self.DispTypeDesc := L.dispTypeDesc;
    Self.Chapter := L.chapter;
    Self.CorpFlag := L.corp_flag;
    Self.Disposition := L.disposition;
    Self.SelfRepresented := L.pro_se_ind;
    Self.DischargeDate := iesp.ECL2ESP.toDatestring8 (L.discharged);
    Self.StatusDate := iesp.ECL2ESP.toDatestring8 (L.statusDate);
    Self.DateVacated := iesp.ECL2ESP.toDatestring8 (L.dateVacated);
    Self.DateTransferred := iesp.ECL2ESP.toDatestring8 (L.dateTransferred);
    Self.ConvertedDate := iesp.ECL2ESP.toDatestring8 (L.converted_date);
    Self.Names := choosen (project (L.names, SetNameV3 (Left)), iesp.Constants.BANKRPT.MaxPersonNames);
    Self.Addresses := choosen (project (L.addresses, SetAddresses (Left)), iesp.Constants.BANKRPT.MaxPersonAddresses);
    Self.Phones := choosen (project (L.phones, SetPhonesEx (Left)), iesp.Constants.BANKRPT.MaxPersonPhones);
		Self.Statementids := L.Statementids;
		Self.isDisputed := L.isDisputed; 
		Self.WithdrawnStatus.WithdrawnId := L.WithdrawnStatus.WithdrawnId; 
		Self.WithdrawnStatus.WithdrawnDate := iesp.ECL2ESP.toDatestring8(L.WithdrawnStatus.WithdrawnDate); 
		Self.WithdrawnStatus.WithdrawnDisposition := L.WithdrawnStatus.WithdrawnDisposition; 
		Self.WithdrawnStatus.WithdrawnDispositionDate := iesp.ECL2ESP.toDatestring8(L.WithdrawnStatus.WithdrawnDispositionDate); 
		// other data available:
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().caseID;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().defendantID;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().recID;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().business_flag;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().orig_county;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().srcDesc;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().srcMtchDesc;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().screen;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().screenDesc;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().dCode;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().dispType;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().dispReason;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().holdCase;
		// bankruptcyv3.key_bankruptcyv3_search_full_bip().activityReceipt;
  end;

  iesp.bankruptcy.t_BankruptcyReport3Attorney SetAttorneys3 (BankruptcyV3_Services.layouts.layout_party_slim L) := transform
    Self.UniqueId := L.did;
    Self.BusinessId := L.bdid;
    Self.SSN  := L.ssn;
    Self.AppendedSSN := L.app_ssn;
    Self.TaxId := L.tax_id;
    Self.AppendedTaxId := L.app_tax_id;

    Self.Names := project (choosen (L.names, iesp.Constants.BANKRPT.MaxPersonNames), SetNameV3 (Left));
    Self.Addresses  := project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddresses (Left));
    Self.Phones    := project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhonesEx (Left));
    Self := [];
  end;

  iesp.bankruptcy.t_Bankruptcy3Trustee SetTrusteeV3 (BankruptcyV3_Services.layouts.layout_trustee L) := transform
    Self.DID := L.did;
    Self.TrusteeId := L.trusteeID;
    Self.AppSSN := L.app_SSN;
		// TODO: only one "title" in the input
    Self.Title := '';
    //address.Layout_Clean_Name:
    Self.Name.Title := L.title;
    Self.Name.OrigName   := L.orig_name;
    Self.Name.FirstName  := L.fname;
    Self.Name.MiddleName := L.mname;
    Self.Name.LastName   := L.lname;
    Self.Name.Suffix     := L.name_suffix;
    Self.Name.NameScore  := L.name_score;

    Self.OrigAddress.OrigAddress := L.orig_address;
    Self.OrigAddress.OrigCity := L.orig_city;
    Self.OrigAddress.OrigState := L.orig_st;
    Self.OrigAddress.OrigZIP := L.orig_zip;
    Self.OrigAddress.OrigZIP4 := L.orig_zip4;

    //address.Layout_Clean182
    Self.Address.PrimRange  := L.prim_range;
    Self.Address.PreDir     := L.predir;
    Self.Address.PrimName   := L.prim_name;
    Self.Address.AddrSuffix := L.addr_suffix;
    Self.Address.PostDir    := L.postdir;
    Self.Address.UnitDesig  := L.unit_desig;
    Self.Address.SecRange   := L.sec_range;
    Self.Address.PCityName  := L.p_city_name;
    Self.Address.VCityName  := L.v_city_name;
    Self.Address.State      := L.st;
    Self.Address.Zip        := L.zip;
    Self.Address.Zip4       := L.zip4;
    Self.Address.County     := L.county; //NB: string 5, not county name
    Self.Cart       := L.cart;
    Self.CrSortSz   := L.cr_sort_sz;
    Self.Lot        := L.lot;
    Self.LotOrder   := L.lot_order;
    Self.DBPC       := L.dbpc;
    Self.ChkDigit   := L.chk_digit;
    Self.RecType    := L.rec_type;
		//TODO: what are phones -- there's only one in the source.
    Self.Phone := '';
    Self.TrusteePhone := L.phone;
  end;

  // Dockets; generally, not used for compound reports
  iesp.bankruptcy.t_BankruptcyReport3Dockets SetDockets (BankruptcyV3_Services.layouts.layout_docket L) := transform
    Self.PacerEnteredDate := iesp.ECL2ESP.toDatestring8 (L.Pacer_EnteredDate);
    //Self.DocketText := L.DocketText;
    Self.FiledDate := iesp.ECL2ESP.toDatestring8 (L.FiledDate);
    //Self.AttachmentURL := L.AttachmentURL;
    //Self.EntryNumber := L.EntryNumber;
    //Self.string DocketEntryId := L.DocketEntryID;
    //Self.string DRCategoryEventId := L.DRCategoryEventID;
    Self.EnteredDate := iesp.ECL2ESP.toDatestring8 (L.EnteredDate);
    Self.EventDescription := L.CatEvent_Description;
    Self.EventCategory  := L.CatEvent_Category;
    //Self.string PacerCaseId := L.PacerCaseID;
    Self := L;
  end;

  iesp.bankruptcy.t_BankruptcyStatus SetStatusHistory (BankruptcyV3_Services.layouts.layout_status L) := transform
		Self._Type := L.status_type;
    Self.Date := iesp.ECL2ESP.toDatestring8 (L.status_date);
  end;

  iesp.bankruptcy.t_BankruptcyComment SetComments (BankruptcyV3_Services.layouts.layout_comment L) := transform
		Self.Description := L.description;
    Self.FilingDate := iesp.ECL2ESP.toDatestring8 (L.filing_date);
  end;

  iesp.bankruptcy_fcra.t_FcraBankruptcy3BpsRecord toOutV3 (in_rec L) := transform
    Self.CaseNumber := L.case_number; //str7
    Self.CourtName := L.court_name;
    Self.CourtLocation  := L.court_location;
    Self.CaseType := L.CaseType;
    Self.FilingJurisdiction := L.filing_jurisdiction;
    Self.JudgeName := L.judge_name;
    Self.JudgeIdentification := L.judges_identification;
    Self.AssetsForUnsecured := L.assets_no_asset_indicator; //? values['U','Y','N','']
    Self.OriginalChapter := L.orig_chapter;
    Self.FilerType  := L.filer_type_ex; //translated L.filer_type
    Self.FilingStatus := L.filing_status;
    Self.FilingDate         := iesp.ECL2ESP.toDatestring8 (L.date_filed);
    Self.OriginalFilingDate := iesp.ECL2ESP.toDatestring8 (L.orig_filing_date);
    Self.ClosedDate         := iesp.ECL2ESP.toDatestring8 (L.case_closing_date);
    Self.ReopenDate         := iesp.ECL2ESP.toDatestring8 (L.reopen_date);
    Self.ClaimsDeadline    := iesp.ECL2ESP.toDatestring8 (L.claims_deadline);
    Self.ComplaintDeadline := iesp.ECL2ESP.toDatestring8 (L.complaint_deadline);
    Self.CourtCode := L.court_code;
    Self.Liabilities := L.liabilities;
    Self.Assets := L.assets;

    // meeting v3 is the same as v2
    mdate := iesp.ECL2ESP.toDatestring8 (L.meeting_date);
    Self.Meeting := ROW ({mdate, L.meeting_time, L.address_341}, iesp.bankruptcy.t_Bankruptcy2Meeting);

    Self.StatusHistory := project (choosen (L.status_history,  iesp.Constants.BANKRPT.MaxStatusHistory), SetStatusHistory (Left));
    Self.Comments      := project (choosen (L.comment_history, iesp.Constants.BANKRPT.MaxComments), SetComments (Left));
    Self.Debtors       := project (choosen (L.debtors,         iesp.Constants.BANKRPT.MaxDebtors),   SetDebtors3 (Left));
    Self.Attorneys     := project (choosen (L.attorneys,       iesp.Constants.BANKRPT.MaxAttorneys), SetAttorneys3 (Left));
    Self.Trustee      := row (SetTrusteeV3 (L.trustee));

    Self.CaseId := L.caseID;
    Self.BarDate := L.barDate;
    Self.SplitCase := L.SplitCase;
    Self.TMSId := L.tmsid;
    Self.FiledInError := L.FiledInError;
    Self.DateReclosed := L.dateReclosed;
    Self.TransferIn := L.transferIn;
		Self.isDisputed := L.isDisputed;
		Self.Statementids := L.Statementids;
    // blank duplicate fields for V3->V2 patch
    SELF := []; //Chapter, CorpFlag, Disposition, SelfRepresented, DischargeDate

  end;

  return project (bankruptcies, toOutV3 (Left));

END;