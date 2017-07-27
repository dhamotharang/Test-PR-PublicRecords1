/* Custom Layouts for services like CompID 
	 Source: Generic EditsV2 Order */
EXPORT Layouts_Services := MODULE
	
	EXPORT CompId_Order := RECORD
		// RI01
		STRING2  ReportUseCode;
		
		// PI01
		STRING4  PrefName;
		STRING28 LastName;
		STRING20 FirstName;
		STRING15 MidName;
		STRING3  SufName;
		
		STRING8  BirthDate;
		STRING9  SsnNum;
		
		// AL01
		STRING9  HouseNum;
		STRING20 StrName;
		STRING5  AptNum;
		
		STRING20 CityName;
		STRING2  StateCode;
		STRING5  ZipNum;
		STRING4  ZipSufNum;
		
		// DL01
		STRING25 LicNum;
		STRING2  DLStateCode;

	END;
	
END;