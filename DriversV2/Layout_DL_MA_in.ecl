export Layout_DL_MA_In := module

	export	Raw	:=	record
		string		RecordCreationDate;
		string 	  RMVPersonSurrogate;  				
		string   	RMVAtlasKey;								
		string		DateOfBirth;					
		string  	Gender;								
		string		HeightFeet;
		string		HeightInches;
		string		LastName;
		string		FirstName;
		string		MiddleName;
		string		NameSuffix;
		string		LicenseNumber;
		string		LicenseIssueDate;
		string		LicenseExpirationDate;
		string		LicenseClass;
		string		FirstLicensePermitExpirationDate;
		string		FirstLicensePermitClass;
		string		SecondLicensePermitExpirationDate;
		string		SecondLicensePermitClass;
		string		ThirdLicensePermitExpirationDate;
		string		ThirdLicensePermitClass;
		string		FourthLicensePermitExpirationDate;
		string		FourthLicensePermitClass;
		string		FifthLicensePermitExpirationDate;
		string		FifthLicensePermitClass;
		string		CurrentPassengerLicenseStatus;
		string		CurrentCommercialLicenseStatus;
		string		FullResidentialAddress;
		string		ResidentialStreet1;
		string		ResidentialStreet2;
		string		ResidentialUnit;
		string		ResidentialUnitType;
		string		ResidentialCity;
		string		ResidentialState;
		string		ResidentialZipCode;
		string		ResidentialCounty;
		string		ResidentialCountry;
		string		FullMailingAddress;
		string		MailingStreet1;
		string		MailingStreet2;
		string		MailingUnit;
		string		MailingUnitType;
		string		MailingCity;
		string		MailingState;
		string		MailingZipCode;
		string		MailingCounty;
		string		MailingCountry;
		string		CRLF;
	end;

  export 	Layout_MA_With_Clean := record
		string9   PERS_SURROGATE;  				
		string1   FILLER1;								
		string9		LICENSE_LICNO;					
		string1		FILLER2;								
		string8		LICENSE_BDATE_YYYYMMDD;	
		string8		LICENSE_EDATE_YYYYMMDD;	
		string2		LICENSE_LIC_CLASS;			
		string3		LICENSE_HEIGHT;					
		string1		LICENSE_SEX;						
		string50	LICENSE_LAST_NAME;			
		string50	LICENSE_FIRST_NAME;			
		string50	LICENSE_MIDDLE_NAME;		
		string20	LICMAIL_STREET1;				
		string20	LICMAIL_STREET2;				
		string15	LICMAIL_CITY;						
		string2		LICMAIL_STATE;					
		string9		LICMAIL_ZIP;						
		string20	LICRESI_STREET1;				
		string20	LICRESI_STREET2;				
		string15	LICRESI_CITY;						
		string2		LICRESI_STATE;					
		string9		LICRESI_ZIP;						
		string8		ISSUE_DATE_YYYYMMDD;    
		string7		LICENSE_STATUS;					
	// New fields being added for possible future use. MA is sending us permit data 
	// but we are not passing this along to the keys as of yet. Just storing the data.	
    string1   PERMIT_FLAG;
    string2   PERMIT_CLASS1;
    string8   PERMIT_EXP_DATE1;
    string2   PERMIT_CLASS2;
    string8   PERMIT_EXP_DATE2;
    string2   PERMIT_CLASS3;
    string8  	PERMIT_EXP_DATE3;
    string2   PERMIT_CLASS4;
    string8   PERMIT_EXP_DATE4;
    string2   PERMIT_CLASS5;
    string8   PERMIT_EXP_DATE5;		
		string3		clean_status			:= '';
		string8 	process_date	  	:= '';
  end;
	
end;



