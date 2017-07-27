export Layout_DataSourceStats := RECORD
	string		SourceName;
	string4		SourceType;
	string		SourceID;
	string		SourceErrorCode;
	string		SourceErrorMessage;
	boolean 	isCit; // government citizen datasource
	boolean 	isCom; // commercial datasource
	integer1	VerLevel; // 0-12
	integer1	citVL; // 0-12
	integer1	comVL; // 0-12
	
	// -1 missing, 0 no match, 1 match
	integer1	FirstName;
	integer1	FirstInitial;
	integer1	MiddleName;
	integer1	LastName;
	integer1	FullName;

	integer1	FullStreet;
	integer1	UnitNumber;
	integer1	StreetNumber;
	integer1	StreetName;
	integer1	StreetType;
	integer1	Suburb;
	integer1	Area;
	integer1	State;
	integer1	PostalCode;
	
	integer1	PhoneNumber;
	integer1	IdNumber;

	integer1	DateOfBirth;
	integer1	DayOfBirth;
	integer1	MonthOfBirth;
	integer1	YearOfBirth;
	
	boolean		isNameVer;
	boolean		isFirstVer;
	boolean		isLastVer;
	boolean		isAddrVer;
	boolean		isNIDVer;
	boolean		isDOBVer;
	boolean		isPhoneVer;
END;