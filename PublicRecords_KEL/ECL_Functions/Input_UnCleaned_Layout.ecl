IMPORT PublicRecords_KEL;
//Contains the non-cleaned input

EXPORT Input_UnCleaned_Layout := RECORD
	INTEGER7 InputLexid;
	STRING70 InputFirstName;
	STRING70 InputMiddleName;
	STRING70 InputLastName;
	STRING120 InputAddress;
	STRING50 InputCity;
	STRING25 InputState; 
	STRING10 InputZip;
	STRING10 InputHomePhone;
	STRING10 InputSSN;
	STRING10 InputDateOfBirth;
	STRING10 InputWorkPhone;
	STRING10 InputIncome;
	STRING20 InputDLNumber;
	STRING25 InputDLState;
	STRING10 InputBalance;
	STRING10 InputChargeoFFd;
	STRING70 InputFormername;
	STRING50 InputEmail;
	STRING100 InputEmployment;
	STRING20 InputArchiveDate; 
END;