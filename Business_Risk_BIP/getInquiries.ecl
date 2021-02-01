IMPORT Business_Risk_BIP, Doxie, Inquiry_AccLogs, Risk_Indicators, UT, STD;

EXPORT getInquiries(DATASET(Business_Risk_BIP.Layouts.Shell) Shell_pre,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 SET OF STRING2 AllowedSourcesSet
                       ) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	InqBuildDate := Risk_Indicators.get_Build_date('inquiry_update_build_version');

	// Add fifteen minutes to the historydatetime to accommodate for delays in
	// the real time database information being available in production runs
	Shell :=
		PROJECT(
			Shell_pre,
			TRANSFORM( Business_Risk_BIP.Layouts.Shell,
				SELF.Clean_Input.HistoryDateTime := IF( ((STRING)LEFT.Clean_Input.HistoryDateTime)[1..6] = '999999', LEFT.Clean_Input.HistoryDateTime, Business_Risk_BIP.Common.getFutureTime(LEFT.Clean_Input.HistoryDateTime, 15) ),
				SELF := LEFT
			)
		);

	// ---------------- Business Inquiries - Only Allowed in Non-Marketing Mode ------------------
	InquiriesRaw := IF(Options.MarketingMode = 0, Inquiry_AccLogs.Key_Inquiry_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
                                              mod_access,
																						  Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Inquiries,
																							Options.KeepLargeBusinesses));
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(InquiriesRaw, Shell, InquiriesSeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodesInquiry := Business_Risk_BIP.Common.GrabFetchErrorCode(InquiriesSeq);

	// Filter out records after our history date
	Inquiries := Business_Risk_BIP.Common.FilterRecords2(InquiriesSeq, (TRIM(Search_Info.DateTime,ALL))[1..12], '', AllowedSourcesSet);

	InquiriesUpdateRaw := IF(Options.MarketingMode = 0, Inquiry_AccLogs.Key_Inquiry_LinkIds_Update.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
    mod_access,
    Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
    0, /*ScoreThreshold --> 0 = Give me everything*/
    Business_Risk_BIP.Constants.Limit_Inquiries,
    Options.KeepLargeBusinesses));

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(InquiriesUpdateRaw, Shell, InquiriesUpdateSeq);

	// Figure out if the kFetch was successful
	kFetchErrorCodesInquiryUpdate := Business_Risk_BIP.Common.GrabFetchErrorCode(InquiriesUpdateSeq);

	// Filter out records after our history date
	InquiriesUpdate := Business_Risk_BIP.Common.FilterRecords2(InquiriesUpdateSeq, (TRIM(Search_Info.DateTime,ALL))[1..12], '', AllowedSourcesSet);

	// Keep the unique inquiries between the historical and update keys
	InquiriesAllTemp := DEDUP(SORT((Inquiries + InquiriesUpdate), Seq, Search_Info.Transaction_ID, -Search_Info.DateTime[1..8], -Search_Info.DateTime[10..15]), Seq, Search_Info.Transaction_ID, Search_Info.DateTime[1..8], Search_Info.DateTime[10..15]);

	// Grab the authorized rep information from input
	InquiriesAll := JOIN(InquiriesAllTemp, Shell, LEFT.Seq = RIGHT.Seq, TRANSFORM({RECORDOF(LEFT), STRING20 Rep_FirstName, STRING20 Rep_LastName, STRING20 Rep2_FirstName, STRING20 Rep2_LastName, STRING20 Rep3_FirstName, STRING20 Rep3_LastName},
																					SELF.Rep_FirstName := RIGHT.Clean_Input.Rep_FirstName; SELF.Rep_LastName := RIGHT.Clean_Input.Rep_LastName;
																					SELF.Rep2_FirstName := RIGHT.Clean_Input.Rep2_FirstName; SELF.Rep2_LastName := RIGHT.Clean_Input.Rep2_LastName;
																					SELF.Rep3_FirstName := RIGHT.Clean_Input.Rep3_FirstName; SELF.Rep3_LastName := RIGHT.Clean_Input.Rep3_LastName;
																					SELF := LEFT), LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	inquiryIndustryDateRec := RECORD
		STRING8 InquiryDate;
		STRING40 Industry;
	END;
	tempBusinessInquiry := RECORD
		BOOLEAN ValidInquiry;
		UNSIGNED2 BusExecLinkInquiryOverlapCount;
		UNSIGNED2 BusExecLinkInquiryOverlapCount2;
		UNSIGNED2 BusExecLinkInquiryOverlapCount3;
		UNSIGNED2 InquiryCount;
		UNSIGNED2 Inquiry24Month;
		UNSIGNED2 Inquiry12Month;
		UNSIGNED2 Inquiry06Month;
		UNSIGNED2 Inquiry03Month;
		UNSIGNED2 InquiryHighRiskCount;
		UNSIGNED2 InquiryHighRisk24Month;
		UNSIGNED2 InquiryHighRisk12Month;
		UNSIGNED2 InquiryHighRisk06Month;
		UNSIGNED2 InquiryHighRisk03Month;
		UNSIGNED2 InquiryCreditCount;
		UNSIGNED2 InquiryCredit24Month;
		UNSIGNED2 InquiryCredit12Month;
		UNSIGNED2 InquiryCredit06Month;
		UNSIGNED2 InquiryCredit03Month;
		UNSIGNED2 InquiryOtherCount;
		UNSIGNED2 InquiryOther24Month;
		UNSIGNED2 InquiryOther12Month;
		UNSIGNED2 InquiryOther06Month;
		UNSIGNED2 InquiryOther03Month;
		DATASET(inquiryIndustryDateRec) InquiryIndustryDates;
		STRING40 Vertical;
		STRING40 SubMarket;
		STRING100 FunctionDescription;
		STRING2 ProductCode;
		RECORDOF(InquiriesAll);
	END;
	tempBusinessInquiry DetermineValidBusinessInquiry(InquiriesAll le) := TRANSFORM
		SELF.Seq := le.Seq;

		RawIndustry := STD.Str.ToUpperCase(TRIM(le.Bus_Intel.Industry, LEFT, RIGHT));
		Vertical := STD.Str.ToUpperCase(TRIM(le.Bus_Intel.Vertical, LEFT, RIGHT));
		SubMarket := STD.Str.ToUpperCase(TRIM(le.Bus_Intel.Sub_Market, LEFT, RIGHT));
		FunctionDescription := STD.Str.ToUpperCase(TRIM(le.Search_Info.Function_Description, LEFT, RIGHT));
		ProductCode := STD.Str.ToUpperCase(TRIM(le.Search_Info.Product_Code, LEFT, RIGHT));
		BusUse := STD.Str.ToUpperCase(TRIM(le.Bus_Intel.Use, LEFT, RIGHT));
		Method := STD.Str.ToUpperCase(TRIM(le.Search_Info.Method, LEFT, RIGHT));

		// Authorize Representative information is logged to the BusUser_Q section
		FirstName := STD.Str.ToUpperCase(TRIM(le.BusUser_Q.FName, LEFT, RIGHT));
		LastName := STD.Str.ToUpperCase(TRIM(le.BusUser_Q.LName, LEFT, RIGHT));
		// FirstName := STD.Str.ToUpperCase(TRIM(le.Person_Q.First_Name, LEFT, RIGHT));
		// LastName := STD.Str.ToUpperCase(TRIM(le.Person_Q.Last_Name, LEFT, RIGHT));

		FirstNameMatch := FirstName <> '' AND le.Rep_FirstName <> '' AND FirstName[1] = le.Rep_FirstName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(FirstName, le.Rep_FirstName));
		LastNameMatch := LastName <> '' AND le.Rep_LastName <> '' AND LastName[1] = le.Rep_LastName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(LastName, le.Rep_LastName));
		NameMatch := FirstNameMatch AND LastNameMatch;

		FirstNameMatch2 := FirstName <> '' AND le.Rep2_FirstName <> '' AND FirstName[1] = le.Rep2_FirstName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(FirstName, le.Rep2_FirstName));
		LastNameMatch2 := LastName <> '' AND le.Rep2_LastName <> '' AND LastName[1] = le.Rep2_LastName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(LastName, le.Rep2_LastName));
		NameMatch2 := FirstNameMatch2 AND LastNameMatch2;

		FirstNameMatch3 := FirstName <> '' AND le.Rep3_FirstName <> '' AND FirstName[1] = le.Rep3_FirstName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(FirstName, le.Rep3_FirstName));
		LastNameMatch3 := LastName <> '' AND le.Rep3_LastName <> '' AND LastName[1] = le.Rep3_LastName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(LastName, le.Rep3_LastName));
		NameMatch3 := FirstNameMatch3 AND LastNameMatch3;

		Date := Business_Risk_BIP.Common.checkInvalidDate(TRIM(STD.Str.Filter(le.search_info.datetime[1..8], '0123456789')), Business_Risk_BIP.Constants.MissingDate, le.HistoryDateTime);
		Time := TRIM(STD.Str.Filter(le.search_info.datetime[10..15], '0123456789'));
		LogDate := IF(LENGTH(Date) = 8, Date, ''); // Make sure we have a valid 8 byte date
		LogTime := IF(LENGTH(Time) = 6, Time, ''); // Make sure we have a valid 6 byte time (HHMMSS)

		DaysApart := ut.DaysApart(LogDate, Business_Risk_BIP.Common.todaysDate(InqBuildDate, le.HistoryDate));

		ValidInquiry := Inquiry_AccLogs.Shell_Constants.Valid_Business_Shell_Inquiry(FunctionDescription, BusUse, ProductCode);

		SELF.ValidInquiry := ValidInquiry;

		SELF.InquiryIndustryDates := IF(ValidInquiry = TRUE, DATASET([{LogDate, Business_Risk_BIP.Common.commonIndustry(RawIndustry)}], inquiryIndustryDateRec), DATASET([], inquiryIndustryDateRec));
		SELF.Vertical := IF(ValidInquiry = TRUE, Vertical, '');
		SELF.SubMarket := IF(ValidInquiry = TRUE, SubMarket, '');
		SELF.FunctionDescription := IF(ValidInquiry = TRUE, FunctionDescription, '');
		SELF.ProductCode := IF(ValidInquiry = TRUE, ProductCode, '');

		SELF.InquiryCount := IF(ValidInquiry = TRUE, 1, 0);
		SELF.Inquiry24Month := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0);
		SELF.Inquiry12Month := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneYear, 1, 0);
		SELF.Inquiry06Month := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.Inquiry03Month := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);

		HighRiskInquiry := RawIndustry IN (Inquiry_AccLogs.shell_constants.collection_industry + Inquiry_AccLogs.shell_constants.HighRiskCredit_industry5 + Inquiry_AccLogs.shell_constants.PrepaidCards_industry);
		CreditInquiry := RawIndustry IN (Inquiry_AccLogs.shell_constants.banking_industry5);
		SELF.InquiryHighRiskCount := IF(ValidInquiry = TRUE AND HighRiskInquiry = TRUE, 1, 0);
		SELF.InquiryHighRisk24Month := IF(ValidInquiry = TRUE AND HighRiskInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0);
		SELF.InquiryHighRisk12Month := IF(ValidInquiry = TRUE AND HighRiskInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneYear, 1, 0);
		SELF.InquiryHighRisk06Month := IF(ValidInquiry = TRUE AND HighRiskInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.InquiryHighRisk03Month := IF(ValidInquiry = TRUE AND HighRiskInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
		SELF.InquiryCreditCount := IF(ValidInquiry = TRUE AND CreditInquiry = TRUE, 1, 0);
		SELF.InquiryCredit24Month := IF(ValidInquiry = TRUE AND CreditInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0);
		SELF.InquiryCredit12Month := IF(ValidInquiry = TRUE AND CreditInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneYear, 1, 0);
		SELF.InquiryCredit06Month := IF(ValidInquiry = TRUE AND CreditInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.InquiryCredit03Month := IF(ValidInquiry = TRUE AND CreditInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
		SELF.InquiryOtherCount := IF(ValidInquiry = TRUE AND CreditInquiry = FALSE AND HighRiskInquiry = FALSE, 1, 0);
		SELF.InquiryOther24Month := IF(ValidInquiry = TRUE AND CreditInquiry = FALSE AND HighRiskInquiry = FALSE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0);
		SELF.InquiryOther12Month := IF(ValidInquiry = TRUE AND CreditInquiry = FALSE AND HighRiskInquiry = FALSE AND DaysApart <= Business_Risk_BIP.Constants.OneYear, 1, 0);
		SELF.InquiryOther06Month := IF(ValidInquiry = TRUE AND CreditInquiry = FALSE AND HighRiskInquiry = FALSE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
		SELF.InquiryOther03Month := IF(ValidInquiry = TRUE AND CreditInquiry = FALSE AND HighRiskInquiry = FALSE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);

		SELF.BusExecLinkInquiryOverlapCount := IF(ValidInquiry = TRUE AND NameMatch = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0); // Only count valid inquiries that have the authorized rep on file
		SELF.BusExecLinkInquiryOverlapCount2 := IF(ValidInquiry = TRUE AND NameMatch2 = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0); // Only count valid inquiries that have the authorized rep on file
		SELF.BusExecLinkInquiryOverlapCount3 := IF(ValidInquiry = TRUE AND NameMatch3 = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0); // Only count valid inquiries that have the authorized rep on file

		SELF := le;
	END;
	ValidInquiries := SORT(PROJECT(InquiriesAll, DetermineValidBusinessInquiry(LEFT)), Seq);

	tempBusinessInquiry countInquiries(tempBusinessInquiry le, tempBusinessInquiry ri) := TRANSFORM
		SELF.InquiryIndustryDates := le.InquiryIndustryDates + ri.InquiryIndustryDates;

		SELF.InquiryCount := le.InquiryCount + ri.InquiryCount;
		SELF.Inquiry24Month := le.Inquiry24Month + ri.Inquiry24Month;
		SELF.Inquiry12Month := le.Inquiry12Month + ri.Inquiry12Month;
		SELF.Inquiry06Month := le.Inquiry06Month + ri.Inquiry06Month;
		SELF.Inquiry03Month := le.Inquiry03Month + ri.Inquiry03Month;

		SELF.InquiryHighRiskCount := le.InquiryHighRiskCount + ri.InquiryHighRiskCount;
		SELF.InquiryHighRisk24Month := le.InquiryHighRisk24Month + ri.InquiryHighRisk24Month;
		SELF.InquiryHighRisk12Month := le.InquiryHighRisk12Month + ri.InquiryHighRisk12Month;
		SELF.InquiryHighRisk06Month := le.InquiryHighRisk06Month + ri.InquiryHighRisk06Month;
		SELF.InquiryHighRisk03Month := le.InquiryHighRisk03Month + ri.InquiryHighRisk03Month;
		SELF.InquiryCreditCount := le.InquiryCreditCount + ri.InquiryCreditCount;
		SELF.InquiryCredit24Month := le.InquiryCredit24Month + ri.InquiryCredit24Month;
		SELF.InquiryCredit12Month := le.InquiryCredit12Month + ri.InquiryCredit12Month;
		SELF.InquiryCredit06Month := le.InquiryCredit06Month + ri.InquiryCredit06Month;
		SELF.InquiryCredit03Month := le.InquiryCredit03Month + ri.InquiryCredit03Month;
		SELF.InquiryOtherCount := le.InquiryOtherCount + ri.InquiryOtherCount;
		SELF.InquiryOther24Month := le.InquiryOther24Month + ri.InquiryOther24Month;
		SELF.InquiryOther12Month := le.InquiryOther12Month + ri.InquiryOther12Month;
		SELF.InquiryOther06Month := le.InquiryOther06Month + ri.InquiryOther06Month;
		SELF.InquiryOther03Month := le.InquiryOther03Month + ri.InquiryOther03Month;

		SELF.BusExecLinkInquiryOverlapCount := le.BusExecLinkInquiryOverlapCount + ri.BusExecLinkInquiryOverlapCount;
		SELF.BusExecLinkInquiryOverlapCount2 := le.BusExecLinkInquiryOverlapCount2 + ri.BusExecLinkInquiryOverlapCount2;
		SELF.BusExecLinkInquiryOverlapCount3 := le.BusExecLinkInquiryOverlapCount3 + ri.BusExecLinkInquiryOverlapCount3;

		SELF := le;
	END;
	RolledInquiries := ROLLUP(ValidInquiries, LEFT.Seq = RIGHT.Seq, countInquiries(LEFT, RIGHT));

	withBusinessInquiries := JOIN(Shell, RolledInquiries, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SortedInquiries := SORT(RIGHT.InquiryIndustryDates, -InquiryDate, Industry);
																							SELF.Inquiry.InquiryIndustryDescriptionList := Business_Risk_BIP.Common.convertDelimited(SortedInquiries, Industry, Business_Risk_BIP.Constants.FieldDelimiter);
																							SELF.Inquiry.InquiryDateList := Business_Risk_BIP.Common.convertDelimited(SortedInquiries, InquiryDate, Business_Risk_BIP.Constants.FieldDelimiter);
																							oldestInquiryDate := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SortedInquiries, 1, InquiryDate)[1].InquiryDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDateTime);
																							newestInquiryDate := Business_Risk_BIP.Common.checkInvalidDate(TOPN(SortedInquiries, 1, -InquiryDate)[1].InquiryDate, Business_Risk_BIP.Constants.MissingDate, LEFT.Clean_Input.HistoryDateTime);
																							SELF.Inquiry.InquiryDateFirstSeen := oldestInquiryDate;
																							SELF.Inquiry.InquiryDateLastSeen := newestInquiryDate;
																							SELF.Inquiry.InquiryCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryCount, -1, 99999);
																							SELF.Inquiry.Inquiry24Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.Inquiry24Month, -1, 99999);
																							SELF.Inquiry.Inquiry12Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.Inquiry12Month, -1, 99999);
																							SELF.Inquiry.Inquiry06Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.Inquiry06Month, -1, 99999);
																							SELF.Inquiry.Inquiry03Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.Inquiry03Month, -1, 99999);
																							SELF.Inquiry.InquiryHighRiskCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryHighRiskCount, -1, 99999);
																							SELF.Inquiry.InquiryHighRisk24Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryHighRisk24Month, -1, 99999);
																							SELF.Inquiry.InquiryHighRisk12Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryHighRisk12Month, -1, 99999);
																							SELF.Inquiry.InquiryHighRisk06Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryHighRisk06Month, -1, 99999);
																							SELF.Inquiry.InquiryHighRisk03Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryHighRisk03Month, -1, 99999);
																							SELF.Inquiry.InquiryCreditCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryCreditCount, -1, 99999);
																							SELF.Inquiry.InquiryCredit24Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryCredit24Month, -1, 99999);
																							SELF.Inquiry.InquiryCredit12Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryCredit12Month, -1, 99999);
																							SELF.Inquiry.InquiryCredit06Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryCredit06Month, -1, 99999);
																							SELF.Inquiry.InquiryCredit03Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryCredit03Month, -1, 99999);
																							SELF.Inquiry.InquiryOtherCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryOtherCount, -1, 99999);
																							SELF.Inquiry.InquiryOther24Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryOther24Month, -1, 99999);
																							SELF.Inquiry.InquiryOther12Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryOther12Month, -1, 99999);
																							SELF.Inquiry.InquiryOther06Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryOther06Month, -1, 99999);
																							SELF.Inquiry.InquiryOther03Month := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.InquiryOther03Month, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BusExecLinkInquiryOverlapCount, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount2 := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BusExecLinkInquiryOverlapCount2, -1, 99999);
																							SELF.Business_To_Executive_Link.BusExecLinkInquiryOverlapCount3 := (STRING)Business_Risk_BIP.Common.capNum((INTEGER)RIGHT.BusExecLinkInquiryOverlapCount3, -1, 99999);
																							SELF.Data_Build_Dates.InquiriesBuildDate := InqBuildDate;
                                              SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	withErrorCodesInquiry := JOIN(withBusinessInquiries, kFetchErrorCodesInquiry, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeInquiries := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	withErrorCodesInquiryUpdate := JOIN(withErrorCodesInquiry, kFetchErrorCodesInquiryUpdate, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeInquiriesUpdate := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(Inquiries, 100), NAMED('Sample_Inquiries'));
	// OUTPUT(CHOOSEN(InquiriesUpdate, 100), NAMED('Sample_InquiriesUpdate'));
	// OUTPUT(CHOOSEN(InquiriesAll, 100), NAMED('Sample_InquiriesAll'));
	// OUTPUT(CHOOSEN(ValidInquiries, 100), NAMED('Sample_ValidInquiries'));
	// OUTPUT(CHOOSEN(RolledInquiries, 100), NAMED('Sample_RolledInquiries'));
	// OUTPUT(CHOOSEN(withBusinessInquiries, 100), NAMED('Sample_withBusinessInquiries'));

	RETURN withErrorCodesInquiryUpdate;
END;
