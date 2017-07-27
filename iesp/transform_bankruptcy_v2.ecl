IMPORT bankruptcyv2_services, iesp, TopBusiness_Services;

// Transform ECL bankruptcy V2 to an ESDL bankruptcy V2

in_rec 	:= bankruptcyv2_services.layouts.layout_rollup;
out_rec := iesp.bankruptcy.t_BankruptcyReport2Record;

EXPORT out_rec transform_bankruptcy_v2(dataset(in_rec) bankruptcies) := FUNCTION

	iesp.bankruptcy.t_BankruptcyStatus SetStatusHistory (BankruptcyV2_Services.layouts.layout_status L) := transform
		Self._Type := L.status_type;
    Self.Date := iesp.ECL2ESP.toDatestring8 (L.status_date);
  end;

  iesp.bankruptcy.t_BankruptcyComment SetComments (BankruptcyV2_Services.layouts.layout_comment L) := transform
		Self.Description := L.description;
    Self.FilingDate := iesp.ECL2ESP.toDatestring8 (L.filing_date);
  end;

  iesp.bankruptcy.t_BankruptcySearch2Name SetNames (BankruptcyV2_Services.layouts.layout_name L) := transform
    Self. Full := L.orig_name; //TODO: concatenate?   added in orig_name since it is now returning in BK layout bug 38116
    Self. First := L.fname;
    Self. Middle := L.mname;
    Self. Last := L.lname;
    Self. Suffix := L.name_suffix;
    Self. Prefix := ''; //absent
    Self. CompanyName := L.cname;
    Self._Type := L.debtor_type;
  end;

  iesp.share.t_Address SetAddresses (BankruptcyV2_Services.layouts.layout_address L) := transform
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
	
  iesp.share.t_AddressWithRawInfo SetAddressesEx (BankruptcyV2_Services.layouts.layout_address L) := transform
	  Self.OrigStreetAddress1 := L.orig_addr1;
	  Self.OrigStreetAddress2 := L.orig_addr2;
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
	
  iesp.share.t_StringArrayItem SetPhones (BankruptcyV2_Services.layouts.layout_phone L) := transform
    Self.value := L.phone;
  end;

  iesp.share.t_PhoneTimeZone SetPhonesEx (BankruptcyV2_Services.layouts.layout_phone L) := transform
    Self.Phone10 := L.phone;
    Self.TimeZone := L.timezone;
  end;
	
	iesp.share.t_StringArrayItem SetEmails (BankruptcyV2_Services.layouts.layout_email L) := transform
		self.value := L.orig_email;
	end;
	
	//sets debtors, attorneys, trustees
	iesp.bankruptcy.t_BankruptcyPerson2 SetParties (BankruptcyV2_Services.layouts.layout_party_slim L) := transform
    Self.UniqueId := L.did;
    Self.BusinessId := L.bdid;
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false);
    Self.SSN  := L.ssn;
    Self.AppendedSSN := L.app_SSN;
    Self.TaxId := L.tax_id;
    Self.AppendedTaxId := L.app_tax_id;

    Self.Names := project (choosen (L.names, iesp.Constants.BANKRPT.MaxPersonNames), SetNames (Left));
    Self.Addresses  := project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddresses (Left));
    Self.AddressesEx  := project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddressesEx (Left));
    Self.Phones    := project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhones (Left));
    Self.PhonesEx  := project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhonesEx (Left));
		Self.Emails		 := project (choosen (L.emails, iesp.Constants.BANKRPT.MaxPersonEmails), SetEmails(Left));
		self.HasCriminalConviction := L.HasCriminalConviction;
		self.IsSexualOffender	:= L.IsSexualOffender;
		Self := []; //idValue
	end;

	iesp.bankruptcy.t_BankruptcyReport2Debtor setDebtors (BankruptcyV2_Services.layouts.layout_party L) := transform
		Self.UniqueId := L.did;
    Self.BusinessId := L.bdid;
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false);
    Self.SSN  := L.ssn;
    Self.AppendedSSN := L.app_SSN;
    Self.TaxId := L.tax_id;
    Self.AppendedTaxId := L.app_tax_id;
		Self.CaseId				:= L.caseID;
		Self.DefendantID := L.DefendantId;
		Self.RecordID := L.recID;
		Self.DefendantType := L.business_flag;
		Self.OriginalCounty := L.orig_county;
		Self.SSNSource := L.ssnSrc;
		Self.SSNSourceDesc := L.srcDesc;
		Self.SSNMatch := L.ssnMatch;
		Self.SSNMatchDesc := L.srcMtchDesc;
		Self.SSNMatchSource := L.ssnMSrc;
		Self.Screen := L.screen;
		Self.ScreenDesc := L.screenDesc;
		Self.DispositionCode := L.dCode;
		Self.DispositionCodeDesc := L.dCodeDesc;
		Self.DispositionType := L.dispType;
		Self.DispositionTypeDesc := L.dispTypeDesc;
		Self.DispositionReason := L.dispReason;
		Self.StatusDate := iesp.ECL2ESP.toDatestring8(L.statusDate);
		Self.HoldCase := L.holdCase;
		Self.DateVacated:= iesp.ECL2ESP.toDatestring8(L.dateVacated);
		Self.DateTransferred := iesp.ECL2ESP.toDatestring8(L.dateTransferred);
		Self.ActivityReceipt := L.activityReceipt;

		Self.Names := project (choosen (L.names, iesp.Constants.BANKRPT.MaxPersonNames), SetNames (Left));
		Self.Addresses  := project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddresses (Left));
		Self.AddressesEx  := project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddressesEx (Left));
		Self.Phones    := project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhones (Left));
		Self.PhonesEx  := project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhonesEx (Left));		
		Self.Emails		 := project (choosen (L.emails, iesp.Constants.BANKRPT.MaxPersonEmails), SetEmails(Left)),
		self.HasCriminalConviction := L.HasCriminalConviction;
		self.IsSexualOffender	:= L.IsSexualOffender;
		self	:= []; //idValue
	end;
	
	out_rec toOutV2 (in_rec L) := transform
    Self.CorpFlag := L.corp_flag;
    Self.FilingType := L.orig_filing_type_ex; // translated L.orig_filing_type
    Self.FilerType  := L.filer_type_ex; //translated L.filer_type
    Self.FilingJurisdiction := L.filing_jurisdiction;
    Self.CaseType := L.CaseType;
    Self.CaseNumber := L.case_number; //str7
    Self.FilingDate         := iesp.ECL2ESP.toDatestring8 (L.date_filed);
    Self.OriginalFilingDate := iesp.ECL2ESP.toDatestring8 (L.orig_filing_date);
    Self.ClosedDate         := iesp.ECL2ESP.toDatestring8 (L.case_closing_date);
    Self.ReopenDate         := iesp.ECL2ESP.toDatestring8 (L.reopen_date);
    Self.ConvertedDate      := iesp.ECL2ESP.toDatestring8 (L.converted_date);
    Self.Chapter := L.chapter;
    Self.OriginalChapter := L.orig_chapter;
    Self.CourtName := L.court_name;
    Self.CourtLocation  := L.court_location;
    Self.JudgeName := L.judge_name;
    Self.JudgeIdentification := L.judges_identification;

    Self.ClaimsDeadline    := iesp.ECL2ESP.toDatestring8 (L.claims_deadline);
    Self.ComplaintDeadline := iesp.ECL2ESP.toDatestring8 (L.complaint_deadline);
    Self.FilingStatus := L.filing_status;
    Self.CourtCode := L.court_code;
    Self.DischargeDate := iesp.ECL2ESP.toDatestring8 (L.disposed_date); //? dateDischarged is not taken from main
    Self.Disposition := L.disposition;
    Self.Liabilities := L.liabilities;
    Self.Assets := L.assets;
    mdate := iesp.ECL2ESP.toDatestring8 (L.meeting_date);
    Self.Meeting := ROW ({{mdate.year, mdate.month, mdate.day}, L.meeting_time, L.address_341}, iesp.bankruptcy.t_Bankruptcy2Meeting);

    Self.SelfRepresented := L.pro_se_ind; //? values['U','Y','N','']
    Self.AssetsForUnsecured := L.assets_no_asset_indicator; //? values['U','Y','N','']
		
		//New fields
		Self.MethodDismiss := L.method_dismiss;
		Self.CaseStatus	:= L.case_status;
		Self.SplitCase := L.SplitCase;
		Self.FiledInError := L.FiledInError;
		Self.DateReclosed := iesp.ECL2ESP.toDatestring8(L.dateReclosed);
		Self.TrusteeID := L.TrusteeID;
		Self.CaseID := L.caseID;
		Self.BarDate := iesp.ECL2ESP.toDatestring8(L.barDate);
		Self.TransferIn := L.transferIn;
		Self.DeleteFlag := L.delete_flag = 'D';
				
    Self.StatusHistory := project (choosen (L.status_history,  iesp.Constants.BANKRPT.MaxStatusHistory), SetStatusHistory (Left));
    Self.Comments      := project (choosen (L.comment_history, iesp.Constants.BANKRPT.MaxComments), SetComments (Left));
    Self.Debtors       := project (choosen (L.debtors,         iesp.Constants.BANKRPT.MaxDebtors),   SetDebtors (Left));
    Self.Attorneys     := project (choosen (L.attorneys,       iesp.Constants.BANKRPT.MaxAttorneys), SetParties (Left));
    Self.Trustees      := project (choosen (L.trustees,        iesp.Constants.BANKRPT.MaxTrustees),  SetParties (Left));
		
		Self := []; //BIP ids, idValue
	end;
	RETURN project (bankruptcies, toOutV2 (Left));
END;