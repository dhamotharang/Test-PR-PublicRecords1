IMPORT STD;

EXPORT Utilities := MODULE

	EXPORT getAnalyticsUID (DATASET(FraudGovPlatform_Services.Layouts.fragment_w_value_recs) ds_entity_rolled) := FUNCTION

		_Constants := FraudGovPlatform_Services.Constants;
		Fragment_Types_const := _Constants.Fragment_Types;
		Entity_Type_Identifier := _Constants.KelEntityIdentifier;

		ds_entityNameValue := PROJECT(ds_entity_rolled, 
														TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
															SELF.entity_name := LEFT.fragment,
															SELF.entity_value := LEFT.fragment_value,
															SELF := LEFT));

		// All the commneted Fragment Types in the below project are not supported as of now (in MVP), However, 
		// ... they will be supported for the final product. 
		analytics_uids := PROJECT(ds_entityNameValue, 
												TRANSFORM(FraudGovPlatform_Services.Layouts.elementNidentity_uid_recs,
													uid := CASE(LEFT.entity_name,
																			// Fragment_Types_const.DEVICE_ID_FRAGMENT
																			Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => Entity_Type_Identifier._DLNUMBER + HASH64(STD.Str.FindReplace(LEFT.entity_value,_Constants.FRAGMENT_SEPARATOR,'|')),
																			// Fragment_Types_const.GEOLOCATION_FRAGMENT
																			Fragment_Types_const.IP_ADDRESS_FRAGMENT => Entity_Type_Identifier._IPADDRESS + HASH64(LEFT.entity_value),
																			// Fragment_Types_const.MAILING_ADDRESS_FRAGMENT
																			// Fragment_Types_const.NAME_FRAGMENT
																			Fragment_Types_const.PERSON_FRAGMENT => Entity_Type_Identifier._LEXID + LEFT.entity_value,
																			Fragment_Types_const.PHONE_FRAGMENT => Entity_Type_Identifier._PHONENO + LEFT.entity_value,
																			Fragment_Types_const.SSN_FRAGMENT => Entity_Type_Identifier._SSN +  HASH64(LEFT.entity_value),
																			//Calculating the tree_uid for the physical address value. Calculation is '_09'+HASH(address_1|address_2)
																			Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => Entity_Type_Identifier._PHYSICAL_ADDRESS + HASH64(STD.Str.FindReplace(LEFT.entity_value,_Constants.FRAGMENT_SEPARATOR,'|')),
																			Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => Entity_Type_Identifier._BANKACCOUNT + HASH64(STD.Str.FindReplace(LEFT.entity_value,_Constants.FRAGMENT_SEPARATOR,'|')),
																			Fragment_Types_const.EMAIL_FRAGMENT => Entity_Type_Identifier._EMAIL + HASH64(LEFT.entity_value),
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
