/*
This function compares callerID data from Accudata with subject and REAB identities
*/
IMPORT PhoneOwnership,Phones,Risk_Indicators,STD;
EXPORT AppendCallerName(DATASET(Phones.Layouts.AccuDataCNAM) dsCallerIDs,
						DATASET(PhoneOwnership.Layouts.BatchOut) batch_in_wREAB) := FUNCTION

	Constants := PhoneOwnership.Constants;
	Functions := PhoneOwnership.Functions;	

	dsSubmittedAccts := DEDUP(SORT(batch_in_wREAB,acctno),acctno);
	PhoneOwnership.Layouts.BatchOut formatCNAM(Phones.Layouts.AccuDataCNAM l, PhoneOwnership.Layouts.BatchOut r):= TRANSFORM
		validCNAMResponse := l.listingname<>'' AND l.listingname<>'ERROR';
		SELF.acctno := r.acctno;
		SELF.AppendedListingName := IF(validCNAMResponse,l.listingname,'');
		SELF.AppendedLastDate := IF(validCNAMResponse,Functions.TODAY,0);			
		SELF.AppendedDID := (STRING)l.did;
		SELF.AppendedFirstName := l.fname;
		SELF.AppendedMiddleName := '';
		SELF.AppendedSurname := l.lname;
		// cleaning listing name to perform a partial business name match below.
		// l.listingname is sometimes private and include city and state rather than an actual name. 
		// The name fields are populated only when there is a valid name. 
		// We have no way of knowing if CallerID Name is a person or company prior to this line.
		SELF.AppendedCompanyName := IF(l.fname<>'' OR l.lname<>'',Phones.Functions.GetCleanCompanyName(l.listingname),'');
		SELF.validatedRecord := l.availabilityindicator = 0 AND validCNAMResponse AND l.privateflag = 0;
		SELF.source_category := IF(validCNAMResponse, r.source_category+Constants.CNAM, r.source_category);
		//report error results and mark any reported bad numbers.
		SELF.error_desc := IF(l.listingname='ERROR', r.error_desc+'CNAM: '+ l.error_desc + IF(l.error_desc<>'',PhoneOwnership.Constants.DELIMITER,''),r.error_desc);			
		badNumber := STD.Str.ToLowerCase(l.error_desc) = 'missingorinvalidbtn';
		SELF.subj2own_relationship := IF(badNumber,Constants.Relationship.INVALID,'');
		SELF.LexisNexisMatchCode := IF(badNumber,Constants.LNMatch.INVALID,'');	
		SELF.reason_codes := IF(badNumber,Constants.Reason_Codes.INVALID_NUMBER,r.reason_codes); //this is to account for phone status from Zumigo
		SELF.ownership_index := IF(badNumber,Constants.Ownership.enumIndex.INVALID,Constants.Ownership.enumIndex.UNDETERMINED); //marked undetermined until connected with a known identity
		SELF.DotID := 0;
		SELF.EmpID := 0;
		SELF.POWID := 0;
		SELF.ProxID := 0;
		SELF.SELEID := 0;  
		SELF.OrgID := 0;
		SELF.UltID := 0;
		SELF.AppendedStreetNumber := '';
		SELF.AppendedPreDirectional := '';
		SELF.AppendedStreetName := '';
		SELF.AppendedStreetSuffix := '';
		SELF.AppendedPostDirectional := '';
		SELF.AppendedUnitDesignator := '';
		SELF.AppendedUnitNumber := '';
		SELF.AppendedCity := '';
		SELF.AppendedStateCode := '';
		SELF.AppendedZipCode := '';	
		SELF.AppendedZipCodeExtension := '';
		SELF.AppendedEmailAddress:='';	
		//If we have disconnect info but Accudata returns a valid name then we update disconnect_status to indicate that disconnect info is POSSIBLY old.
		SELF.disconnect_status := IF(r.disconnect_status<>'' AND (l.fname<>'' OR l.lname<>''),Constants.DisconnectStatus.HISTORIC_DISCONNECT,r.disconnect_status);
		SELF := l;
		SELF := r;	
	END;
	dsAccuDataFormatted := JOIN(dsCallerIDs, dsSubmittedAccts,
								LEFT.phone=RIGHT.phone,
								formatCNAM(LEFT,RIGHT),
								LIMIT(Constants.MAX_RECORDS,SKIP));
													
	PhoneOwnership.Layouts.BatchOut updateREABInfo(PhoneOwnership.Layouts.BatchOut l, PhoneOwnership.Layouts.BatchOut r) := TRANSFORM
		SELF.acctno:= l.acctno;
		SELF.phone := l.phone;
		noCallerName := l.AppendedFirstName = '' AND l.AppendedSurname = '' AND l.lexisnexismatchcode != Constants.LNMatch.INVALID;
		businessMatch := r.AppendedCompanyName<>'' AND l.AppendedCompanyName[1..5] = r.AppendedCompanyName[1..5];
		nameMatchValue:= Functions.CallerNameMatch(l.AppendedFirstName,l.AppendedSurname,r.AppendedFirstName,r.AppendedSurname);
		inputMatchValue:= Functions.CallerNameMatch(l.AppendedFirstName,l.AppendedSurname,r.name_first,r.name_last);
		fullNameMatch := nameMatchValue = Constants.NameMatch.FIRSTLAST; 
		Subject := inputMatchValue = Constants.NameMatch.FIRSTLAST;	
		Match := fullNameMatch OR businessMatch;
		SELF.AppendedListingName := l.AppendedListingName;
		SELF.seq:= r.seq;
		SELF.AppendedDID := IF(Match AND NOT businessMatch,r.AppendedDID,l.AppendedDID);
		SELF.AppendedFirstName := IF(noCallerName,r.AppendedFirstName,l.AppendedFirstName);
		SELF.AppendedMiddleName := IF(noCallerName,r.AppendedMiddleName,l.AppendedMiddleName);
		SELF.AppendedSurname := IF(noCallerName,r.AppendedSurname,l.AppendedSurname);
		SELF.validatedRecord := IF(NOT noCallerName,l.validatedRecord,FALSE);
		SELF.AppendedCompanyName := IF(NOT noCallerName AND businessMatch,l.AppendedCompanyName,'');					
		SELF.AppendedLastDate := MAX(l.AppendedLastDate,r.AppendedLastDate);
		SELF.AppendedFirstDate := IF(Match,(UNSIGNED)r.AppendedFirstDate,l.AppendedFirstDate);
		SELF.AppendedRecordType := IF(businessMatch OR r.subj2own_relationship IN Constants.BUSINESS_RELATIONS,Phones.Constants.ListingType.Business,'');
		nameMatch := IF(STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.NAME,false) OR //accounting for name match from accudata results - LexisNexisMatchCode
										inputMatchValue > Constants.NameMatch.NONE,Constants.LNMatch.NAME,'');
		lastNameOnlyMatch := inputMatchValue = Constants.NameMatch.PARTIAL AND l.name_last IN [l.AppendedFirstName, l.AppendedSurname];										
		SELF.subj2own_relationship := MAP(Subject => Constants.Relationship.SUBJECT,
											l.subj2own_relationship<>'' => l.subj2own_relationship,
											Match => r.subj2own_relationship,
											lastNameOnlyMatch => Constants.Relationship.RELATIVE,
											Constants.Relationship.NONE);				
		relationalMatch := MAP(businessMatch OR (fullNameMatch AND r.subj2own_relationship IN Constants.BUSINESS_RELATIONS) => Constants.LNMatch.EMPLOYER,
								fullNameMatch OR STD.Str.Contains(r.LexisNexisMatchCode,Constants.LNMatch.RELATIVE,false) OR lastNameOnlyMatch => Constants.LNMatch.RELATIVE,
								'');
		addressMatch := IF(Match AND Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(
																						l.prim_range,l.prim_name,l.sec_range,
																						r.AppendedStreetNumber,r.AppendedStreetName,r.AppendedUnitNumber,
																						Risk_Indicators.AddrScore.zip_score(l.zip,r.AppendedZipCode),
																						Risk_Indicators.AddrScore.citystate_score(l.p_city_name,l.st,r.AppendedCity,r.AppendedStateCode,''))),
																						Constants.LNMatch.ADDRESS,'');	
		phoneMatch := IF(nameMatch<> '' OR relationalMatch <> '',Constants.LNMatch.PHONE,'');
		SELF.LexisNexisMatchCode := MAP(l.LexisNexisMatchCode = Constants.LNMatch.INVALID => Constants.LNMatch.INVALID, 
										l.validatedRecord => nameMatch + relationalMatch + addressMatch + phoneMatch,
										relationalMatch + phoneMatch); 
		ownership := MAP(l.ownership_index=Constants.Ownership.enumIndex.INVALID => Constants.Ownership.enumIndex.INVALID,
						Subject => Constants.Ownership.enumIndex.HIGH,
						Match AND r.subj2own_relationship = Constants.Relationship.RELATIVE => Constants.Ownership.enumIndex.MEDIUM,
						Match AND r.subj2own_relationship <>'' => Constants.Ownership.enumIndex.MEDIUM_HIGH,
						lastNameOnlyMatch => Constants.Ownership.enumIndex.MEDIUM,
						l.AppendedSurname='' OR l.AppendedFirstName='' => Constants.Ownership.enumIndex.UNDETERMINED,
						NOT Match AND l.AppendedListingName<>'' => Constants.Ownership.enumIndex.LOW,
						l.ownership_index);
		SELF.ownership_index := ownership;
		SELF.ownership_likelihood := Functions.getOwnershipValue(ownership);
		SELF.reason_codes := MAP(fullNameMatch OR relationalMatch<>''=>Constants.Reason_Codes.MATCH,
								l.AppendedFirstName<>'' OR l.AppendedSurname<>'' => Constants.Reason_Codes.NO_MATCH,
								'')+ l.reason_codes;
		SELF.DotID := IF(businessMatch,r.DotID,0);
		SELF.EmpID := IF(businessMatch,r.EmpID,0);
		SELF.POWID := IF(businessMatch,r.POWID,0);
		SELF.ProxID := IF(businessMatch,r.ProxID,0);
		SELF.SELEID := IF(businessMatch,r.SELEID,0);  
		SELF.OrgID := IF(businessMatch,r.OrgID,0);
		SELF.UltID := IF(businessMatch,r.UltID,0);	
		SELF.AppendedStreetNumber := IF(Match,r.AppendedStreetNumber,'');
		SELF.AppendedPreDirectional := IF(Match,r.AppendedPreDirectional,'');
		SELF.AppendedStreetName := IF(Match,r.AppendedStreetName,'');
		SELF.AppendedStreetSuffix := IF(Match,r.AppendedStreetSuffix,'');
		SELF.AppendedPostDirectional := IF(Match,r.AppendedPostDirectional,'');
		SELF.AppendedUnitDesignator := IF(Match,r.AppendedUnitDesignator,'');
		SELF.AppendedUnitNumber := IF(Match,r.AppendedUnitNumber,'');
		SELF.AppendedCity := IF(Match,r.AppendedCity,'');
		SELF.AppendedStateCode := IF(Match,r.AppendedStateCode,'');
		SELF.AppendedZipCode := IF(Match,r.AppendedZipCode,'');	
		SELF.AppendedZipCodeExtension := IF(Match,r.AppendedZipCodeExtension,'');		
		SELF := l;
	END;
	dsPhoneswCallerName := JOIN(dsAccuDataFormatted,batch_in_wREAB,
							LEFT.acctno=RIGHT.acctno AND
							LEFT.phone=RIGHT.phone, 
							updateREABInfo(LEFT,RIGHT),
							LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));

	#IF(PhoneOwnership.Constants.Debug.AccuDataCNAM)
		OUTPUT(batch_in_wREAB,NAMED('AccuDatabatch_in_wREAB'));
		OUTPUT(dsCallerIDs,NAMED('dsCallerIDs'));
		OUTPUT(dsAccuDataFormatted,NAMED('dsAccuDataFormatted'));
		OUTPUT(dsPhoneswCallerName,NAMED('dsPhoneswCallerName'));
	#END                            

    RETURN dsPhoneswCallerName;

END;