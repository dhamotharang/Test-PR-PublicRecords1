Layout_SourceResults := RECORD
	string FirstName;
	string FirstInitial;
	string MiddleName;
	string LastName;
	string FullName;
	string Address;
	string FullStreet;
	string UnitNumber;
	string StreetNumber;
	string StreetName;
	string StreetType;
	string Aza;
	string Suburb;
	string Area;
	string State;
	string PostalCode;
	string PhoneNumber;
	string DateOfBirth;
	string DayOfBirth;
	string MonthOfBirth;
	string YearOfBirth;
	string IdNumber;
	string AMLBureau;
END;

export Layout_DataSource := RECORD
	string SourceId;
	string SourceName;
	string SourceType := '';
	Layout_SourceResults Results;
	string MatchedToRules;
	string ErrorMessage;
	string ErrorCode;
	string25000 Photo := '', 
END;