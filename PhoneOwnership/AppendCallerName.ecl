/*
This function compares callerID data from Accudata with subject and REAB identities
*/
IMPORT PhoneOwnership,Phones,Risk_Indicators,STD;
EXPORT AppendCallerName(DATASET(Phones.Layouts.AccuDataCNAM) dsCallerIDs,
						DATASET(PhoneOwnership.Layouts.BatchOut) batch_in_wREAB) := FUNCTION

	Constants := PhoneOwnership.Constants;
	Functions := PhoneOwnership.Functions;	
	today := STD.Date.Today();
	dsSubmittedAccts := DEDUP(SORT(batch_in_wREAB,acctno),acctno);
	PhoneOwnership.Layouts.BatchOut formatCNAM(Phones.Layouts.AccuDataCNAM l, PhoneOwnership.Layouts.BatchOut r):= TRANSFORM
		validCNAMResponse := l.listingname<>'' AND l.listingname<>'ERROR';
		SELF.acctno := r.acctno;
		SELF.AppendedListingName := IF(validCNAMResponse,l.listingname,'');
		SELF.AppendedLastDate := IF(validCNAMResponse,today,0);			
		SELF.AppendedDID := (STRING)l.did;
		SELF.AppendedFirstName := l.fname;
		SELF.AppendedMiddleName := '';
		SELF.AppendedSurname := l.lname;
		SELF.AppendedCompanyName := IF(l.fname<>'' AND l.lname<>'',Phones.Functions.GetCleanCompanyName(l.listingname),'');
		SELF.validatedRecord := l.availabilityindicator = 0 AND validCNAMResponse AND l.privateflag = 0;
		SELF.source_category := IF(validCNAMResponse, r.source_category+Constants.CNAM, r.source_category);
		//report error results and mark any reported bad numbers.
		SELF.error_desc := IF(l.listingname='ERROR', r.error_desc+'CNAM: '+ l.error_desc + IF(l.error_desc<>'',PhoneOwnership.Constants.DELIMITER,''),r.error_desc);			
		badNumber := STD.Str.ToLowerCase(l.error_desc) = 'missingorinvalidbtn';
		SELF.subj2own_relationship := IF(badNumber,Constants.Relationship.INVALID,'');
		SELF.LexisNexisMatchCode := IF(badNumber,Constants.LNMatch.INVALID,'');	
		SELF.reason_codes := IF(badNumber,Constants.Reason_Codes.INVALID_NUMBER,'');
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
		Match := r.seq > 0;
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
		inNameMatch := Functions.evaluateNameMatch(l.name_first,l.name_last,l.AppendedFirstName,l.AppendedSurname);
		fullNameMatch := inNameMatch = Constants.NameMatch.FIRSTLAST; 	
		nameMatch := IF(STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.NAME,false) OR //accounting for name match from accudata results - LexisNexisMatchCode
										inNameMatch > Constants.NameMatch.NONE,Constants.LNMatch.NAME,'');
		recordMatch := Functions.evaluateNameMatch(l.AppendedFirstName,l.AppendedSurname,r.AppendedFirstName,r.AppendedSurname) = Constants.NameMatch.FIRSTLAST;								
		SELF.subj2own_relationship := MAP(fullNameMatch => Constants.Relationship.SUBJECT,
											r.subj2own_relationship='' => Constants.Relationship.NONE,
											l.subj2own_relationship='' => r.subj2own_relationship,
											l.subj2own_relationship);										
		lastnameMatch := l.name_last = l.AppendedSurname;
		relationalMatch := MAP(STD.Str.Contains(r.LexisNexisMatchCode,Constants.LNMatch.RELATIVE,false) OR lastnameMatch => Constants.LNMatch.RELATIVE,
								businessMatch OR r.subj2own_relationship IN Constants.BUSINESS_RELATIONS => Constants.LNMatch.EMPLOYER,
								'');
		addressMatch := IF(Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(
																						l.prim_range,l.prim_name,l.sec_range,
																						r.prim_range,r.prim_name,r.sec_range,
																						Risk_Indicators.AddrScore.zip_score(l.zip,r.zip),
																						Risk_Indicators.AddrScore.citystate_score(l.p_city_name,l.st,r.p_city_name,r.st,''))),
																						Constants.LNMatch.ADDRESS,'');	
		phoneMatch := IF(nameMatch<> '' OR relationalMatch <> '',Constants.LNMatch.PHONE,'');
		SELF.LexisNexisMatchCode := MAP(l.LexisNexisMatchCode = Constants.LNMatch.INVALID => Constants.LNMatch.INVALID, 
										recordMatch AND l.validatedRecord => nameMatch + relationalMatch + addressMatch + phoneMatch,
										relationalMatch + phoneMatch); 
		ownership := MAP(l.ownership_index=Constants.Ownership.enumIndex.INVALID => Constants.Ownership.enumIndex.INVALID,
						fullNameMatch AND r.subj2own_relationship=Constants.Relationship.SUBJECT => Constants.Ownership.enumIndex.HIGH,
						recordMatch AND r.subj2own_relationship = Constants.Relationship.RELATIVE => Constants.Ownership.enumIndex.MEDIUM,
						(businessMatch OR recordMatch) AND r.subj2own_relationship <>'' => Constants.Ownership.enumIndex.MEDIUM_HIGH,
						lastnameMatch => Constants.Ownership.enumIndex.MEDIUM,
						l.AppendedSurname='' OR l.AppendedFirstName='' => Constants.Ownership.enumIndex.UNDETERMINED,
						NOT fullNameMatch AND NOT recordMatch AND NOT businessMatch AND l.AppendedListingName<>'' => Constants.Ownership.enumIndex.LOW,
						l.ownership_index);
		SELF.ownership_index := ownership;
		SELF.ownership_likelihood := Functions.getOwnershipValue(ownership);
		SELF.reason_codes := MAP(fullNameMatch OR relationalMatch<>'' => Constants.Reason_Codes.MATCH,
								r.LexisNexisMatchCode<>'' => r.reason_codes,
								l.reason_codes);
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
	dsPhoneswCallerName := JOIN(dsAccuDataFormatted(AppendedFirstName<>'' AND AppendedSurname<>''),batch_in_wREAB,
							LEFT.acctno=RIGHT.acctno AND
							LEFT.phone=RIGHT.phone AND
							//trying to match callerID with REAB info - hence names and company
							((LEFT.AppendedFirstName = RIGHT.AppendedFirstName AND 
							LEFT.AppendedSurname = RIGHT.AppendedSurname) OR
							LEFT.AppendedCompanyName[1..5] = RIGHT.AppendedCompanyName[1..5]), //add a fuzzy match
							updateREABInfo(LEFT,RIGHT),
							LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));
	dsOtherPhones := JOIN(dsAccuDataFormatted(AppendedFirstName='' AND AppendedSurname=''),batch_in_wREAB,
							LEFT.acctno=RIGHT.acctno AND
							LEFT.phone=RIGHT.phone,
							updateREABInfo(LEFT,RIGHT),
							LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));  						

	#IF(PhoneOwnership.Constants.Debug.AccuDataCNAM)
		OUTPUT(batch_in_wREAB,NAMED('AccuDatabatch_in_wREAB'));
		OUTPUT(dsCallerIDs,NAMED('dsCallerIDs'));
		OUTPUT(dsAccuDataFormatted,NAMED('dsAccuDataFormatted'));
		OUTPUT(dsPhoneswCallerName,NAMED('dsPhoneswCallerName'));
		OUTPUT(dsOtherPhones,NAMED('dsOtherPhones'));
	#END                            

    RETURN dsPhoneswCallerName + dsOtherPhones;

END;