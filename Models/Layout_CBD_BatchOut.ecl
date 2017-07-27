Layout_Chargeback := RECORD
	// Layout_Chargeback_In;
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


export Layout_CBD_BatchOut := RECORD
	string20 acctno;
	Layout_CBDAttributesBatch;
	string3 index3;	
	string20 modelname1;
	string3 score1;
	string15 scorename1;
	string3 score2;
	string15 scorename2;
	string3 score3;
	string15 scorename3;
	string3 reason1;
	string3 reason2;
	string3 reason3;
	string3 reason4;
	string3 reason5;
	string3 reason6;
	string3 reason7;
	string3 reason8;
	string3 reason9;
	string3 reason10;
	string3 reason11;
	string3 reason12;
	Layout_Chargeback chargeback;
	Layout_IPData ipdata;
END;