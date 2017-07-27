import risk_indicators;

Layout_Chargeback := RECORD
	Layout_Chargeback_In -TypeOfOrder -DeviceProvider1_value -DeviceProvider2_value -DeviceProvider3_value -DeviceProvider4_value -btst_order_type -HistoryDateTimeStamp;	
	// STRING30 account := '';
	// STRING32 riskwiseid := '';
	STRING2  socsverlevel := '';
	STRING2  phoneverlevel := '';
	STRING20 correctlast := '';
	STRING10 correcthphone := '';
	STRING9  correctsocs := '';
	STRING50 correctaddr := '';
	STRING3  altareacode := '';
	STRING8  areacodesplitdate := '';
	STRING15 verfirst := '';
	STRING20 verlast := '';
	STRING50 veraddr := '';
	STRING30 vercity := '';
	STRING2  verstate := '';
	STRING5  verzip5 := '';
	STRING4  verzip4 := '';
	STRING10 nameaddrphone := '';
	STRING1  hphonetypeflag := '';
	STRING1  dwelltypeflag := '';
	STRING6  sic := '';
	
	STRING2  phoneverlevel2 := '';
	STRING20 correctlast2 := '';
	STRING10 correcthphone2 := '';
	STRING50 correctaddr2 := '';
	STRING3  altareacode2 := '';
	STRING8  areacodesplitdate2 := '';
	STRING15 verfirst2 := '';
	STRING20 verlast2 := '';
	STRING50 veraddr2 := '';
	STRING30 vercity2 := '';
	STRING2  verstate2 := '';
	STRING5  verzip52 := '';
	STRING4  verzip42 := '';
	STRING10 nameaddrphone2 := '';
	STRING1  hphonetypeflag2 := '';
	STRING1  dwelltypeflag2 := '';
	STRING6  sic2 := '';
	//STRING2  socsverlevel2 := ''; //in ESP layout but not ECL...not enhancing CBD at this time per Marc Bacon
	// DATASET(risk_indicators.Layout_Billing) Billing;
END;

	

Layout_IPData := RECORD
	STRING1  ipcontinent := '';
	STRING2  ipcountry := '';
	STRING2  iproutingtype := '';
	STRING2  ipstate := '';
	STRING9   ipzip := '';
	STRING10 topleveldomain := '';
	STRING3  ipareacode := '';
	STRING67 secondleveldomain := '';
END;



export Layout_Chargeback_Out := RECORD, maxlength(100000)
	STRING30 AccountNumber;
	DATASET(Models.Layouts.Layout_CBD_Echo_In_for_output) Input_Echo {maxcount(1)};
	DATASET(Models.Layouts.Layout_Model_Multiple) models {maxcount(6)};
	DATASET(Models.Layouts.Layout_AttributeGroup) AttributeGroups {maxcount(6)};
	Layout_Chargeback chargeback;
	Layout_IPData ipdata;
END;

