import iesp, Seed_Files, Address, risk_indicators, RiskWise;

// for now this only supports a single input record -- that's what the fcradataservice restricts too...

EXPORT Report_TestSeed_Function(DATASET(Risk_Indicators.Layout_Input) inData,
																STRING32 TestDataTableName_in) := FUNCTION
		
		returnLayout := RECORD
			unsigned4 Seq;
			iesp.riskview2.t_RiskView2Report;
		END;

	
	lookupkey := RECORD
		string30 in_seq;
		string20 dataset_name;
		data16 hashkey;
	END;
	
	lookupkey getSearchKey(Risk_Indicators.Layout_Input le) := TRANSFORM
		self.in_seq := (String)le.Seq;
		self.dataset_name := TestDataTableName_in;

		self.hashkey := Seed_Files.Hash_InstantID(
															trim((string15)stringlib.stringtouppercase(le.fname)),
															trim((string20)stringlib.stringtouppercase(le.lname)),
															trim((string9)le.SSN),
															risk_indicators.nullstring,
															trim((string9)(le.in_zipcode)),
															trim((string10)le.Phone10),
															risk_indicators.nullstring
															);
	END;
	
	inrecs := project(inData, getSearchKey(LEFT));

	RV2Summary := join(inrecs, Seed_Files.RiskView2_Report_keys.Summary,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		LEFT OUTER, KEEP(1), ATMOST(RiskWise.max_atmost)
	);
	RV2AddrHist := join(inrecs, Seed_Files.RiskView2_Report_keys.AddressHistory,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2RealProperty := join(inrecs, Seed_Files.RiskView2_Report_keys.RealProperty,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2Personalproperty := join(inrecs, Seed_Files.RiskView2_Report_keys.PersonalProperty,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2Filing := join(inrecs, Seed_Files.RiskView2_Report_keys.Filing,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2Bankruptcy := join(inrecs, Seed_Files.RiskView2_Report_keys.Bankruptcy,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2Criminal := join(inrecs, Seed_Files.RiskView2_Report_keys.Criminal,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2Education := join(inrecs, Seed_Files.RiskView2_Report_keys.Education,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2License := join(inrecs, Seed_Files.RiskView2_Report_keys.License,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2BusinessAssociation := join(inrecs, Seed_Files.RiskView2_Report_keys.BusinessAssociation,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2LoanOffer := join(inrecs, Seed_Files.RiskView2_Report_keys.LoanOffer,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2CreditInquiry := join(inrecs, Seed_Files.RiskView2_Report_keys.CreditInquiry,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);
	RV2PurchaseActivity := join(inrecs, Seed_Files.RiskView2_Report_keys.Purchase,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25), ATMOST(RiskWise.max_atmost)
	);

	iesp.RiskView2.t_Rv2ReportAddressHistoryRecord getHistories(RV2AddrHist le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.from.year := (integer)le.from_year;
		self.from.month := (integer)le.from_month;
		self.from.day := (integer)le.from_day;
		self.to.year := (integer)le.to_year;
		self.to.month := (integer)le.to_month;
		self.to.day := (integer)le.to_day;
		self.assesseddate.year := (integer)le.as_year;
		self.assesseddate.month := (integer)le.as_month;
		self.assesseddate.day := (integer)le.as_day;
		self.address := le;
		self := le;
		self := [];
	END;

	iesp.RiskView2.t_Rv2ReportRealPropertyRecord getRealProperty(RV2RealProperty le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.PurchaseDate.year := (integer)le.purch_year;
		self.PurchaseDate.month := (integer)le.purch_month;
		self.PurchaseDate.day := (integer)le.purch_day;
		self.SaleDate.year := (integer)le.sale_year;
		self.SaleDate.month := (integer)le.sale_month;
		self.SaleDate.day := (integer)le.sale_day;
		self.AssessedDate.year := (integer)le.as_year;
		self.AssessedDate.month := (integer)le.as_month;
		self.AssessedDate.day := (integer)le.as_day;
		self.Address := le;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportPersonalPropertyRecord getPersonalProperty(RV2PersonalProperty le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.RegistrationDate.year := (integer)le.reg_year;
		self.RegistrationDate.month := (integer)le.reg_month;
		self.RegistrationDate.day := (integer)le.reg_day;
		self.Name := le;
		self.Address := le;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportFilingRecord getFiling(RV2Filing le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.FilingDate.year := (integer)le.filing_year;
		self.FilingDate.month := (integer)le.filing_month;
		self.FilingDate.day := (integer)le.filing_day;
		self.LastActionDate.year := (integer)le.lastaction_year;
		self.LastActionDate.month := (integer)le.lastaction_month;
		self.LastActionDate.day := (integer)le.lastaction_day;
		self.DateLastSeen.year := (integer)le.lastseen_year;
		self.DateLastSeen.month := (integer)le.lastseen_month;
		self.DateLastSeen.day := (integer)le.lastseen_day;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportBankruptcyRecord getBankruptcy(RV2Bankruptcy le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.FilingDate.year := (integer)le.filing_year;
		self.FilingDate.month := (integer)le.filing_month;
		self.FilingDate.day := (integer)le.filing_day;
		self.LastActionDate.year := (integer)le.lastaction_year;
		self.LastActionDate.month := (integer)le.lastaction_month;
		self.LastActionDate.day := (integer)le.lastaction_day;
		self.name := le;
		self := le;
		self := [];
	END;
	
	iesp.riskview2.t_Rv2ReportCriminalRecord assignCriminal(RV2Criminal le) := TRANSFORM
		self.seq := (Integer)le.Crim_seq;
		self.Name := le.Crim_Name;
		self.Aliases := le.Crim_Aliases;
		self.Address := le.Crim_Address;
		self.dob.year := le.Crim_dob_year;
		self.dob.month := le.Crim_dob_month;
		self.dob.day := le.Crim_dob_day;
		self.SSN := le.Crim_SSN;
		self.State := le.Crim_State;
		self.CaseNumber := le.CaseNumber;
		self.OffenseDate.year := (Integer)le.offense_year;
		self.OffenseDate.month := (Integer)le.offense_month;
		self.OffenseDate.day := (Integer)le.offense_day;
		self.Charge := le.Charge;
		self._Type := le._Type;
		self := [];
	END;
	
	iesp.riskview2.t_Rv2ReportOffenderRegistryRecord assignOffender(RV2Criminal le) := TRANSFORM
		self.seq := (Integer)le.Off_seq;
		self.Name := le.Off_Name;
		self.Aliases := le.Off_Aliases;
		self.Address := le.Off_Address;
		self.dob.year := le.Off_dob_year;
		self.dob.month := le.Off_dob_month;
		self.dob.day := le.Off_dob_day;
		self.SSN := le.Off_SSN;
		self.RegistrationCounty := le.RegistrationCounty;
		self := [];
	END;
	
	iesp.RiskView2.t_Rv2ReportEducationRecord getEducation(RV2Education le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.name := le;
		self.address := le;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportLicenseRecord getLicense(RV2License le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.lastreported.year := (integer)le.lastreported_year;
		self.lastreported.month := (integer)le.lastreported_month;
		self.lastreported.day := (integer)le.lastreported_day;
		self.name := le;
		self.address := le;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportBusinessAssociationRecord getBusinessAssociation(RV2BusinessAssociation le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.CompanyAddress.StreetNumber := le.company_StreetNumber;
		self.CompanyAddress.StreetPreDirection := le.company_StreetPreDirection;
		self.CompanyAddress.StreetName := le.company_StreetName;
		self.CompanyAddress.StreetSuffix := le.company_StreetSuffix;
		self.CompanyAddress.StreetPostDirection := le.company_StreetPostDirection;
		self.CompanyAddress.UnitDesignation := le.company_UnitDesignation;
		self.CompanyAddress.UnitNumber := le.company_UnitNumber;
		self.CompanyAddress.StreetAddress1 := le.company_StreetAddress1;
		self.CompanyAddress.StreetAddress2 := le.company_StreetAddress2;
		self.CompanyAddress.City := le.company_City;
		self.CompanyAddress.State := le.company_State;
		self.CompanyAddress.Zip5 := le.company_Zip5;
		self.CompanyAddress.Zip4 := le.company_Zip4;
		self.CompanyAddress.County := le.company_County;
		self.CompanyAddress.PostalCode := le.company_PostalCode;
		self.CompanyAddress.StateCityZip := le.company_StateCityZip;
		self.firstreport.year := (integer)le.firstreport_year;
		self.firstreport.month := (integer)le.firstreport_month;
		self.firstreport.day := (integer)le.firstreport_day;
		self.lastreport.year := (integer)le.lastreport_year;
		self.lastreport.month := (integer)le.lastreport_month;
		self.lastreport.day := (integer)le.lastreport_day;
		self.name := le;
		self.address := le;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportLoanOfferRecord getLoanOffer(RV2LoanOffer le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.date.year := (integer)le.year;
		self.date.month := (integer)le.month;
		self.date.day := (integer)le.day;
		self.name := le;
		self.address := le;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportCreditInquiryRecord getCreditInquiry(RV2CreditInquiry le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.date.year := (integer)le.year;
		self.date.month := (integer)le.month;
		self.date.day := (integer)le.day;
		self := le;
		self := [];
	END;
	iesp.RiskView2.t_Rv2ReportPurchaseActivityRecord getPurchaseActivity(RV2PurchaseActivity le) := TRANSFORM
		self.seq := (integer)le.seq;
		self.From.year := (integer)le.purFrom_year;
		self.From.month := (integer)le.purFrom_month;
		self.From.day := (integer)le.purFrom_day;
		self.To.year := (integer)le.purTo_year;
		self.To.month := (integer)le.purTo_month;
		self.To.day := (integer)le.purTo_day;
		self.name := le;
		self.address := le;
		self := le;
		self := [];
	END;

	returnLayout finalSeed( RV2Summary le ) := TRANSFORM
		self.seq := (unsigned4)le.in_seq;
		self.Summary.name := le;
		self.Summary.address := le;
		self.Summary.dob.year := le.dob_year;
		self.Summary.dob.month := le.dob_month;
		self.Summary.dob.day := le.dob_day;
		self.Summary := le;
		
		self.AddressHistories := sort(project( RV2AddrHist(hashKey=le.hashkey), getHistories(LEFT)), seq);
		self.RealProperties := sort(project( RV2RealProperty(hashKey=le.hashkey), getRealProperty(LEFT)), seq);
		self.PersonalProperties := sort(project( RV2PersonalProperty(hashKey=le.hashkey), getPersonalProperty(LEFT)), seq);
		self.FilingRecords := sort(project( RV2Filing(hashKey=le.hashkey), getFiling(LEFT)), seq);
		self.Bankruptcies := sort(project( RV2Bankruptcy(hashKey=le.hashkey), getBankruptcy(LEFT)), seq);
		
		crim_key := sort(RV2Criminal(hashKey=le.hashkey),crim_seq);
		
		self.Criminal.criminalrecords := project(crim_key, assignCriminal(LEFT));
		self.Criminal.OffenderRegistryRecords := project(crim_key, assignOffender(LEFT));
		self.EducationRecords := sort(project( RV2Education(hashKey=le.hashkey), getEducation(LEFT)), seq);
		self.Licenses := sort(project( RV2License(hashKey=le.hashkey), getLicense(LEFT)), seq);
		self.BusinessAssociations := sort(project( RV2BusinessAssociation(hashKey=le.hashkey), getBusinessAssociation(LEFT)), seq);
		self.LoanOffers := sort(project( RV2LoanOffer(hashKey=le.hashkey), getLoanOffer(LEFT)), seq);
		self.CreditInquiries := sort(project( RV2CreditInquiry(hashKey=le.hashkey), getCreditInquiry(LEFT)), seq);
		self.PurchaseActivities := sort(project( RV2PurchaseActivity(hashKey=le.hashkey), getPurchaseActivity(LEFT)), seq);
		
		self := [];
	END;
  // only one summary record per test seed...rest can have multiples...
	
	result := project( RV2Summary, finalSeed(LEFT));
	
	// output(indata, named('indata'));
	// output(inrecs, named('inrecs'));
	
	return result;
END;

