import Corp2, VehicleV2, DidVille, Business_Header, Watercraft, FAA, tools;

export LuxuryAssetTax_BatchService(STRING clientName,
																	 INTEGER4 clientId,
																	 STRING processDate,
																	 SET OF STRING2 noTaxStatesInit = ['AK','DE','MT','NH','OR'],
																	 SET OF STRING2 searchStatesInit,
																	 UNSIGNED1 DPPA_Purpose,
																	 UNSIGNED1 GLB_Purpose,
																	 STRING realTimePermissableUse,
																	 BOOLEAN onlyRVs = false, 
                                   UNSIGNED minValue = 0,
																	 BOOLEAN useRealTimeMVR = false,
																	 BOOLEAN searchVehicle = true,
																	 BOOLEAN searchAircraft = true,
																	 BOOLEAN searchWatercraft = true,
																	 STRING SSN_Masking = 'FULL') := FUNCTION

	inRec := RECORD
	  STRING2 state;
	END;
	
  allNoTaxStates := ['AK','DE','MT','NH','OR'];
  allNoTaxStatesDS :=  DATASET(allNoTaxStates, inRec);
	
  allStates := ['AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FL', 'GA', 'GU',
	              'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MH', 'MA', 
								'MI', 'FM', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 
								'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD',
								'TN', 'TX', 'UT', 'VT', 'VA', 'VI', 'WA', 'WV', 'WI', 'WY'];
	allStatesDS :=  DATASET(allStates, inRec);
	allSearchStatesDS := JOIN(allStatesDS, allNoTaxStatesDS, LEFT.state = RIGHT.state, TRANSFORM(LEFT), LEFT ONLY);
	
	noTaxStatesInitDS := DATASET(noTaxStatesInit, inRec);
	noTaxStatesValid := JOIN(noTaxStatesInitDS, allNoTaxStatesDS, LEFT.state = RIGHT.state, TRANSFORM(LEFT));
	noTaxStatesSet := SET(noTaxStatesValid, state);
  noTaxStates := IF(EXISTS(noTaxStatesValid), noTaxStatesSet, allNoTaxStates);
	
	searchStatesDS := DATASET(searchStatesInit, inRec);
	searchStatesValid := JOIN(searchStatesDS, allSearchStatesDS, LEFT.state = RIGHT.state, TRANSFORM(LEFT));
	searchStates := SET(searchStatesValid, state);

	boolean runLuxuryAssetTax := EXISTS(searchStatesValid);
	
  finalLuxTaxOut := IF(runLuxuryAssetTax,
	                     LuxuryAssetTax.ValidBatchServiceRun(clientName, clientId, processDate, noTaxStates, searchStates, 
	                                       DPPA_Purpose, GLB_Purpose, realTimePermissableUse, onlyRVs, 
																				 minValue, useRealTimeMVR, searchVehicle, searchAircraft, 
																				 searchWatercraft, SSN_Masking),
											 DATASET([], LuxuryAssetTax.Layouts.Layout_Final_Output));
	return finalLuxTaxOut;
END;