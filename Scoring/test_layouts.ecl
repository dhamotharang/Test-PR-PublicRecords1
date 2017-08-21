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
    integer historydateyyyymm;
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
END;