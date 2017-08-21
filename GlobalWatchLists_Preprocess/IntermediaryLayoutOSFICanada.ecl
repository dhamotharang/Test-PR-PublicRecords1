EXPORT IntermediaryLayoutOSFICanada := MODULE;

EXPORT tempLayoutEnt := RECORD
	string 	ID;
	unicode entity;
	unicode 	Address;
	unicode basis3;
	string orig_raw_name;
END;

EXPORT tempLayoutEnt1 := RECORD
	tempLayoutEnt;
  unicode Addresses_Parsed;
END;

EXPORT tempLayoutEnt2 := RECORD
	tempLayoutEnt1;
  integer2 Address_Count;
END;

// EXPORT BaseLayoutEnt := RECORD
  // string6 			ID;
  // unicode350 		entity;
  // unicode1000 	Address;
  // unicode1050 	basis3;
  // string10	 		last_vend_upd;
// END;

EXPORT BaseLayoutEntWithComments := RECORD
  string6 			ID;
  unicode350 		entity;
  unicode1000 		Address;
	unicode1000 	comments := '';
  unicode1050 	basis3;
  string10	 		last_vend_upd;
  string orig_raw_name;
end;

EXPORT tempLayoutInd := RECORD
	string  ID;
	string  LastName;
	string  First_Name;
	string  SecondName;
	string  ThirdName;
	string  FourthName;
	string  POB;
	string  ALTPOB;
	string  DOB4;
	string  ALTDOB1;
	string  ALTDOB2;
	string  ALTDOB3;
	string  Nationality;
	string  ALTNAtionality1;
	string  ALTNationality2;
	string  OtherInfo;
	string  basis5;
	string orig_raw_name;
END;

EXPORT BaseLayoutInd := RECORD
  string6 		ID;
  string35 		LastName;
  string30 		First_Name;
  string30 		SecondName;
  string30 		ThirdName;
  string30 		FourthName;
  string80 		POB;
  string80 		ALTPOB;
  string25 		DOB4;
  string25 		ALTDOB1;
  string20 		ALTDOB2;
  string20 		ALTDOB3;
  string60 		Nationality;
  string60 		ALTNAtionality1;
  string60 		ALTNationality2;
  string1500 	OtherInfo;
  string200 	basis5;
  string200 	lstd_entity;
  string350		orig_raw_name;
end;

EXPORT BaseLayoutIndWithVendUpd := RECORD
	BaseLayoutInd;
	string10 		last_vend_upd;
END;

EXPORT BaseLayoutIndWithCleanName := RECORD
  BaseLayoutInd;
  rNameAddress.rName 	clean_name;
end;

END;