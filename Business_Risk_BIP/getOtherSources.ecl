IMPORT AutoKey, BBB2, BIPV2, Business_Risk, Business_Risk_BIP, CalBus, Data_Services, DNB_FEINV2, 
    Doxie, dx_DataBridge, FBNv2, Frandx, GovData, IRS5500, MDR, PAW, Phones, Phonesplus_v2, 
    Risk_Indicators, TXBUS, UT, UtilFile, STD, YellowPages;

EXPORT getOtherSources(DATASET(Business_Risk_BIP.Layouts.Shell) Shell, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet,
											 doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

	// ---------------- Better Business Bureau ------------------ 
	BBBMemberRaw := BBB2.Key_BBB_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	BBBNonMemberRaw := BBB2.Key_BBB_Non_Member_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq2(BBBMemberRaw, Shell, BBBMemberSeq);
	
	Business_Risk_BIP.Common.AppendSeq2(BBBNonMemberRaw, Shell, BBBNonMemberSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesBBBMember := Business_Risk_BIP.Common.GrabFetchErrorCode(BBBMemberSeq);
	
	kFetchErrorCodesBBBNonMember := Business_Risk_BIP.Common.GrabFetchErrorCode(BBBNonMemberSeq);
	
	// Filter out records after our history date
	BBBMember := Business_Risk_BIP.Common.FilterRecords(BBBMemberSeq, date_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_BBB_Member, AllowedSourcesSet);
	
	BBBNonMember := Business_Risk_BIP.Common.FilterRecords(BBBNonMemberSeq, date_first_seen, dt_vendor_first_reported,  MDR.SourceTools.src_BBB_Non_Member, AllowedSourcesSet);
	
	// Figure out the first seen and last seen date per source for each Seq, by LinkID level
	BBBMemberStats := TABLE(BBBMember,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_BBB_Member,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	
	BBBNonMemberStats := TABLE(BBBNonMember,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_BBB_Non_Member,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
			 
	// Rollup the dates first/last seen into child datasets by Seq
	tempLayout := RECORD
		UNSIGNED4 Seq;
		INTEGER FirmReportedEarnings;
		UNSIGNED4 RecordCount;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) Sources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSICNAIC) SICNAICSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSalesSources) SalesSources;
	END;
	
	BBBStatsTemp := PROJECT(SORT(UNGROUP(BBBMemberStats + BBBNonMemberStats), Seq), TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	BBBStatsRolled := ROLLUP(BBBStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF := LEFT));
	
	withBBB := JOIN(Shell, BBBStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// ---------------- Ficticious Business Name ---------------------
	FBNRaw := FBNv2.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell), mod_access,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(FBNRaw, Shell, FBNSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesFBN := Business_Risk_BIP.Common.GrabFetchErrorCode(FBNSeq);
	
	// Filter out records after our history date
	FBN := Business_Risk_BIP.Common.FilterRecords(FBNSeq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_FBNV2_BusReg, AllowedSourcesSet);
	
	FBNStats := TABLE(FBN,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_FBNV2_BusReg,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_vendor_first_reported, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_vendor_last_reported, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	FBNStatsTemp := PROJECT(FBNStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	FBNStatsRolled := ROLLUP(FBNStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF := LEFT));
	
	withFBNStats := JOIN(withBBB, FBNStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Get all unique SIC Codes along with dates
	FBNSIC := TABLE(FBN,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_FBNV2_BusReg,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := (STD.Str.Filter((STRING)SIC_Code, '0123456789'))[1..4],
			 BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)SIC_Code)[1..4]
			 );
	
	FBNSICTemp := PROJECT(FBNSIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
	
	FBNSICRolled := ROLLUP(FBNSICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	
	withFBN := JOIN(withFBNStats, FBNSICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// ---------------- IRS 990/IRS Non-Profit ------------------------
	IRS990Raw := GovData.key_IRS_NonProfit_linkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(IRS990Raw, Shell, IRS990Seq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesIRSNonProfit := Business_Risk_BIP.Common.GrabFetchErrorCode(IRS990Seq);
	
	// Filter out records after our history date
	IRS990 := Business_Risk_BIP.Common.FilterRecords(IRS990Seq, process_date, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_IRS_Non_Profit, AllowedSourcesSet);
	
	SortTaxIRS990 := Dedup(sort(IRS990, seq, -tax_period), seq);
	
	IRS990Stats := TABLE(IRS990,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_IRS_Non_Profit,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(process_date, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Constants.MissingDate, // vendor dates not included in key
			 STRING6 DateLastSeen := (STRING)'0', // This dataset doesn't contain a last seen date
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate, 
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	IRS990StatsTemp := JOIN(IRS990Stats, SortTaxIRS990, LEFT.Seq = RIGHT.Seq,
																				TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
                                        // For v30 and up, need to differentiate between 0 and '' for FirmReportedSales. Set missing records to -1.                          
																				SELF.SalesSources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	IF(RIGHT.Income_Amount = '' AND Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30, -1, 
																																						(INTEGER)RIGHT.Income_Amount);
																																	}], Business_Risk_BIP.Layouts.LayoutSalesSources);	
																				SELF.FirmReportedEarnings :=  (INTEGER)(STD.Str.Filter(RIGHT.Negative_Rev_Amount, '-') + (STRING)RIGHT.Form_990_Revenue_Amount);
																				SELF.RecordCount := LEFT.RecordCount;
																				SELF := []), left outer);
																				
	IRS990StatsRolled := ROLLUP(IRS990StatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; 
																																		SELF.Sources := LEFT.Sources + RIGHT.Sources; 
																																		SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
																																		SELF.FirmReportedEarnings := MAX(LEFT.FirmReportedEarnings, RIGHT.FirmReportedEarnings);
																																		SELF.RecordCount := LEFT.RecordCount + RIGHT.RecordCount;
																																		SELF := LEFT));
	
	withIRS990 := JOIN(withFBN, IRS990StatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF.SalesSources := LEFT.SalesSources + RIGHT.SalesSources;
																							SELF.Firmographic.FirmReportedEarnings := (STRING)Business_Risk_BIP.Common.capNum(IF(RIGHT.RecordCount > 0, RIGHT.FirmReportedEarnings, -1), -1, 999999999);
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// ---------------- IRS 5500 401K/Retirement ----------------------
	IRS5500Raw := IRS5500.Key_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(IRS5500Raw, Shell, IRS5500Seq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesIRSRetirement := Business_Risk_BIP.Common.GrabFetchErrorCode(IRS5500Seq);
	
	// Filter out records after our history date
	IRS5500 := Business_Risk_BIP.Common.FilterRecords(IRS5500Seq, form_plan_year_begin_date, trans_date, MDR.SourceTools.src_IRS_5500, AllowedSourcesSet);
	
	IRS5500Sort := DEDUP(SORT(IRS5500, SEQ, -form_plan_year_begin_date), seq);

  withIRS5500 := JOIN(withIRS990, IRS5500Sort, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Firmographic.FirmIRSRetirementPlan := if((integer)right.form_plan_year_begin_date <> 0, '1','0');
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// ---------------- Phone Risk Table - This contains Disconnect information via EDA/Gong ----------------------
	potentialPhoneDisconnectRaw := JOIN(Shell, Risk_Indicators.Key_Phone_Table_V2, TRIM(LEFT.Clean_Input.Phone10) <> '' AND KEYED(LEFT.Clean_Input.Phone10 = RIGHT.Phone10),
																	TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate}, SELF.Seq := LEFT.Seq; SELF.HistoryDate := LEFT.Clean_Input.HistoryDate; SELF := RIGHT),
																	ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	potentialPhoneDisconnect := SORT(Business_Risk_BIP.Common.FilterRecords(potentialPhoneDisconnectRaw, dt_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, '', AllowedSourcesSet), Seq, -((INTEGER)dt_first_seen), -potDisconnect);
	
	// Keep the most recent record, it's possible this number has been disconnected and then reconnected, the most recent record should hopefully be accurate
	phoneDisconnect := ROLLUP(potentialPhoneDisconnect, LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));
	
	withPhoneDisconnect := JOIN(withIRS5500, phoneDisconnect, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.PhoneDisconnected := IF((INTEGER)RIGHT.dt_first_seen <= 0, '2', (STRING)((INTEGER)RIGHT.potDisconnect)); // A 2 indicates "Unknown"
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	// ---------------------- Phones Plus Data ----------------------------
	PhoneAutoKey := AutoKey.Key_Phone(Data_Services.Data_Location.Prefix('phonesPlus') + 'thor_data400::key::phonesplusv2_');
	
	layoutPPTemp := RECORD
		UNSIGNED8 fdid := 0; // Fake DID - used to search the full phones plus payload
		Business_Risk_BIP.Layouts.Shell;
	END;
	layoutPPTemp getFDID(Business_Risk_BIP.Layouts.Shell le, PhoneAutoKey ri) := TRANSFORM
		SELF.fdid := ri.did;
		SELF := le;
	END;
	getPhoneFDID := JOIN(Shell, PhoneAutoKey, (INTEGER)LEFT.Clean_Input.Phone10 > 0 AND KEYED(RIGHT.p7 = LEFT.Clean_Input.Phone10[4..10]) AND KEYED(RIGHT.p3 = LEFT.Clean_Input.Phone10[1..3]),
																		getFDID(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

  // moving filter condition out of join since it was causing Packet Length Exceeded error.																		
	phonesPlusRaw := JOIN(getPhoneFDID, Phonesplus_v2.key_phonesplus_fdid, LEFT.FDID <> 0 AND KEYED(LEFT.FDID = RIGHT.FDID) AND
																											(INTEGER)RIGHT.CellPhone > 0, 
																										TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate}, SELF.Seq := LEFT.Seq; SELF.HistoryDate := LEFT.Clean_Input.HistoryDate; SELF := RIGHT), 
																										ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	phonesPlusRaw_filter_srcall := phonesPlusRaw(Phones.Functions.IsPhoneRestricted(origstate, 
																																									Options.GLBA_Purpose, 
																																									Options.DPPA_Purpose, 
																																									Options.IndustryClass,
																																									,
																																									datefirstseen,
																																									dt_nonglb_last_seen,
																																									rules,
																																									src_all,
																																									Options.DataRestrictionMask
																																								) = FALSE);
	// Filter out records after our history date
	phonesPlus := Business_Risk_BIP.Common.FilterRecords(phonesPlusRaw_filter_srcall, datefirstseen, datevendorfirstreported, '', AllowedSourcesSet);
	
	tempPhonesPlusCalc := RECORD
		UNSIGNED4 Seq;
		STRING2 BNAP;
		STRING1 PhoneMatch;
		BOOLEAN NameMatched;
		BOOLEAN AddressMatched;
		BOOLEAN PhoneMatched;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) NameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) AddressVerSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutBestAddrPhones) BestAddrPhones;
	END;
	
	tempPhonesPlusCalc calcPhonesPlus(Business_Risk_BIP.Layouts.Shell le, phonesPlus ri) := TRANSFORM
		SELF.Seq := le.Seq;
		
		// In an effort to "short circuit" the fuzzy matching require that the first character match before doing the fuzzy comparison - this helps with latency
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.Company) <> '';
		NameMatched					:= NamePopulated AND le.Clean_Input.CompanyName[1] = ri.Company[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.Company));
		
		NoScoreValue				:= 255;
		AddressPopulated		:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip5) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip5) <> '';
		ZIPScore						:= IF(le.Clean_Input.Zip5 <> '' AND ri.Zip5 <> '' AND le.Clean_Input.Zip5[1] = ri.Zip5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip5, ri.Zip5), NoScoreValue);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.State <> '' AND le.Clean_Input.State[1] = ri.State[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.State, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue, 
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));
		
		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND TRIM(ri.CellPhone) <> '';
		PhoneMatched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.CellPhone[1] OR le.Clean_Input.Phone10[4] = ri.CellPhone[4] OR le.Clean_Input.Phone10[4] = ri.CellPhone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.CellPhone));


		BestAddressPopulated		:= TRIM(le.Best_Info.BestPrimName) <> '' AND TRIM(le.Best_Info.BestCompanyZip) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip5) <> '';
		BestZIPScore						:= IF(le.Best_Info.BestCompanyZip <> '' AND ri.Zip5 <> '' AND le.Best_Info.BestCompanyZip[1] = ri.Zip5[1], Risk_Indicators.AddrScore.ZIP_Score(le.Best_Info.BestCompanyZip, ri.Zip5), NoScoreValue);
		BestCityStateScore			:= IF(BestZIPScore <> NoScoreValue AND le.Best_Info.BestCompanyCity <> '' AND le.Best_Info.BestCompanyState <> '' AND ri.p_city_name <> '' AND ri.State <> '' AND le.Best_Info.BestCompanyState[1] = ri.State[1], Risk_Indicators.AddrScore.CityState_Score(le.Best_Info.BestCompanyCity, le.Best_Info.BestCompanyState, ri.p_city_name, ri.State, ''), NoScoreValue);
		BestCityStateZipMatched	:= Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore) AND BestAddressPopulated;
		BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(IF(BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue, NoScoreValue, 
																								Risk_Indicators.AddrScore.AddressScore(le.Best_Info.BestPrimRange, le.Best_Info.BestPrimName, le.Best_Info.BestSecRange, 
																								ri.prim_range, ri.prim_name, ri.sec_range,
																								BestZIPScore, BestCityStateScore)));
																																										
		// This is also being calculated in Business_Risk_BIP.getBusinessHeader and Business_Risk_BIP.getEDA to help boost verification, 
		// Only the levels that can be calculated with a phone match will be calculated here
		BNAPCalc := Business_Risk_BIP.Common.calcBNAP_narrow(NameMatched, AddressMatched, PhoneMatched);
		
		SELF.BNAP := BNAPCalc;
		// A BNAP of 4, 5, or 8 should also update the PhoneMatch flag as we effectively have verified the input phone against the input Business Name AND/OR Business Address
		SELF.PhoneMatch := Business_Risk_BIP.Common.SetBoolean(BNAPCalc IN ['4', '5', '8']);
		DateFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.datefirstseen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.datevendorfirstreported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateLastSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.datelastseen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorLastSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.datevendorlastreported, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		
    
    Sources := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v31 AND Options.MarketingMode = 1,
                    DATASET([], Business_Risk_BIP.Layouts.LayoutSources),
                    DATASET([{MDR.SourceTools.src_Phones_Plus, 
												 DateFirstSeen, 
												 DateVendorFirstSeen, 
												 DateLastSeen,
												 DateVendorLastSeen,
												 1}], Business_Risk_BIP.Layouts.LayoutSources)); 
												 
		SELF.PhoneSources := IF(BNAPCalc IN ['4', '5', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.NameSources := IF(Options.BusShellVersion >= 22 AND BNAPCalc IN ['5', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));																											
		SELF.AddressVerSources := IF(Options.BusShellVersion >= 22 AND BNAPCalc IN ['4', '8'], Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));					
		SELF.BestAddrPhones := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched AND TRIM(ri.CellPhone) <> '',
																				DATASET([{ri.CellPhone}], Business_Risk_BIP.Layouts.LayoutBestAddrPhones), DATASET([], Business_Risk_BIP.Layouts.LayoutBestAddrPhones));
		// For BNAP2 we want to rollup the various match elements across all header records to catch situations where FEIN verified on one record, but wasn't populated on the header record that Address verified.
		SELF.NameMatched := NameMatched;
		SELF.AddressMatched := AddressMatched;
		SELF.PhoneMatched := PhoneMatched;
	END;
	phonesPlusBNAPRaw := JOIN(Shell, phonesPlus, LEFT.Seq = RIGHT.Seq,
																	calcPhonesPlus(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	phonesPlusBNAP := ROLLUP(SORT(phonesPlusBNAPRaw, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempPhonesPlusCalc,
																			SELF.BNAP := (STRING)MAX((INTEGER)LEFT.BNAP, (INTEGER)RIGHT.BNAP);
																			SELF.PhoneMatch := (STRING)MAX((INTEGER)LEFT.PhoneMatch, (INTEGER)RIGHT.PhoneMatch);
																			SELF.PhoneSources := LEFT.PhoneSources + RIGHT.PhoneSources;
																			SELF.NameSources := LEFT.NameSources + RIGHT.NameSources;
																			SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																			SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																			SELF.NameMatched := LEFT.NameMatched OR RIGHT.NameMatched;
																			SELF.AddressMatched := LEFT.AddressMatched OR RIGHT.AddressMatched;
																			SELF.PhoneMatched := LEFT.PhoneMatched OR RIGHT.PhoneMatched;
																			SELF := LEFT));
	
	withPhonesPlus := JOIN(withPhoneDisconnect, phonesPlusBNAP, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.BNAP := RIGHT.BNAP; // Requires all elements verify within the same phone record
																							SELF.Verification.BNAP2 := Business_Risk_BIP.Common.calcBNAP_narrow(RIGHT.NameMatched, RIGHT.AddressMatched, RIGHT.PhoneMatched); // Uses the combination of all phone records to verify elements
																							SELF.Verification.PhoneMatch := RIGHT.PhoneMatch;
																							SELF.PhoneSources := RIGHT.PhoneSources;
																							SELF.NameSources := RIGHT.NameSources;
																							SELF.AddressVerSources := RIGHT.AddressVerSources;
																							SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																							SELF.Sources := LEFT.Sources + RIGHT.PhoneSources; // Make sure we copy the phone sources to the main source list as well
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// ---------------- Utility Data ---------------------
	UtilRaw := IF(~Doxie.Compliance.isUtilityRestricted(Options.IndustryClass), UtilFile.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses));
																							
	Business_Risk_BIP.Common.AppendSeq2(UtilRaw, Shell, UtilSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesUtility := Business_Risk_BIP.Common.GrabFetchErrorCode(UtilSeq);
	
	// Filter out records after our history date
	Util := Business_Risk_BIP.Common.FilterRecords(UtilSeq, date_first_seen, date_added_to_exchange, MDR.SourceTools.src_Utilities, AllowedSourcesSet);
	
	// ----- Utilities: calculate Business-2-Exec links -----
  
	tempUtilRec := RECORD
		UNSIGNED4 Seq;
		UNSIGNED4 BusExecLinkUtilityOverlapCount;
		UNSIGNED4 BusExecLinkUtilityOverlapCount2;
		UNSIGNED4 BusExecLinkUtilityOverlapCount3;
		UNSIGNED4 BusExecLinkUtilityOverlapCount4;
		UNSIGNED4 BusExecLinkUtilityOverlapCount5;
	END;
  
	tempUtilRec getUtilAttributes(Business_Risk_BIP.Layouts.Shell le, Util ri) := TRANSFORM
		SELF.Seq := le.Seq;
		fname1InputPopulated := TRIM(le.Clean_Input.Rep_FirstName) <> '';
		lname1InputPopulated := TRIM(le.Clean_Input.Rep_LastName) <> '';
		fnameMatch := fname1InputPopulated AND le.Clean_Input.Rep_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep_FirstName));
		lnameMatch := lname1InputPopulated AND le.Clean_Input.Rep_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep_LastName));
		fnameMatchRev := fname1InputPopulated AND le.Clean_Input.Rep_FirstName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.LName, le.Clean_Input.Rep_FirstName));
		lnameMatchRev := lname1InputPopulated AND le.Clean_Input.Rep_LastName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.FName, le.Clean_Input.Rep_LastName));
		
		fnameOrigFnameMatch := fname1InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep_FirstName, 1) > 0;
		fnameOrigLnameMatch := fname1InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep_FirstName, 1) > 0;
		lnameOrigFnameMatch := lname1InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep_LastName, 1) > 0;
		lnameOrigLnamematch := lname1InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep_LastName, 1) > 0;
		
		fname2InputPopulated := TRIM(le.Clean_Input.Rep2_FirstName) <> '';
		lname2InputPopulated := TRIM(le.Clean_Input.Rep2_LastName) <> '';
		fnameMatch2 := fname2InputPopulated AND le.Clean_Input.Rep2_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep2_FirstName));
		lnameMatch2 := lname2InputPopulated AND le.Clean_Input.Rep2_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep2_LastName));
		fnameMatchRev2 := fname2InputPopulated AND le.Clean_Input.Rep2_FirstName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.LName, le.Clean_Input.Rep2_FirstName));
		lnameMatchRev2 := lname2InputPopulated AND le.Clean_Input.Rep2_LastName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.FName, le.Clean_Input.Rep2_LastName));
		
		fnameOrigFnameMatch2 := fname2InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep2_FirstName, 1) > 0;
		fnameOrigLnameMatch2 := fname2InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep2_FirstName, 1) > 0;
		lnameOrigFnameMatch2 := lname2InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep2_LastName, 1) > 0;
		lnameOrigLnamematch2 := lname2InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep2_LastName, 1) > 0;
		
		fname3InputPopulated := TRIM(le.Clean_Input.Rep3_FirstName) <> '';
		lname3InputPopulated := TRIM(le.Clean_Input.Rep3_LastName) <> '';
		fnameMatch3 := fname3InputPopulated AND le.Clean_Input.Rep3_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep3_FirstName));
		lnameMatch3 := lname3InputPopulated AND le.Clean_Input.Rep3_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep3_LastName));
		fnameMatchRev3 := fname3InputPopulated AND le.Clean_Input.Rep3_FirstName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.LName, le.Clean_Input.Rep3_FirstName));
		lnameMatchRev3 := lname3InputPopulated AND le.Clean_Input.Rep3_LastName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.FName, le.Clean_Input.Rep3_LastName));
		
		fnameOrigFnameMatch3 := fname3InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep3_FirstName, 1) > 0;
		fnameOrigLnameMatch3 := fname3InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep3_FirstName, 1) > 0;
		lnameOrigFnameMatch3 := lname3InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep3_LastName, 1) > 0;
		lnameOrigLnamematch3 := lname3InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep3_LastName, 1) > 0;
		
		fname4InputPopulated := TRIM(le.Clean_Input.Rep4_FirstName) <> '';
		lname4InputPopulated := TRIM(le.Clean_Input.Rep4_LastName) <> '';
		fnameMatch4 := fname4InputPopulated AND le.Clean_Input.Rep4_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep4_FirstName));
		lnameMatch4 := lname4InputPopulated AND le.Clean_Input.Rep4_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep4_LastName));
		fnameMatchRev4 := fname4InputPopulated AND le.Clean_Input.Rep4_FirstName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.LName, le.Clean_Input.Rep4_FirstName));
		lnameMatchRev4 := lname4InputPopulated AND le.Clean_Input.Rep4_LastName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.FName, le.Clean_Input.Rep4_LastName));
		
		fnameOrigFnameMatch4 := fname4InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep4_FirstName, 1) > 0;
		fnameOrigLnameMatch4 := fname4InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep4_FirstName, 1) > 0;
		lnameOrigFnameMatch4 := lname4InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep4_LastName, 1) > 0;
		lnameOrigLnamematch4 := lname4InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep4_LastName, 1) > 0;
		
		fname5InputPopulated := TRIM(le.Clean_Input.Rep5_FirstName) <> '';
		lname5InputPopulated := TRIM(le.Clean_Input.Rep5_LastName) <> '';
		fnameMatch5 := fname5InputPopulated AND le.Clean_Input.Rep5_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep5_FirstName));
		lnameMatch5 := lname5InputPopulated AND le.Clean_Input.Rep5_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep5_LastName));
		fnameMatchRev5 := fname5InputPopulated AND le.Clean_Input.Rep5_FirstName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.LName, le.Clean_Input.Rep5_FirstName));
		lnameMatchRev5 := lname5InputPopulated AND le.Clean_Input.Rep5_LastName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.FName, le.Clean_Input.Rep5_LastName));
		
		fnameOrigFnameMatch5 := fname5InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep5_FirstName, 1) > 0;
		fnameOrigLnameMatch5 := fname5InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep5_FirstName, 1) > 0;
		lnameOrigFnameMatch5 := lname5InputPopulated AND STD.Str.Find(ri.Orig_FName, le.Clean_Input.Rep5_LastName, 1) > 0;
		lnameOrigLnamematch5 := lname5InputPopulated AND STD.Str.Find(ri.Orig_LName, le.Clean_Input.Rep5_LastName, 1) > 0;
		
		nameMatch1 := fnameMatch OR lnameMatch OR fnameMatchRev OR lnameMatchRev OR 
								 fnameOrigFnameMatch OR fnameOrigLnameMatch OR lnameOrigFnameMatch OR lnameOrigLnamematch;
								 
		nameMatch2 := fnameMatch2 OR lnameMatch2 OR fnameMatchRev2 OR lnameMatchRev2 OR 
								 fnameOrigFnameMatch2 OR fnameOrigLnameMatch2 OR lnameOrigFnameMatch2 OR lnameOrigLnamematch2;
								 
		nameMatch3 := fnameMatch3 OR lnameMatch3 OR fnameMatchRev3 OR lnameMatchRev3 OR 
								 fnameOrigFnameMatch3 OR fnameOrigLnameMatch3 OR lnameOrigFnameMatch3 OR lnameOrigLnamematch3;
								 
		nameMatch4 := fnameMatch4 OR lnameMatch4 OR fnameMatchRev4 OR lnameMatchRev4 OR 
								 fnameOrigFnameMatch4 OR fnameOrigLnameMatch4 OR lnameOrigFnameMatch4 OR lnameOrigLnamematch4;
								 
		nameMatch5 := fnameMatch5 OR lnameMatch5 OR fnameMatchRev5 OR lnameMatchRev5 OR 
								 fnameOrigFnameMatch5 OR fnameOrigLnameMatch5 OR lnameOrigFnameMatch5 OR lnameOrigLnamematch5;					 
								 
		SELF.BusExecLinkUtilityOverlapCount := IF(nameMatch1, 1, 0);
		SELF.BusExecLinkUtilityOverlapCount2 := IF(nameMatch2, 1, 0);
		SELF.BusExecLinkUtilityOverlapCount3 := IF(nameMatch3, 1, 0);
		SELF.BusExecLinkUtilityOverlapCount4 := IF(nameMatch4, 1, 0);
		SELF.BusExecLinkUtilityOverlapCount5 := IF(nameMatch5, 1, 0);
		
	END;
  
	UtilAttributes := JOIN(Shell, Util, LEFT.Seq = RIGHT.Seq, 
											getUtilAttributes(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	UtilAttributesRolled := ROLLUP(SORT(UtilAttributes, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempUtilRec,
															SELF.BusExecLinkUtilityOverlapCount := LEFT.BusExecLinkUtilityOverlapCount + RIGHT.BusExecLinkUtilityOverlapCount;
															SELF.BusExecLinkUtilityOverlapCount2 := LEFT.BusExecLinkUtilityOverlapCount2 + RIGHT.BusExecLinkUtilityOverlapCount2;
															SELF.BusExecLinkUtilityOverlapCount3 := LEFT.BusExecLinkUtilityOverlapCount3 + RIGHT.BusExecLinkUtilityOverlapCount3;
															SELF.BusExecLinkUtilityOverlapCount4 := LEFT.BusExecLinkUtilityOverlapCount4 + RIGHT.BusExecLinkUtilityOverlapCount4;
															SELF.BusExecLinkUtilityOverlapCount5 := LEFT.BusExecLinkUtilityOverlapCount5 + RIGHT.BusExecLinkUtilityOverlapCount5;
															SELF := LEFT));

	// ----- Utilities: calculate Sources child dataset. -----
	
	UtilStats := TABLE(Util,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 SourceField := MDR.SourceTools.src_Utilities,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_added_to_exchange, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Constants.MissingDate, // Utility data doesn't have a date last seen
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
       
	UtilStatsTemp := PROJECT(UtilStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.SourceField, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
                                        
	UtilStatsRolled := ROLLUP(UtilStatsTemp, LEFT.Seq = RIGHT.Seq, 
                    TRANSFORM(tempLayout, 
                      SELF.Seq := LEFT.Seq; 
                      SELF.Sources := LEFT.Sources + RIGHT.Sources; 
                      SELF := LEFT));

	// ----- Utilities: calculate NameSources, AddressVerSources, and PhoneSources child datasets. -----

		tempUtilCalc := RECORD
		UNSIGNED4 Seq;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) PhoneSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) NameSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) AddressVerSources;
		DATASET(Business_Risk_BIP.Layouts.LayoutSources) BestAddressSources;
	END;
	
	tempUtilCalc calcUtil(Business_Risk_BIP.Layouts.Shell le, Util ri) := TRANSFORM
		SELF.Seq := le.Seq;
		
		// In an effort to "short circuit" the fuzzy matching require that the first character match before doing the fuzzy comparison - this helps with latency
		NamePopulated				:= TRIM(le.Clean_Input.CompanyName) <> '' AND TRIM(ri.company_name) <> '';
		NameMatched					 := NamePopulated AND le.Clean_Input.CompanyName[1] = ri.company_name[1] AND Risk_Indicators.iid_constants.g(Business_Risk.CNameScore(le.Clean_Input.CompanyName, ri.company_name));
		
		NoScoreValue				 := 255;
		AddressPopulated	:= TRIM(le.Clean_Input.Prim_Name) <> '' AND TRIM(le.Clean_Input.Zip) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		ZIPScore						   := IF(le.Clean_Input.Zip <> '' AND ri.Zip <> '' AND le.Clean_Input.Zip[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Clean_Input.Zip, ri.Zip), NoScoreValue);
		CityStateScore			:= IF(le.Clean_Input.City <> '' AND le.Clean_Input.State <> '' AND ri.p_city_name <> '' AND ri.St <> '' AND le.Clean_Input.State[1] = ri.St[1], Risk_Indicators.AddrScore.CityState_Score(le.Clean_Input.City, le.Clean_Input.State, ri.p_city_name, ri.St, ''), NoScoreValue);
		CityStateZipMatched	:= Risk_Indicators.iid_constants.ga(ZIPScore) AND Risk_Indicators.iid_constants.ga(CityStateScore) AND AddressPopulated;
		AddressMatched			:= AddressPopulated AND Risk_Indicators.iid_constants.ga(IF(ZIPScore = NoScoreValue AND CityStateScore = NoScoreValue, NoScoreValue, 
																						Risk_Indicators.AddrScore.AddressScore(le.Clean_Input.Prim_Range, le.Clean_Input.Prim_Name, le.Clean_Input.Sec_Range, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));

		BestAddressPopulated	:= TRIM(le.Best_Info.BestPrimName) <> '' AND TRIM(le.Best_Info.BestCompanyZip) <> '' AND TRIM(ri.prim_name) <> '' AND TRIM(ri.Zip) <> '';
		BestZIPScore						   := IF(le.Best_Info.BestCompanyZip <> '' AND ri.Zip <> '' AND le.Best_Info.BestCompanyZip[1] = ri.Zip[1], Risk_Indicators.AddrScore.ZIP_Score(le.Best_Info.BestCompanyZip, ri.Zip), NoScoreValue);
		BestCityStateScore			:= IF(le.Best_Info.BestCompanyCity <> '' AND le.Best_Info.BestCompanyState <> '' AND ri.p_city_name <> '' AND ri.St <> '' AND le.Best_Info.BestCompanyState[1] = ri.St[1], Risk_Indicators.AddrScore.CityState_Score(le.Best_Info.BestCompanyCity, le.Best_Info.BestCompanyState, ri.p_city_name, ri.St, ''), NoScoreValue);
		BestCityStateZipMatched	:= Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore) AND BestAddressPopulated;
		BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(IF(BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue, NoScoreValue, 
																						Risk_Indicators.AddrScore.AddressScore(le.Best_Info.BestPrimRange, le.Best_Info.BestPrimName, le.Best_Info.BestSecRange, 
																						ri.prim_range, ri.prim_name, ri.sec_range,
																						ZIPScore, CityStateScore)));
																						
		PhonePopulated			:= TRIM(le.Clean_Input.Phone10) <> '' AND (TRIM(ri.phone) <> '' OR TRIM(ri.work_phone) <> '');
		Phone1Matched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.phone[1] OR le.Clean_Input.Phone10[4] = ri.phone[4] OR le.Clean_Input.Phone10[4] = ri.phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.phone));
		Phone2Matched				:= PhonePopulated AND (le.Clean_Input.Phone10[1] = ri.phone[1] OR le.Clean_Input.Phone10[4] = ri.work_phone[4] OR le.Clean_Input.Phone10[4] = ri.work_phone[1]) AND Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(le.Clean_Input.Phone10, ri.work_phone));
		
		PhoneMatched     := Phone1Matched OR Phone2Matched;
		
		// This is also being calculated in Business_Risk_BIP.getBusinessHeader and Business_Risk_BIP.getEDA to help boost verification, 
		// Only the levels that can be calculated with a phone match will be calculated here	
  BNAPCalc := Business_Risk_BIP.Common.calcBNAP_narrow(NameMatched, AddressMatched, PhoneMatched);

		DateFirstSeen       := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.date_first_seen, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		DateVendorFirstSeen := Business_Risk_BIP.Common.checkInvalidDate((STRING)ri.date_added_to_exchange, Business_Risk_BIP.Constants.MissingDate, le.Clean_Input.HistoryDate)[1..6];
		
		temp_Sources := DATASET([{MDR.SourceTools.src_Utilities, 
												 DateFirstSeen, 
												 DateVendorFirstSeen, 
												 Business_Risk_BIP.Constants.MissingDate, // No date last seen in Util records
												 Business_Risk_BIP.Constants.MissingDate, // No date last seen in Util records
												 1}], Business_Risk_BIP.Layouts.LayoutSources); 
												 
		SELF.PhoneSources      := IF(                                  BNAPCalc IN ['4', '5', '8'], temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));
		SELF.NameSources       := IF(Options.BusShellVersion >= 22 AND BNAPCalc IN ['5', '8']     , temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));																											
		SELF.AddressVerSources := IF(Options.BusShellVersion >= 22 AND BNAPCalc IN ['4', '8']     , temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));	
		SELF.BestAddressSources := IF(Options.BusShellVersion >= 30 AND BestAddressMatched    		, temp_Sources, DATASET([], Business_Risk_BIP.Layouts.LayoutSources));	

	END;
	
	UtilSourcesRaw := JOIN(Shell, Util, LEFT.Seq = RIGHT.Seq,
																	calcUtil(LEFT, RIGHT), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	UtilSourcesRolled := ROLLUP(SORT(UtilSourcesRaw, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(tempUtilCalc,
																			SELF.NameSources       := LEFT.NameSources + RIGHT.NameSources;
																			SELF.AddressVerSources := LEFT.AddressVerSources + RIGHT.AddressVerSources;
																			SELF.BestAddressSources := LEFT.BestAddressSources + RIGHT.BestAddressSources;
																			SELF.PhoneSources      := LEFT.PhoneSources + RIGHT.PhoneSources;
																			SELF := LEFT));
	
  // Join together the three utility datasets, and then join to the result accumulated thus far (withPhonesPlus).
  
  UtilAttrsStats := JOIN(UtilAttributesRolled, UtilStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                       SELF.seq      := LEFT.seq;
																							SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount  := (STRING)Business_Risk_BIP.Common.capNum(LEFT.BusExecLinkUtilityOverlapCount , -1, 1);
																							SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2 := (STRING)Business_Risk_BIP.Common.capNum(LEFT.BusExecLinkUtilityOverlapCount2, -1, 1);
																							SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3 := (STRING)Business_Risk_BIP.Common.capNum(LEFT.BusExecLinkUtilityOverlapCount3, -1, 1);
																							SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4 := (STRING)Business_Risk_BIP.Common.capNum(LEFT.BusExecLinkUtilityOverlapCount4, -1, 1);
																							SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5 := (STRING)Business_Risk_BIP.Common.capNum(LEFT.BusExecLinkUtilityOverlapCount5, -1, 1);																							
																							SELF.Sources  := RIGHT.Sources;
                       SELF := LEFT,
                       SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

  UtilAttrsStatsSources := JOIN(UtilAttrsStats, UtilSourcesRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                       SELF.seq                     := LEFT.seq;
                       SELF.NameSources             := RIGHT.NameSources;
                       SELF.AddressVerSources       := RIGHT.AddressVerSources;
                       SELF.BestAddresSSources			:= RIGHT.BestAddressSources;
                       SELF.PhoneSources            := RIGHT.PhoneSources;
                       SELF.Sources                 := LEFT.Sources;
                       SELF := LEFT,
                       SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
                                  
  withUtil := JOIN(withPhonesPlus, UtilAttrsStatsSources, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
                       SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount  := RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount,
                       SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2 := RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount2,
                       SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3 := RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount3,
                       SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4 := RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount4,
                       SELF.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5 := RIGHT.Business_To_Executive_Link.BusExecLinkUtilityOverlapCount5,
                       SELF.NameSources             := LEFT.NameSources + RIGHT.NameSources,
                       SELF.AddressVerSources       := LEFT.AddressVerSources + RIGHT.AddressVerSources,
                       SELF.BestAddressSources			   := RIGHT.BestAddressSources,
                       SELF.PhoneSources            := LEFT.PhoneSources + RIGHT.PhoneSources,
																							SELF.Sources                 := LEFT.Sources + RIGHT.Sources,
																							SELF := LEFT,
                       SELF := []),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	// ---------------- CALBUS - California Business ---------------------
	CalBusRaw := CalBus.Key_Calbus_LinkIDS.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(CalBusRaw, Shell, CalBusSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesCalBus := Business_Risk_BIP.Common.GrabFetchErrorCode(CalBusSeq);
	
	// Filter out records after our history date
	CalBus := Business_Risk_BIP.Common.FilterRecords(CalBusSeq, dt_first_seen, process_date, MDR.SourceTools.src_CalBus, AllowedSourcesSet);
	
	CalBusStats := TABLE(CalBus,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_CalBus,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateVendorFirstSeen :=  Business_Risk_BIP.Common.groupMinDate6(process_date, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	CalBusStatsTemp := PROJECT(CalBusStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.Source, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	CalBusStatsRolled := ROLLUP(CalBusStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF := LEFT));
	
	withCalBusStats := JOIN(withUtil, CalBusStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Get all unique NAIC Codes along with dates
	CalBusNAIC := TABLE(CalBus,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 Source := MDR.SourceTools.src_CalBus,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
			 STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 NAICCode := (STD.Str.Filter((STRING)NAICs_Code, '0123456789'))[1..6],
			 BOOLEAN IsPrimary := TRUE // There is only 1 NAIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)NAICs_Code)[1..6]
			 );
	
	CalBusNAICTemp := PROJECT(CalBusNAIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
	
	CalBusNAICRolled := ROLLUP(CalBusNAICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	
	withCalBus := JOIN(withCalBusStats, CalBusNAICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	// ---------------- Yellow Pages ---------------------
	YellowPagesRaw := YellowPages.key_yellowpages_linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(YellowPagesRaw, Shell, YellowPagesSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesYellowPages := Business_Risk_BIP.Common.GrabFetchErrorCode(YellowPagesSeq);
	
	// Filter out records after our history date
	YellowPages := Business_Risk_BIP.Common.FilterRecords(YellowPagesSeq, pub_date, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, MDR.SourceTools.src_Yellow_Pages, AllowedSourcesSet);
	
	YellowPagesStats := TABLE(YellowPages,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 MySource := MDR.SourceTools.src_Yellow_Pages,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(pub_date, HistoryDate),
			 STRING6 DateVendorFirstSeen := Business_Risk_BIP.Constants.MissingDate, //No vendor dates in YP
			 STRING6 DateLastSeen := Business_Risk_BIP.Constants.MissingDate, // This dataset doesn't contain a last seen date
			 STRING6 DateVendorLastSeen := Business_Risk_BIP.Constants.MissingDate,
			 UNSIGNED4 RecordCount := COUNT(GROUP)
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID)
			 );
	YellowPagesStatsTemp := PROJECT(YellowPagesStats, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.Sources := DATASET([{LEFT.MySource, 
																																	IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), 
																																	IF(LEFT.DateVendorFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateVendorFirstSeen), 																																	
																																	LEFT.DateLastSeen,
																																	LEFT.DateVendorLastSeen,
																																	LEFT.RecordCount}], Business_Risk_BIP.Layouts.LayoutSources);
																				SELF := []));
	YellowPagesStatsRolled := ROLLUP(YellowPagesStatsTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.Sources := LEFT.Sources + RIGHT.Sources; SELF := LEFT));
	
	withYellowPagesStats := JOIN(withCalBus, YellowPagesStatsRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Sources := LEFT.Sources + RIGHT.Sources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Get all unique NAIC Codes along with dates
	YellowPagesNAIC := TABLE(YellowPages,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 MySource := MDR.SourceTools.src_Yellow_Pages,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(pub_date, HistoryDate),
			 STRING6 DateLastSeen := (STRING)'0', // This dataset doesn't contain a last seen date
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 NAICCode := (STD.Str.Filter((STRING)NAICs_Code, '0123456789'))[1..6],
			 BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)NAICs_Code)[1..6]
			 );
	
	YellowPagesNAICTemp := PROJECT(YellowPagesNAIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.MySource, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
	
	YellowPagesNAICRolled := ROLLUP(YellowPagesNAICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	
	withYellowPagesNAIC := JOIN(withYellowPagesStats, YellowPagesNAICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	
	// Get all unique NAIC Codes along with dates
	YellowPagesSIC := TABLE(YellowPages,
			{Seq,
			 LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
			 MySource := MDR.SourceTools.src_Yellow_Pages,
			 STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(pub_date, HistoryDate),
			 STRING6 DateLastSeen := (STRING)'0', // This dataset doesn't contain a last seen date
			 UNSIGNED4 RecordCount := COUNT(GROUP),
			 STRING10 SICCode := (STD.Str.Filter((STRING)SIC_Code, '0123456789'))[1..4],
			 BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
			 },
			 Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)SIC_Code)[1..4]
			 );
	
	YellowPagesSICTemp := PROJECT(YellowPagesSIC, TRANSFORM(tempLayout,
																				SELF.Seq := LEFT.Seq;
																				SELF.SICNAICSources := DATASET([{LEFT.MySource, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
																				SELF := []));
	
	YellowPagesSICRolled := ROLLUP(YellowPagesSICTemp, LEFT.Seq = RIGHT.Seq, TRANSFORM(tempLayout, SELF.Seq := LEFT.Seq; SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; SELF := LEFT));
	
	withYellowPagesSIC := JOIN(withYellowPagesNAIC, YellowPagesSICRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	YellowPagesBestPhones := JOIN(Shell, YellowPages, LEFT.seq=RIGHT.seq, TRANSFORM({UNSIGNED seq, DATASET(Business_Risk_BIP.Layouts.LayoutBestAddrPhones) BestAddrPhones},
																				SELF.seq := LEFT.seq,
																				NoScoreValue						:= 255;
																				BestAddressPopulated		:= TRIM(LEFT.Best_Info.BestPrimName) <> '' AND TRIM(LEFT.Best_Info.BestCompanyZip) <> '' AND TRIM(RIGHT.prim_name) <> '' AND TRIM(RIGHT.zip) <> '';
																				BestZIPScore						:= IF(LEFT.Best_Info.BestCompanyZip <> '' AND RIGHT.zip <> '' AND LEFT.Best_Info.BestCompanyZip[1] = RIGHT.zip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Best_Info.BestCompanyZip, RIGHT.zip), NoScoreValue);
																				BestCityStateScore			:= IF(BestZIPScore <> NoScoreValue AND LEFT.Best_Info.BestCompanyCity <> '' AND LEFT.Best_Info.BestCompanyState <> '' AND RIGHT.p_city_name <> '' AND RIGHT.st <> '' AND LEFT.Best_Info.BestCompanyState[1] = RIGHT.st[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Best_Info.BestCompanyCity, LEFT.Best_Info.BestCompanyState, RIGHT.p_city_name, RIGHT.st, ''), NoScoreValue);
																				BestCityStateZipMatched	:= Risk_Indicators.iid_constants.ga(BestZIPScore) AND Risk_Indicators.iid_constants.ga(BestCityStateScore) AND BestAddressPopulated;
																				BestAddressMatched			:= BestAddressPopulated AND Risk_Indicators.iid_constants.ga(IF(BestZIPScore = NoScoreValue AND BestCityStateScore = NoScoreValue, NoScoreValue, 
																																										Risk_Indicators.AddrScore.AddressScore(LEFT.Best_Info.BestPrimRange, LEFT.Best_Info.BestPrimName, LEFT.Best_Info.BestSecRange, 
																																										RIGHT.prim_range, RIGHT.prim_name, RIGHT.sec_range,
																																										BestZIPScore, BestCityStateScore)));
																				SELF.BestAddrPhones := IF(Options.BusShellVersion >= Business_Risk_BIP.Constants.BusShellVersion_v30 AND BestAddressMatched AND TRIM(RIGHT.Phone10) <> '',
																				DATASET([{RIGHT.Phone10}], Business_Risk_BIP.Layouts.LayoutBestAddrPhones), DATASET([], Business_Risk_BIP.Layouts.LayoutBestAddrPhones));
																																										));
																																										
	YellowPagesBestPhonesRolled := ROLLUP(SORT(YellowPagesBestPhones, Seq), LEFT.Seq = RIGHT.Seq, TRANSFORM(RECORDOF(LEFT), 
																				SELF.Seq := LEFT.Seq; 
																				SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																				SELF := LEFT));
	
	WithYellowPages := JOIN(withYellowPagesSIC, YellowPagesBestPhonesRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.BestAddrPhones := LEFT.BestAddrPhones + RIGHT.BestAddrPhones;
																							
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);
																	
	// ---------------- PAW ---------------------
	PAWRaw := PAW.Key_LinkIDs.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell), mod_access,
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, 
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							
	Business_Risk_BIP.Common.AppendSeq2(PAWRaw, Shell, PAWSeq);
	
	// Figure out if the kFetch was successful
	kFetchErrorCodesPAW := Business_Risk_BIP.Common.GrabFetchErrorCode(PAWSeq);
	
	// Filter out records after our history date
	PAW := Business_Risk_BIP.Common.FilterRecords(PAWSeq, dt_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, Source, AllowedSourcesSet);
	
	tempPAWLayout := RECORD
		UNSIGNED4 Seq;
		STRING2 AR2BBusPAWRep1;
		STRING2 AR2BBusPAWRep2;
		STRING2 AR2BBusPAWRep3;
		STRING2 AR2BBusPAWRep4;
		STRING2 AR2BBusPAWRep5;
	END;	
	tempPAWLayout getPAWAttributes(Shell le, PAW ri) := TRANSFORM
		SELF.Seq := le.Seq,
		PAWRecordsExist := ri.Seq > 0;
		
		fname1InputPopulated := TRIM(le.Clean_Input.Rep_FirstName) <> '';
		lname1InputPopulated := TRIM(le.Clean_Input.Rep_LastName) <> '';
		fnameMatch := fname1InputPopulated AND le.Clean_Input.Rep_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep_FirstName));
		lnameMatch := lname1InputPopulated AND le.Clean_Input.Rep_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep_LastName));
		
		SELF.AR2BBusPAWRep1 := MAP(NOT fname1InputPopulated AND NOT lname1InputPopulated 									=> '-1',
															 (fname1InputPopulated OR lname1InputPopulated) AND NOT PAWRecordsExist	=> '0',
															 PAWRecordsExist AND NOT (fnameMatch AND lnameMatch)   									=> '1',
															 PAWRecordsExist AND fnameMatch AND lnameMatch				 									=> '2',
																																																				 '0');
															 
		
		fname2InputPopulated := TRIM(le.Clean_Input.Rep2_FirstName) <> '';
		lname2InputPopulated := TRIM(le.Clean_Input.Rep2_LastName) <> '';
		fnameMatch2 := fname2InputPopulated AND le.Clean_Input.Rep2_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep2_FirstName));
		lnameMatch2 := lname2InputPopulated AND le.Clean_Input.Rep2_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep2_LastName));

		SELF.AR2BBusPAWRep2 := MAP(NOT fname2InputPopulated AND NOT lname2InputPopulated 									=> '-1',
															 (fname2InputPopulated OR lname2InputPopulated) AND NOT PAWRecordsExist => '0',
															 PAWRecordsExist AND NOT (fnameMatch2 AND lnameMatch2) 									=> '1',
															 PAWRecordsExist AND fnameMatch2 AND lnameMatch2			 									=> '2',
																																																				 '0');
		fname3InputPopulated := TRIM(le.Clean_Input.Rep3_FirstName) <> '';
		lname3InputPopulated := TRIM(le.Clean_Input.Rep3_LastName) <> '';
		fnameMatch3    := fname3InputPopulated AND le.Clean_Input.Rep3_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep3_FirstName));
		lnameMatch3    := lname3InputPopulated AND le.Clean_Input.Rep3_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep3_LastName));
		
		SELF.AR2BBusPAWRep3 := MAP(NOT fname3InputPopulated AND NOT lname3InputPopulated 									=> '-1',
															 (fname3InputPopulated OR lname3InputPopulated) AND NOT PAWRecordsExist => '0',
															 PAWRecordsExist AND NOT (fnameMatch3 AND lnameMatch3) 									=> '1',
															 PAWRecordsExist AND fnameMatch3 AND lnameMatch3			 									=> '2',
																																																				 '0');		
		fname4InputPopulated := TRIM(le.Clean_Input.Rep4_FirstName) <> '';
		lname4InputPopulated := TRIM(le.Clean_Input.Rep4_LastName) <> '';
		fnameMatch4 := fname4InputPopulated AND le.Clean_Input.Rep4_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep4_FirstName));
		lnameMatch4 := lname4InputPopulated AND le.Clean_Input.Rep4_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep4_LastName));

		SELF.AR2BBusPAWRep4 := MAP(NOT fname4InputPopulated AND NOT lname4InputPopulated 									=> '-1',
															 (fname4InputPopulated OR lname4InputPopulated) AND NOT PAWRecordsExist => '0',
															 PAWRecordsExist AND NOT (fnameMatch4 AND lnameMatch4) 									=> '1',
															 PAWRecordsExist AND fnameMatch4 AND lnameMatch4			 									=> '2',
																																																				 '0');
		fname5InputPopulated := TRIM(le.Clean_Input.Rep5_FirstName) <> '';
		lname5InputPopulated := TRIM(le.Clean_Input.Rep5_LastName) <> '';
		fnameMatch5    := fname5InputPopulated AND le.Clean_Input.Rep5_FirstName[1] = ri.FName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.FNameScore(ri.FName, le.Clean_Input.Rep5_FirstName));
		lnameMatch5    := lname5InputPopulated AND le.Clean_Input.Rep5_LastName[1] = ri.LName[1] AND Risk_Indicators.iid_constants.g(Risk_Indicators.LNameScore(ri.LName, le.Clean_Input.Rep5_LastName));
		
		SELF.AR2BBusPAWRep5 := MAP(NOT fname5InputPopulated AND NOT lname5InputPopulated 									=> '-1',
															 (fname5InputPopulated OR lname5InputPopulated) AND NOT PAWRecordsExist => '0',
															 PAWRecordsExist AND NOT (fnameMatch5 AND lnameMatch5) 									=> '1',
															 PAWRecordsExist AND fnameMatch5 AND lnameMatch5			 									=> '2',
																																																				 '0');																																																			 
																																																				 
																																																				 
  END;
	
	PAWAttributes := JOIN(Shell, PAW, LEFT.Seq = RIGHT.Seq, 
												getPAWAttributes(LEFT,RIGHT), LEFT OUTER, ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	
	
	PAWAttributesRolled := ROLLUP(SORT(PAWAttributes, Seq), LEFT.Seq = RIGHT.Seq,
												TRANSFORM(TempPAWLayout,
																	SELF.Seq := LEFT.Seq,
																	SELF.AR2BBusPAWRep1 := (STRING)MAX((INTEGER)LEFT.AR2BBusPAWRep1, (INTEGER)RIGHT.AR2BBusPAWRep1),
																	SELF.AR2BBusPAWRep2 := (STRING)MAX((INTEGER)LEFT.AR2BBusPAWRep2, (INTEGER)RIGHT.AR2BBusPAWRep2),
																	SELF.AR2BBusPAWRep3 := (STRING)MAX((INTEGER)LEFT.AR2BBusPAWRep3, (INTEGER)RIGHT.AR2BBusPAWRep3);
																	SELF.AR2BBusPAWRep4 := (STRING)MAX((INTEGER)LEFT.AR2BBusPAWRep4, (INTEGER)RIGHT.AR2BBusPAWRep4),
																	SELF.AR2BBusPAWRep5 := (STRING)MAX((INTEGER)LEFT.AR2BBusPAWRep5, (INTEGER)RIGHT.AR2BBusPAWRep5)));
																	
	
	withPAWAttributes := IF(Options.BusShellVersion <= Business_Risk_BIP.Constants.BusShellVersion_v21, withYellowPages,
												JOIN(withYellowPages, PAWAttributesRolled, LEFT.Seq = RIGHT.Seq,
												  TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																	 SELF.Business_To_Executive_Link.AR2BBusPAWRep1 := RIGHT.AR2BBusPAWRep1,
																	 SELF.Business_To_Executive_Link.AR2BBusPAWRep2 := RIGHT.AR2BBusPAWRep2,
																	 SELF.Business_To_Executive_Link.AR2BBusPAWRep3 := RIGHT.AR2BBusPAWRep3,
																	 SELF.Business_To_Executive_Link.AR2BBusPAWRep4 := RIGHT.AR2BBusPAWRep4,
																	 SELF.Business_To_Executive_Link.AR2BBusPAWRep5 := RIGHT.AR2BBusPAWRep5,																	 
																	 SELF := LEFT),
													LEFT OUTER, KEEP(1), ATMOST(100), FEW));

	// ---------------- DataBridge ------------------

  dataBridge_raw := dx_DataBridge.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
                                                        mod_access,
                                                        Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                                        0, /*ScoreThreshold --> 0 = Give me everything*/
																												Business_Risk_BIP.Constants.Limit_Default,
                                                        Options.KeepLargeBusinesses);

	Business_Risk_BIP.Common.AppendSeq(dataBridge_raw, Shell, dataBridge_seq, Options.LinkSearchLevel);
	
	// kFetchErrorCodesDataBridge := Business_Risk_BIP.Common.GrabFetchErrorCode(dataBridge_seq);
	
	dataBridge := Business_Risk_BIP.Common.FilterRecords(dataBridge_seq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_DataBridge, AllowedSourcesSet);

  // Get all unique SIC Codes along with dates. For this data source, we only need the primary code.
  dataBridgeSIC := TABLE(dataBridge,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
      STRING2 Source := MDR.SourceTools.src_DataBridge,
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6( IF( dt_first_seen = 0, dt_vendor_first_reported, dt_first_seen ), HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6( IF( dt_last_seen = 0, dt_vendor_last_reported, dt_last_seen ), HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 SICCode := (STD.Str.Filter((STRING)sic8_1, '0123456789'))[1..4],
      BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)sic8_1)[1..4]
  );

  dataBridgeSICTemp := 
    PROJECT(
      dataBridgeSIC, 
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  dataBridgeSICRolled := 
    ROLLUP(
      dataBridgeSICTemp, 
      LEFT.Seq = RIGHT.Seq, 
      TRANSFORM( tempLayout, 
        SELF.Seq := LEFT.Seq; 
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; 
        SELF := LEFT
      )
    );

  withDataBridge := 
    JOIN(withPAWAttributes, dataBridgeSICRolled, 
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );
 
  
	// ---------------- TXBus ------------------																												
	TXBus_raw := TXBUS.Key_TXBUS_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
																						 Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
																							0, /*ScoreThreshold --> 0 = Give me everything*/
																							Business_Risk_BIP.Constants.Limit_Default,
																							Options.KeepLargeBusinesses);
																							

	Business_Risk_BIP.Common.AppendSeq(TXBus_raw, Shell, TXBus_seq, Options.LinkSearchLevel);
	
	// kFetchErrorCodesDataBridge := Business_Risk_BIP.Common.GrabFetchErrorCode(TXBus_seq);
	
	TXBus := Business_Risk_BIP.Common.FilterRecords(TXBus_seq, dt_first_seen, 0, MDR.SourceTools.src_TXBUS, AllowedSourcesSet);

  // Get all unique NAIC Codes along with dates. For this data source, we only need the primary code.
  TXBusNAIC := TABLE(TXBus,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
      STRING2 Source := MDR.SourceTools.src_TXBUS,
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(dt_first_seen, HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(dt_last_seen, HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 NAICCode := (STD.Str.Filter((STRING)outlet_naics_code, '0123456789'))[1..6],
      BOOLEAN IsPrimary := TRUE
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)outlet_naics_code)[1..6]
  );

  TXBusNAICTemp := 
    PROJECT(
      TXBusNAIC, 
      TRANSFORM(tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, '' /*SICCode*/, '' /*SICIndustry*/, LEFT.NAICCode, Business_Risk_BIP.Common.industryGroup(LEFT.NAICCode, Business_Risk_BIP.Constants.NAIC), LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  TXBusNAICRolled := 
    ROLLUP(
      TXBusNAICTemp, 
      LEFT.Seq = RIGHT.Seq, 
      TRANSFORM( tempLayout, 
        SELF.Seq := LEFT.Seq; 
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; 
        SELF := LEFT
      )
    );

  withTXBusNAIC := 
    JOIN(withDataBridge, TXBusNAICRolled, 
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );

	// ---------------- Frandx ------------------

  Frandx_raw := Frandx.Key_Linkids.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
                                                        Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                                        0, // ScoreThreshold --> 0 = Give me everything
																												Business_Risk_BIP.Constants.Limit_Default,
																												Options.KeepLargeBusinesses);
																																																				

	Business_Risk_BIP.Common.AppendSeq(Frandx_raw, Shell, Frandx_seq, Options.LinkSearchLevel);
	
	// kFetchErrorCodesDataBridge := Business_Risk_BIP.Common.GrabFetchErrorCode(Frandx_seq);
	
	Frandx := Business_Risk_BIP.Common.FilterRecords(Frandx_seq, dt_first_seen, dt_vendor_first_reported, MDR.SourceTools.src_Frandx, AllowedSourcesSet);

  // Get all unique SIC Codes along with dates. For this data source, we only need the primary code.
  FrandxSIC := TABLE(Frandx,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
      STRING2 Source := MDR.SourceTools.src_Frandx,
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6( IF( dt_first_seen = 0, dt_vendor_first_reported, dt_first_seen ), HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6( IF( dt_last_seen = 0, dt_vendor_last_reported, dt_last_seen ), HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 SICCode := (STD.Str.Filter((STRING)sic_code, '0123456789'))[1..4],
      BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)sic_code)[1..4]
  );

  FrandxSICTemp := 
    PROJECT(
      FrandxSIC, 
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  FrandxSICRolled := 
    ROLLUP(
      FrandxSICTemp, 
      LEFT.Seq = RIGHT.Seq, 
      TRANSFORM( tempLayout, 
        SELF.Seq := LEFT.Seq; 
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; 
        SELF := LEFT
      )
    );

  withFrandxSIC := 
    JOIN(withTXBusNAIC, FrandxSICRolled, 
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );

	// ---------------- DNB FEIN ------------------

  DNBFEIN_raw := DNB_FEINV2.Key_LinkIds.kFetch2(Business_Risk_BIP.Common.GetLinkIDs(Shell),
                                                Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                                0, // ScoreThreshold --> 0 = Give me everything
                                                Business_Risk_BIP.Constants.Limit_Default,
																								Options.KeepLargeBusinesses);

	Business_Risk_BIP.Common.AppendSeq(DNBFEIN_raw, Shell, DNBFEIN_seq, Options.LinkSearchLevel);
	
	// kFetchErrorCodesDataBridge := Business_Risk_BIP.Common.GrabFetchErrorCode(Frandx_seq);
	
	DNBFEIN := Business_Risk_BIP.Common.FilterRecords(DNBFEIN_seq, date_first_seen, date_vendor_first_reported, MDR.SourceTools.src_Frandx, AllowedSourcesSet);

  // Get all unique SIC Codes along with dates. For this data source, we only need the primary code.
  DNBFEIN_SIC := TABLE(DNBFEIN,
    {
      Seq,
      LinkID := Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID),
      STRING2 Source := MDR.SourceTools.src_Dunn_Bradstreet_Fein,
      STRING6 DateFirstSeen := Business_Risk_BIP.Common.groupMinDate6(date_first_seen, HistoryDate),
      STRING6 DateLastSeen := Business_Risk_BIP.Common.groupMaxDate6(date_last_seen, HistoryDate),
      UNSIGNED4 RecordCount := COUNT(GROUP),
      STRING10 SICCode := (STD.Str.Filter((STRING)sic_code, '0123456789'))[1..4],
      BOOLEAN IsPrimary := TRUE // There is only 1 SIC field on this source, mark it as primary
    },
    Seq, Business_Risk_BIP.Common.GetLinkSearchLevel(Options.LinkSearchLevel, SeleID), ((STRING)sic_code)[1..4]
  );

  DNBFEIN_SIC_Temp := 
    PROJECT(
      DNBFEIN_SIC, 
      TRANSFORM( tempLayout,
        SELF.Seq := LEFT.Seq;
        SELF.SICNAICSources := DATASET([{LEFT.Source, IF(LEFT.DateFirstSeen = Business_Risk_BIP.Constants.NinesDate, Business_Risk_BIP.Constants.MissingDate, LEFT.DateFirstSeen), LEFT.DateLastSeen, LEFT.RecordCount, LEFT.SICCode, Business_Risk_BIP.Common.industryGroup(LEFT.SICCode, Business_Risk_BIP.Constants.SIC), '' /*NAICCode*/, '' /*NAICIndustry*/, LEFT.IsPrimary}], Business_Risk_BIP.Layouts.LayoutSICNAIC);
        SELF := []
      )
    );

  DNBFEIN_SIC_Rolled := 
    ROLLUP(
      DNBFEIN_SIC_Temp, 
      LEFT.Seq = RIGHT.Seq, 
      TRANSFORM( tempLayout, 
        SELF.Seq := LEFT.Seq; 
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources; 
        SELF := LEFT
      )
    );

  withDNBFEIN_SIC := 
    JOIN(withFrandxSIC, DNBFEIN_SIC_Rolled, 
      LEFT.Seq = RIGHT.Seq,
      TRANSFORM( Business_Risk_BIP.Layouts.Shell,
        SELF.SICNAICSources := LEFT.SICNAICSources + RIGHT.SICNAICSources;
        SELF := LEFT
      ),
      LEFT OUTER, KEEP(1), ATMOST(100), FEW
    );

 
	//------------ Get Error Codes --------------
	withErrorCodesBBBMember := JOIN(withDNBFEIN_SIC, kFetchErrorCodesBBBMember, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeBBBMember := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesBBBNonMember := JOIN(withErrorCodesBBBMember, kFetchErrorCodesBBBNonMember, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeBBBNonMember := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesFBN := JOIN(withErrorCodesBBBNonMember, kFetchErrorCodesFBN, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeFBN := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesIRSNonProfit := JOIN(withErrorCodesFBN, kFetchErrorCodesIRSNonProfit, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeIRSNonProfit := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesIRSRetirement := JOIN(withErrorCodesIRSNonProfit, kFetchErrorCodesIRSRetirement, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeIRSRetirement := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesUtility := JOIN(withErrorCodesIRSRetirement, kFetchErrorCodesUtility, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeUtility := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);
	
	withErrorCodesCalBus := JOIN(withErrorCodesUtility, kFetchErrorCodesCalBus, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeCalBus := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

	withErrorCodesYellowPages := JOIN(withErrorCodesCalBus, kFetchErrorCodesYellowPages, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Data_Fetch_Indicators.FetchCodeYellowPages := (STRING)RIGHT.Fetch_Error_Code;
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), PARALLEL, FEW);

  // *********************
  //   DEBUGGING OUTPUTS
  // *********************
  // OUTPUT(CHOOSEN(BBBMemberRaw, 100), NAMED('Sample_BBBMemberRaw'));
  // OUTPUT(CHOOSEN(BBBNonMemberRaw, 100), NAMED('Sample_BBBNonMemberRaw'));
  // OUTPUT(CHOOSEN(BBBMember, 100), NAMED('Sample_BBBMember'));
  // OUTPUT(CHOOSEN(BBBNonMember, 100), NAMED('Sample_BBBNonMember'));
  // OUTPUT(CHOOSEN(BBBMemberStats, 100), NAMED('Sample_BBBMemberStats'));
  // OUTPUT(CHOOSEN(BBBNonMemberStats, 100), NAMED('Sample_BBBNonMemberStats'));
  // OUTPUT(CHOOSEN(BBBStatsTemp, 100), NAMED('Sample_BBBStatsTemp'));
  // OUTPUT(CHOOSEN(withBBB, 100), NAMED('Sample_withBBB'));
  // OUTPUT(CHOOSEN(FBNRaw, 100), NAMED('Sample_FBNRaw'));
  // OUTPUT(CHOOSEN(FBN, 100), NAMED('Sample_FBN'));
  // OUTPUT(CHOOSEN(FBNStatsTemp, 100), NAMED('Sample_FBNStatsTemp'));
  // OUTPUT(CHOOSEN(withFBN, 100), NAMED('Sample_withFBN'));
  // OUTPUT(CHOOSEN(IRS990, 100), NAMED('Sample_IRS990'));
  // OUTPUT(CHOOSEN(SortTaxIRS990, 100), NAMED('Sample_SortTaxIRS990'));
  // OUTPUT(CHOOSEN(IRS990Raw, 100), NAMED('Sample_IRS990Raw'));
  // OUTPUT(CHOOSEN(IRS990Stats, 100), NAMED('Sample_IRS990Stats'));
  // OUTPUT(CHOOSEN(IRS990StatsTemp, 100), NAMED('Sample_IRS990StatsTemp'));
  // OUTPUT(CHOOSEN(IRS990StatsRolled, 100), NAMED('Sample_IRS990StatsRolled'));
  // OUTPUT(CHOOSEN(IRS5500Raw, 100), NAMED('Sample_IRS5500Raw'));
  // OUTPUT(CHOOSEN(IRS5500, 100), NAMED('Sample_IRS5500'));
  // OUTPUT(CHOOSEN(IRS5500Sort, 100), NAMED('Sample_IRS5500Sort'));
  // OUTPUT(CHOOSEN(withIRS5500, 100), NAMED('Sample_withIRS5500'));
  // OUTPUT( Util, NAMED('Util'), ALL );
  // OUTPUT( UtilSourcesRaw, NAMED('UtilSourcesRaw') );
  // OUTPUT( UtilSourcesRolled, NAMED('UtilSourcesRolled') );
  // OUTPUT( UtilAttrsStats, NAMED('UtilAttrsStats') );
  // OUTPUT( UtilAttrsStatsSources, NAMED('UtilAttrsStatsSources') );
  // OUTPUT( withUtil, NAMED('withUtil') );
	
	RETURN withErrorCodesYellowPages;
END;