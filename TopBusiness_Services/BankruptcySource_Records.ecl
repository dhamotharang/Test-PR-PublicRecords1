// ================================================================================
// = FOR BIP2, RETURNS BANKRUPTCY RECORDS FOR A GIVEN ENTITY IN ESP-COMPLIANT WAY =
// ================================================================================
// uses V1 layouts (both in ECL and ESP)

IMPORT iesp, doxie, Doxie_Raw, BankruptcyV2_Services, BankruptcyV3, BIPV2, ut, TopBusiness_Services;

EXPORT BankruptcySource_Records ( 
  dataset(TopBusiness_Services.Layouts.rec_input_ids_wSrc) in_docids,
	SourceService_Layouts.OptionsLayout inoptions,
  boolean IsFCRA = false
) := MODULE
	
	SHARED bank_layout_wLinkIds := RECORD
		Layouts.rec_input_ids_wSrc;
		bankruptcyv2_services.layouts.layout_rollup;
	END;
	
	// For in_docids records that don't have SourceDocIds (tmsid's) retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get all bankruptcy tmsids for the input linkids
  SHARED ds_bankkeys := PROJECT(BankruptcyV3.key_bankruptcyV3_linkids.kfetch(
	                                in_docs_linkonly,inoptions.fetch_level)
                                  // v--- For BIP2, we only want debtor recs, not recs where the 
																	// reported on company is an attorney (added for bug 139521).
																	(name_type[1] = 'D')
																,
																TRANSFORM(TopBusiness_Services.Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.tmsid,
																					SELF := LEFT,
																					SELF := []));

	bank_keys_comb := in_docids+ds_bankkeys;
	
	bank_keys := PROJECT(bank_keys_comb(IdValue != ''),TRANSFORM(bankruptcyv2_services.layout_tmsid_ext,SELF.tmsid := LEFT.IdValue,SELF.isdeepdive := FALSE));
	
	bank_keys_dedup := DEDUP(bank_keys,ALL);
	
  // fetch main records
  // NB: layout of bankruptcy_raw results is not published; generally, it all comes from extended and modified
  //     bankruptcyV2.Layout_bankruptcy_main.layout_bankruptcy_main_filing & layout_bankruptcy_search
  bank_sourceview := BankruptcyV2_Services.bankruptcy_raw(IsFCRA).source_view (in_tmsids := bank_keys_dedup, in_ssn_mask := inoptions.ssn_mask, skip_ids_search := true); 
	
	SHARED bank_sourceview_wLinkIds := JOIN(bank_sourceview,bank_keys_comb,
																		LEFT.tmsid = RIGHT.IdValue,
																		TRANSFORM(bank_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																		KEEP(1));   // For cases in which a idvalue has multiple linkids;
					
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
    Self.City := L.p_city_name;
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
			
	// sets attorneys, trustees
  iesp.bankruptcy.t_BankruptcyPerson2 SetParties (BankruptcyV2_Services.layouts.layout_party_slim L) := transform
    Self.UniqueId := L.did;
    Self.BusinessId := '';
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false);
    Self.SSN  := L.ssn;
    Self.AppendedSSN := L.app_SSN;
    Self.TaxId := L.tax_id;
    Self.AppendedTaxId := L.app_tax_id;

    Self.Names := dedup(project (choosen (L.names, iesp.Constants.BANKRPT.MaxPersonNames), SetNames (Left)), record, all);
    Self.Addresses  := dedup(project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddresses (Left)), record, all);
		Self.AddressesEx  := dedup(project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddressesEx (Left)), record, all);
    Self.Phones    := dedup(project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhones (Left)), record, all);
    Self.PhonesEx  := dedup(project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhonesEx (Left)), record, all);
		Self.Emails		 := project (choosen (L.emails, iesp.Constants.BANKRPT.MaxPersonEmails), SetEmails(Left));
		self.HasCriminalConviction := L.HasCriminalConviction;
		self.IsSexualOffender	:= L.IsSexualOffender;
		self := [];
	end;
	
  // sets debtors
	iesp.bankruptcy.t_BankruptcyReport2Debtor SetDebtors (BankruptcyV2_Services.layouts.layout_party L) := transform
    Self.UniqueId := L.did;
    Self.BusinessId := '';
		TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false);
    Self.SSN  := L.ssn;
    Self.AppendedSSN := L.app_SSN;
    Self.TaxId := L.tax_id;
    Self.AppendedTaxId := L.app_tax_id;
		
		//New fields
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
		
    Self.Names := dedup(project (choosen (L.names, iesp.Constants.BANKRPT.MaxPersonNames), SetNames (Left)), record, all);
    Self.Addresses  := dedup(project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddresses (Left)), record, all);
		Self.AddressesEx  := dedup(project (choosen (L.addresses, iesp.Constants.BANKRPT.MaxPersonAddresses), SetAddressesEx (Left)), record, all);
    Self.Phones    := dedup(project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhones (Left)), record, all);
    Self.PhonesEx  := dedup(project (choosen (L.phones, iesp.Constants.BANKRPT.MaxPersonPhones), SetPhonesEx (Left)), record, all);
		Self.Emails		 := project (choosen (L.emails, iesp.Constants.BANKRPT.MaxPersonEmails), SetEmails(Left));
		self.HasCriminalConviction := L.HasCriminalConviction;
		self.IsSexualOffender	:= L.IsSexualOffender;
		self := []; //IdValue
	end;
	
  SHARED iesp.bankruptcy.t_BankruptcyReport2Record toOut (bank_layout_wLinkIds L) := transform
		IDmacros.mac_IespTransferLinkids()
    Self.CorpFlag := L.corp_flag;
    Self.FilingType := L.orig_filing_type_ex; 
    Self.FilerType  := L.filer_type_ex; 
    Self.FilingJurisdiction := L.filing_jurisdiction;
    Self.CaseType := L.CaseType;
    Self.CaseNumber := L.case_number;
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
    Self.DischargeDate := iesp.ECL2ESP.toDatestring8 (L.disposed_date); 
    Self.Disposition := L.disposition;
    Self.Liabilities := L.liabilities;
    Self.Assets := L.assets;
    mdate := iesp.ECL2ESP.toDatestring8 (L.meeting_date);
    Self.Meeting := ROW ({{mdate.year, mdate.month, mdate.day}, L.meeting_time, L.address_341}, iesp.bankruptcy.t_Bankruptcy2Meeting);

    Self.SelfRepresented := L.pro_se_ind; 
    Self.AssetsForUnsecured := L.assets_no_asset_indicator; 
		
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
    Self.Debtors       := dedup(project (choosen (L.debtors,	 iesp.Constants.BANKRPT.MaxDebtors),   SetDebtors (Left)), record);
    Self.Attorneys     := project (choosen (L.attorneys,       iesp.Constants.BANKRPT.MaxAttorneys), SetParties (Left));
    Self.Trustees      := project (choosen (L.trustees,        iesp.Constants.BANKRPT.MaxTrustees),  SetParties (Left));
		self := [];
	end;

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(bank_layout_wLinkIds L) := TRANSFORM
			self.src			:= 'BK';
			self.src_desc := 'Bankruptcy Records';
			self.hasName 	:= exists(L.debtors(exists(names(lname <>'' or fname <>''))));
			self.hasSSN  	:= exists(L.debtors(exists(names(ssn <>''))));
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= exists(L.debtors(exists(addresses(st <>'' or zip <>''))));
		  self.hasPhone := exists(L.debtors(exists(phones(phone <>''))));
			self.dt_first_seen := ut.NormDate((unsigned)L.orig_filing_date);
			self.dt_last_seen := ut.max2(ut.NormDate((unsigned)L.disposed_date),ut.NormDate((unsigned)L.reopen_date));
			self := [];
	END;
		
	EXPORT SourceDetailInfo := project(bank_sourceview_wLinkIds,xform_Details(LEFT));
	EXPORT SourceView_Recs := project(bank_sourceview_wLinkIds, toOut(left));
  EXPORT SourceView_RecCount := COUNT(bank_sourceview_wLinkIds);
	
	
END;
