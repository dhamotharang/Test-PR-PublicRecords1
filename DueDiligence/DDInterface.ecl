IMPORT DueDiligence, Risk_Indicators;

EXPORT DDInterface := MODULE

    EXPORT iDDRegulatoryCompliance := INTERFACE
      EXPORT UNSIGNED3 glba := 0;
      EXPORT UNSIGNED3 dppa := 0;
      EXPORT STRING drm := Risk_Indicators.iid_constants.default_DataRestriction;
      EXPORT STRING dpm := Risk_Indicators.iid_constants.default_DataPermission;
      EXPORT STRING10 industryClass := '';
      EXPORT STRING ssn_mask := '';

      //CCPA Regulatory fields
      EXPORT UNSIGNED1 lexIDSourceOptOut := 1;
      EXPORT STRING transactionID := '';
      EXPORT STRING batchUID := '';
      EXPORT UNSIGNED6 globalCompanyID := 0;
    END;


    EXPORT iDDPersonOptions := INTERFACE
      EXPORT BOOLEAN includeCitizenship := FALSE;
      EXPORT BOOLEAN includeReportData := FALSE;
      EXPORT STRING10 ssnMask := '';
      EXPORT UNSIGNED1 inputUsage := 0; //see DueDiligence.Constants.USE_INPUT_DATA_ENUM for values/explainations
      EXPORT DATASET(Risk_Indicators.Layout_Boca_Shell) bs := DATASET([], Risk_Indicators.Layout_Boca_Shell);
    END;


    EXPORT iDDv3PersonAttributes := INTERFACE
      EXPORT BOOLEAN includeAssetOwnProperty := FALSE;
      EXPORT BOOLEAN includeAssetOwnAircraft := FALSE;
      EXPORT BOOLEAN includeAssetOwnWatercraft := FALSE;
      EXPORT BOOLEAN includeAssetOwnVehicle := FALSE;
      EXPORT BOOLEAN includeAccessToFundsIncome := FALSE;
      EXPORT BOOLEAN includeAccessToFundsProperty := FALSE;
      EXPORT BOOLEAN includeGeographic := FALSE;
      EXPORT BOOLEAN includeMobility := FALSE;
      EXPORT BOOLEAN includeStateLegalEvent := FALSE;
      EXPORT BOOLEAN includeFederalLegalEvent := FALSE; //not yet implemented
      EXPORT BOOLEAN includeFederalLegalMatchLevel := FALSE;  //not yet implemented
      EXPORT BOOLEAN includeCivilLegalEvent := FALSE;
      EXPORT BOOLEAN includeCivilLegalEventFilingAmount := FALSE;
      EXPORT BOOLEAN includeOffenseType := FALSE;
      EXPORT BOOLEAN includeAgeRange := FALSE;
      EXPORT BOOLEAN includeIdentityRisk := FALSE;
      EXPORT BOOLEAN includeUSResidency := FALSE;
      EXPORT BOOLEAN includeMatchLevel := FALSE;
      EXPORT BOOLEAN includeAssociates := FALSE;
      EXPORT BOOLEAN includeEmploymentIndustry := FALSE; //not yet implemented
      EXPORT BOOLEAN includeProfLicense := FALSE;
      EXPORT BOOLEAN includeBusAssociations := FALSE;
      EXPORT BOOLEAN includeAll := FALSE;
    END;



    EXPORT iDDBusinessOptions := INTERFACE
      EXPORT BOOLEAN includeReportData := FALSE;
      EXPORT STRING10 ssnMask := '';
      EXPORT UNSIGNED1 inputUsage := 0; //see DueDiligence.Constants.USE_INPUT_DATA_ENUM for values/explainations
    END;


    EXPORT iDDv3BusinessAttributes := INTERFACE
      EXPORT BOOLEAN includeAssetOwnProperty := FALSE;
      EXPORT BOOLEAN includeAssetOwnAircraft := FALSE;
      EXPORT BOOLEAN includeAssetOwnWatercraft := FALSE;
      EXPORT BOOLEAN includeAssetOwnVehicle := FALSE;
      EXPORT BOOLEAN includeAccessToFundSales := FALSE;
      EXPORT BOOLEAN includeAccessToFundsProperty := FALSE;
      EXPORT BOOLEAN includeGeographic := FALSE;
      EXPORT BOOLEAN includeValidity := FALSE;
      EXPORT BOOLEAN includeStability := FALSE;
      EXPORT BOOLEAN includeIndustry := FALSE;
      EXPORT BOOLEAN includeStructureType := FALSE;
      EXPORT BOOLEAN includeSOSAgeRange := FALSE;
      EXPORT BOOLEAN includePublicRecordAgeRange := FALSE;
      EXPORT BOOLEAN includeShellShelf := FALSE;
      EXPORT BOOLEAN includeMatchLevel := FALSE;
      EXPORT BOOLEAN includeStateLegalEvent := FALSE;
      EXPORT BOOLEAN includeFederalLegalEvent := FALSE; //not yet implemented
      EXPORT BOOLEAN includeFederalLegalMatchLevel := FALSE; //not yet implemented
      EXPORT BOOLEAN includeCivilLegalEvent := FALSE;
      EXPORT BOOLEAN includeCivilLegalEventFilingAmount := FALSE;
      EXPORT BOOLEAN includeOffenseType := FALSE;
      EXPORT BOOLEAN includeBEOProfLicense := FALSE;
      EXPORT BOOLEAN includeBEOUSResidency := FALSE;
      EXPORT BOOLEAN includeBEOAccessToFundsProperty := FALSE;
      EXPORT BOOLEAN includeLinkedBusinesses := FALSE; //not yet implemented
      EXPORT BOOLEAN includeAll := FALSE;
    END;


END;
