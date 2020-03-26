IMPORT DueDiligence;


EXPORT BusinessLayouts := MODULE

  //=======================================================
  // Keyed fields for Due Diligence Business Report TestSeeds 
  //=======================================================
  EXPORT Input := RECORD
    STRING20 inDatasetName;
		STRING100 inAccountNumber;
		STRING120 inCompanyName;
		STRING5 inZip5;
    STRING9 inFEIN;
    STRING10 inPhone;
  END;
  
  SHARED Business := RECORD
    STRING15 lexID;
    STRING120 companyName;
    DueDiligence.TestSeeds.SharedLayouts.Address;
    STRING9 fein;
    STRING10 phone;
  END;
  
  //================================
  // Business Input Echo Section
  //================================
  EXPORT InputEchoSection := RECORD
    Input;
    Business;
    STRING120 altCompanyName;
  END;
  
  
  
  //================================
  // Attributes Section
  //================================
  EXPORT AttributesSection := RECORD
    Input;
    STRING8 attributeName;
    STRING15 busLexID;
    STRING3 busLexIDMatch;
    STRING2 busAssetOwnProperty;
    STRING10 busAssetOwnProperty_Flag;
    STRING2 busAssetOwnAircraft;
    STRING10 busAssetOwnAircraft_Flag;
    STRING2 busAssetOwnWatercraft;
    STRING10 busAssetOwnWatercraft_Flag;
    STRING2 busAssetOwnVehicle;
    STRING10 busAssetOwnVehicle_Flag;
    STRING2 busAccessToFundSales;
    STRING10 busAccessToFundsSales_Flag;
    STRING2 busAccessToFundsProperty;
    STRING10 busAccessToFundsProperty_Flag;
    STRING2 busGeographic;
    STRING10 busGeographic_Flag;
    STRING2 busValidity;
    STRING10 busValidity_Flag;
    STRING2 busStability;
    STRING10 busStability_Flag;
    STRING2 busIndustry;
    STRING10 busIndustry_Flag;
    STRING2 busStructureType;
    STRING10 busStructureType_Flag;
    STRING2 busSOSAgeRange;
    STRING10 busSOSAgeRange_Flag;
    STRING2 busPublicRecordAgeRange;
    STRING10 busPublicRecordAgeRange_Flag;
    STRING2 busShellShelf;
    STRING10 busShellShelf_Flag;
    STRING2 busMatchLevel;
    STRING10 busMatchLevel_Flag;
    STRING2 busStateLegalEvent;
    STRING10 busStateLegalEvent_Flag;
    STRING2 busFederalLegalEvent;
    STRING10 busFederalLegalEvent_Flag;
    STRING2 busFederalLegalMatchLevel;
    STRING10 busFederalLegalMatchLevel_Flag;
    STRING2 busCivilLegalEvent;
    STRING10 busCivilLegalEvent_Flag;
    STRING2 busOffenseType;
    STRING10 busOffenseType_Flag;
    STRING2 busBEOProfLicense;
    STRING10 busBEOProfLicense_Flag;
    STRING2 busBEOUSResidency;
    STRING10 busBEOUSResidency_Flag;
    STRING2 busBEOAccessToFundsProperty;
    STRING10 busBEOAccessToFundsProperty_Flag;
    STRING2 busLinkedBusinesses;
    STRING10 busLinkedBusinesses_Flag;
  END;
  
  
  
END;