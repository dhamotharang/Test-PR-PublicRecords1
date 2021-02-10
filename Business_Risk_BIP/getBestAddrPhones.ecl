IMPORT Business_Risk_BIP, BIPV2, Risk_Indicators, CellPhone, doxie, Suppress;

EXPORT getBestAddrPhones(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	/* ************************************************************************
	 *  Get Switch Type and Phone Type																						*
	 ************************************************************************ */

	mod_access := PROJECT(Options, doxie.IDataAccess);

	PotentialPhones := DEDUP(SORT(NORMALIZE(Shell, LEFT.BestAddrPhones,
																				TRANSFORM({UNSIGNED seq, UNSIGNED HistoryDate, Business_Risk_BIP.Layouts.LayoutBestAddrPhones},
																									SELF.seq := LEFT.seq,
																									SELF.HistoryDate := LEFT.Clean_Input.HistoryDate,
																									SELF := RIGHT)), seq, phone10), seq, phone10);


	Layout_Raw_Phone_Characteristics := RECORD
		//Business_Risk_BIP.Layouts.Input;
		UNSIGNED4 Seq;
		STRING10 Phone10;
		STRING1 Phone_Switch_Type := ''; // 8 - Toll Free, C - Cell Phone, G - Pager, I - Puerto Rico/Virgin Islands, P - POTS, T - Time, U - Unknown, V - VOIP, W - Weather
		STRING2 Phone_Cell_Type := ''; // 8 - Toll Free, C - Cell Phone, G - Pager, I - Puerto Rico/Virgin Islands, P - POTS, T - Time, U - Unknown, V - VOIP, W - Weather
		BOOLEAN Phone_Disconnected := FALSE;
		BOOLEAN PhoneActive;

	END;

	Layout_Raw_Phone_Characteristics getSwitchType(PotentialPhones le, Risk_Indicators.Key_Telcordia_TDS ri) := TRANSFORM
		SELF.seq := le.seq;
		SELF.phone10 := le.phone10;
		toll_free_set := ['800', '811', '822', '833', '844', '855', '866', '877', '888', '899'];
		switchFlag := MAP(le.Phone10[1..3] IN toll_free_set OR
											REGEXFIND('I', ri.SSC) 																=> '8', // Toll Free
											ri.COCType IN ['EOC', 'PMC', 'RCC', 'SP1', 'SP2'] AND
											(REGEXFIND('C', ri.SSC) OR
											REGEXFIND('R', ri.SSC) OR
											REGEXFIND('S', ri.SSC))																=> 'C', // Cell
											REGEXFIND('B', ri.SSC)																=> 'G', // Pager
											REGEXFIND('N', ri.SSC)																=> 'P', // POTS
											REGEXFIND('V', ri.SSC)																=> 'V', // VOIP
											REGEXFIND('T', ri.SSC)																=> 'T', // Time
											REGEXFIND('W', ri.SSC)																=> 'W', // Weather
											REGEXFIND('8', ri.SSC)																=> 'I', // Puerto-Rico/Virgin Islands
																																							 'U'); // Unknown


		SELF.Phone_Switch_Type := IF(TRIM(le.Phone10) <> '', switchFlag, '');
		SELF.Phone_Cell_Type := MAP(  switchFlag = 'U' => '0',
																	switchFlag = 'C' => '1',
																	RI.npa = '' and ri.nxx = '' => '0',
																	'0');

		SELF := [];
	END;
	SwitchTypeTZTemp := JOIN(PotentialPhones, Risk_Indicators.Key_Telcordia_TDS, (UNSIGNED)LEFT.Phone10 > 10000000 AND
																																			KEYED(LEFT.Phone10[1..3] = RIGHT.npa AND LEFT.Phone10[4..6] = RIGHT.nxx) AND LEFT.Phone10[7] = RIGHT.tb,
																													getSwitchType(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	Layout_Raw_Phone_Characteristics cleanSwitchType(Layout_Raw_Phone_Characteristics le, CellPhone.Key_Neustar_Phone ri) := TRANSFORM
	 SELF.seq := le.seq;
		SELF.phone10 := le.phone10;
		SELF.Phone_Switch_Type := IF(ri.cellphone <> '', 'C', le.Phone_Switch_Type);
		SELF.Phone_Cell_Type := IF(ri.cellphone <> '', '1', le.Phone_Cell_Type);
		SELF := le;
	END;
	SwitchTypeTZ := JOIN(SwitchTypeTZTemp, CellPhone.Key_Neustar_Phone, KEYED(LEFT.Phone10 = RIGHT.cellphone), cleanSwitchType(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	/* ************************************************************************
	 *  Get Phone Disconnect																									*
	 ************************************************************************ */

	{Layout_Raw_Phone_Characteristics, UNSIGNED4 global_sid, UNSIGNED6 did} getDisconnectHRisk(PotentialPhones le, Risk_Indicators.key_phone_table_v2 ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.did := ri.did;
		SELF.seq := le.seq;
		SELF.phone10 := le.phone10;
		SELF.Phone_Disconnected := IF(ri.potdisconnect, TRUE, FALSE);
		SELF := le;
		SELF := [];
	END;
	phoneDisconnectHRiskTemp_unsuppressed := JOIN(PotentialPhones, Risk_Indicators.key_phone_table_v2, KEYED(LEFT.Phone10 = RIGHT.phone10),
																					getDisconnectHRisk(LEFT, RIGHT), KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default), left outer);

	phoneDisconnectHRiskTemp := Suppress.Suppress_ReturnOldLayout(phoneDisconnectHRiskTemp_unsuppressed, mod_access, Layout_Raw_Phone_Characteristics);

	Layout_Raw_Phone_Characteristics rollDisconnectHRisk(Layout_Raw_Phone_Characteristics le, Layout_Raw_Phone_Characteristics ri) := TRANSFORM
		SELF.seq := le.seq;
		SELF.phone10 := le.phone10;
		// In case there are multiple results, if one of them says the phone isn't disconnected then the phone isn't disconnected.  Only if all records are disconnected is the phone disconnected
		SELF.Phone_Disconnected := le.Phone_Disconnected AND ri.Phone_Disconnected;
		SELF := le;
		SELF := [];
	END;
	phoneDisconnectHRisk := ROLLUP(SORT(phoneDisconnectHRiskTemp, Seq, Phone10),
																				LEFT.Seq = RIGHT.Seq AND LEFT.Phone10 = RIGHT.Phone10,
																	rollDisconnectHRisk(LEFT, RIGHT));

	AddPhoneDisc := join(SwitchTypeTZ, phoneDisconnectHRisk, LEFT.seq = RIGHT.seq,
													TRANSFORM(Layout_Raw_Phone_Characteristics,
																					SELF.Phone_Disconnected := RIGHT.Phone_Disconnected,
																					SELF := LEFT),
																					LEFT OUTER);

	GetPhoneStatus := PROJECT(AddPhoneDisc, TRANSFORM(Layout_Raw_Phone_Characteristics,
																					SELF.PhoneActive := IF(LEFT.Phone_Disconnected OR
																																 LEFT.Phone_Switch_Type = 'G' OR
																																 LEFT.Phone_Cell_Type = '1',
																																 FALSE, TRUE),
																					SELF := LEFT));
	RollPhoneStatus := ROLLUP(SORT(GetPhoneStatus, Seq), LEFT.seq=RIGHT.seq, TRANSFORM(Layout_Raw_Phone_Characteristics,
																					SELF.PhoneActive := LEFT.PhoneActive OR RIGHT.PhoneActive,
																					SELF := LEFT));

	// Now roll up by seq. There can be multiple phones with multiple records for each seq, but since we are just looking for
	// any record indicating an active phone, we can roll them all together.
	withBestAddrPhones := JOIN(Shell, RollPhoneStatus, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																						SELF.Best_Info.BestPhoneService := Business_Risk_BIP.Common.SetBoolean(RIGHT.PhoneActive);
																						SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// *********************
	//   DEBUGGING OUTPUTS
	// *********************
	// OUTPUT(Shell, NAMED('Sample_Shell'));
	// OUTPUT(PotentialPhones, NAMED('Sample_PotentialPhones'));
	// OUTPUT(SwitchTypeTZTemp, NAMED('Sample_SwitchTypeTZTemp'));
	// OUTPUT(SwitchTypeTZ, NAMED('Sample_SwitchTypeTZ'));
	// OUTPUT(phoneDisconnectHRisk, NAMED('Sample_phoneDisconnectHRisk'));
	// OUTPUT(AddPhoneDisc, NAMED('Sample_AddPhoneDisc'));
	// OUTPUT(GetPhoneStatus, NAMED('Sample_GetPhoneStatus'));
	// OUTPUT(RollPhoneStatus, NAMED('Sample_RollPhoneStatus'));
	// OUTPUT(withBestAddrPhones, NAMED('Sample_withBestAddrPhones'));
	RETURN withBestAddrPhones;
END;
