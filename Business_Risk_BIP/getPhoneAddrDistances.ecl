IMPORT Business_Risk_BIP, BIPV2, Gateway, Risk_Indicators, RiskWise, UT;

EXPORT getPhoneAddrDistances(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
												 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	TempPhoneDistanceLayout := RECORD
		UNSIGNED4 Seq;
		BOOLEAN BestBusinessPhoneMatched;
		BOOLEAN BusinessPhoneMatched;
		BOOLEAN Rep1PhoneMatched;
		BOOLEAN Rep2PhoneMatched;
		BOOLEAN Rep3PhoneMatched;
		BOOLEAN Rep4PhoneMatched;
		BOOLEAN Rep5PhoneMatched;
		STRING10 BestBusPhoneLat;
		STRING11 BestBusPhoneLong;
		STRING10 BusPhoneLat;
		STRING11 BusPhoneLong;
		STRING10 BusPhonePrimRange;
		STRING28 BusPhonePrimName;
		STRING8 BusPhoneSecRange;
		STRING5 BusPhoneZip;
		STRING2 BusPhoneSt;
		STRING25 BusPhoneCity;
		STRING10 Rep1PhoneLat;
		STRING11 Rep1PhoneLong;
		STRING10 Rep2PhoneLat;
		STRING11 Rep2PhoneLong;
		STRING10 Rep3PhoneLat;
		STRING11 Rep3PhoneLong;
		STRING10 Rep4PhoneLat;
		STRING11 Rep4PhoneLong;
		STRING10 Rep5PhoneLat;
		STRING11 Rep5PhoneLong;
	END;

	BestBusPhonePrep := PROJECT(Shell((INTEGER)PhoneAddressDistances.BestBusinessPhone > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.PhoneAddressDistances.BestBusinessPhone,
																							SELF := []));

	BusPhonePrep := PROJECT(Shell((INTEGER)Clean_Input.Phone10 > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.Clean_Input.Phone10,
																							SELF := []));

	Rep1PhonePrep := PROJECT(Shell((INTEGER)Clean_Input.Rep_Phone10 > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.Clean_Input.Rep_Phone10,
																							SELF := []));

	Rep2PhonePrep := PROJECT(Shell((INTEGER)Clean_Input.Rep2_Phone10 > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.Clean_Input.Rep2_Phone10,
																							SELF := []));

	Rep3PhonePrep := PROJECT(Shell((INTEGER)Clean_Input.Rep3_Phone10 > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.Clean_Input.Rep3_Phone10,
																							SELF := []));

	Rep4PhonePrep := PROJECT(Shell((INTEGER)Clean_Input.Rep4_Phone10 > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.Clean_Input.Rep4_Phone10,
																							SELF := []));

	Rep5PhonePrep := PROJECT(Shell((INTEGER)Clean_Input.Rep5_Phone10 > 0),
																	TRANSFORM(Risk_Indicators.Layouts.Layout_Input_Plus_Overrides,
																							SELF.Seq := LEFT.Seq,
																							SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																							SELF.HistoryDateTimeStamp := (STRING)LEFT.Clean_Input.HistoryDateTime,
																							SELF.Phone10 := LEFT.Clean_Input.Rep5_Phone10,
																							SELF := []));

	PhonePrep := BestBusPhonePrep + BusPhonePrep + Rep1PhonePrep + Rep2PhonePrep + Rep3PhonePrep + Rep4PhonePrep + Rep5PhonePrep;

	DirsByPhone := RiskWise.getDirsByPhone(PhonePrep, Gateway.Constants.void_gateway, Options.dppa, Options.glb, isFCRA := FALSE, BSOptions:=0, lastSeenThreshold:=risk_indicators.iid_constants.oneyear,
											ExactMatchLevel:=risk_indicators.iid_constants.default_ExactMatchLevel, companyID:='');

	DirsByPhoneDD := DEDUP(SORT(DirsByPhone, Phone10, -dt_last_seen, RECORD), Phone10);


	TempPhoneDistanceLayout getPhoneInfo(Shell le, DirsByPhone ri) := TRANSFORM
		SELF.Seq := le.Seq;
		BestBusinessPhoneMatched := le.PhoneAddressDistances.BestBusinessPhone = ri.Phone10 AND (INTEGER)le.PhoneAddressDistances.BestBusinessPhone > 0;
		SELF.BestBusinessPhoneMatched := BestBusinessPhoneMatched;
		BusinessPhoneMatched := le.Clean_Input.Phone10 = ri.Phone10 AND (INTEGER)le.Clean_Input.Phone10 > 0;
		SELF.BusinessPhoneMatched := BusinessPhoneMatched;
		Rep1PhoneMatched := le.Clean_Input.Rep_Phone10 = ri.Phone10 AND (INTEGER)le.Clean_Input.Rep_Phone10 > 0;
		SELF.Rep1PhoneMatched := Rep1PhoneMatched;
		Rep2PhoneMatched := le.Clean_Input.Rep2_Phone10 = ri.Phone10 AND (INTEGER)le.Clean_Input.Rep2_Phone10 > 0;
		SELF.Rep2PhoneMatched := Rep2PhoneMatched;
		Rep3PhoneMatched := le.Clean_Input.Rep3_Phone10 = ri.Phone10 AND (INTEGER)le.Clean_Input.Rep3_Phone10 > 0;
		SELF.Rep3PhoneMatched := Rep3PhoneMatched;
		Rep4PhoneMatched := le.Clean_Input.Rep4_Phone10 = ri.Phone10 AND (INTEGER)le.Clean_Input.Rep4_Phone10 > 0;
		SELF.Rep4PhoneMatched := Rep4PhoneMatched;
		Rep5PhoneMatched := le.Clean_Input.Rep5_Phone10 = ri.Phone10 AND (INTEGER)le.Clean_Input.Rep5_Phone10 > 0;
		SELF.Rep5PhoneMatched := Rep5PhoneMatched;

		SELF.BestBusPhoneLat := IF(BestBusinessPhoneMatched, ri.Geo_Lat, '');
		SELF.BestBusPhoneLong := IF(BestBusinessPhoneMatched, ri.Geo_Long, '');
		SELF.BusPhoneLat := IF(BusinessPhoneMatched, ri.Geo_Lat, '');
		SELF.BusPhoneLong := IF(BusinessPhoneMatched, ri.Geo_Long, '');

		SELF.BusPhonePrimRange := IF(BusinessPhoneMatched, ri.Prim_Range, '');
		SELF.BusPhonePrimName := IF(BusinessPhoneMatched, ri.Prim_Name, '');
		SELF.BusPhoneSecRange := IF(BusinessPhoneMatched, ri.Sec_Range, '');
		SELF.BusPhoneZip := IF(BusinessPhoneMatched, ri.Z5, '');
		SELF.BusPhoneSt := IF(BusinessPhoneMatched, ri.St, '');
		SELF.BusPhoneCity := IF(BusinessPhoneMatched, ri.P_City_Name, '');

		SELF.Rep1PhoneLat := IF(Rep1PhoneMatched, ri.Geo_Lat, '');
		SELF.Rep1PhoneLong := IF(Rep1PhoneMatched, ri.Geo_Long, '');
		SELF.Rep2PhoneLat := IF(Rep2PhoneMatched, ri.Geo_Lat, '');
		SELF.Rep2PhoneLong := IF(Rep2PhoneMatched, ri.Geo_Long, '');
		SELF.Rep3PhoneLat := IF(Rep3PhoneMatched, ri.Geo_Lat, '');
		SELF.Rep3PhoneLong := IF(Rep3PhoneMatched, ri.Geo_Long, '');
		SELF.Rep4PhoneLat := IF(Rep4PhoneMatched, ri.Geo_Lat, '');
		SELF.Rep4PhoneLong := IF(Rep4PhoneMatched, ri.Geo_Long, '');
		SELF.Rep5PhoneLat := IF(Rep5PhoneMatched, ri.Geo_Lat, '');
		SELF.Rep5PhoneLong := IF(Rep5PhoneMatched, ri.Geo_Long, '');
	END;

	DirsByPhoneSlim := JOIN(Shell, DirsByPhoneDD, (LEFT.Clean_Input.Phone10 = RIGHT.Phone10 OR
																	LEFT.PhoneAddressDistances.BestBusinessPhone = RIGHT.Phone10 OR
																	LEFT.Clean_Input.Rep_Phone10 = RIGHT.Phone10 OR
																	LEFT.Clean_Input.Rep2_Phone10 = RIGHT.Phone10 OR
																	LEFT.Clean_Input.Rep3_Phone10 = RIGHT.Phone10 OR
																	LEFT.Clean_Input.Rep4_Phone10 = RIGHT.Phone10 OR
																	LEFT.Clean_Input.Rep5_Phone10 = RIGHT.Phone10) AND (INTEGER)RIGHT.Phone10 > 0,
																	getPhoneInfo(LEFT, RIGHT),
																	ALL/*, LIMIT(100)*/);

	DirsByPhoneRolled := ROLLUP(SORT(DirsByPhoneSlim, Seq), LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(TempPhoneDistanceLayout,
																							SELF.Seq := LEFT.Seq,
																							SELF.BestBusPhoneLat := IF(LEFT.BestBusinessPhoneMatched, LEFT.BestBusPhoneLat, RIGHT.BestBusPhoneLat);
																							SELF.BestBusPhoneLong := IF(LEFT.BestBusinessPhoneMatched, LEFT.BestBusPhoneLong, RIGHT.BestBusPhoneLong);
																							SELF.BusPhoneLat := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhoneLat, RIGHT.BusPhoneLat);
																							SELF.BusPhoneLong := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhoneLong, RIGHT.BusPhoneLong);

																							SELF.BusPhonePrimRange := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhonePrimRange, RIGHT.BusPhonePrimRange);
																							SELF.BusPhonePrimName := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhonePrimName, RIGHT.BusPhonePrimName);
																							SELF.BusPhoneSecRange := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhoneSecRange, RIGHT.BusPhoneSecRange);
																							SELF.BusPhoneZip := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhoneZip, RIGHT.BusPhoneZip);
																							SELF.BusPhoneSt := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhoneSt, RIGHT.BusPhoneSt);
																							SELF.BusPhoneCity := IF(LEFT.BusinessPhoneMatched, LEFT.BusPhoneCity, RIGHT.BusPhoneCity);

																							SELF.Rep1PhoneLat := IF(LEFT.Rep1PhoneMatched, LEFT.Rep1PhoneLat, RIGHT.Rep1PhoneLat);
																							SELF.Rep1PhoneLong := IF(LEFT.Rep1PhoneMatched, LEFT.Rep1PhoneLong, RIGHT.Rep1PhoneLong);
																							SELF.Rep2PhoneLat := IF(LEFT.Rep2PhoneMatched, LEFT.Rep2PhoneLat, RIGHT.Rep2PhoneLat);
																							SELF.Rep2PhoneLong := IF(LEFT.Rep2PhoneMatched, LEFT.Rep2PhoneLong, RIGHT.Rep2PhoneLong);
																							SELF.Rep3PhoneLat := IF(LEFT.Rep3PhoneMatched, LEFT.Rep3PhoneLat, RIGHT.Rep3PhoneLat);
																							SELF.Rep3PhoneLong := IF(LEFT.Rep3PhoneMatched, LEFT.Rep3PhoneLong, RIGHT.Rep3PhoneLong);
																							SELF.Rep4PhoneLat := IF(LEFT.Rep4PhoneMatched, LEFT.Rep4PhoneLat, RIGHT.Rep4PhoneLat);
																							SELF.Rep4PhoneLong := IF(LEFT.Rep4PhoneMatched, LEFT.Rep4PhoneLong, RIGHT.Rep4PhoneLong);
																							SELF.Rep5PhoneLat := IF(LEFT.Rep5PhoneMatched, LEFT.Rep5PhoneLat, RIGHT.Rep5PhoneLat);
																							SELF.Rep5PhoneLong := IF(LEFT.Rep5PhoneMatched, LEFT.Rep5PhoneLong, RIGHT.Rep5PhoneLong);

																							SELF.BestBusinessPhoneMatched := LEFT.BestBusinessPhoneMatched OR RIGHT.BestBusinessPhoneMatched;
																							SELF.BusinessPhoneMatched := LEFT.BusinessPhoneMatched OR RIGHT.BusinessPhoneMatched;
																							SELF.Rep1PhoneMatched := LEFT.Rep1PhoneMatched OR RIGHT.Rep1PhoneMatched;
																							SELF.Rep2PhoneMatched := LEFT.Rep2PhoneMatched OR RIGHT.Rep2PhoneMatched;
																							SELF.Rep3PhoneMatched := LEFT.Rep3PhoneMatched OR RIGHT.Rep3PhoneMatched;
																							SELF.Rep4PhoneMatched := LEFT.Rep4PhoneMatched OR RIGHT.Rep4PhoneMatched;
																							SELF.Rep5PhoneMatched := LEFT.Rep5PhoneMatched OR RIGHT.Rep5PhoneMatched;
																							SELF := []));


	WithDirsByPhone := JOIN(Shell, DirsByPhoneRolled, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							BestBusinessAddrPopulated := TRIM(LEFT.PhoneAddressDistances.BestBusinessPrimName) <> '' AND TRIM(LEFT.PhoneAddressDistances.BestBusinessZip) <> '';
																							BestBusinessAddrLLPopulated := TRIM(LEFT.PhoneAddressDistances.BestBusinessLat) <> '' AND TRIM(LEFT.PhoneAddressDistances.BestBusinessLong) <> '';

																							BestBusinessPhoneLLPopulated := TRIM(RIGHT.BestBusPhoneLat) <> '' AND TRIM(RIGHT.BestBusPhoneLong) <> '';
																							BusinessPhoneLLPopulated := TRIM(RIGHT.BusPhoneLat) <> '' AND TRIM(RIGHT.BusPhoneLong) <> '';
																							Rep1PhoneLLPopulated := TRIM(RIGHT.Rep1PhoneLat) <> '' AND TRIM(RIGHT.Rep1PhoneLong) <> '';
																							Rep2PhoneLLPopulated := TRIM(RIGHT.Rep2PhoneLat) <> '' AND TRIM(RIGHT.Rep2PhoneLong) <> '';
																							Rep3PhoneLLPopulated := TRIM(RIGHT.Rep3PhoneLat) <> '' AND TRIM(RIGHT.Rep3PhoneLong) <> '';
																							Rep4PhoneLLPopulated := TRIM(RIGHT.Rep4PhoneLat) <> '' AND TRIM(RIGHT.Rep4PhoneLong) <> '';
																							Rep5PhoneLLPopulated := TRIM(RIGHT.Rep5PhoneLat) <> '' AND TRIM(RIGHT.Rep5PhoneLong) <> '';

																							Rep1PhoneMatchesBestBusiness := (INTEGER)LEFT.Clean_Input.Rep_Phone10 > 0 AND (INTEGER)LEFT.PhoneAddressDistances.BestBusinessPhone > 0 AND
																																							Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep_Phone10, LEFT.PhoneAddressDistances.BestBusinessPhone));
																							Rep2PhoneMatchesBestBusiness := (INTEGER)LEFT.Clean_Input.Rep2_Phone10 > 0 AND (INTEGER)LEFT.PhoneAddressDistances.BestBusinessPhone > 0 AND
																																							Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep2_Phone10, LEFT.PhoneAddressDistances.BestBusinessPhone));
																							Rep3PhoneMatchesBestBusiness := (INTEGER)LEFT.Clean_Input.Rep3_Phone10 > 0 AND (INTEGER)LEFT.PhoneAddressDistances.BestBusinessPhone > 0 AND
																																							Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep3_Phone10, LEFT.PhoneAddressDistances.BestBusinessPhone));
																							Rep4PhoneMatchesBestBusiness := (INTEGER)LEFT.Clean_Input.Rep4_Phone10 > 0 AND (INTEGER)LEFT.PhoneAddressDistances.BestBusinessPhone > 0 AND
																																							Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep4_Phone10, LEFT.PhoneAddressDistances.BestBusinessPhone));
																							Rep5PhoneMatchesBestBusiness := (INTEGER)LEFT.Clean_Input.Rep5_Phone10 > 0 AND (INTEGER)LEFT.PhoneAddressDistances.BestBusinessPhone > 0 AND
																																							Risk_Indicators.iid_constants.gn(Risk_Indicators.PhoneScore(LEFT.Clean_Input.Rep5_Phone10, LEFT.PhoneAddressDistances.BestBusinessPhone));


																							Rep1BusPhoneDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.LL_Dist((REAL)RIGHT.BestBusPhoneLat, (REAL)RIGHT.BestBusPhoneLong, (REAL)RIGHT.Rep1PhoneLat, (REAL)RIGHT.Rep1PhoneLong)), 1, 999999);
																							Rep2BusPhoneDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.LL_Dist((REAL)RIGHT.BestBusPhoneLat, (REAL)RIGHT.BestBusPhoneLong, (REAL)RIGHT.Rep2PhoneLat, (REAL)RIGHT.Rep2PhoneLong)), 1, 999999);
																							Rep3BusPhoneDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.LL_Dist((REAL)RIGHT.BestBusPhoneLat, (REAL)RIGHT.BestBusPhoneLong, (REAL)RIGHT.Rep3PhoneLat, (REAL)RIGHT.Rep3PhoneLong)), 1, 999999);
																							Rep4BusPhoneDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.LL_Dist((REAL)RIGHT.BestBusPhoneLat, (REAL)RIGHT.BestBusPhoneLong, (REAL)RIGHT.Rep4PhoneLat, (REAL)RIGHT.Rep4PhoneLong)), 1, 999999);
																							Rep5BusPhoneDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.LL_Dist((REAL)RIGHT.BestBusPhoneLat, (REAL)RIGHT.BestBusPhoneLong, (REAL)RIGHT.Rep5PhoneLat, (REAL)RIGHT.Rep5PhoneLong)), 1, 999999);

																							PhoneDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.LL_Dist((REAL)LEFT.PhoneAddressDistances.BestBusinessLat, (REAL)LEFT.PhoneAddressDistances.BestBusinessLong, (REAL)RIGHT.BusPhoneLat, (REAL)RIGHT.BusPhoneLong)), 1, 999999);

																							NoScoreValue := 255;
																							BusZIPScore := IF(RIGHT.BusPhoneZip <> '' AND LEFT.PhoneAddressDistances.BestBusinessZip <> '' AND RIGHT.BusPhoneZip[1] = LEFT.PhoneAddressDistances.BestBusinessZip[1], Risk_Indicators.AddrScore.ZIP_Score(RIGHT.BusPhoneZip, LEFT.PhoneAddressDistances.BestBusinessZip), NoScoreValue);
																							BusCityStateScore		:= IF(RIGHT.BusPhoneCity <> '' AND RIGHT.BusPhoneSt <> '' AND LEFT.PhoneAddressDistances.BestBusinessCity <> '' AND LEFT.PhoneAddressDistances.BestBusinessSt <> '' AND RIGHT.BusPhoneSt[1] = LEFT.PhoneAddressDistances.BestBusinessSt[1], Risk_Indicators.AddrScore.CityState_Score(RIGHT.BusPhoneCity, RIGHT.BusPhoneSt, LEFT.PhoneAddressDistances.BestBusinessCity, LEFT.PhoneAddressDistances.BestBusinessSt, ''), NoScoreValue);
																							BusCityStateZipMatched := Risk_Indicators.iid_constants.ga(BusZIPScore) AND Risk_Indicators.iid_constants.ga(BusCityStateScore);
																							BusPhoneBestAddrMatched := Risk_Indicators.iid_constants.ga(IF(BusZIPScore = NoScoreValue AND BusCityStateScore = NoScoreValue, NoScoreValue,
																										Risk_Indicators.AddrScore.AddressScore(RIGHT.BusPhonePrimRange, RIGHT.BusPhonePrimName, RIGHT.BusPhoneSecRange,
																											LEFT.PhoneAddressDistances.BestBusinessPrimRange, LEFT.PhoneAddressDistances.BestBusinessPrimName, LEFT.PhoneAddressDistances.BestBusinessSecRange,
																											BusZIPScore, BusCityStateScore)));

																							SELF.Verification.PhoneDistance := MAP(NOT BestBusinessAddrLLPopulated OR NOT BusinessPhoneLLPopulated => '-1', 			// No addresses found for business or input business phone
																																										 BusPhoneBestAddrMatched 																				 => '0', 				// Address found for input business phone matches address on file for best business address -- 0 distance
																																																																												PhoneDist);	// Calc distance between address found for input phone and best business address on file


																							SELF.Business_To_Executive_Link.AR2BBusRep1PhoneDistance := MAP(NOT BestBusinessPhoneLLPopulated OR NOT Rep1PhoneLLPopulated => '-1',								// Missing phones or phones we can't find Lat/Long on return -1.
																																																							Rep1PhoneMatchesBestBusiness		 														 => '0',								// If phones match, set distance to 0
																																																																																							Rep1BusPhoneDist);	// Calc distance between phones (minimum set to 1, per Lea)

																							SELF.Business_To_Executive_Link.AR2BBusRep2PhoneDistance := MAP(NOT BestBusinessPhoneLLPopulated OR NOT Rep2PhoneLLPopulated => '-1',
																																																							Rep2PhoneMatchesBestBusiness		 														 => '0',
																																																																																							Rep2BusPhoneDist);
																							SELF.Business_To_Executive_Link.AR2BBusRep3PhoneDistance := MAP(NOT BestBusinessPhoneLLPopulated OR NOT Rep3PhoneLLPopulated => '-1',
																																																							Rep3PhoneMatchesBestBusiness		 														 => '0',
																																																																																							Rep3BusPhoneDist);

																							SELF.Business_To_Executive_Link.AR2BBusRep4PhoneDistance := MAP(NOT BestBusinessPhoneLLPopulated OR NOT Rep4PhoneLLPopulated => '-1',
																																																							Rep4PhoneMatchesBestBusiness		 														 => '0',
																																																																																							Rep4BusPhoneDist);
																							SELF.Business_To_Executive_Link.AR2BBusRep5PhoneDistance := MAP(NOT BestBusinessPhoneLLPopulated OR NOT Rep5PhoneLLPopulated => '-1',
																																																							Rep5PhoneMatchesBestBusiness		 														 => '0',
																																																																																							Rep5BusPhoneDist);

																							Rep1AddrPopulated := TRIM(LEFT.Clean_Input.Rep_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep_Zip5) <> '';
																							Rep2AddrPopulated := TRIM(LEFT.Clean_Input.Rep2_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep2_Zip5) <> '';
																							Rep3AddrPopulated := TRIM(LEFT.Clean_Input.Rep3_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep3_Zip5) <> '';
																							Rep4AddrPopulated := TRIM(LEFT.Clean_Input.Rep4_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep4_Zip5) <> '';
																							Rep5AddrPopulated := TRIM(LEFT.Clean_Input.Rep5_Prim_Name) <> '' AND TRIM(LEFT.Clean_Input.Rep5_Zip5) <> '';


																							RepZIPScore := IF(LEFT.Clean_Input.Rep_Zip5 <> '' AND LEFT.PhoneAddressDistances.BestBusinessZip <> '' AND LEFT.Clean_Input.Rep_Zip5[1] = LEFT.PhoneAddressDistances.BestBusinessZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep_Zip5, LEFT.PhoneAddressDistances.BestBusinessZip), NoScoreValue);
																							RepCityStateScore		:= IF(LEFT.Clean_Input.Rep_City <> '' AND LEFT.Clean_Input.Rep_State <> '' AND LEFT.PhoneAddressDistances.BestBusinessCity <> '' AND LEFT.PhoneAddressDistances.BestBusinessSt <> '' AND LEFT.Clean_Input.Rep_State[1] = LEFT.PhoneAddressDistances.BestBusinessSt[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep_City, LEFT.Clean_Input.Rep_State, LEFT.PhoneAddressDistances.BestBusinessCity, LEFT.PhoneAddressDistances.BestBusinessSt, ''), NoScoreValue);
																							RepCityStateZipMatched := Risk_Indicators.iid_constants.ga(RepZIPScore) AND Risk_Indicators.iid_constants.ga(RepCityStateScore);
																							Rep1AddrMatchesBestBusiness := Risk_Indicators.iid_constants.ga(IF(RepZIPScore = NoScoreValue AND RepCityStateScore = NoScoreValue, NoScoreValue,
																										Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep_Prim_Range, LEFT.Clean_Input.Rep_Prim_Name, LEFT.Clean_Input.Rep_Sec_Range,
																											LEFT.PhoneAddressDistances.BestBusinessPrimRange, LEFT.PhoneAddressDistances.BestBusinessPrimName, LEFT.PhoneAddressDistances.BestBusinessSecRange,
																											RepZIPScore, RepCityStateScore)));


																							Rep2ZIPScore := IF(LEFT.Clean_Input.Rep2_Zip5 <> '' AND LEFT.PhoneAddressDistances.BestBusinessZip <> '' AND LEFT.Clean_Input.Rep2_Zip5[1] = LEFT.PhoneAddressDistances.BestBusinessZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep2_Zip5, LEFT.PhoneAddressDistances.BestBusinessZip), NoScoreValue);
																							Rep2CityStateScore		:= IF(LEFT.Clean_Input.Rep2_City <> '' AND LEFT.Clean_Input.Rep2_State <> '' AND LEFT.PhoneAddressDistances.BestBusinessCity <> '' AND LEFT.PhoneAddressDistances.BestBusinessSt <> '' AND LEFT.Clean_Input.Rep2_State[1] = LEFT.PhoneAddressDistances.BestBusinessSt[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep2_City, LEFT.Clean_Input.Rep2_State, LEFT.PhoneAddressDistances.BestBusinessCity, LEFT.PhoneAddressDistances.BestBusinessSt, ''), NoScoreValue);
																							Rep2CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep2ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep2CityStateScore);
																							Rep2AddrMatchesBestBusiness := Risk_Indicators.iid_constants.ga(IF(Rep2ZIPScore = NoScoreValue AND Rep2CityStateScore = NoScoreValue, NoScoreValue,
																										Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep2_Prim_Range, LEFT.Clean_Input.Rep2_Prim_Name, LEFT.Clean_Input.Rep2_Sec_Range,
																											LEFT.PhoneAddressDistances.BestBusinessPrimRange, LEFT.PhoneAddressDistances.BestBusinessPrimName, LEFT.PhoneAddressDistances.BestBusinessSecRange,
																											Rep2ZIPScore, Rep2CityStateScore)));


																							Rep3ZIPScore := IF(LEFT.Clean_Input.Rep3_Zip5 <> '' AND LEFT.PhoneAddressDistances.BestBusinessZip <> '' AND LEFT.Clean_Input.Rep3_Zip5[1] = LEFT.PhoneAddressDistances.BestBusinessZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep3_Zip5, LEFT.PhoneAddressDistances.BestBusinessZip), NoScoreValue);
																							Rep3CityStateScore		:= IF(LEFT.Clean_Input.Rep3_City <> '' AND LEFT.Clean_Input.Rep3_State <> '' AND LEFT.PhoneAddressDistances.BestBusinessCity <> '' AND LEFT.PhoneAddressDistances.BestBusinessSt <> '' AND LEFT.Clean_Input.Rep3_State[1] = LEFT.PhoneAddressDistances.BestBusinessSt[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep3_City, LEFT.Clean_Input.Rep3_State, LEFT.PhoneAddressDistances.BestBusinessCity, LEFT.PhoneAddressDistances.BestBusinessSt, ''), NoScoreValue);
																							Rep3CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep3ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep3CityStateScore);
																							Rep3AddrMatchesBestBusiness := Risk_Indicators.iid_constants.ga(IF(Rep3ZIPScore = NoScoreValue AND Rep3CityStateScore = NoScoreValue, NoScoreValue,
																										Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep3_Prim_Range, LEFT.Clean_Input.Rep3_Prim_Name, LEFT.Clean_Input.Rep3_Sec_Range,
																											LEFT.PhoneAddressDistances.BestBusinessPrimRange, LEFT.PhoneAddressDistances.BestBusinessPrimName, LEFT.PhoneAddressDistances.BestBusinessSecRange,
																											Rep3ZIPScore, Rep3CityStateScore)));

																							Rep4ZIPScore := IF(LEFT.Clean_Input.Rep4_Zip5 <> '' AND LEFT.PhoneAddressDistances.BestBusinessZip <> '' AND LEFT.Clean_Input.Rep4_Zip5[1] = LEFT.PhoneAddressDistances.BestBusinessZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep4_Zip5, LEFT.PhoneAddressDistances.BestBusinessZip), NoScoreValue);
																							Rep4CityStateScore		:= IF(LEFT.Clean_Input.Rep4_City <> '' AND LEFT.Clean_Input.Rep4_State <> '' AND LEFT.PhoneAddressDistances.BestBusinessCity <> '' AND LEFT.PhoneAddressDistances.BestBusinessSt <> '' AND LEFT.Clean_Input.Rep4_State[1] = LEFT.PhoneAddressDistances.BestBusinessSt[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep4_City, LEFT.Clean_Input.Rep4_State, LEFT.PhoneAddressDistances.BestBusinessCity, LEFT.PhoneAddressDistances.BestBusinessSt, ''), NoScoreValue);
																							Rep4CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep4ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep4CityStateScore);
																							Rep4AddrMatchesBestBusiness := Risk_Indicators.iid_constants.ga(IF(Rep4ZIPScore = NoScoreValue AND Rep4CityStateScore = NoScoreValue, NoScoreValue,
																										Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep4_Prim_Range, LEFT.Clean_Input.Rep4_Prim_Name, LEFT.Clean_Input.Rep4_Sec_Range,
																											LEFT.PhoneAddressDistances.BestBusinessPrimRange, LEFT.PhoneAddressDistances.BestBusinessPrimName, LEFT.PhoneAddressDistances.BestBusinessSecRange,
																											Rep4ZIPScore, Rep4CityStateScore)));


																							Rep5ZIPScore := IF(LEFT.Clean_Input.Rep5_Zip5 <> '' AND LEFT.PhoneAddressDistances.BestBusinessZip <> '' AND LEFT.Clean_Input.Rep5_Zip5[1] = LEFT.PhoneAddressDistances.BestBusinessZip[1], Risk_Indicators.AddrScore.ZIP_Score(LEFT.Clean_Input.Rep5_Zip5, LEFT.PhoneAddressDistances.BestBusinessZip), NoScoreValue);
																							Rep5CityStateScore		:= IF(LEFT.Clean_Input.Rep5_City <> '' AND LEFT.Clean_Input.Rep5_State <> '' AND LEFT.PhoneAddressDistances.BestBusinessCity <> '' AND LEFT.PhoneAddressDistances.BestBusinessSt <> '' AND LEFT.Clean_Input.Rep5_State[1] = LEFT.PhoneAddressDistances.BestBusinessSt[1], Risk_Indicators.AddrScore.CityState_Score(LEFT.Clean_Input.Rep5_City, LEFT.Clean_Input.Rep5_State, LEFT.PhoneAddressDistances.BestBusinessCity, LEFT.PhoneAddressDistances.BestBusinessSt, ''), NoScoreValue);
																							Rep5CityStateZipMatched := Risk_Indicators.iid_constants.ga(Rep5ZIPScore) AND Risk_Indicators.iid_constants.ga(Rep5CityStateScore);
																							Rep5AddrMatchesBestBusiness := Risk_Indicators.iid_constants.ga(IF(Rep5ZIPScore = NoScoreValue AND Rep5CityStateScore = NoScoreValue, NoScoreValue,
																										Risk_Indicators.AddrScore.AddressScore(LEFT.Clean_Input.Rep5_Prim_Range, LEFT.Clean_Input.Rep5_Prim_Name, LEFT.Clean_Input.Rep5_Sec_Range,
																											LEFT.PhoneAddressDistances.BestBusinessPrimRange, LEFT.PhoneAddressDistances.BestBusinessPrimName, LEFT.PhoneAddressDistances.BestBusinessSecRange,
																											Rep5ZIPScore, Rep5CityStateScore)));



																							Rep1BusAddrDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.Zip_Dist(LEFT.PhoneAddressDistances.BestBusinessZip, LEFT.Clean_Input.Rep_Zip5)), 1, 999999);
																							Rep2BusAddrDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.Zip_Dist(LEFT.PhoneAddressDistances.BestBusinessZip, LEFT.Clean_Input.Rep2_Zip5)), 1, 999999);
																							Rep3BusAddrDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.Zip_Dist(LEFT.PhoneAddressDistances.BestBusinessZip, LEFT.Clean_Input.Rep3_Zip5)), 1, 999999);
																							Rep4BusAddrDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.Zip_Dist(LEFT.PhoneAddressDistances.BestBusinessZip, LEFT.Clean_Input.Rep4_Zip5)), 1, 999999);
																							Rep5BusAddrDist := (STRING)Business_Risk_BIP.Common.capNum(ROUND(Ut.Zip_Dist(LEFT.PhoneAddressDistances.BestBusinessZip, LEFT.Clean_Input.Rep5_Zip5)), 1, 999999);


																							SELF.Business_To_Executive_Link.AR2BBusRep1AddrDistance := MAP(NOT BestBusinessAddrPopulated OR NOT Rep1AddrPopulated => '-1',
																																																						 Rep1AddrMatchesBestBusiness														=> '0',
																																																																																			 Rep1BusAddrDist);
																							SELF.Business_To_Executive_Link.AR2BBusRep2AddrDistance := MAP(NOT BestBusinessAddrPopulated OR NOT Rep2AddrPopulated => '-1',
																																																						 Rep2AddrMatchesBestBusiness															=> '0',
																																																																																			 Rep2BusAddrDist);
																							SELF.Business_To_Executive_Link.AR2BBusRep3AddrDistance := MAP(NOT BestBusinessAddrPopulated OR NOT Rep3AddrPopulated => '-1',
																																																						 Rep3AddrMatchesBestBusiness														=> '0',
																																																																																			 Rep3BusAddrDist);
																							SELF.Business_To_Executive_Link.AR2BBusRep4AddrDistance := MAP(NOT BestBusinessAddrPopulated OR NOT Rep4AddrPopulated => '-1',
																																																						 Rep4AddrMatchesBestBusiness															=> '0',
																																																																																			 Rep4BusAddrDist);
																							SELF.Business_To_Executive_Link.AR2BBusRep5AddrDistance := MAP(NOT BestBusinessAddrPopulated OR NOT Rep5AddrPopulated => '-1',
																																																						 Rep5AddrMatchesBestBusiness														=> '0',
																																																																																			 Rep5BusAddrDist);


																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);


	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(CHOOSEN(PhonePrep, 100), NAMED('Sample_PhonePrep'));
	// OUTPUT(CHOOSEN(DirsByPhone, 100), NAMED('Sample_DirsByPhone'));
	// OUTPUT(CHOOSEN(DirsByPhoneDD, 100), NAMED('Sample_DirsByPhoneDD'));
	// OUTPUT(CHOOSEN(DirsByPhoneSlim, 100), NAMED('Sample_DirsByPhoneSlim'));
	// OUTPUT(CHOOSEN(DirsByPhoneRolled, 100), NAMED('Sample_DirsByPhoneRolled'));
	// OUTPUT(CHOOSEN(WithDirsByPhone, 100), NAMED('Sample_WithDirsByPhone'));
	RETURN WithDirsByPhone;
END;
