IMPORT ut,STD;

EXPORT Utilities := MODULE

  SHARED getKnownFraudCodeDescLookup (String KnownFraudCode) := FUNCTION
		KnownFraudDesc := CASE(KnownFraudCode,
													'1000' => 'Confirmed as stolen or compromised',
													'1001' => 'Suspected stolen or compromised',
													'1002' => 'Confirmed out-of-state',
													'1003' => 'Suspected out-of-state',
													'1004' => 'Under investigation',
													'1005' => 'Confirmed association with fraud ring',
													'1006' => 'Suspected association with fraud ring',
													'1007' => 'On known watch list',
													'2000' => 'Fraud - Multiple categories',
													'2001' => 'Fraud - False Pretense',
													'2002' => 'Fraud - Criminal Impersonation',
													'2003' => 'Fraud - Misrepresentation',
													'2004' => 'Fraud - Food Stamp',
													'2005' => 'Fraud - Deceit',
													'2006' => 'Fraud - Tax',
													'2007' => 'Fraud - Exploitation',
													'2008' => 'Fraud - Computer Fraud',
													'2009' => 'Fraud - Multiple HHS Programs',
													'2010' => 'Fraud - Medicaid Beneficiary',
													'2011' => 'Fraud - Medicaid Provider',
													'2012' => 'Fraud - Medicaid Claims',
													'2013' => 'Fraud - Unemployment Insurance Business',
													'2014' => 'Fraud - Unemployment Insurance Beneficiary',
													'2015' => 'Fraud - Unemployment Insurance Claims',
													'2016' => 'Fraud - Collusion',
													'2017' => 'Fraud - False Welfare',
													'2018' => 'Fraud - Falsification',
													'2019' => 'Fraud - False Statements & Reports',
													'3000' => 'Theft - Breach of trust',
													'3001' => 'Theft - Multiple Categories',
													'3002' => 'Theft - Credit Card',
													'3003' => 'Theft - Deception',
													'3004' => 'Theft - Embezzlement',
													'3005' => 'Theft - Multiple Categories',
													'3006' => 'Theft - Trover',
													'3007' => 'Theft - Services',
													'4000' => 'Forgery - Multiple categories',
													'4001' => 'Forgery - Counterfeit',
													'4002' => 'Bad Check - Multiple Categories',
													'4003' => 'Bad Check - Checks',
													'4004' => 'Bad Check - Funds',
													'4005' => 'False Personation',
													'4006' => 'Money Laundering',
													'4007' => 'Tampering',
													'' );
		RETURN KnownFraudDesc;
	END;

 EXPORT getKnownFraudDescriptionFromPayload(	string8 event_date = '', 
																							string8 event_end_date = '', 
																							string75 event_type1 = '', string75 event_type2 = '', string75 event_type3 = '') := FUNCTION

    dString1 := '(On: ' + ut.date_YYYYMMDDtoDateSlashed(event_date) + ') ';
    dString2 := '(From: '+ ut.date_YYYYMMDDtoDateSlashed(event_date) + ' To: ' + ut.date_YYYYMMDDtoDateSlashed(event_end_date) + ') ';

    eventDates := IF(event_date=event_end_date, dString1, dString2);
    eventType1 := ',' + getKnownFraudCodeDescLookup(event_type1); 
    eventType2 := ',' + getKnownFraudCodeDescLookup(event_type2);
    eventType3 := ',' + getKnownFraudCodeDescLookup(event_type3);

    RETURN STD.Str.CleanSpaces(eventDates + eventType1 + eventType2 + eventType3);
  END;
	
	EXPORT getAnalyticsUID (DATASET(FraudGovPlatform_Services.Layouts.fragment_w_value_recs) ds_entity_rolled) := FUNCTION
				
		ds_entityNameValue := PROJECT(ds_entity_rolled, 
														TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
															SELF.entity_name := LEFT.fragment,
															SELF.entity_value := LEFT.fragment_value,
															SELF := LEFT));
		
		Fragment_Types_const := FraudGovPlatform_Services.Constants.Fragment_Types;
		Entity_Type_Identifier := FraudGovPlatform_Services.Constants.KelEntityIdentifier;
		// All the commneted Fragment Types in the below project are not supported as of now (in MVP), However, 
		// ... they will be supported for the final product. 
		analytics_uids := PROJECT(ds_entityNameValue, 
												TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
													uid := CASE(LEFT.entity_name,
																			// Fragment_Types_const.DEVICE_ID_FRAGMENT
																			// Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT
																			// Fragment_Types_const.GEOLOCATION_FRAGMENT
																			Fragment_Types_const.IP_ADDRESS_FRAGMENT => Entity_Type_Identifier._IPADDRESS + HASH32(LEFT.entity_value),
																			// Fragment_Types_const.MAILING_ADDRESS_FRAGMENT
																			// Fragment_Types_const.NAME_FRAGMENT
																			Fragment_Types_const.PERSON_FRAGMENT => Entity_Type_Identifier._LEXID + LEFT.entity_value,
																			Fragment_Types_const.PHONE_FRAGMENT => Entity_Type_Identifier._PHONENO + LEFT.entity_value,
																			//Calculating the tree_uid for the physical address value. Calculation is '_09'+HASH(address_1,address_2)
																			Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => 
																					Entity_Type_Identifier._PHYSICAL_ADDRESS + HASH32(regexfind('(.*)@@@(.*)$',LEFT.entity_value,1),regexfind('(.*)@@@(.*)$',LEFT.entity_value,2)),
																			Fragment_Types_const.SSN_FRAGMENT => Entity_Type_Identifier._SSN +  LEFT.entity_value,
																			// Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => '' + LEFT.entity_value,
																			'');

													SELF.tree_uid := uid;
													SELF.entity_context_uid := uid;
													SELF := LEFT));
		RETURN analytics_uids;
	END;
	
	EXPORT GetRiskLevel (integer RiskScore) := FUNCTION
		risk_level := MAP(RiskScore > 0 AND  RiskScore <= 25 => 'LOW',
											RiskScore > 25 AND  RiskScore <= 75 => 'MEDIUM',
											RiskScore > 75 => 'HIGH', 
											'');
		return risk_level;
	END;
END;
