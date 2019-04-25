IMPORT Risk_Indicators;

export test_layouts := MODULE
  EXPORT prii_layout := RECORD
    STRING Account;
    STRING FirstName;
    STRING MiddleName;
    STRING LastName;
    STRING StreetAddress;
    STRING City;
    STRING State;
    STRING Zip;
    STRING HomePhone;
    STRING SSN;
    STRING DateOfBirth;
    STRING WorkPhone;
    STRING income;  
    string DLNumber;
    string DLState;
    string BALANCE; 
    string CHARGEOFFD;  
    string FormerName;
    string EMAIL;  
    string employername;
    string historydateyyyymm;
  END;

  EXPORT layout_ox := RECORD
    STRING AccountNumber;
    risk_indicators.Layout_Boca_Shell_Edina;
    STRING errorcode;
  END;
	
  EXPORT layout_slimInput := RECORD	
    String30 Account;
    String10 SEQNUM;
    String15 FirstName;
    String20 LastName;
    String50 StreetAddress;
    String30 City;
    String2  State;
    String9  Zip;
    String10 HomePhone;
    String10 WorkPhone;
    String9  SSN;
    String8  DateOfBirth;
    String30 employername;
    String8  CHARGEOFFD;
    String8  historydateyyyymm;
	END;

  EXPORT layout_BS_extended := RECORD
    risk_indicators.Layout_Boca_Shell;
    STRING errorcode;
  END;



Layout_Address_Validation :=
RECORD
	BOOLEAN USPS_Deliverable;
	STRING10 Dwelling_Type;
	STRING10 Zip_Type;
	BOOLEAN HR_Address;
	STRING100 HR_Company;
	STRING4 Error_Codes;
	BOOLEAN Corrections;
END;

Layout_Address_Verification :=
RECORD
	Risk_Indicators.Layout_Address_Information Input_Address_Information;
	Risk_Indicators.Layout_Applicant_Property_values;
	// Risk_Indicators.Layout_Address_Information Address_History_1;
	// Risk_Indicators.Layout_Address_Information Address_History_2;
END;

Layout_InstantID_Results := RECORD
	string10 dirs_prim_range := '';
	string2  dirs_predir:= '';
	string28 dirs_prim_name:= '';
	string4  dirs_suffix:= '';
	string2  dirs_postdir:= '';
	string10 dirs_unit_desig:= '';
	string8  dirs_sec_range:= '';
	STRING30 dirscity := '';
	STRING2 dirsstate := '';
	STRING9 dirszip := '';
	STRING50 dirscmpy := '';

	STRING10 dirsaddr_phone := '';

	string10 chronoprim_range := '';
	string2  chronopredir:= '';
	string28 chronoprim_name:= '';
	string4  chronosuffix:= '';
	string2  chronopostdir:= '';
	string10 chronounit_desig:= '';
	string8  chronosec_range:= '';
	STRING30 chronocity := '';
	STRING2 chronostate := '';
	STRING9 chronozip := '';

	STRING10 chronophone := '';
/*	
	string10 chronoprim_range2 := '';
	string2  chronopredir2 := '';
	string28 chronoprim_name2 := '';
	string4  chronosuffix2 := '';
	string2  chronopostdir2 := '';
	string10 chronounit_desig2 := '';
	string8  chronosec_range2 := '';
	STRING30 chronocity2 := '';
	STRING2 chronostate2 := '';
	STRING9 chronozip2 := '';

	STRING10 chronophone2 := '';

	string10 chronoprim_range3 := '';
	string2  chronopredir3 := '';
	string28 chronoprim_name3 := '';
	string4  chronosuffix3 := '';
	string2  chronopostdir3 := '';
	string10 chronounit_desig3 := '';
	string8  chronosec_range3 := '';
	STRING30 chronocity3 := '';
	STRING2 chronostate3 := '';
	STRING9 chronozip3 := '';

	STRING10 chronophone3 := '';
*/
END;

  EXPORT layout_BS_slim_address := RECORD
    unsigned4 seq;
    unsigned6 did;
    BOOLEAN trueDID;
    Layout_InstantID_Results 					iid;
    Layout_Address_Verification 			Address_Verification;
	  // Risk_Indicators.Layout_Address_Information Input_Address_Information;
	  // Risk_Indicators.Layout_Applicant_Property_values;
    UNSIGNED3													historyDate;
    STRING errorcode;
  END;

END;