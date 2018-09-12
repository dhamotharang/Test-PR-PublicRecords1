/*
This function sends up to 15 identities to zumigo and surveys the returned scores for firstnames, lastnames, and addresss.
If any of the 3 fields has a score between 80 to 100 inclusively, it is deemed validated/passing.
Hence there is some connection with the input phone.  
Connections are further assessed to determined the most likely owner.
*/
IMPORT Gateway,PhoneOwnership,Phones,Risk_Indicators,STD;

EXPORT AppendCarrierValidations(DATASET(PhoneOwnership.Layouts.BatchOut) ds_batch_in,
                            PhoneOwnership.IParams.BatchParams inMod) := FUNCTION
	// Only processing wireless phones and only the first identity for AT&T phones
	Constants := PhoneOwnership.Constants;
	dsPhoneIdentityValidationRequest := ds_batch_in(LexisNexisMatchCode != Constants.LNMatch.INVALID AND 
													((AppendedFirstName<>'' AND AppendedSurname<>'') OR  AppendedCompanyName<>'') AND
													(AppendedPhoneServiceType=Phones.Constants.PhoneServiceType.Wireless[1] OR 
													AppendedPhoneLineType=Phones.Constants.PhoneServiceType.Wireless[1]) AND
													(AppendedCarrierName!=Constants.ATTPhone OR (AppendedCarrierName=Constants.ATTPhone AND seq = 1)));
	dsZumigoRequest :=IF(inMod.useZumigo, PROJECT(dsPhoneIdentityValidationRequest,
													TRANSFORM(Phones.Layouts.ZumigoIdentity.subjectVerificationRequest, // we need scores for subject and all REAB
																SELF.acctno:= LEFT.acctno,
																SELF.sequence_number:= LEFT.seq,
																SELF.phone:= LEFT.phone,
																SELF.lexid:= (UNSIGNED)LEFT.AppendedDID,
																SELF.first_name:= LEFT.AppendedFirstName,
																SELF.middle_name:= LEFT.AppendedMiddleName,
																SELF.last_name:= LEFT.AppendedSurname,
																SELF.nameType:= LEFT.subj2own_relationship,
																SELF.emailType:= IF(LEFT.AppendedEmailAddress<>'',LEFT.subj2own_relationship,''),
																SELF.email_address:= LEFT.AppendedEmailAddress,
																SELF.busult_id:=LEFT.ultid,
																SELF.busorg_id:=LEFT.orgid,
																SELF.bussele_id:=LEFT.seleid,
																SELF.busprox_id:=LEFT.proxid,
																SELF.buspow_id:=LEFT.powid,
																SELF.busemp_id:=LEFT.empid,
																SELF.busdot_id:=LEFT.dotid,
																SELF.business_name:=LEFT.AppendedCompanyName,
																SELF.prim_range := LEFT.AppendedStreetNumber,
																SELF.predir := LEFT.AppendedPreDirectional,
																SELF.prim_name := LEFT.AppendedStreetName,
																SELF.addr_suffix := LEFT.AppendedStreetSuffix,
																SELF.postdir := LEFT.AppendedPostDirectional,
																SELF.unit_desig := LEFT.AppendedUnitDesignator,
																SELF.sec_range := LEFT.AppendedUnitNumber,
																SELF.p_city_name := LEFT.AppendedCity,
																SELF.st := LEFT.AppendedStateCode,
																SELF.z5 := LEFT.AppendedZipCode,
																SELF.zip4 := LEFT.AppendedZipCodeExtension,
																SELF.county_name := '',
																SELF.addressType:=LEFT.subj2own_relationship,
																SELF:=LEFT)),
											DATASET([],Phones.Layouts.ZumigoIdentity.subjectVerificationRequest));
	zMod := MODULE(Phones.IParam.inZumigoParams)
		EXPORT STRING20 useCase := inMod.useCase;
		EXPORT STRING3 	productCode := inMod.productCode;
		EXPORT STRING8	billingId := inMod.billingId;
		EXPORT STRING20 productName := inMod.productName;
		EXPORT BOOLEAN 	NameAddressValidation := inMod.NameAddressValidation;
		EXPORT BOOLEAN 	AccountStatusInfo := inMod.AccountStatusInfo;
		EXPORT STRING10 optInType := inMod.optInType;
		EXPORT STRING5 	optInMethod := inMod.optInMethod;
		EXPORT STRING3 	optinDuration := inMod.optinDuration;
		EXPORT STRING 	optinId := inMod.optinId;
		EXPORT STRING 	optInVersionId := inMod.optInVersionId;
		EXPORT STRING15 optInTimestamp := IF(inMod.optInTimestamp='',(STRING)STD.Date.CurrentDate(TRUE)+' '+(STRING)STD.Date.CurrentTime(TRUE),inMod.optInTimestamp);			
		EXPORT DATASET(Gateway.Layouts.Config) gateways := inMod.gateways(Gateway.Configuration.IsZumigoIdentity(servicename));
	END;
	
	dsZumigoScores := IF(EXISTS(dsZumigoRequest),Phones.GetZumigoIdentity(dsZumigoRequest,zMod,inMod.GLBPurpose,inMod.DPPAPurpose,inMod.DataRestrictionMask,inMod.Industryclass,inMod.ApplicationType),
												DATASET([],Phones.Layouts.ZumigoIdentity.zOut));
	// fields are only populated for output when Zumigo matches
	// otherwise REAB data is preserved for Accudata search
	// ValidatedRecord indicates thoses confirmed by Zumigo.
	// Any match of firstname, lastname, or address is a confirmation and hence deemed as validated.
	PhoneOwnership.Layouts.BatchOut appendZumigo(PhoneOwnership.Layouts.BatchOut l, Phones.Layouts.ZumigoIdentity.zOut r):= TRANSFORM
		FirstNameMatch := Phones.Functions.isPassZumigo(r.first_name_score);
		LastNameMatch  := Phones.Functions.isPassZumigo(r.last_name_score);
		AddressMatch   := Phones.Functions.isPassZumigo(r.addr_score);
		// business_name_score is only populated for AT&T and TMobile
		BusinessNameMatch   := Phones.Functions.isPassZumigo(r.business_name_score);
		EmailMatch   := Phones.Functions.isPassZumigo(r.email_address_score);
		validPass := FirstNameMatch OR LastNameMatch OR AddressMatch OR BusinessNameMatch OR EmailMatch;
		// Zumigo is currently returning -1 for score fields based on data submitted. 
		// Hence identity fields should be populated with blanks below as expected. 
		// Therefore no need for the additional isCancelled check.
		isCancelled := r.account_status = Phones.Constants.PhoneStatus.CANCELLED;
		isSuspended := r.account_status = Phones.Constants.PhoneStatus.SUSPENDED;
		isActive := r.account_status = Phones.Constants.PhoneStatus.ACTIVE;
		ZumigoMatch := validPass OR isCancelled;
		FullNameMatch := FirstNameMatch AND LastNameMatch; 
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.AppendedDID := IF(NOT ZumigoMatch OR FullNameMatch,l.AppendedDID,'');
		SELF.AppendedFirstName := IF(NOT ZumigoMatch OR FirstNameMatch,l.AppendedFirstName,'');
		SELF.AppendedMiddleName := IF(NOT ZumigoMatch OR FullNameMatch,l.AppendedMiddleName,'');
		SELF.AppendedSurname := IF(NOT ZumigoMatch OR LastNameMatch,l.AppendedSurname,'');
		SELF.AppendedCompanyName := IF(NOT ZumigoMatch OR BusinessNameMatch,l.AppendedCompanyName,'');
		SELF.AppendedEmailAddress := IF(NOT ZumigoMatch OR EmailMatch,l.AppendedEmailAddress,'');
		SELF.validatedRecord := ZumigoMatch;
		SELF.AppendedStreetNumber := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedStreetNumber,'');
		SELF.AppendedPreDirectional := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedPreDirectional,'');
		SELF.AppendedStreetName := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedStreetName,'');
		SELF.AppendedStreetSuffix := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedStreetSuffix,'');
		SELF.AppendedPostDirectional := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedPostDirectional,'');
		SELF.AppendedUnitDesignator := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedUnitDesignator,'');
		SELF.AppendedUnitNumber := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedUnitNumber,'');
		SELF.AppendedCity := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedCity,'');
		SELF.AppendedStateCode := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedStateCode,'');
		SELF.AppendedZipCode := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedZipCode,'');
		SELF.AppendedZipCodeExtension := IF(NOT ZumigoMatch OR AddressMatch,l.AppendedZipCodeExtension,'');
		SELF.AppendedListingName := '';
		SELF.AppendedLastDate := IF(ZumigoMatch OR isSuspended OR isActive,PhoneOwnership.Functions.TODAY,l.AppendedLastDate);	
		SELF.disconnect_status := MAP(isCancelled => Constants.DisconnectStatus.CONFIRMED_DISCONNECTED,
										isSuspended => Constants.DisconnectStatus.CONFIRMED_SUSPENDED,
										(validPass OR isActive) AND l.disconnect_status<>'' => Constants.DisconnectStatus.HISTORIC_DISCONNECT,
										l.disconnect_status);			
		SELF.source_category := l.source_category + IF(ZumigoMatch OR isSuspended OR isActive,PhoneOwnership.Constants.CARRIER,'');
		SELF.error_desc := l.error_desc + r.device_mgmt_status + IF(r.device_mgmt_status<>'',PhoneOwnership.Constants.DELIMITER,'');
		inFNameMatch := PhoneOwnership.Functions.fuzzyString(l.name_first) = PhoneOwnership.Functions.fuzzyString(l.AppendedFirstName);
		inLNameMatch := PhoneOwnership.Functions.fuzzyString(l.name_last) = PhoneOwnership.Functions.fuzzyString(l.AppendedSurname);
		businessMatch := IF(BusinessNameMatch OR l.subj2own_relationship IN Constants.BUSINESS_RELATIONS,Phones.Constants.ListingType.Business,''); 
		inputAddressMatch := Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(
																						l.appendedstreetnumber,l.appendedstreetname,l.appendedunitnumber,
																						l.prim_range,l.prim_name,l.sec_range,
																						Risk_Indicators.AddrScore.zip_score(l.appendedzipcode,l.zip),
																						Risk_Indicators.AddrScore.citystate_score(l.appendedcity,l.appendedstatecode,l.p_city_name,l.st,'')));	
		SELF.LexisNexisMatchCode := MAP(inFNameMatch AND FirstNameMatch AND inputAddressMatch AND AddressMatch => Constants.LNMatch.NAME + Constants.LNMatch.ADDRESS + Constants.LNMatch.PHONE,
										inLNameMatch AND LastNameMatch AND inputAddressMatch AND AddressMatch AND NOT FirstNameMatch => Constants.LNMatch.NAME + Constants.LNMatch.RELATIVE + Constants.LNMatch.ADDRESS + Constants.LNMatch.PHONE,
										inFNameMatch AND FirstNameMatch AND NOT AddressMatch => Constants.LNMatch.NAME + Constants.LNMatch.PHONE,
										inLNameMatch AND LastNameMatch AND NOT FirstNameMatch AND NOT AddressMatch => Constants.LNMatch.NAME + Constants.LNMatch.RELATIVE + Constants.LNMatch.PHONE,
										LastNameMatch AND inputAddressMatch AND businessMatch='' AND AddressMatch => Constants.LNMatch.RELATIVE + Constants.LNMatch.ADDRESS + Constants.LNMatch.PHONE,
										inputAddressMatch AND AddressMatch => Constants.LNMatch.ADDRESS + Constants.LNMatch.PHONE,
										businessMatch='' AND LastNameMatch => Constants.LNMatch.RELATIVE + Constants.LNMatch.PHONE,
										isCancelled => Constants.LNMatch.CELL,
										l.LexisNexisMatchCode) + businessMatch;
		SELF.reason_codes := MAP(fullNameMatch => Constants.Reason_Codes.MATCH,
									isCancelled => Constants.Reason_Codes.CONFIRMED_DISCONNECTED,
									ZumigoMatch AND NOT (FirstNameMatch OR LastNameMatch) => Constants.Reason_Codes.NO_IDENTITY, 
									l.reason_codes) + IF(isSuspended, Constants.Reason_Codes.CONFIRMED_SUSPENDED,'');
		SELF.TotalZumigoScore := IF(FirstNameMatch OR Phones.Functions.isValidZumigo(r.first_name_score),r.first_name_score,0) + 
								IF(LastNameMatch OR Phones.Functions.isValidZumigo(r.last_name_score),r.last_name_score,0) +
								IF(AddressMatch OR Phones.Functions.isValidZumigo(r.addr_score),r.addr_score,0) +
								IF(BusinessNameMatch OR Phones.Functions.isValidZumigo(r.business_name_score),r.business_name_score,0) +
								IF(EmailMatch OR Phones.Functions.isValidZumigo(r.email_address_score),r.email_address_score,0); //preserved to sort by highest valued owner based on summed scores.
								// ownership_index for Zumigo will be used to sort passing records.
		SELF.ownership_index := MAP(isCancelled => Constants.Ownership.enumIndex.INVALID,
									FirstNameMatch => Constants.Ownership.enumIndex.HIGH,
									LastNameMatch => Constants.Ownership.enumIndex.MEDIUM_HIGH,
									AddressMatch OR BusinessNameMatch OR EmailMatch => Constants.Ownership.enumIndex.MEDIUM,
									Constants.Ownership.enumIndex.UNDETERMINED);
								
		SELF.ownership_likelihood := MAP(isCancelled => Constants.Ownership.NONE,
											(l.subj2own_relationship = Constants.Relationship.SUBJECT AND FirstNameMatch) OR (FirstNameMatch AND inFNameMatch AND inLNameMatch) => Constants.Ownership.HIGH,
										 	inLNameMatch AND NOT inFNameMatch => Constants.Ownership.MEDIUM_HIGH,
											AddressMatch AND NOT FirstNameMatch AND NOT LastNameMatch => Constants.Ownership.MEDIUM,
											NOT ZumigoMatch AND l.AppendedCarrierName=Constants.ATTPhone => Constants.Ownership.UNDETERMINED,
											(LastNameMatch AND NOT FirstNameMatch) OR l.subj2own_relationship = Constants.Relationship.RELATIVE => Constants.Ownership.MEDIUM,
											l.subj2own_relationship NOT IN ['',Constants.Relationship.INVALID,Constants.Relationship.RELATIVE,Constants.Relationship.SUBJECT,Constants.Relationship.NONE] => Constants.Ownership.MEDIUM_HIGH,
											l.ownership_likelihood);
		SELF.subj2own_relationship := MAP(AddressMatch AND businessMatch='' AND NOT FirstNameMatch AND NOT LastNameMatch=> Constants.Relationship.ROOMMATE,
										AddressMatch AND businessMatch<>'' => Constants.Relationship.BUSINESS,
										LastNameMatch AND NOT FirstNameMatch AND businessMatch='' => Constants.Relationship.RELATIVE,
										isCancelled => Constants.Relationship.NO_OWNER, // No valid owner
										l.subj2own_relationship);								
		SELF := l;
	END;
	dsPhoneswZumigoValidations :=  JOIN(ds_batch_in,dsZumigoScores,
										LEFT.acctno = RIGHT.acctno AND
										LEFT.seq = RIGHT.sequence_number,
										appendZumigo(LEFT,RIGHT),
										LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));	

	PhoneOwnership.Layouts.Final zResults () := TRANSFORM
		SELF.Results := dsPhoneswZumigoValidations;
		SELF.ZumigoResults:= dsZumigoScores;
        SELF:=[];
	END;

	zFinal := DATASET([zResults()])[1];    

	#IF(PhoneOwnership.Constants.Debug.Zumigo)
		OUTPUT(ds_batch_in,NAMED('ZumigoREAB_ds_batch_in'));
		OUTPUT(dsZumigoRequest,NAMED('dsZumigoRequest'));
		OUTPUT(dsZumigoScores,NAMED('dsZumigoScores'));
		OUTPUT(dsPhoneswZumigoValidations,NAMED('dsPhoneswZumigoValidations'));
	#END                            

    RETURN zFinal;

END;