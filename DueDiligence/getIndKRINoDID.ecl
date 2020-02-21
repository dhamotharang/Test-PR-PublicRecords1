IMPORT DueDiligence;


EXPORT getIndKRINoDID(DATASET(DueDiligence.Layouts.Indv_Internal) noDIDs) := FUNCTION

    //individual not found
    STRING10 INVALID_INDIVIDUAL_FLAGS := 'FFFFFFFFFF';
    STRING2 INVALID_INDIVIDUAL_SCORE := '-1';


    //all of the person with no information(DID) will get the value of -1
    RETURN PROJECT(noDIDs, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
                                      SELF.PerAssetOwnProperty := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAssetOwnProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAssetOwnAircraft := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAssetOwnAircraft_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAssetOwnWatercraft := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAssetOwnWatercraft_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAssetOwnVehicle := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAssetOwnVehicle_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAccessToFundsProperty := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAccessToFundsProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAccessToFundsIncome := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAccessToFundsIncome_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerGeographic := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerGeographic_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerMobility := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerMobility_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerStateLegalEvent := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerStateLegalEvent_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      // SELF.PerFederalLegalEvent := INVALID_INDIVIDUAL_SCORE;
                                      // SELF.PerFederalLegalEvent_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      // SELF.PerFederalLegalMatchLevel := INVALID_INDIVIDUAL_SCORE;
                                      // SELF.PerFederalLegalMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerCivilLegalEvent := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerCivilLegalEvent_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerOffenseType := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerOffenseType_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAgeRange := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAgeRange_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerIdentityRisk := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerIdentityRisk_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerUSResidency := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerUSResidency_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerMatchLevel := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerAssociates := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerAssociates_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerProfLicense := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerProfLicense_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      SELF.PerBusAssociations := INVALID_INDIVIDUAL_SCORE;
                                      SELF.PerBusAssociations_Flag := INVALID_INDIVIDUAL_FLAGS;
                                      // SELF.PerEmploymentIndustry := INVALID_INDIVIDUAL_SCORE;
                                      // SELF.PerEmploymentIndustry_Flags := INVALID_INDIVIDUAL_FLAGS
                                      SELF := LEFT;));

END;