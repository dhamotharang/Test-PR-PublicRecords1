IMPORT BIPV2, Business_Risk_BIP, DID_Add, Inquiry_AccLogs, Risk_Indicators, RiskWise, UT, Doxie, Suppress, STD;

EXPORT getInquiriesByInputs(DATASET(Business_Risk_BIP.Layouts.Shell) Shell_pre,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	shell_version := Options.BusShellVersion;
	is_marketing := Options.MarketingMode != 0;

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
	// ---------------- Consumer Inquiries Address - Only Allowed in Non-Marketing Mode ------------------
	tempConsumerInquiry := RECORD
		UNSIGNED4 Seq;
		STRING40 Transaction_ID;
		STRING40 Sequence_Number;
		UNSIGNED2 InquiryCount;
		UNSIGNED2 InquiryCount12;
		UNSIGNED2 InquiryCount06;
		UNSIGNED2 InquiryCount03;
		UNSIGNED2 InquiryCount01;
		UNSIGNED2 InquirySSNCount;
		UNSIGNED2 InquirySSNCount12;
		UNSIGNED2 InquirySSNCount06;
		UNSIGNED2 InquirySSNCount03;
		UNSIGNED2 InquirySSNCount01;

		UNSIGNED2 BusInquiryCount;
		UNSIGNED2 BusInquiryCount24;
		UNSIGNED2 BusInquiryCount12;
		UNSIGNED2 BusInquiryCount06;
		UNSIGNED2 BusInquiryCount03;
		UNSIGNED2 BusInquiryCount01;
	END;
	// This MACRO creates a common transform for counting up valid inquiries
	inquiryTransformMac (TransformName, KeyName) := MACRO
		{tempConsumerInquiry, unsigned4 global_sid, unsigned6 did} TransformName(Business_Risk_BIP.Layouts.Shell le, KeyName ri) := TRANSFORM
			SELF.global_sid := ri.ccpa.global_sid;
			SELF.did := le.ContactDIDs[1].did;
			SELF.Seq := le.Seq;
			SELF.Transaction_ID := (STRING)ri.Search_Info.Transaction_ID;
			SELF.Sequence_Number := (STRING)ri.Search_Info.Sequence_Number;

			RawIndustry := STD.Str.ToUpperCase(TRIM(ri.Bus_Intel.Industry, LEFT, RIGHT));
			Vertical := STD.Str.ToUpperCase(TRIM(ri.Bus_Intel.Vertical, LEFT, RIGHT));
			SubMarket := STD.Str.ToUpperCase(TRIM(ri.Bus_Intel.Sub_Market, LEFT, RIGHT));
			FunctionDescription := STD.Str.ToUpperCase(TRIM(ri.Search_Info.Function_Description, LEFT, RIGHT));
			ProductCode := STD.Str.ToUpperCase(TRIM(ri.Search_Info.Product_Code, LEFT, RIGHT));
			BusUse := STD.Str.ToUpperCase(TRIM(ri.Bus_Intel.Use, LEFT, RIGHT));

			Date := Business_Risk_BIP.Common.checkInvalidDate(TRIM(STD.Str.Filter(ri.search_info.datetime[1..8], '0123456789')), Business_Risk_BIP.Constants.MissingDate, (INTEGER)Business_Risk_BIP.Constants.NinesDate);
			Time := TRIM(STD.Str.Filter(ri.search_info.datetime[10..15], '0123456789'));
			LogDate := IF(LENGTH(Date) = 8, Date, ''); // Make sure we have a valid 8 byte date
			LogTime := IF(LENGTH(Time) = 6, Time, ''); // Make sure we have a valid 6 byte time (HHMMSS)

			DaysApart := ut.DaysApart(LogDate, Business_Risk_BIP.Common.todaysDate(InqBuildDate, le.Clean_Input.HistoryDate));

			// Adopted from Risk_Indicators.Boca_Shell_Inquiries
			ValidInquiry := Inquiry_AccLogs.Shell_Constants.Valid_Velocity_Inquiry(Vertical, RawIndustry, FunctionDescription,
															LogDate, le.Clean_Input.HistoryDate, SubMarket, BusUse, ProductCode,
															ri.Permissions.FCRA_Purpose, FALSE /*isFCRA*/, 50  /*bsversion*/, ri.search_info.method );

			ValidBusinessInquiry := Inquiry_AccLogs.Shell_Constants.Valid_Business_Shell_Inquiry(FunctionDescription, BusUse, ProductCode);

			SELF.InquiryCount := IF(ValidInquiry = TRUE, 1, 0);
			SELF.InquiryCount12 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneYear, 1, 0);
			SELF.InquiryCount06 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
			SELF.InquiryCount03 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
			SELF.InquiryCount01 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneMonth, 1, 0);

			SELF.BusInquiryCount := IF(ValidBusinessInquiry = TRUE, 1, 0);
			SELF.BusInquiryCount24 := IF(ValidBusinessInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.TwoYear, 1, 0);
			SELF.BusInquiryCount12 := IF(ValidBusinessInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneYear, 1, 0);
			SELF.BusInquiryCount06 := IF(ValidBusinessInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths, 1, 0);
			SELF.BusInquiryCount03 := IF(ValidBusinessInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths, 1, 0);
			SELF.BusInquiryCount01 := IF(ValidBusinessInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneMonth, 1, 0);

			SSNMatches := Risk_Indicators.iid_constants.gn(DID_Add.SSN_Match_Score(le.Clean_Input.FEIN, ri.Person_Q.Appended_SSN, LENGTH(TRIM(le.Clean_Input.FEIN)) = 4));
			// This will only be used in the InquiryConsumerAddressSSN* calculations
			SELF.InquirySSNCount := IF(ValidInquiry = TRUE AND SSNMatches = TRUE, 1, 0);
			SELF.InquirySSNCount12 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneYear AND SSNMatches = TRUE, 1, 0);
			SELF.InquirySSNCount06 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.SixMonths AND SSNMatches = TRUE, 1, 0);
			SELF.InquirySSNCount03 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.ThreeMonths AND SSNMatches = TRUE, 1, 0);
			SELF.InquirySSNCount01 := IF(ValidInquiry = TRUE AND DaysApart <= Business_Risk_BIP.Constants.OneMonth AND SSNMatches = TRUE, 1, 0);

		END;
	ENDMACRO;

	inquiryTransformMac(grabAddress, Inquiry_AccLogs.Key_Inquiry_Address);
	inquiryTransformMac(grabAddressUpdate, Inquiry_AccLogs.Key_Inquiry_Address_Update);
	consumerAddressBase_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_Address,
																TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip AND LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND
																			LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range) AND
																LEFT.Clean_Input.PreDir = RIGHT.Person_Q.PreDir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Person_Q.Addr_Suffix AND
																// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
																((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
															grabAddress(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
													DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	consumerAddressBase := Suppress.Suppress_ReturnOldLayout(consumerAddressBase_unsuppressed, mod_access, tempConsumerInquiry);

	consumerAddressUpdate_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_Address_Update,
																TRIM(LEFT.Clean_Input.Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Zip5) <> '' AND
																KEYED(LEFT.Clean_Input.Zip5 = RIGHT.Zip AND LEFT.Clean_Input.Prim_Name = RIGHT.Prim_Name AND
																			LEFT.Clean_Input.Prim_Range = RIGHT.Prim_Range AND LEFT.Clean_Input.Sec_Range = RIGHT.Sec_Range) AND
																LEFT.Clean_Input.PreDir = RIGHT.Person_Q.PreDir AND LEFT.Clean_Input.Addr_Suffix = RIGHT.Person_Q.Addr_Suffix AND
																// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
																((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
															grabAddressUpdate(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
													DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	consumerAddressUpdate := Suppress.Suppress_ReturnOldLayout(consumerAddressUpdate_unsuppressed, mod_access, tempConsumerInquiry);

	consumerAddress := DEDUP(SORT(UNGROUP(consumerAddressBase + consumerAddressUpdate), Seq, Transaction_ID, Sequence_Number), Seq, Transaction_ID, Sequence_Number);

	consumerAddressRolled := ROLLUP(consumerAddress, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempConsumerInquiry,
																	SELF.InquiryCount := LEFT.InquiryCount + RIGHT.InquiryCount;
																	SELF.InquiryCount12 := LEFT.InquiryCount12 + RIGHT.InquiryCount12,
																	SELF.InquiryCount06 := LEFT.InquiryCount06 + RIGHT.InquiryCount06,
																	SELF.InquiryCount03 := LEFT.InquiryCount03 + RIGHT.InquiryCount03,
																	SELF.InquiryCount01 := LEFT.InquiryCount01 + RIGHT.InquiryCount01,
																	SELF.InquirySSNCount12 := LEFT.InquirySSNCount12 + RIGHT.InquirySSNCount12,
																	SELF.InquirySSNCount06 := LEFT.InquirySSNCount06 + RIGHT.InquirySSNCount06,
																	SELF.InquirySSNCount03 := LEFT.InquirySSNCount03 + RIGHT.InquirySSNCount03,
																	SELF.InquirySSNCount01 := LEFT.InquirySSNCount01 + RIGHT.InquirySSNCount01,

																	SELF.BusInquiryCount := LEFT.BusInquiryCount + RIGHT.BusInquiryCount;
																	SELF.BusInquiryCount24 := LEFT.BusInquiryCount24 + RIGHT.BusInquiryCount24,
																	SELF.BusInquiryCount12 := LEFT.BusInquiryCount12 + RIGHT.BusInquiryCount12,
																	SELF.BusInquiryCount06 := LEFT.BusInquiryCount06 + RIGHT.BusInquiryCount06,
																	SELF.BusInquiryCount03 := LEFT.BusInquiryCount03 + RIGHT.BusInquiryCount03,
																	SELF.BusInquiryCount01 := LEFT.BusInquiryCount01 + RIGHT.BusInquiryCount01,
																	SELF := LEFT));

	withConsumerAddressRolled := JOIN(Shell, consumerAddressRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              AddrNotInput := TRIM(LEFT.Clean_Input.Prim_Name) = '' AND TRIM(LEFT.Clean_Input.Zip5) = '';
                                              FEINNotInput := TRIM(LEFT.Clean_Input.FEIN) = '';
																							SELF.Inquiry.InquiryConsumerAddress := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddress12Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount12, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddress06Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount06, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddress03Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount03, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddress01Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount01, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddressSSN := IF((AddrNotInput OR FEINNotInput) AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquirySSNCount, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddressSSN12Mos := IF((AddrNotInput OR FEINNotInput) AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquirySSNCount12, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddressSSN06Mos := IF((AddrNotInput OR FEINNotInput) AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquirySSNCount06, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddressSSN03Mos := IF((AddrNotInput OR FEINNotInput) AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquirySSNCount03, -1, 99999));
																							SELF.Inquiry.InquiryConsumerAddressSSN01Mos := IF((AddrNotInput OR FEINNotInput) AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquirySSNCount01, -1, 99999));

																							SELF.Inquiry.InquiryBusAddress := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount, -1, 99999));
																							SELF.Inquiry.InquiryBusAddress24Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount24, -1, 99999));
																							SELF.Inquiry.InquiryBusAddress12Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount12, -1, 99999));
																							SELF.Inquiry.InquiryBusAddress06Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount06, -1, 99999));
																							SELF.Inquiry.InquiryBusAddress03Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount03, -1, 99999));
																							SELF.Inquiry.InquiryBusAddress01Mos := IF(AddrNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount01, -1, 99999));

																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// ---------------- Consumer Inquiries Phone - Only Allowed in Non-Marketing Mode ------------------
	inquiryTransformMac(grabPhone, Inquiry_AccLogs.Key_Inquiry_Phone);
	inquiryTransformMac(grabPhoneUpdate, Inquiry_AccLogs.Key_Inquiry_Phone_Update);
	consumerPhoneBase_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_Phone,
										LEFT.Clean_Input.Phone10 <> '' AND KEYED(LEFT.Clean_Input.Phone10 = RIGHT.Phone10) AND
										// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
										((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
								grabPhone(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
								DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	consumerPhoneBase := Suppress.Suppress_ReturnOldLayout(consumerPhoneBase_unsuppressed, mod_access, tempConsumerInquiry);
	consumerPhoneUpdate_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_Phone_Update,
										LEFT.Clean_Input.Phone10 <> '' AND KEYED(LEFT.Clean_Input.Phone10 = RIGHT.Phone10) AND
										// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
										((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
								grabPhoneUpdate(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
								DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	consumerPhoneUpdate := Suppress.Suppress_ReturnOldLayout(consumerPhoneUpdate_unsuppressed, mod_access, tempConsumerInquiry);
	consumerPhone := DEDUP(SORT(UNGROUP(consumerPhoneBase + consumerPhoneUpdate), Seq, Transaction_ID, Sequence_Number), Seq, Transaction_ID, Sequence_Number);

	consumerPhoneRolled := ROLLUP(consumerPhone, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempConsumerInquiry,
																	SELF.InquiryCount := LEFT.InquiryCount + RIGHT.InquiryCount,
																	SELF.InquiryCount12 := LEFT.InquiryCount12 + RIGHT.InquiryCount12,
																	SELF.InquiryCount06 := LEFT.InquiryCount06 + RIGHT.InquiryCount06,
																	SELF.InquiryCount03 := LEFT.InquiryCount03 + RIGHT.InquiryCount03,
																	SELF.InquiryCount01 := LEFT.InquiryCount01 + RIGHT.InquiryCount01,

																	SELF.BusInquiryCount := LEFT.BusInquiryCount + RIGHT.BusInquiryCount;
																	SELF.BusInquiryCount24 := LEFT.BusInquiryCount24 + RIGHT.BusInquiryCount24,
																	SELF.BusInquiryCount12 := LEFT.BusInquiryCount12 + RIGHT.BusInquiryCount12,
																	SELF.BusInquiryCount06 := LEFT.BusInquiryCount06 + RIGHT.BusInquiryCount06,
																	SELF.BusInquiryCount03 := LEFT.BusInquiryCount03 + RIGHT.BusInquiryCount03,
																	SELF.BusInquiryCount01 := LEFT.BusInquiryCount01 + RIGHT.BusInquiryCount01,
																	SELF := LEFT));

	withConsumerPhoneRolled := JOIN(withConsumerAddressRolled, consumerPhoneRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              PhoneNotInput := TRIM(LEFT.Clean_Input.Phone10) = '';
																							SELF.Inquiry.InquiryConsumerPhone := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount, -1, 99999));
																							SELF.Inquiry.InquiryConsumerPhone12Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount12, -1, 99999));
																							SELF.Inquiry.InquiryConsumerPhone06Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount06, -1, 99999));
																							SELF.Inquiry.InquiryConsumerPhone03Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount03, -1, 99999));
																							SELF.Inquiry.InquiryConsumerPhone01Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount01, -1, 99999));

																							SELF.Inquiry.InquiryBusPhone := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount, -1, 99999));
																							SELF.Inquiry.InquiryBusPhone24Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount24, -1, 99999));
																							SELF.Inquiry.InquiryBusPhone12Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount12, -1, 99999));
																							SELF.Inquiry.InquiryBusPhone06Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount06, -1, 99999));
																							SELF.Inquiry.InquiryBusPhone03Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount03, -1, 99999));
																							SELF.Inquiry.InquiryBusPhone01Mos := IF(PhoneNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount01, -1, 99999));

																							SELF.Data_Build_Dates.InquiriesBuildDate := InqBuildDate;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// ---------------- Consumer Inquiries SSN - Only Allowed in Non-Marketing Mode ------------------
	inquiryTransformMac(grabSSN, Inquiry_AccLogs.Key_Inquiry_SSN);
	inquiryTransformMac(grabSSNUpdate, Inquiry_AccLogs.Key_Inquiry_SSN_Update);
	consumerSSNBase_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_SSN,
										LEFT.Clean_Input.FEIN <> '' AND KEYED(LEFT.Clean_Input.FEIN = RIGHT.SSN) AND
										// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
										((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
								grabSSN(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
								DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	consumerSSNBase := Suppress.Suppress_ReturnOldLayout(consumerSSNBase_unsuppressed, mod_access, tempConsumerInquiry);
	consumerSSNUpdate_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_SSN_Update,
										LEFT.Clean_Input.FEIN <> '' AND KEYED(LEFT.Clean_Input.FEIN = RIGHT.SSN) AND
										// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
										((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
								grabSSNUpdate(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
								DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	consumerSSNUpdate := Suppress.Suppress_ReturnOldLayout(consumerSSNUpdate_unsuppressed, mod_access, tempConsumerInquiry);
	consumerSSN := DEDUP(SORT(UNGROUP(consumerSSNBase + consumerSSNUpdate), Seq, Transaction_ID, Sequence_Number), Seq, Transaction_ID, Sequence_Number);

	consumerSSNRolled := ROLLUP(consumerSSN, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempConsumerInquiry,
																	SELF.InquiryCount := LEFT.InquiryCount + RIGHT.InquiryCount,
																	SELF.InquiryCount12 := LEFT.InquiryCount12 + RIGHT.InquiryCount12,
																	SELF.InquiryCount06 := LEFT.InquiryCount06 + RIGHT.InquiryCount06,
																	SELF.InquiryCount03 := LEFT.InquiryCount03 + RIGHT.InquiryCount03,
																	SELF.InquiryCount01 := LEFT.InquiryCount01 + RIGHT.InquiryCount01,
																	SELF := LEFT));

	withConsumerSSNRolled := JOIN(withConsumerPhoneRolled, consumerSSNRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              FEINNotInput := TRIM(LEFT.Clean_Input.FEIN) = '';
																							SELF.Inquiry.InquiryConsumerSSN := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount, -1, 99999));
																							SELF.Inquiry.InquiryConsumerSSN12Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount12, -1, 99999));
																							SELF.Inquiry.InquiryConsumerSSN06Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount06, -1, 99999));
																							SELF.Inquiry.InquiryConsumerSSN03Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount03, -1, 99999));
																							SELF.Inquiry.InquiryConsumerSSN01Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.InquiryCount01, -1, 99999));
																							SELF.Data_Build_Dates.InquiriesBuildDate := InqBuildDate;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// ---------------- Inquiries by FEIN ------------------
	inquiryTransformMac(grabFEIN, Inquiry_AccLogs.Key_Inquiry_FEIN);
	inquiryTransformMac(grabFEINUpdate, Inquiry_AccLogs.Key_Inquiry_FEIN_Update);
	businessFEINBase_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_FEIN,
										LEFT.Clean_Input.FEIN <> '' AND KEYED(LEFT.Clean_Input.FEIN = RIGHT.appended_ein) AND
										// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
										((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
								grabFEIN(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
								DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	businessFEINBase := Suppress.Suppress_ReturnOldLayout(businessFEINBase_unsuppressed, mod_access, tempConsumerInquiry);
	businessFEINUpdate_unsuppressed := IF(~is_marketing, JOIN(Shell, Inquiry_AccLogs.Key_Inquiry_FEIN_Update,
										LEFT.Clean_Input.FEIN <> '' AND KEYED(LEFT.Clean_Input.FEIN = RIGHT.appended_ein) AND
										// See comments on Business_Risk_BIP.Common.FilterRecords for details - but the <= and < checks below are correct and intentional
										((LEFT.Clean_Input.HistoryDate = (INTEGER)Business_Risk_BIP.Constants.NinesDate AND (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) <= LEFT.Clean_Input.HistoryDate) OR (INTEGER)(RIGHT.Search_Info.DateTime[1..6]) < LEFT.Clean_Input.HistoryDate), // Only keep records within the history date
								grabFEINUpdate(LEFT, RIGHT), ATMOST(RiskWise.max_atmost)),
								DATASET([], {tempConsumerInquiry, unsigned4 global_sid, unsigned6 did}));
	businessFEINUpdate := Suppress.Suppress_ReturnOldLayout(businessFEINUpdate_unsuppressed, mod_access, tempConsumerInquiry);
	businessFEIN := DEDUP(SORT(UNGROUP(businessFEINBase + businessFEINUpdate), Seq, Transaction_ID, Sequence_Number), Seq, Transaction_ID, Sequence_Number);

	businessFEINRolled := ROLLUP(businessFEIN, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempConsumerInquiry,

																	SELF.BusInquiryCount := LEFT.BusInquiryCount + RIGHT.BusInquiryCount;
																	SELF.BusInquiryCount24 := LEFT.BusInquiryCount24 + RIGHT.BusInquiryCount24,
																	SELF.BusInquiryCount12 := LEFT.BusInquiryCount12 + RIGHT.BusInquiryCount12,
																	SELF.BusInquiryCount06 := LEFT.BusInquiryCount06 + RIGHT.BusInquiryCount06,
																	SELF.BusInquiryCount03 := LEFT.BusInquiryCount03 + RIGHT.BusInquiryCount03,
																	SELF.BusInquiryCount01 := LEFT.BusInquiryCount01 + RIGHT.BusInquiryCount01,
																	SELF := LEFT));

	withBusinessFEINRolled := JOIN(withConsumerSSNRolled, businessFEINRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                                              FEINNotInput := TRIM(LEFT.Clean_Input.FEIN) = '';
																							SELF.Inquiry.InquiryBusFEIN := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount, -1, 99999));
																							SELF.Inquiry.InquiryBusFEIN24Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount24, -1, 99999));
																							SELF.Inquiry.InquiryBusFEIN12Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount12, -1, 99999));
																							SELF.Inquiry.InquiryBusFEIN06Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount06, -1, 99999));
																							SELF.Inquiry.InquiryBusFEIN03Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount03, -1, 99999));
																							SELF.Inquiry.InquiryBusFEIN01Mos := IF(FEINNotInput AND shell_version >= Business_Risk_BIP.Constants.BusShellVersion_v30, '-1',
                                                                                       (STRING)Business_Risk_BIP.Common.capNum(RIGHT.BusInquiryCount01, -1, 99999));

																							SELF.Data_Build_Dates.InquiriesBuildDate := InqBuildDate;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(Inquiries, 100), NAMED('Sample_Inquiries'));
	// OUTPUT(CHOOSEN(InquiriesUpdate, 100), NAMED('Sample_InquiriesUpdate'));
	// OUTPUT(CHOOSEN(InquiriesAll, 100), NAMED('Sample_InquiriesAll'));
	// OUTPUT(CHOOSEN(ValidInquiries, 100), NAMED('Sample_ValidInquiries'));
	// OUTPUT(CHOOSEN(RolledInquiries, 100), NAMED('Sample_RolledInquiries'));
	// OUTPUT(CHOOSEN(withBusinessInquiries, 100), NAMED('Sample_withBusinessInquiries'));

	RETURN withBusinessFEINRolled;
END;
