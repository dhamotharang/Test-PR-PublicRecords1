/*
This function compares input records with inhouse phones data to identify a match.
Otherwise, if no match then populate output with known inhouse phone info.
*/
IMPORT Phones, PhoneOwnership, Risk_Indicators, STD,ut;
EXPORT AppendLNPhonesData(DATASET(PhoneOwnership.Layouts.BatchOut) ds_batch_in,
								    PhoneOwnership.IParams.BatchParams inMod) := FUNCTION
	Constants := PhoneOwnership.Constants;	
	Functions := PhoneOwnership.Functions;						
	dsLNPhonesRequest := PROJECT(DEDUP(SORT(ds_batch_in,acctno,phone),acctno),TRANSFORM(Phones.Layouts.PhoneIdentity,
																						//preserve identified landline phone type
																							SELF.append_phone_type:= IF(LEFT.AppendedPhoneLineType=Phones.Constants.PhoneServiceType.Landline[1],LEFT.AppendedPhoneLineType,LEFT.AppendedPhoneServiceType),
																							SELF:=LEFT,SELF:=[]));
	
	//passing through phones to get latest LN phone associates. Trying to match with relatives identified or append known phone record.
	dsLNIdentities := SORT(Phones.GetLNIdentity_byPhone(dsLNPhonesRequest,inMod.GLBPurpose,inMod.DPPAPurpose,inMod.DataRestrictionMask,inMod.Industryclass),acctno,phone,lname='',fname='',-dt_last_seen,dt_first_seen);

	// Note that ownership is defined by relationship with input - this will be replaced with a scoring model later.
	PhoneOwnership.Layouts.BatchOut appendLNData(PhoneOwnership.Layouts.BatchOut l, Phones.Layouts.PhoneIdentity r) := TRANSFORM
		match := r.phone <> '';
		recordNameMatch := match AND Functions.evaluateNameMatch(l.AppendedFirstName,l.AppendedSurname,r.fname,r.lname) = Constants.NameMatch.FIRSTLAST;
		inNameMatch := Functions.evaluateNameMatch(l.name_first,l.name_last,r.fname,r.lname);
		inputNameMatch :=	match AND inNameMatch  = Constants.NameMatch.FIRSTLAST;
		blankName := (l.AppendedFirstName ='' AND l.AppendedSurname='') OR l.AppendedListingName='';
		noCallerName:= match AND (l.AppendedListingName='' OR NOT l.validatedRecord);
		// internalPhoneMatch := match AND blankName;// (OR nameMatch='');
		noOwner := NOT match AND (blankName OR NOT l.validatedRecord); //(OR inMod.search_level = Constants.SearchLevel.BASIC);
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.AppendedDID := IF(noOwner OR noCallerName,(STRING)r.did,'');
		SELF.AppendedFirstName := IF(noOwner OR noCallerName,r.fname,'');
		SELF.AppendedMiddleName := IF(noOwner OR noCallerName,r.mname,'');
		SELF.AppendedSurname := IF(noOwner OR noCallerName,r.lname,'');
		SELF.AppendedListingName := IF(l.AppendedListingName='',r.listed_name,l.AppendedListingName);
		SELF.validatedRecord := l.validatedRecord OR match;	
		SELF.AppendedFirstDate := ut.Min2(l.AppendedFirstDate,(UNSIGNED)r.dt_first_seen);
		SELF.AppendedLastDate := MAX((UNSIGNED)r.dt_last_seen,l.AppendedLastDate);
		SELF.AppendedCompanyName := IF(match,r.companyname,'');
		SELF.AppendedStreetNumber := IF(match,r.prim_range,'');
		SELF.AppendedPreDirectional := IF(match,r.predir,'');
		SELF.AppendedStreetName := IF(match,r.prim_name,'');
		SELF.AppendedStreetSuffix := IF(match,r.suffix,'');
		SELF.AppendedPostDirectional := IF(match,r.postdir,'');
		SELF.AppendedUnitDesignator := IF(match,r.unit_desig,'');
		SELF.AppendedUnitNumber := IF(match,r.sec_range,'');
		SELF.AppendedCity := IF(match,r.city_name,'');
		SELF.AppendedStateCode := IF(match,r.st,'');
		SELF.AppendedZipCode := IF(match,r.zip,'');
		SELF.AppendedZipCodeExtension := IF(match,r.zip4,'');
		nameMatch := IF(STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.NAME,false) OR inNameMatch > Constants.NameMatch.NONE,Constants.LNMatch.NAME,'');
		//********************evaluate data match for LexisNexisMatchCode*******************************************
		containsLexID 	 := STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.LEXID,FALSE);
		containsRelative := STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.RELATIVE,FALSE);
		containsEmployer := STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.EMPLOYER,FALSE);
		includeRelation := containsLexID OR containsRelative OR containsEmployer;	
		sameDID := (UNSIGNED)l.AppendedDID > 0 AND (UNSIGNED)l.AppendedDID = r.DID;
		lexIDMatch := NOT includeRelation AND sameDID;

		// personMatch := match AND (lexIDMatch OR nameMatch<>'');
		addressMatch := IF(Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore( //matching best address
																		l.AppendedStreetNumber,l.AppendedStreetName,l.AppendedUnitNumber,
																		r.prim_range,r.prim_name,r.sec_range,
																		Risk_Indicators.AddrScore.zip_score(l.AppendedZipCode,r.zip),
																		Risk_Indicators.AddrScore.citystate_score(l.AppendedCity,l.AppendedStateCode,r.city_name,r.st,''))),
																		Constants.LNMatch.ADDRESS,'');
		relationalMatch := MAP(LexIDMatch => Constants.LNMatch.LEXID,
								containsRelative => Constants.LNMatch.RELATIVE,
								containsEmployer => Constants.LNMatch.EMPLOYER,
								'');
										
		includeEntity := nameMatch <> '' OR addressMatch <> '' OR relationalMatch <> '';			
		
		phoneMatch := IF(includeEntity,Constants.LNMatch.PHONE,'');
		businessMatch := IF(r.ActiveFlag='A' AND (r.companyname<>'' OR r.seleid > 0 OR r.bdid > 0),Constants.LNMatch.BUSINESS,'');
		noEntityMatch := MAP(NOT includeEntity AND l.AppendedPhoneLineType = Phones.Constants.PhoneServiceType.Wireless[1] => Constants.LNMatch.CELL,
							(businessMatch <> '' AND nameMatch = '' AND relationalMatch = '') AND (addressMatch<>'' OR l.AppendedPhoneLineType <> Phones.Constants.PhoneServiceType.Wireless[1]) => Constants.LNMatch.BUSINESS,
							NOT includeEntity AND (l.AppendedPhoneLineType <> Phones.Constants.PhoneServiceType.Wireless[1] AND businessMatch = '') => Constants.LNMatch.NON_CELL_CONSUMER,
							'');
		// subjectMatch := match AND((l.did > 0 AND l.did IN [(UNSIGNED)l.AppendedDID,r.did]) OR (l.name_first IN [r.fname,l.AppendedFirstName] AND l.name_last IN [r.lname,l.AppendedSurname])) AND
										// l.subj2own_relationship = Constants.Relationship.SUBJECT;
		badNumber := l.LexisNexisMatchCode=Constants.LNMatch.INVALID;
		SELF.LexisNexisMatchCode := MAP(badNumber => Constants.LNMatch.INVALID,
										noOwner => Constants.LNMatch.NONE,
										nameMatch + relationalMatch + addressMatch + phoneMatch + noEntityMatch);
		//********************determine phone Ownership*******************************************
		SELF.subj2own_relationship := MAP(inputNameMatch AND recordNameMatch  => Constants.Relationship.SUBJECT,
											badNumber => Constants.Relationship.INVALID, 
											recordNameMatch => l.subj2own_relationship,
											NOT sameDID AND NOT recordNameMatch AND NOT inputNameMatch => Constants.Relationship.NONE,
											noOwner OR blankName => Constants.Relationship.NONE,
											l.subj2own_relationship);
		isDisconnected := l.disconnect_status = Constants.DisconnectStatus.DISCONNECTED;
		isSuspended	   := l.disconnect_status = Constants.DisconnectStatus.CONFIRMED_SUSPENDED;
		isCloseRelative := recordNameMatch AND l.subj2own_relationship NOT IN ['',Constants.Relationship.INVALID,Constants.Relationship.RELATIVE,Constants.Relationship.SUBJECT,Constants.Relationship.NONE];
		SELF.reason_codes := MAP(badNumber => Constants.Reason_Codes.INVALID_NUMBER,
								 isDisconnected AND l.reason_codes<>'' => l.reason_codes + Constants.Reason_Codes.DISCONNECTED,
								Functions.GetReasonCodes(nameMatch<>'' OR sameDID,noOwner,isDisconnected,isSuspended));	
		ownership := MAP(inputNameMatch AND recordNameMatch => Constants.Ownership.enumIndex.HIGH,
						(recordNameMatch OR inputNameMatch) AND l.subj2own_relationship=Constants.Relationship.SUBJECT => Constants.Ownership.enumIndex.HIGH,
						(recordNameMatch OR inputNameMatch) AND isCloseRelative => Constants.Ownership.enumIndex.MEDIUM_HIGH,
						(recordNameMatch OR inputNameMatch) AND l.subj2own_relationship = Constants.Relationship.RELATIVE => Constants.Ownership.enumIndex.MEDIUM,
						noOwner => Constants.Ownership.enumIndex.UNDETERMINED,
						NOT inputNameMatch => Constants.Ownership.enumIndex.LOW,									
						l.ownership_index);
		SELF.ownership_index := IF(badNumber,Constants.Ownership.enumIndex.INVALID,ownership);
		SELF.ownership_likelihood := IF(badNumber,Constants.Ownership.INVALID,Functions.getOwnershipValue(ownership));
		SELF.AppendedRecordType := businessMatch; 
		SELF:=l;
		SELF:=[];
	END;
	dsPhoneswLNData := JOIN(ds_batch_in,dsLNIdentities,
						LEFT.phone=RIGHT.phone AND
						(((UNSIGNED)LEFT.AppendedDID > 0 AND LEFT.AppendedDID = (STRING)RIGHT.DID) OR
						//account for name or company matches
						(Functions.fuzzyString(LEFT.AppendedFirstName) = Functions.fuzzyString(RIGHT.fname) AND 
							Functions.fuzzyString(LEFT.AppendedSurname) = Functions.fuzzyString(RIGHT.lname)) OR
						(LEFT.AppendedListingName <> '' AND Functions.fuzzyString(LEFT.AppendedListingName) = Functions.fuzzyString(RIGHT.companyname))),
						appendLNData(LEFT,RIGHT),
						LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));	
	// If there is no match with input or associated REAB, then output gets populated with inhouse phone identities.
	noRelation := 	DEDUP(SORT(dsPhoneswLNData,acctno,-validatedRecord,appendeddid,appendedfirstname,appendedsurname,appendedlistingname,record),acctno);												
	dsDefaultLNData := JOIN(noRelation(NOT validatedRecord),dsLNIdentities,
					LEFT.phone=RIGHT.phone AND
					LEFT.AppendedFirstName ='' AND LEFT.AppendedSurname ='',
					appendLNData(LEFT,RIGHT),
					LIMIT(Constants.MAX_RECORDS,SKIP));											

	#IF(PhoneOwnership.Constants.Debug.LNPhones)
		OUTPUT(ds_batch_in,NAMED('LNPhone_ds_batch_in'));		
		OUTPUT(dsLNIdentities,NAMED('dsLNIdentities'));
		OUTPUT(dsPhoneswLNData,NAMED('dsPhoneswLNData'));
		OUTPUT(dsDefaultLNData,NAMED('dsDefaultLNData'));
	#END                    
    RETURN dsPhoneswLNData+dsDefaultLNData;
END;                