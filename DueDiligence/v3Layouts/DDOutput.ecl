IMPORT DueDiligence, iesp;

EXPORT DDOutput := MODULE

    //ALSO USED BY BATCH - changing name will impact batch
    EXPORT PerAttributes := RECORD
      STRING15 PerLexID;
      STRING3 PerLexIDMatch;
      STRING2 PerAssetOwnProperty;
      STRING10 PerAssetOwnProperty_Flag;
      STRING2 PerAssetOwnAircraft;
      STRING10 PerAssetOwnAircraft_Flag;
      STRING2 PerAssetOwnWatercraft;
      STRING10 PerAssetOwnWatercraft_Flag;
      STRING2 PerAssetOwnVehicle;
      STRING10 PerAssetOwnVehicle_Flag;
      STRING2 PerAccessToFundsIncome;
      STRING10 PerAccessToFundsIncome_Flag;
      STRING2 PerAccessToFundsProperty;
      STRING10 PerAccessToFundsProperty_Flag;		
      STRING2 PerGeographic;
      STRING10 PerGeographic_Flag;
      STRING2 PerMobility;
      STRING10 PerMobility_Flag;
      STRING2 PerStateLegalEvent;
      STRING10 PerStateLegalEvent_Flag;
      STRING2 PerFederalLegalEvent;
      STRING10 PerFederalLegalEvent_Flag;
      STRING2 PerFederalLegalMatchLevel;
      STRING10 PerFederalLegalMatchLevel_Flag;
      STRING2 PerCivilLegalEvent;
      STRING10 PerCivilLegalEvent_Flag;
      STRING2 perCivilLegalEventFilingAmt;
      STRING10 perCivilLegalEventFilingAmt_Flag;
      STRING2 PerOffenseType;
      STRING10 PerOffenseType_Flag;
      STRING2 PerAgeRange;
      STRING10 PerAgeRange_Flag;
      STRING2 PerIdentityRisk;
      STRING10 PerIdentityRisk_Flag;
      STRING2 PerUSResidency;
      STRING10 PerUSResidency_Flag;
      STRING2 PerMatchLevel;
      STRING10 PerMatchLevel_Flag;
      STRING2 PerAssociates;
      STRING10 PerAssociates_Flag;
      STRING2 PerEmploymentIndustry;
      STRING10 PerEmploymentIndustry_Flag;
      STRING2 PerProfLicense;
      STRING10 PerProfLicense_Flag;
      STRING2 PerBusAssociations;
      STRING10 PerBusAssociations_Flag;
    END;

    //ALSO USED BY BATCH - changing name will impact batch
    EXPORT BusAttributes := RECORD
      STRING15 BusLexID;
      STRING3 BusLexIDMatch;
      STRING2 BusAssetOwnProperty;
      STRING10 BusAssetOwnProperty_Flag;
      STRING2 BusAssetOwnAircraft;
      STRING10 BusAssetOwnAircraft_Flag;
      STRING2 BusAssetOwnWatercraft;
      STRING10 BusAssetOwnWatercraft_Flag;
      STRING2 BusAssetOwnVehicle;
      STRING10 BusAssetOwnVehicle_Flag;
      STRING2 BusAccessToFundSales;
      STRING10 BusAccessToFundsSales_Flag;
      STRING2 BusAccessToFundsProperty;
      STRING10 BusAccessToFundsProperty_Flag;
      STRING2 BusGeographic;
      STRING10 BusGeographic_Flag;
      STRING2 BusValidity;
      STRING10 BusValidity_Flag;
      STRING2 BusStability;
      STRING10 BusStability_Flag;
      STRING2 BusIndustry;
      STRING10 BusIndustry_Flag;
      STRING2 BusStructureType;
      STRING10 BusStructureType_Flag;
      STRING2 BusSOSAgeRange;
      STRING10 BusSOSAgeRange_Flag;
      STRING2 BusPublicRecordAgeRange;
      STRING10 BusPublicRecordAgeRange_Flag;
      STRING2 BusShellShelf;
      STRING10 BusShellShelf_Flag;
      STRING2 BusMatchLevel;
      STRING10 BusMatchLevel_Flag;
      STRING2 BusStateLegalEvent;
      STRING10 BusStateLegalEvent_Flag;
      STRING2 BusFederalLegalEvent;
      STRING10 BusFederalLegalEvent_Flag;
      STRING2 BusFederalLegalMatchLevel;
      STRING10 BusFederalLegalMatchLevel_Flag;
      STRING2 BusCivilLegalEvent;
      STRING10 BusCivilLegalEvent_Flag;
      STRING2 BusCivilLegalEventFilingAmt;
      STRING10 BusCivilLegalEventFilingAmt_Flag;
      STRING2 BusOffenseType;
      STRING10 BusOffenseType_Flag;
      STRING2 BusBEOProfLicense;
      STRING10 BusBEOProfLicense_Flag;
      STRING2 BusBEOUSResidency;
      STRING10 BusBEOUSResidency_Flag;
      STRING2 BusBEOAccessToFundsProperty;
      STRING10 BusBEOAccessToFundsProperty_Flag;
      STRING2 BusLinkedBusinesses;
      STRING10 BusLinkedBusinesses_Flag;
    END;

    EXPORT PersonResults := RECORD
      UNSIGNED6 seq;
      PerAttributes;
      DueDiligence.Citizenship.Layouts.LayoutScoreAndIndicators;
      iesp.duediligencepersonreport.t_DDRPersonReport personReport;
    END;
    
    EXPORT BusinessResults := RECORD
      UNSIGNED6 seq;
      BusAttributes;
      iesp.duediligencebusinessreport.t_DDRBusinessResult report;
    END;

END;