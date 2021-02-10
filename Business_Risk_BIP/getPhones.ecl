IMPORT Business_Risk_BIP, BIPV2, Risk_Indicators, CellPhone, dx_Gong, Doxie, Suppress, ut;

EXPORT getPhones(DATASET(Business_Risk_BIP.Layouts.Shell) Shell,
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN Options,
											 BIPV2.mod_sources.iParams linkingOptions,
											 SET OF STRING2 AllowedSourcesSet) := FUNCTION

	mod_access := PROJECT(Options, doxie.IDataAccess);

	calculateValueFor := Business_Risk_BIP.mod_BusinessShellVersionLogic(Options);

/* ************************************************************************
	 *  Get Switch Type and Phone Type																						*
	 ************************************************************************ */


 FlatZipLayout := RECORD
		INTEGER ZipDist;
  END;
Layout_Raw_Phone_Characteristics := RECORD
	Business_Risk_BIP.Layouts.Input;
	STRING1 Phone_Switch_Type := ''; // 8 - Toll Free, C - Cell Phone, G - Pager, I - Puerto Rico/Virgin Islands, P - POTS, T - Time, U - Unknown, V - VOIP, W - Weather
	STRING2 Phone_Cell_Type := ''; // 8 - Toll Free, C - Cell Phone, G - Pager, I - Puerto Rico/Virgin Islands, P - POTS, T - Time, U - Unknown, V - VOIP, W - Weather
	UNSIGNED1 Phone_High_Risk := 0;
	BOOLEAN Phone_Disconnected := FALSE;
	UNSIGNED1 Phone_Zip_Match := 0;
	UNSIGNED2  ZipDistance;
	STRING1 phonetype;
	INTEGER Phone_Entity_Count := 0;


