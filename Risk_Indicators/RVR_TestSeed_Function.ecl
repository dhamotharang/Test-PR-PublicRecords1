import iesp, Seed_Files, Address;

// for now this only supports a single input record -- that's what the fcradataservice restricts too...

EXPORT RVR_TestSeed_Function(dataset (iesp.riskviewreport.t_RiskViewReportRequest) rvrin) := FUNCTION
		
		returnLayout := RECORD
			unsigned4 Seq;
			iesp.riskviewreport.t_RiskViewReport;
		END;

	
	lookupkey := RECORD
		string30 in_seq;
		string20 dataset_name;
		data16 hashkey;
	END;
	
	lookupkey getSearchKey(iesp.riskviewreport.t_RiskViewReportRequest le) := TRANSFORM
		self.in_seq := le.SearchBy.Seq;
		self.dataset_name := le.user.TestDataTableName;
		
		usecleaned := le.SearchBy.Name.Last='' and le.SearchBy.Name.Full<>'';
		cleaned := Address.CleanPerson73(le.SearchBy.Name.Full);
		string fname_val :=if(not usecleaned,le.SearchBy.Name.First, cleaned[6..25]);
		string lname_val :=if(not usecleaned,le.SearchBy.Name.Last,  cleaned[46..65]);

		self.hashkey := Seed_Files.Hash_InstantID(
															(string15)stringlib.stringtouppercase(fname_val),
															(string20)stringlib.stringtouppercase(lname_val),
															(string9)le.SearchBy.SSN,
															risk_indicators.nullstring,
															(string9)(le.SearchBy.Address.zip5+le.SearchBy.Address.zip4),
															(string10)le.SearchBy.HomePhone,
															risk_indicators.nullstring
															);
	END;
	
	inrecs := project(rvrin, getSearchKey(LEFT));

	rvrSummary := join(inrecs, Seed_Files.RiskViewReport_keys.Summary,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		LEFT OUTER, KEEP(1)
	);
	rvrAddrHist := join(inrecs, Seed_Files.RiskViewReport_keys.AddressHistory,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrRealProperty := join(inrecs, Seed_Files.RiskViewReport_keys.RealProperty,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrPersonalproperty := join(inrecs, Seed_Files.RiskViewReport_keys.PersonalProperty,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrFiling := join(inrecs, Seed_Files.RiskViewReport_keys.Filing,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrBankruptcy := join(inrecs, Seed_Files.RiskViewReport_keys.Bankruptcy,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrCriminal := join(inrecs, Seed_Files.RiskViewReport_keys.Criminal,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrEducation := join(inrecs, Seed_Files.RiskViewReport_keys.Education,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrLicense := join(inrecs, Seed_Files.RiskViewReport_keys.License,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrBusinessAssociation := join(inrecs, Seed_Files.RiskViewReport_keys.BusinessAssociation,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrLoanOffer := join(inrecs, Seed_Files.RiskViewReport_keys.LoanOffer,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);
	rvrCreditInquiry := join(inrecs, Seed_Files.RiskViewReport_keys.CreditInquiry,
		keyed(right.dataset_name=left.dataset_name) and keyed(right.hashvalue=left.hashkey),
		INNER, KEEP(25)
	);

	iesp.RiskViewReport.t_RvReportAddressHistoryRecord getHistories(rvrAddrHist le) := TRANSFORM
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
	END;

	iesp.RiskViewReport.t_RvReportRealPropertyRecord getRealProperty(rvrRealProperty le) := TRANSFORM
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
	END;
	iesp.RiskViewReport.t_RvReportPersonalPropertyRecord getPersonalProperty(rvrPersonalProperty le) := TRANSFORM
		self.RegistrationDate.year := (integer)le.reg_year;
		self.RegistrationDate.month := (integer)le.reg_month;
		self.RegistrationDate.day := (integer)le.reg_day;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportFilingRecord getFiling(rvrFiling le) := TRANSFORM
		self.FilingDate.year := (integer)le.filing_year;
		self.FilingDate.month := (integer)le.filing_month;
		self.FilingDate.day := (integer)le.filing_day;
		self.LastActionDate.year := (integer)le.lastaction_year;
		self.LastActionDate.month := (integer)le.lastaction_month;
		self.LastActionDate.day := (integer)le.lastaction_day;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportBankruptcyRecord getBankruptcy(rvrBankruptcy le) := TRANSFORM
		self.FilingDate.year := (integer)le.filing_year;
		self.FilingDate.month := (integer)le.filing_month;
		self.FilingDate.day := (integer)le.filing_day;
		self.LastActionDate.year := (integer)le.lastaction_year;
		self.LastActionDate.month := (integer)le.lastaction_month;
		self.LastActionDate.day := (integer)le.lastaction_day;
		self.name := le;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportCriminalRecord getCriminal(rvrCriminal le) := TRANSFORM
		self.dob.year := (integer)le.dob_year;
		self.dob.month := (integer)le.dob_month;
		self.dob.day := (integer)le.dob_day;
		self.OffenseDate.year := (integer)le.offense_year;
		self.OffenseDate.month := (integer)le.offense_month;
		self.OffenseDate.day := (integer)le.offense_day;
		self.state := le.crim_state;
		self.name := le;
		self.address := le;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportEducationRecord getEducation(rvrEducation le) := TRANSFORM
		self.name := le;
		self.address := le;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportLicenseRecord getLicense(rvrLicense le) := TRANSFORM
		self.lastreported.year := (integer)le.lastreported_year;
		self.lastreported.month := (integer)le.lastreported_month;
		self.lastreported.day := (integer)le.lastreported_day;
		self.name := le;
		self.address := le;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportBusinessAssociationRecord getBusinessAssociation(rvrBusinessAssociation le) := TRANSFORM
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
	END;
	iesp.RiskViewReport.t_RvReportLoanOfferRecord getLoanOffer(rvrLoanOffer le) := TRANSFORM
		self.date.year := (integer)le.year;
		self.date.month := (integer)le.month;
		self.date.day := (integer)le.day;
		self.name := le;
		self.address := le;
		self := le;
	END;
	iesp.RiskViewReport.t_RvReportCreditInquiryRecord getCreditInquiry(rvrCreditInquiry le) := TRANSFORM
		self.date.year := (integer)le.year;
		self.date.month := (integer)le.month;
		self.date.day := (integer)le.day;
		self := le;
	END;

	returnLayout finalSeed( rvrSummary le ) := TRANSFORM
		self.seq := (unsigned4)le.in_seq;
		self.estimatedIncome := le.estimatedIncome;
		self.ConsumerStatement := le.ConsumerStatement;
		self.Summary.name := le;
		self.Summary.address := le;
		self.Summary.dob.year := (integer)le.dob_year;
		self.Summary.dob.month := (integer)le.dob_month;
		self.Summary.dob.day := (integer)le.dob_day;
		self.Summary := le;
		
		self.AddressHistories := sort(project( rvrAddrHist(hashKey=le.hashkey), getHistories(LEFT)), seq);
		self.RealProperties := sort(project( rvrRealProperty(hashKey=le.hashkey), getRealProperty(LEFT)), seq);
		self.PersonalProperties := sort(project( rvrPersonalProperty(hashKey=le.hashkey), getPersonalProperty(LEFT)), seq);
		self.FilingRecords := sort(project( rvrFiling(hashKey=le.hashkey), getFiling(LEFT)), seq);
		self.Bankruptcies := sort(project( rvrBankruptcy(hashKey=le.hashkey), getBankruptcy(LEFT)), seq);
		self.CriminalRecords := sort(project( rvrCriminal(hashKey=le.hashkey), getCriminal(LEFT)), seq);
		self.EducationRecords := sort(project( rvrEducation(hashKey=le.hashkey), getEducation(LEFT)), seq);
		self.Licenses := sort(project( rvrLicense(hashKey=le.hashkey), getLicense(LEFT)), seq);
		self.BusinessAssociations := sort(project( rvrBusinessAssociation(hashKey=le.hashkey), getBusinessAssociation(LEFT)), seq);
		self.LoanOffers := sort(project( rvrLoanOffer(hashKey=le.hashkey), getLoanOffer(LEFT)), seq);
		self.CreditInquiries := sort(project( rvrCreditInquiry(hashKey=le.hashkey), getCreditInquiry(LEFT)), seq);
		self := [];
	END;
  // only one summary record per test seed...rest can have multiples...
	
	resu := project( rvrSummary, finalSeed(LEFT));
	return resu;
END;

