IMPORT DueDiligence;

EXPORT PersonLayouts := MODULE

  //=======================================================
  // Keyed fields for Due Diligence Person Report TestSeeds 
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
  
  
  SHARED Person := RECORD
    DueDiligence.TestSeeds.SharedLayouts.Address;
    STRING45 addressType;
    STRING9 ssn;
    UNSIGNED4 dob;
    INTEGER2 age;
    STRING10 phone;
  END;
  
  
  //================================
  // Best Information Section
  //================================
  EXPORT BestSection := RECORD
    Input;
    DueDiligence.TestSeeds.SharedLayouts.Name;
    Person;
  END;
  
  
  //================================
  // Person Information Section
  //================================
  EXPORT PersonInformationSection := RECORD
    Input;
    DueDiligence.TestSeeds.SharedLayouts.NameLexID;
    Person;
  END;
  
  
  //================================
  // Attributes Section
  //================================
  EXPORT AttributesSection := RECORD
    Input;
    STRING8 attributeName;
    UNSIGNED6 PerLexID;
    STRING3 PerLexIDMatch;
    STRING2 perAssetOwnProperty;
    STRING10 perAssetOwnProperty_Flag;
    STRING2 perAssetOwnAircraft;
    STRING10 perAssetOwnAircraft_Flag;
    STRING2 perAssetOwnWatercraft;
    STRING10 perAssetOwnWatercraft_Flag;
    STRING2 perAssetOwnVehicle;
    STRING10 perAssetOwnVehicle_Flag;
    STRING2 perAccessToFundsIncome;
    STRING10 perAccessToFundsIncome_Flag;
    STRING2 perAccessToFundsProperty;
    STRING10 perAccessToFundsProperty_Flag;
    STRING2 perGeographic;
    STRING10 perGeographic_Flag;
    STRING2 perMobility;
    STRING10 perMobility_Flag;
    STRING2 perStateLegalEvent;
    STRING10 perStateLegalEvent_Flag;
    STRING2 perFederalLegalEvent;
    STRING10 perFederalLegalEvent_Flag;
    STRING2 perFederalLegalMatchLevel;
    STRING10 perFederalLegalMatchLevel_Flag;
    STRING2 perCivilLegalEvent;
    STRING10 perCivilLegalEvent_Flag;
    STRING2 perOffenseType;
    STRING10 perOffenseType_Flag;
    STRING2 perAgeRange;
    STRING10 perAgeRange_Flag;
    STRING2 perIdentityRisk;
    STRING10 perIdentityRisk_Flag;
    STRING2 perUSResidency;
    STRING10 perUSResidency_Flag;
    STRING2 perMatchLevel;
    STRING10 perMatchLevel_Flag;
    STRING2 perAssociates;
    STRING10 perAssociates_Flag;
    STRING2 perEmploymentIndustry;
    STRING10 perEmploymentIndustry_Flag;
    STRING2 perProfLicense;
    STRING10 perProfLicense_Flag;
    STRING2 perBusAssociations;
    STRING10 perBusAssociations_Flag;
  END;
  
  
  //================================
  // Legal Section
  //================================
  EXPORT LegalSection := RECORD
    Input;
    DueDiligence.TestSeeds.SharedLayouts.NameLexID;
    DueDiligence.TestSeeds.SharedLayouts.Address;
    STRING9 ssn;
    UNSIGNED4 dob;
    DueDiligence.TestSeeds.SharedLayouts.TopLevelCriminal topLevelCriminal1;
    DueDiligence.TestSeeds.SharedLayouts.TopLevelCriminal topLevelCriminal2;
  END;
  
  
  //================================
  // Economic Section - Income
  //================================
  EXPORT EconomicIncomeSection := RECORD
    Input;
    INTEGER8 estimatedIncome;
  END;
  
  
  //================================
  // Economic Section - Property
  //================================
  EXPORT Property := RECORD
    DueDiligence.TestSeeds.SharedLayouts.Address;
    STRING45 addressType;
    STRING1 ownerOccupied;
    DueDiligence.TestSeeds.SharedLayouts.OwnershipDetails;
    DueDiligence.TestSeeds.SharedLayouts.AssessmentDetails;
    DueDiligence.TestSeeds.SharedLayouts.AreaRisk;
    Duediligence.TestSeeds.SharedLayouts.CountyCityRisk;
    BOOLEAN vacant;
    DueDiligence.TestSeeds.SharedLayouts.Ownership;
  END;
  
  EXPORT EconomicPropertySection := RECORD
    Input;
    INTEGER8 taxAssessedValue;
    Property property1;
    Property property2;
    Property property3;
    Property property4;
    Property property5;
    Property property6;
    Property property7;
    Property property8;
    Property property9;
    Property property10;
    Property property11;
    Property property12;
    Property property13;
    Property property14;
    Property property15;
  END;
  
  
  //================================
  // Economic Section - Vehicle
  //================================
  EXPORT MotorVehicle := RECORD
    DueDiligence.TestSeeds.SharedLayouts.YearMakeModelVIN;
    STRING licensePlateType;
    STRING classType;
    INTEGER3 basePrice;
    DueDiligence.TestSeeds.SharedLayouts.TitleOrRegistration title;
    DueDiligence.TestSeeds.SharedLayouts.TitleOrRegistration registration;
    DueDiligence.TestSeeds.SharedLayouts.Ownership;
  END;
  
  EXPORT EconomicVehicleSection := RECORD
    Input;
    MotorVehicle vehicle1;
    MotorVehicle vehicle2;
    MotorVehicle vehicle3;
    MotorVehicle vehicle4;
    MotorVehicle vehicle5;
    MotorVehicle vehicle6;
    MotorVehicle vehicle7;
    MotorVehicle vehicle8;
    MotorVehicle vehicle9;
    MotorVehicle vehicle10;
    MotorVehicle vehicle11;
    MotorVehicle vehicle12;
    MotorVehicle vehicle13;
    MotorVehicle vehicle14;
    MotorVehicle vehicle15;
  END;
  
  
  //================================
  // Economic Section - Watercraft
  //================================
  EXPORT Watercraft := RECORD
    DueDiligence.TestSeeds.SharedLayouts.YearMakeModelVIN;
    STRING vesselType;
    DueDiligence.TestSeeds.SharedLayouts.TitleOrRegistration title;
    DueDiligence.TestSeeds.SharedLayouts.TitleOrRegistration registration;
    INTEGER2 lengthInches;
    INTEGER2 lengthFeet;
    STRING25 propulsion;
    DueDiligence.TestSeeds.SharedLayouts.Ownership;
  END;
  
  EXPORT EconomicWatercraftSection := RECORD
    Input;
    Watercraft watercraft1;
    Watercraft watercraft2;
    Watercraft watercraft3;
    Watercraft watercraft4;
    Watercraft watercraft5;
    Watercraft watercraft6;
  END;
  
  
  //================================
  // Economic Section - Aircraft
  //================================
  EXPORT Aircraft := RECORD
    DueDiligence.TestSeeds.SharedLayouts.YearMakeModelVIN;
    STRING additionalDetails;
    STRING2 numberOfEngines;
    STRING50 tailNumber;
    UNSIGNED4 registrationDate;
    DueDiligence.TestSeeds.SharedLayouts.Ownership;
  END;
  
  EXPORT EconomicAircraftSection := RECORD
    Input;
    Aircraft aircraft1;
    Aircraft aircraft2;
    Aircraft aircraft3;
    Aircraft aircraft4;
    Aircraft aircraft5;
    Aircraft aircraft6;
    Aircraft aircraft7;
    Aircraft aircraft8;
  END;
  
  
  //================================
  // Professional Network Section
  //================================
  EXPORT ProfessionalNetworkSection := RECORD
    Input;
    DueDiligence.TestSeeds.SharedLayouts.ProfessionalLicense license1;
    DueDiligence.TestSeeds.SharedLayouts.ProfessionalLicense license2;
  END;


  //================================
  // Business Associations Section
  //================================
  EXPORT IndustryRisk := RECORD
    STRING code;
    STRING description;
    STRING industryRisk;
  END;
  
  EXPORT Business := RECORD
    STRING businessName;
    UNSIGNED6 lexID;
    DueDiligence.TestSeeds.SharedLayouts.Address;
    STRING45 addressType;
    IndustryRisk bestNAICS;
    IndustryRisk bestSIC;
    IndustryRisk highestRisk;
    STRING structureType;
    DueDiligence.TestSeeds.SharedLayouts.Executives exec1;
    DueDiligence.TestSeeds.SharedLayouts.Executives exec2;
    DueDiligence.TestSeeds.SharedLayouts.NameLexID registeredAgent1;
    DueDiligence.TestSeeds.SharedLayouts.NameLexID registeredAgent2;
  END;
  
  EXPORT BusinessAssociationSection := RECORD
    Input;
    Business business1;
    Business business2;
  END;
  
  
  //================================
  // Identity Section - Age
  //================================
  EXPORT IdentityAgeSection := RECORD
    Input;
    INTEGER8 estimatedAge;
  END;
  
END;