END;

	Layout_Raw_Phone_Characteristics getSwitchType(Business_Risk_BIP.Layouts.Shell le, Risk_Indicators.Key_Telcordia_TDS ri) := TRANSFORM
		toll_free_set := ['800', '811', '822', '833', '844', '855', '866', '877', '888', '899'];
		switchFlag := MAP(le.Clean_Input.Phone10[1..3] IN toll_free_set OR
											REGEXFIND('I', ri.SSC) 																=> '8', // Toll Free
											ri.COCType IN ['EOC', 'PMC', 'RCC', 'SP1', 'SP2'] AND
											(REGEXFIND('C', ri.SSC) OR
											REGEXFIND('R', ri.SSC) OR
											REGEXFIND('S', ri.SSC))															=> 'C', // Cell
											REGEXFIND('B', ri.SSC)																=> 'G', // Pager
											REGEXFIND('N', ri.SSC)																=> 'P', // POTS
											REGEXFIND('V', ri.SSC)																=> 'V', // VOIP
											REGEXFIND('T', ri.SSC)																=> 'T', // Time
											REGEXFIND('W', ri.SSC)																=> 'W', // Weather
											REGEXFIND('8', ri.SSC)																=> 'I', // Puerto-Rico/Virgin Islands
																																							 'U'); // Unknown


		SELF.Phone_Switch_Type := IF(TRIM(le.Clean_Input.Phone10) <> '', switchFlag, '');
		SELF.Phone_Cell_Type := MAP(  switchFlag = 'U' => '0',
																	switchFlag = 'C' => '1',
																	RI.npa = '' and ri.nxx = '' => '0',
																	'0');

		SELF := le.Clean_Input;
		SELF := [];
	END;
	SwitchTypeTZTemp := JOIN(Shell, Risk_Indicators.Key_Telcordia_TDS, (UNSIGNED)LEFT.Clean_Input.Phone10 > 10000000 AND
																																			KEYED(LEFT.Clean_Input.Phone10[1..3] = RIGHT.npa AND LEFT.Clean_Input.Phone10[4..6] = RIGHT.nxx) AND LEFT.Clean_Input.Phone10[7] = RIGHT.tb,
																													getSwitchType(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	Layout_Raw_Phone_Characteristics cleanSwitchType(Layout_Raw_Phone_Characteristics le, CellPhone.Key_Neustar_Phone ri) := TRANSFORM
		SELF.Phone_Switch_Type := IF(ri.cellphone <> '', 'C', le.Phone_Switch_Type);
		SELF.Phone_Cell_Type := IF(ri.cellphone <> '', '1', le.Phone_Cell_Type);
		SELF := le;
	END;
	SwitchTypeTZ := JOIN(SwitchTypeTZTemp, CellPhone.Key_Neustar_Phone, KEYED(LEFT.Phone10 = RIGHT.cellphone), cleanSwitchType(LEFT, RIGHT), LEFT OUTER, KEEP(1), ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	/* ************************************************************************
	 *  Get Phone Zip Match																										*
	 *************************************************************************/

	Layout_Raw_Phone_Characteristics getPhoneZip(Business_Risk_BIP.Layouts.Shell le, Risk_Indicators.Key_Telcordia_tpm_slim ri) := TRANSFORM
		SELF.Phone_Zip_Match := IF(le.Clean_Input.Zip5 IN SET(ri.zipcodes, zip), 1, 0);
    SELF.phonetype := risk_indicators.PRIIPhoneRiskFlag('').telcordiaPhoneType(ri.dial_ind, ri.point_id);
		ALLzips  := project(ri.zipcodes, transform(FlatZipLayout,
																					SELF.ZipDist:= IF(le.Clean_Input.Zip5 = '' 	OR LEFT.zip ='', 9999,
																								min((INTEGER) ut.zip_Dist(le.Clean_Input.Zip5, LEFT.zip), 9998));	));
		SortedDist := sort(ALLzips(zipdist <>0),ZipDist);
		SELF.Zipdistance := SortedDist[1].ZipDist;
		SELF := le.Clean_input;
		SELF := [];
	END;
	ZipMatchTemp := JOIN(Shell, Risk_Indicators.Key_Telcordia_tpm_slim, KEYED(LEFT.Clean_Input.Phone10[1..3] = RIGHT.npa AND
																						LEFT.Clean_Input.Phone10[4..6] = RIGHT.nxx AND LEFT.Clean_Input.Phone10[7] = RIGHT.tb),
																	getPhoneZip(LEFT, RIGHT), KEEP(500), ATMOST(Business_Risk_BIP.Constants.Limit_Default));
	// It's possible that more than one record results from the above join, keep the one that might match on zip
	ZipMatch := DEDUP(SORT(ZipMatchTemp,Seq, Phone10, -Phone_Zip_Match), Seq, Phone10);


	/* ************************************************************************
	 *  Get Phone Disconnect and Sic_Code																			*
	 ************************************************************************ */

	{Layout_Raw_Phone_Characteristics, UNSIGNED4 global_sid, UNSIGNED4 did} getDisconnectHRisk(Business_Risk_BIP.Layouts.Shell le, Risk_Indicators.key_phone_table_v2 ri) := TRANSFORM
		SELF.global_sid := ri.global_sid;
		SELF.did := ri.did;
		SELF.Phone_Disconnected := IF(ri.potdisconnect, TRUE, FALSE);
		SELF.Phone_High_Risk := IF(TRIM(ri.sic_code) <> '', 1, 0);
		SELF := le.Clean_input;
		SELF := [];
	END;
	phoneDisconnectHRiskTemp_unsuppressed := JOIN(Shell, Risk_Indicators.key_phone_table_v2, KEYED(LEFT.Clean_Input.Phone10 = RIGHT.phone10),
																					getDisconnectHRisk(LEFT, RIGHT), KEEP(100), ATMOST(Business_Risk_BIP.Constants.Limit_Default), left outer);

	phoneDisconnectHRiskTemp := Suppress.Suppress_ReturnOldLayout(phoneDisconnectHRiskTemp_unsuppressed, mod_access, Layout_Raw_Phone_Characteristics);

	Layout_Raw_Phone_Characteristics rollDisconnectHRisk(Layout_Raw_Phone_Characteristics le, Layout_Raw_Phone_Characteristics ri) := TRANSFORM
		// In case there are multiple results, if one of them says the phone isn't disconnected then the phone isn't disconnected.  Only if all records are disconnected is the phone disconnected
		SELF.Phone_Disconnected := le.Phone_Disconnected AND ri.Phone_Disconnected;
		// In case there are multiple results, if any records indicate this is a transient or institutional address, keep the high risk flag
		SELF.Phone_High_Risk := IF(le.Phone_High_Risk = 1 OR ri.Phone_High_Risk = 1, 1, 0);

		SELF := le;
		SELF := [];
	END;
	phoneDisconnectHRisk := ROLLUP(SORT(phoneDisconnectHRiskTemp, Seq, Phone10),
																				LEFT.Seq = RIGHT.Seq AND LEFT.Phone10 = RIGHT.Phone10,
																	rollDisconnectHRisk(LEFT, RIGHT));


layout_gonghistory := {dx_Gong.layouts.i_history_phone, unsigned4 seq, UNSIGNED3 HistoryDate};
connectedPhones_unsuppressed := JOIN (shell, dx_Gong.key_history_phone(),
															(integer) LEFT.Clean_Input.Phone10 <>0
															AND keyed (LEFT.Clean_Input.Phone10[4..10] = RIGHT.p7 AND LEFT.Clean_Input.Phone10[1..3] = RIGHT.p3) and
															((LEFT.Clean_Input.historydate = 999999 and RIGHT.current_flag = TRUE) or
																(LEFT.Clean_Input.historydate <> 999999 and (unsigned)RIGHT.dt_first_seen[1..6] < LEFT.Clean_Input.historydate))
															AND (UNSIGNED)RIGHT.dt_first_seen > 0,
															TRANSFORM (layout_gonghistory,
																															SELF.SEQ := LEFT.seq,
																															SELF.Historydate := LEFT.Clean_Input.Historydate,
																															SELF := Right),
																	ATMOST(keyed (LEFT.Clean_Input.Phone10[4..10] = RIGHT.p7 AND LEFT.Clean_Input.Phone10[1..3] = RIGHT.p3),
																Business_Risk_BIP.Constants.Limit_Default),
															keep(100));
	// Count the unique "entities" per phone number (p3 + p7) where an entity is a DID/BDID that is non-zero

	connectedPhones := Suppress.MAC_SuppressSource(connectedPhones_unsuppressed, mod_access);

	ResidentialPhonesDD := DEDUP(SORT(connectedPhones, Seq, -dt_last_seen), Seq);

	withResidentialPhones := JOIN(Shell, ResidentialPhonesDD, LEFT.Seq = RIGHT.Seq,
													TRANSFORM(Business_Risk_BIP.Layouts.Shell,
														SELF.Verification.PhoneResidential := calculateValueFor._PhoneResidential(RIGHT.Business_Flag, RIGHT.Prim_Name, LEFT.Input.InputCheckBusPhone);
														SELF := LEFT),
													LEFT OUTER, KEEP(1), ATMOST(100), FEW);
	SortConnectedPhones := dedup(sort(connectedPhones, seq, p3, p7, DID, BDID, dt_last_seen), seq, p3, p7, DID, BDID) ((UNSIGNED)DID > 0 OR (UNSIGNED)BDID > 0);

	tbleConnectedPhones := table(SortConnectedPhones, {seq, STRING10 Phone := (STRING)p3 + (STRING)p7, unsigned3 EntityCount := count(group)}, seq);

  AddPhoneZip := join(SwitchTypeTZ, ZipMatch, LEFT.seq = RIGHT.seq,
													TRANSFORM(Layout_Raw_Phone_Characteristics,
																					SELF.phonetype := RIGHT.phonetype,
																					SELF.Phone_Zip_Match := RIGHT.Phone_Zip_Match,
																					SELF.Zipdistance := RIGHT.Zipdistance,
																					SELF := LEFT),
																					LEFT OUTER);

	AddPhoneDisc := join(AddPhoneZip, phoneDisconnectHRisk, LEFT.seq = RIGHT.seq,
													TRANSFORM(Layout_Raw_Phone_Characteristics,
																					SELF.Phone_Disconnected := RIGHT.Phone_Disconnected,
																					SELF.Phone_High_Risk := RIGHT.Phone_High_Risk,
																					SELF := LEFT),
																					LEFT OUTER);

	AddConnectedPhoneCnt := join(AddPhoneDisc, tbleConnectedPhones, LEFT.seq = RIGHT.seq,
													TRANSFORM(Layout_Raw_Phone_Characteristics,
																					SELF.Phone_Entity_Count := if(RIGHT.seq = 0, -1, Business_Risk_BIP.Common.CapNum(RIGHT.EntityCount, -1, 255)),
																					SELF := LEFT),
																					LEFT OUTER);
// phone problems
// " -1 = business  information not on file, or phone number not input
// 0 = Input phone presumed to be valid
// 1 = Input phone is currently disconnected
// 2 = Distance between the input address and address served by input phone, if a landline, is more than 10 miles
// 3 = Input phone is associated with transient or institutional address, such as hotel, campground, warehouse, mail drop, institutional, or correctional facility
// 4 = Input phone does not belong to input ZIP code area
// 5 = Input phone is a pager service
// 6 = Input phone is invalid"
	AddphoneAttributes := join(withResidentialPhones, AddConnectedPhoneCnt, LEFT.seq = RIGHT.seq,
													TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																			SELF.Input_Characteristics.InputPhoneProblems  :=  MAP(RIGHT.phonetype <> '1'  => '6',
																																				RIGHT.Phone_Switch_Type = 'G' => '5',
																																				RIGHT.Phone_Zip_Match <> 1 => '4',
																																				RIGHT.Phone_High_Risk = 1 =>  '3',
																																				RIGHT.Zipdistance > 10 => '2',
																																				RIGHT.Phone_Disconnected => '1',
																																				LEFT.Clean_Input.Phone10 = '' OR  RIGHT.SEQ = 0 => '-1',
																																				'0'),
																			SELF.Input_Characteristics.InputPhoneEntityCount := (string)RIGHT.Phone_Entity_Count,
																			SELF.Input_Characteristics.InputPhoneMobile := RIGHT.Phone_Cell_Type,
																		//	SELF.Verification.PhoneResidential := IF(RIGHT.Phone_Cell_Type = '1', '-1', LEFT.Verification.PhoneResidential);
																			SELF := LEFT), LEFT OUTER);

	// ---------------- Phone Risk Table - This contains Disconnect information via EDA/Gong ----------------------
	potentialPhoneDisconnectRaw_unsuppressed := JOIN(Shell, Risk_Indicators.Key_Phone_Table_V2, TRIM(LEFT.Clean_Input.Phone10) <> '' AND KEYED(LEFT.Clean_Input.Phone10 = RIGHT.Phone10),
																	TRANSFORM({RECORDOF(RIGHT), UNSIGNED4 Seq, UNSIGNED3 HistoryDate}, SELF.Seq := LEFT.Seq; SELF.HistoryDate := LEFT.Clean_Input.HistoryDate; SELF := RIGHT),
																	ATMOST(Business_Risk_BIP.Constants.Limit_Default));

	potentialPhoneDisconnectRaw := Suppress.MAC_SuppressSource(potentialPhoneDisconnectRaw_unsuppressed, mod_access);

	potentialPhoneDisconnect := SORT(Business_Risk_BIP.Common.FilterRecords(potentialPhoneDisconnectRaw, dt_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, '', AllowedSourcesSet), Seq, -((INTEGER)dt_first_seen), -potDisconnect);

	// Keep the most recent record, it's possible this number has been disconnected and then reconnected, the most recent record should hopefully be accurate
	phoneDisconnect := ROLLUP(potentialPhoneDisconnect, LEFT.Seq = RIGHT.Seq, TRANSFORM(LEFT));

	withPhoneDisconnect := JOIN(AddphoneAttributes, phoneDisconnect, LEFT.Seq = RIGHT.Seq,
																	TRANSFORM(Business_Risk_BIP.Layouts.Shell,
																							SELF.Verification.PhoneDisconnected := IF((INTEGER)RIGHT.dt_first_seen <= 0, '2', (STRING)((INTEGER)RIGHT.potDisconnect)); // A 2 indicates "Unknown"
																							SELF := LEFT),
																	LEFT OUTER, KEEP(1), ATMOST(100), FEW);

	// output(Shell, named('ShellInTemp'));
	// output(SwitchTypeTZTemp, named('SwitchTypeTZTemp'));
	// output(SwitchTypeTZ, named('sample_SwitchTypeTZ'));
	// output(ZipMatchTemp, named('sample_ZipMatchTemp'));
	// output(ZipMatch, named('sample_ZipMatch'));
  // output(phoneDisconnect, named('phoneDisconnect'));
	// output(phoneDisconnectHRiskTemp, named('sample_phoneDisconnectHRiskTemp'));
	// output(phoneDisconnectHRisk, named('sample_phoneDisconnectHRisk'));
	// output(connectedPhones, named('sample_connectedPhones'));
	// output(SortConnectedPhones, named('sample_SortConnectedPhones'));
	// output(AddPhoneZip, named('AddPhoneZip'));
	// output(AddPhoneDisc, named('AddPhoneDisc'));
	// output(AddConnectedPhoneCnt, named('AddConnectedPhoneCnt'));
	// output(AddphoneAttributes, named('AddphoneAttributes'));
	// OUTPUT(AllowedSourcesSet,NAMED('Allowed_Srcs_Phones'));

	RETURN withPhoneDisconnect;
	END;
