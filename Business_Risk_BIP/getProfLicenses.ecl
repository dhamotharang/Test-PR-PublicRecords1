IMPORT BIPV2, Business_Risk, Business_Risk_BIP, Doxie, Prof_LicenseV2, Risk_Indicators;

EXPORT getProfLicenses(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions, // NOTE: not used here in getProfLicenses( )
											 SET OF STRING2 AllowedSourcesSet,
                       Doxie.IDataAccess mod_access) := FUNCTION

	// ---------------- Professional License Records ------------------
  searchLevel := Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel); // e.g. 'S'

	ProfLicRaw := Prof_LicenseV2.Key_Proflic_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell), mod_access,
																						 (STRING1)searchLevel,
																							0 /*ScoreThreshold --> 0 = Give me everything*/,
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq(ProfLicRaw, Shell, ProfLicSeq, Options.LinkSearchLevel);

	// NOTE: the ProfLic KeyFetch doesn't output a Fetch_Error_Code field, so we can't figure out
 // if the kFetch was unsuccessful.

	// Filter out records after our history date
	ProfLicRecords := Business_Risk_BIP.Common.FilterRecords(ProfLicSeq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, Business_Risk_BIP.Constants.Src_Prolic, AllowedSourcesSet);

	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	ProfLicStats := TABLE(ProfLicRecords,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := Business_Risk_BIP.Constants.Src_Prolic,
			 STRING6 DateFirstSeen       := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Constants.MissingDate, // no vendor first seen date field on professional license records
			 STRING6 DateLastSeen        := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen  := Business_Risk_BIP.Constants.MissingDate, // no vendor last seen date field on professional license records
			 UNSIGNED4 RecordCount       := COUNT(GROUP),
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );

	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
	END;

  // ----- Professional Licenses: calculate Sources child dataset. -----

	ProfLicStatsTemp := PROJECT(ProfLicStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := IF(LEFT.RecordCount > 0, DATASET([{LEFT.Source,
																																													IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen),
																																													IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen),
																																													LEFT.DateLastSeen,
																																													LEFT.DateVendorLastSeen,
																																													LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources),
																																									DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
																				SELF := []));

	ProfLicStatsRolled := ROLLUP(ProfLicStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF := LEFT));

  // ----- Professional Licenses: calculate NameSources, AddressVerSources, and PhoneSources child datasets. -----

	tempProfLicCalc := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) NameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) AddressVerSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) BestAddressSources;
	END;

	tempProfLicCalc calcProfLic(Business_Risk_BIP.Layouts.Shell le, ProfLicRecords ri) := TRANSFORM
		SELF.Seq := le.Seq;

		// In an effort to "short circuit" the fuzzy matching require that the first character match before doing the fuzzy comparison - this helps with latency
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.company_name) <> '';
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.company_name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.company_name));

		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip5[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip), NoScoreValue);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.St <> '' AND le.Clean_Input.State[1] = ri.St[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.St, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));

		BestAddressPopulated		:= TRIM(le.Best_Info.BestPrimName) <> '' AND TRIM(le.Best_Info.BestCompanyZip) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		BestZIPScore						:= IF(le.Best_Info.BestCompanyZip <> '' AND ri.Zip <> '' AND le.Best_Info.BestCompanyZip[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Best_Info.BestCompanyZip, ri.Zip), NoScoreValue);
		BestCityStateScore			:= IF(le.Best_Info.BestCompanyCity <> '' AND le.Best_Info.BestCompanyState <> '' AND ri.p_city_name <> '' AND ri.St <> '' AND le.Best_Info.BestCompanyState[1] = ri.St[1], Risk_Indicators.AddrScore.CityState_Score(le.Best_Info.BestCompanyCity, le.Best_Info.BestCompanyState, ri.p_city_name, ri.St, ''), NoScoreValue);
		BestCityStateZipMatched	:= Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore) AND BestAddressPopulated;
		BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(IF(BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue, NoScoreValue,
																						Risk_Indicators.AddrScore.AddressScore(le.Best_Info.BestPrimRange, le.Best_Info.BestPrimName, le.Best_Info.BestSecRange,
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						BestZIPScore, BestCityStateScore)));

		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.phone) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.phone[1] OR le.Clean_Input.Phone10[4] = ri.phone[4] OR le.Clean_Input.Phone10[4] = ri.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.phone));

		// This is also being calculated in Business_Risk_BIP.getBusinessHeader and Business_Risk_BIP.getEDA to help boost verification,
		// Only the levels that can be calculated with a phone match will be calculated here
		BNAPCalc := Business_Risk_BIP.Common.calcBNAP_narrow(NameMatched, AddressMatched, PhoneMatched);

		DateFirstSeen       := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.date_first_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateLastSeen        := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.date_last_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];

		Sources := DATASET([{Business_Risk_BIP.Constants.Src_Prolic,
												 DateFirstSeen,
												 Business_Risk_BIP.Constants.MissingDate, // no vendor first seen date field on professional license records
												 DateLastSeen,
												 Business_Risk_BIP.Constants.MissingDate, // no vendor last seen date field on professional license records
												 1}], Business_Risk_BIP.Layouts.LayoutSources);

		SELF.PhoneSources      := IF(                                  																							BNAPCalc IN ['4', '5', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.NameSources       := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v22 AND BNAPCalc IN ['5', '8']     , Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.AddressVerSources := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v22 AND BNAPCalc IN ['4', '8']     , Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.BestAddressSources := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched, Sources, 				DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
	END;

	profLicBNAPRaw := JOIN(Shell, ProfLicRecords, LEFT.Seq = RIGHT.Seq,
																	calcProfLic(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	profLicBNAPRolled := ROLLUP(SORT(profLicBNAPRaw, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempProfLicCalc,
																			SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																			SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																			SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																			SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																			SELF := LEFT));

  withProfLic := JOIN(ProfLicStatsRolled, profLicBNAPRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                       SELF.seq                     := LEFT.seq,
                       SELF.PhoneSources            := RIGHT.PhoneSources,
                       SELF.NameSources             := RIGHT.NameSources,
                       SELF.AddressVerSources       := RIGHT.AddressVerSources,
											 SELF.BestAddressSources			:= RIGHT.BestAddressSources,
                       SELF.Sources                 := LEFT.Sources,
                       SELF := RIGHT,
                       SELF := LEFT,
                       SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


  // *********************
  //   DEBUGGING OUTPUTS
  // *********************
  // OUTPUT( ProfLicRecords, NAMED('ProfLicRecords') );
  // OUTPUT( ProfLicStatsTemp, NAMED('ProfLicStatsTemp') );
  // OUTPUT( ProfLicStatsRolled, NAMED('ProfLicStatsRolled') );
  // OUTPUT( profLicBNAPRaw, NAMED('profLicBNAPRaw') );
  // OUTPUT( profLicBNAPRolled, NAMED('profLicBNAPRolled') );
  // OUTPUT( withProfLic, NAMED('withProfLic') );

	RETURN withProfLic;

END;