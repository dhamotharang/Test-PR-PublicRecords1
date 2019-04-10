IMPORT Data_Services, doxie, DueDiligence, Risk_Indicators, Seed_Files;

EXPORT keys_DueDiligencePersonReport := MODULE



	SHARED middleName := 'testseed::' + doxie.Version_SuperKey + '::DueDiligencePersonReport::';

  
  //==========================================
  // Configuration variables for prod
  //==========================================  
	SHARED locat_Prod := Data_Services.Data_location.Prefix('NONAMEGIVEN') + 'thor_data400::key::' + middleName;
  
  
  SHARED GetIndex(seed, fileName) := FUNCTIONMACRO
    newRecord := RECORD
      DATA16 hashvalue := seed_files.Hash_InstantID(StringLib.StringToUpperCase(trim(seed.inFirstName)), // fname,
                                                    StringLib.StringToUpperCase(trim(seed.inLastName)),  // lname,
                                                    StringLib.StringToUpperCase(trim(seed.inSSN)), // ssn,
                                                    Risk_Indicators.nullstring, // fein -- not used in person,
                                                    StringLib.StringToUpperCase(trim(seed.inZip5)), // zip,
                                                    StringLib.StringToUpperCase(trim(seed.inPhone)), // phone,
                                                    Risk_Indicators.nullstring); // company_name -- not used in person
      seed;
    END;
    
    
    newTable := TABLE(seed, newRecord);
    
    
    RETURN INDEX(newTable,{inDatasetName, hashvalue}, {newTable}, locat_Prod + fileName);
  ENDMACRO;







  //==========================================================
  // Best Information Section
  //==========================================================	
  EXPORT BestSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_Best;
  
    RETURN GetIndex(seedFile, 'BestInfo');
  END;
  
  
  //==========================================================
  // Person Information Section
  //==========================================================	
  EXPORT PersonInformationSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_PersonInfo;
  
    RETURN GetIndex(seedFile, 'PersonInfo');
  END;
  
  
  //==========================================================
  // Attributes Section
  //==========================================================	
  EXPORT AttributesSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_Attributes;
  
    RETURN GetIndex(seedFile, 'Attributes');
  END;
  
  
  //==========================================================
  // Legal Section
  //==========================================================	
  EXPORT LegalSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_Legal;
  
    RETURN GetIndex(seedFile, 'Legal');
  END;
  
  
  //==========================================================
  // Economic Section - Income
  //==========================================================	
  EXPORT EconomicIncomeSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_EconomicIncome;
  
    RETURN GetIndex(seedFile, 'EconomicIncome');
  END;
  
  
  //==========================================================
  // Economic Section - Property
  //==========================================================	
  EXPORT EconomicPropertySection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_EconomicProperty;
  
    RETURN GetIndex(seedFile, 'EconomicProperty');
  END;
  
  
  //==========================================================
  // Economic Section - Vehicle
  //==========================================================	
  EXPORT EconomicVehicleSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_EconomicVehicle;
  
    RETURN GetIndex(seedFile, 'EconomicVehicle');
  END;
  
  
  //==========================================================
  // Economic Section - Watercraft
  //==========================================================	
  EXPORT EconomicWatercraftSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_EconomicWatercraft;
  
    RETURN GetIndex(seedFile, 'EconomicWatercraft');
  END;
  
  
  //==========================================================
  // Economic Section - Aircraft
  //==========================================================	
  EXPORT EconomicAircraftSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_EconomicAircraft;
  
    RETURN GetIndex(seedFile, 'EconomicAircraft');
  END;
  
  
  //==========================================================
  // Professional Network Section
  //==========================================================	
  EXPORT ProfessionalNetworkSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_ProfessionalNetwork;
  
    RETURN GetIndex(seedFile, 'ProfessionalNetwork');
  END;
  
  
  //==========================================================
  // Business Associations Section
  //==========================================================	
  EXPORT BusinessAssociationSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_BusinessAssociation;
  
    RETURN GetIndex(seedFile, 'BusinessAssociation');
  END;
  
  
  //==========================================================
  // Identity Section - Age
  //==========================================================	
  EXPORT IdentityAgeSection := FUNCTION
    seedFile := Seed_Files.files_DueDiligencePersonReport.Section_IdentityAge;
  
    RETURN GetIndex(seedFile, 'IdentityAge');
  END;
	
END;