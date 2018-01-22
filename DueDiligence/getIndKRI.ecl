﻿IMPORT DueDiligence;

EXPORT getIndKRI (DATASET(DueDiligence.Layouts.Indv_Internal) indivs) := FUNCTION;
	//individual not found
	STRING10 INVALID_INDIVIDUAL_FLAGS := 'FFFFFFFFFF';
	STRING2 INVALID_INDIVIDUAL_SCORE := '-1';

	//We have both companies with and without BIP IDs
	withDIDs := indivs(individual.did <> DueDiligence.Constants.NUMERIC_ZERO);
	noDIDs := indivs(individual.did = DueDiligence.Constants.NUMERIC_ZERO);
	
	DueDiligence.Layouts.Indv_Internal IndvKRIs(indivs le) := TRANSFORM

		SELF := le;
	END;


	kriIndv := PROJECT(SORT(withDIDs, seq), IndvKRIs(LEFT));
	kriUnknownIndv := PROJECT(noDIDs, TRANSFORM(DueDiligence.Layouts.Indv_Internal,
																							// SELF.PerAssetOwnProperty := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssetOwnAircraft := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnAircraft_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssetOwnWatercraft := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnWatercraft_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssetOwnVehicle := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssetOwnVehicle_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAccessToFundsProperty := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAccessToFundsProperty_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAccessToFundsIncome := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAccessToFundsIncome_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerGeographic := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerGeographic_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerMobility := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerMobility_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerLegalCriminal := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerLegalCriminal_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerLegalCivil := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerLegalCivil_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerLegalTraffInfr := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerLegalTraffInfr_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerLegalTypes := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerLegalTypes_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerHighRiskNewsProfiles := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerHighRiskNewsProfiles_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAgeRange := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAgeRange_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerIdentityRisk := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerIdentityRisk_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerUSResidency := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerUSResidency_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerMatchLevel := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerMatchLevel_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerAssociatesIndex := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerAssociatesIndex_Flag := INVALID_INDIVIDUAL_FLAGS;
																							// SELF.PerProfLicense := INVALID_INDIVIDUAL_SCORE;
																							// SELF.PerProfLicense_Flag := INVALID_INDIVIDUAL_FLAGS;
																							SELF := LEFT;));



	RETURN kriIndv + kriUnknownIndv;
				 
END;