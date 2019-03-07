EXPORT SharedLayouts := MODULE
  
  EXPORT Address := RECORD
    STRING10 streetNumber;
    STRING2 streetPreDirection;
    STRING28 streetName;
    STRING4 streetSuffix;
    STRING2 streetPostDirection;
    STRING10 unitDesignation;
    STRING8 unitNumber;
    STRING60 streetAddress1;
    STRING60 streetAddress2;
    STRING25 city;
    STRING2 state;
    STRING5 zip5;
    STRING4 zip4;
    STRING18 county;
    STRING9 postalCode;
    STRING50 stateCityZip;
  END;
  
  
  //==================================
  // Person/Individual Related Layouts
  //==================================
  EXPORT Name := RECORD
    STRING62 fullName;
    STRING20 firstName;
    STRING20 middleName;
    STRING20 lastName;
    STRING5 suffix;
    STRING3 prefix;
  END;
  
  EXPORT NameLexID := RECORD
    Name;
    UNSIGNED6 lexID;
  END;
  
  EXPORT Ownership := RECORD
    BOOLEAN subjectOwned;
    BOOLEAN spouseOwned;
    NameLexID owner1;
    NameLexID owner2;
  END;
  
  EXPORT ProfessionalLicense := RECORD
    STRING license;
    STRING status;
    STRING issuingAgency;
    UNSIGNED4 issueDate;
    UNSIGNED4 expirationDate;
    BOOLEAN lawAccounting;
    BOOLEAN financeRealEstate;
    BOOLEAN medicalDoctor;
    BOOLEAN pilotMarinePilotHarborPilotExplosives;
  END;
  
  EXPORT Executives := RECORD
    NameLexID;
    STRING execTitle;
    UNSIGNED4 firstReported;
    UNSIGNED4 lastReported;
  END;
  
  
  //==================================
  // Criminal/Offenses Layouts
  //==================================
  EXPORT CriminalSourceDetail := RECORD
    STRING OffenseCharge;
    STRING7 OffenseConviction;
    STRING OffenseChargeLevelReported;
    STRING Source;
    STRING CourtDisposition1;
    STRING CourtDisposition2;
    UNSIGNED4 OffenseReportedDate;
    UNSIGNED4 OffenseArrestDate;
    UNSIGNED4 OffenseCourtDispDate;
    UNSIGNED4 OffenseAppealDate;
    UNSIGNED4 OffenseSentenceDate;
    UNSIGNED4 OffenseSentenceStartDate;
    UNSIGNED4 DOCConvictionOverrideDate;
    UNSIGNED4 DOCScheduledReleaseDate;
    UNSIGNED4 DOCActualReleaseDate;
    STRING DOCInmateStatus;
    STRING DOCParoleStatus;
    STRING OffenseMaxTerm;
    UNSIGNED4 DOCParoleActualReleaseDate;
    UNSIGNED4 DOCParolePresumptiveReleaseDate;
    UNSIGNED4 DOCParoleScheduledReleaseDate;
    STRING DOCCurrentLocationSecurity;
    STRING DOCParoleCurrentStatus;
    STRING DOCCurrentKnownInmateStatus;
    boolean currentIncarcerationFlag;
    boolean currentParoleFlag;
    boolean currentProbationFlag;
    STRING250 partyName1;
    STRING250 partyName2;
  END;
  
  EXPORT TopLevelCriminal := RECORD
    STRING50 state;
    STRING25 source;
    STRING caseNumber;
    STRING offenseStatute;
    UNSIGNED4 offenseDDFirstReported;
    UNSIGNED4 offenseDDLastReportedActivity;
    UNSIGNED4 offenseDDMostRecentCourtDispDate;
    STRING offenseDDLegalEventTypeMapped;
    STRING offenseCharge;
    STRING offenseDDChargeLevelCalculated;
    STRING offenseChargeLevelReported;
    STRING7 offenseConviction;
    STRING35 offenseIncarcerationProbationParole;
    STRING7 offenseTrafficRelated;
    STRING30 county;
    STRING40 countyCourt;
    STRING40 city;
    STRING50 agency;
    STRING30 race;
    STRING7 sex;
    STRING15 hairColor;
    STRING15 eyeColor;
    STRING3 height;
    STRING3 weight;
    CriminalSourceDetail sourceDetail1;
    CriminalSourceDetail sourceDetail2;
  END;
  
  
  //==================================
  // Property Related Layouts
  //==================================
  EXPORT AreaRisk := RECORD
    BOOLEAN hifca;
    BOOLEAN hidta;
    STRING5 crimeIndex;
  END;
  
  EXPORT CountyCityRisk := RECORD
    STRING countyName;
    BOOLEAN bordersForeignJurisdiction;
    BOOLEAN bordersOceanWithin150ForeignJurisdiction;
    BOOLEAN accessThroughBorderStation;
    BOOLEAN accessThroughRailCrossing;
    BOOLEAN accessThroughFerryCrossing;
  END;
  
  EXPORT OwnershipDetails := RECORD
    UNSIGNED4 purchaseDate;
    INTEGER2 lengthOfOwnership;
    INTEGER8 purchasePrice;
  END;
  
  EXPORT AssessmentDetails := RECORD
    STRING4 taxYear;
    INTEGER8 taxPrice;
  END;
  
  
  //==================================
  // Moter Vehicle Related Layouts
  //==================================
  EXPORT YearMakeModelVIN := RECORD
    STRING4 year;
    STRING make;
    STRING model;
    STRING vin;
  END;
  
  EXPORT TitleOrRegistration := RECORD
    STRING2 state;
    UNSIGNED4 date;
  END;

END;