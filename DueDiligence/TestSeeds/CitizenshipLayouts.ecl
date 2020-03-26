IMPORT DueDiligence;


EXPORT CitizenshipLayouts := MODULE

  //=======================================================
  // Keyed fields for Citizenship TestSeeds 
  //=======================================================
  EXPORT Input := RECORD
    STRING20 inDatasetName;
		STRING100 inAccountNumber;
		STRING20 inFirstName;
		STRING20 inLastName;
		STRING5 inZip5;
    STRING9 inSSN;
    STRING10 inPhone;
  END;
  
  
  //================================
  // Citizenship Input Echo Section
  //================================
  EXPORT InputEchoSection := RECORD
    Input;
    STRING15 lexID;
    STRING10 phone;
    DueDiligence.TestSeeds.SharedLayouts.Address;
    STRING9 ssn;
    DueDiligence.TestSeeds.SharedLayouts.Name;
    UNSIGNED4 dob;
    STRING15 modelName;
    STRING10 phone2;
    STRING25 dlNumber;
    STRING2 dlState;
    STRING100 emailAddress;
  END;
  
  
  
  //================================
  // Attributes Section
  //================================
  EXPORT RiskIndicatorsSection := RECORD
    Input;
    STRING3 citizenshipScore;
    STRING17 lexID;
    STRING5 lexIDScore;
    STRING5 identityAge;
    STRING5 emergenceAgeHeader;
    STRING5 emergenceAgeBureau;
    STRING5 ssnIssuanceAge;
    STRING5 ssnIssuanceYears;
    STRING5 relativeCount;
    STRING5 ver_voterRecords;
    STRING5 ver_insuranceRecords;
    STRING5 ver_studentFile;
    STRING5 firstSeenAddr10;
    STRING5 reportedCurAddressYears;
    STRING5 addressFirstReportedAge;
    STRING5 timeSinceLastReportedNonBureau;
    STRING5 inputSSNRandomlyIssued;
    STRING5 inputSSNRandomIssuedInvalid;
    STRING5 inputSSNIssuedToNonUS;
    STRING5 inputSSNITIN;
    STRING5 inputSSNInvalid;
    STRING5 inputSSNIssuedPriorDOB;
    STRING5 inputSSNAssociatedMultLexIDs;
    STRING5 inputSSNReportedDeceased;
    STRING5 inputSSNNotPrimaryLexID;
    STRING5 lexIDBestSSNInvalid;
    STRING5 lexIDReportedDeceased;
    STRING5 lexIDMultipleSSNs;
    STRING5 inputComponentDivRisk;
  END;
  
  
  
END;