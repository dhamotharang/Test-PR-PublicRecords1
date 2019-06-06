IMPORT ut,STD;

EXPORT Utilities := MODULE

  SHARED getKnownFraudCodeDescLookup (String KnownFraudCode) := FUNCTION
		KnownFraudDesc := CASE(KnownFraudCode,
													'100' => 'SSN linked to fraudulent activity',
													'101' => 'SSN linked to stolen identity',
													'200' => 'DL has expired',
													'201' => 'DL has been revoked',
													'202' => 'DL is outside of {state}',
													'203' => 'DL linked to fraudulent activity',
													'204' => 'DL linked to stolen identity',
													'300' => 'Address is a virtual mail box',
													'301' => 'Address linked to fraudulent activity',
													'302' => 'Address linked to criminal activity',
													'303' => 'Address linked to stolen identity',
													'400' => 'Phone linked to fraudulent activity',
													'401' => 'Phone number is disposable',
													'402' => 'Phone linked to stolen identity',
													'500' => 'Email is disposable',
													'501' => 'Email linked to fraudulent activity',
													'502' => 'Email linked to stolen identity',
													'600' => 'IP Address is outside of {state}',
													'601' => 'IP Address linked to fraudulent activity',
													'602' => 'IP Address is outside of {country}',
													'603' => 'IP Address linked to stolen identity',
													'604' => 'IP Address is from a proxy',
													'605' => 'IP Address is invalid',
													'1000' => 'High Risk Internet Service Provider',
													'1001' => 'Risky Internet Service Provider',
													'800' => 'High Risk Bank Account/Routing Number',
													'801' => 'Risky Bank Account/Routing Number',
													'802' => 'Bank Account/Routing Number linked to stolen identity',
													'10000' => 'Identity confirmed as stolen or compromised',
													'10001' => 'Identity suspected as stolen or compromised',
													'10002' => 'Identity confirmed as outside of {state}',
													'10003' => 'Identity suspected as outside of {state}',
													'10004' => 'Identity under investigation',
													'10005' => 'Identity likely associated with fraud ring',
													'10006' => 'Identity potentially associated with fraud ring',
													'10007' => 'Identity is on known watch list',
													'11000' => 'Identity previously linked to multiple fraudulent activities',
													'11001' => 'Identity previously linked to False Pretense offense',
													'11002' => 'Identity previously linked to Criminal Impersonation offense',
													'11003' => 'Identity previously linked to Misrepresentation offense',
													'11004' => 'Identity previously linked to Food Stamp fraud',
													'11005' => 'Identity previously linked to Deception offense',
													'11006' => 'Identity previously linked to Tax fraud',
													'11007' => 'Identity previously linked to Exploitation offense',
													'11008' => 'Identity previously linked to Computer fraud',
													'11009' => 'Identity previously linked to multiple HHS programs fraud',
													'11010' => 'Identity previously linked to Medicaid Beneficiary fraud',
													'11011' => 'Identity previously linked to Medicaid Provider fraud',
													'11012' => 'Identity previously linked to Medicaid Claims fraud',
													'11013' => 'Identity previously linked to Unemployment Insurance Business fraud',
													'11014' => 'Identity previously linked to Unemployment Insurance Beneficiary fraud',
													'11015' => 'Identity previously linked to Unemployment Insurance Claims fraud',
													'11016' => 'Identity previously linked to Collusive activity',
													'11017' => 'Identity previously linked to Welfare fraud',
													'11018' => 'Identity previously linked to Falsification',
													'11019' => 'Identity previously linked to False Statements and Reports offense',
													'12000' => 'Identity previously linked to Breach of trust offense',
													'12001' => 'Identity previously linked to multiple theft offenses',
													'12002' => 'Identity previously linked to Credit Card theft',
													'12003' => 'Identity previously linked to Deception',
													'12004' => 'Identity previously linked to Embezzlement',
													'12006' => 'Identity previously linked to Trover',
													'12007' => 'Identity previously linked to Services theft',
													'13000' => 'Identity previously linked to multiple forgeries',
													'13001' => 'Identity previously linked to Counterfeit',
													'13002' => 'Identity previously linked to multiple bad check offenses',
													'13003' => 'Identity previously linked to bad check offense',
													'13005' => 'Identity previously linked to False personation offense',
													'13006' => 'Identity previously linked to Money Laundering',
													'13007' => 'Identity previously linked to Tampering offense',
													'14000' => 'Identity associated to NAC level 1 collision',
													'14001' => 'Identity associated to NAC level 2 collision',
													'' );
		RETURN KnownFraudDesc;
	END;

 EXPORT getKnownFraudDescriptionFromPayload(	string8 event_date = '', 
																							string8 event_end_date = '', 
																							string75 event_type1 = '', string75 event_type2 = '', string75 event_type3 = '') := FUNCTION

    dString1 := '(On: ' + ut.date_YYYYMMDDtoDateSlashed(event_date) + ') ';
    dString2 := '(From: '+ ut.date_YYYYMMDDtoDateSlashed(event_date) + ' To: ' + ut.date_YYYYMMDDtoDateSlashed(event_end_date) + ') ';

    eventDates := MAP(event_date <> '' AND event_date=event_end_date => dString1, 
											event_date <> '' AND event_date <> event_end_date => dString2,
											'');
    eventType1 := IF(event_type1 <> '', ' ' + getKnownFraudCodeDescLookup(event_type1),''); 
    eventType2 := IF(event_type2 <> '', ', ' + getKnownFraudCodeDescLookup(event_type2),'');
    eventType3 := IF(event_type3 <> '', ', ' + getKnownFraudCodeDescLookup(event_type3),'');

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
																			Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => Entity_Type_Identifier._DLNUMBER + HASH32(LEFT.entity_value),
																			// Fragment_Types_const.GEOLOCATION_FRAGMENT
																			Fragment_Types_const.IP_ADDRESS_FRAGMENT => Entity_Type_Identifier._IPADDRESS + HASH32(LEFT.entity_value),
																			// Fragment_Types_const.MAILING_ADDRESS_FRAGMENT
																			// Fragment_Types_const.NAME_FRAGMENT
																			Fragment_Types_const.PERSON_FRAGMENT => Entity_Type_Identifier._LEXID + LEFT.entity_value,
																			Fragment_Types_const.PHONE_FRAGMENT => Entity_Type_Identifier._PHONENO + LEFT.entity_value,
																			Fragment_Types_const.SSN_FRAGMENT => Entity_Type_Identifier._SSN +  LEFT.entity_value,
																			//Calculating the tree_uid for the physical address value. Calculation is '_09'+HASH(address_1|address_2)
																			Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => Entity_Type_Identifier._PHYSICAL_ADDRESS + HASH32(regexfind('(.*)@@@(.*)$',LEFT.entity_value,1) + '|' + regexfind('(.*)@@@(.*)$',LEFT.entity_value,2)),
																			Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => Entity_Type_Identifier._BANKACCOUNT + HASH32(regexfind('(.*)@@@(.*)$',LEFT.entity_value,1) + '|' + regexfind('(.*)@@@(.*)$',LEFT.entity_value,2)),
																			Fragment_Types_const.EMAIL_FRAGMENT => Entity_Type_Identifier._EMAIL + HASH32(LEFT.entity_value),
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

	EXPORT Yesterday := STD.Date.AdjustDate(STD.Date.Today(),0,0,-1);
END;
