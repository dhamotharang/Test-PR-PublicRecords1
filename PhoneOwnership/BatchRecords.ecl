IMPORT DidVille,BatchServices,Gateway,MDR,Phones,PhoneOwnership, Risk_Indicators,Royalty, STD, Suppress, ut;
EXPORT BatchRecords(DATASET(PhoneOwnership.Layouts.BatchIn) ds_batch_in,
							PhoneOwnership.IParams.BatchParams inMod) := FUNCTION
	Functions := PhoneOwnership.Functions;
	Constants := PhoneOwnership.Constants;
	today := Functions.TODAY; 
	//*******************Get unknown DIDs - using best DID********************************
	dsBatch := PROJECT(ds_batch_in(did=0),TRANSFORM(DidVille.Layout_Did_OutBatch,
													SELF.fname:=LEFT.name_first,
													SELF.mname:=LEFT.name_middle,							
													SELF.seq:=(UNSIGNED)LEFT.acctno,							
													SELF.lname:=LEFT.name_last,
													SELF.phone10 := LEFT.phone_number,
													SELF.z5 := LEFT.zip,
													SELF:=LEFT,SELF:=[]));
	dsBatchwDIDs := Phones.Functions.GetDIDs(dsBatch,inMod.ApplicationType,inMod.GLBPurpose,inMod.DPPAPurpose);
	dsBatchwInput := JOIN(ds_batch_in,dsBatchwDIDs, 
							LEFT.acctno = (STRING)RIGHT.seq,
							TRANSFORM(PhoneOwnership.Layouts.PhonesCommon,
												SELF.acctno := LEFT.acctno;
												SELF.did := IF(LEFT.did=0,RIGHT.did,LEFT.did);
												SELF.fname := LEFT.name_first;
												SELF.mname := LEFT.name_middle;
												SELF.lname := LEFT.name_last;
												SELF.phone := LEFT.phone_number;
												SELF.city_name := LEFT.p_city_name;
												SELF.subj2own_relationship := Constants.Relationship.SUBJECT;
												SELF.batch_in := LEFT,
												SELF.dob := (UNSIGNED)LEFT.dob,
												SELF := LEFT,
												SELF :=[]),
							LEFT OUTER, LIMIT(0),KEEP(1));
	Suppress.MAC_Suppress(dsBatchwInput,dsBatchUnrestricted,inMod.ApplicationType,Suppress.Constants.LinkTypes.DID,DID);

	//*******************Get Phone Metadata - ATT LIDB(Carrier data) and porting info - reuse PhoneAttributes code***************************
	tempMod := MODULE(PROJECT(inMod,Phones.IParam.PhoneAttributes.BatchParams,OPT))
		EXPORT BOOLEAN 		return_current								:= TRUE; // Required for initial release
		EXPORT UNSIGNED		max_lidb_age_days						 	:= Phones.Constants.PhoneAttributes.LastActivityThreshold; 
		EXPORT BOOLEAN		use_realtime_lidb				 			:= inMod.useRealTimeLIDB;
	END;
	dsPhoneswMetadata := Phones.PhoneAttributes_BatchRecords(PROJECT(ds_batch_in,TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn,
																							SELF.acctno:=LEFT.acctno,
																							SELF.phoneno:=LEFT.phone_number,
																							SELF:=[])),
															tempMod);

	PhoneOwnership.Layouts.BatchOut appendLIDB(PhoneOwnership.Layouts.PhonesCommon l, Phones.Layouts.PhoneAttributes.BatchOut r):= TRANSFORM
		nullEffectiveDay := l.batch_in.effective_date=0;
		disconnectDate := IF(nullEffectiveDay OR r.disconnect_date>=l.batch_in.effective_date,r.disconnect_date,0);
		portedDate := IF(nullEffectiveDay OR r.ported_date>=l.batch_in.effective_date,r.ported_date,0);
		swapDate := IF(nullEffectiveDay OR r.swapped_phone_number_date>=l.batch_in.effective_date,r.swapped_phone_number_date,0);
		reactDate := IF(nullEffectiveDay OR r.reactivated_date>=l.batch_in.effective_date,r.reactivated_date,0);
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.dob := (STRING)l.dob;
		SELF.AppendedTelcoName := r.operator_name; 
		SELF.AppendedCarrierName := r.carrier_name;
		SELF.PrepaidPhoneFlag := (BOOLEAN)r.prepaid; //newly added to PhoneAttribute layout
		status := MAP(  disconnectDate > 0 AND portedDate > 0 AND  ut.DaysApart((STRING)disconnectDate, (STRING)portedDate)<=7 => Constants.DisconnectStatus.UNDETERMINED,
						disconnectDate > 0 AND (portedDate > disconnectDate OR reactDate > disconnectDate) => Constants.DisconnectStatus.HISTORIC_DISCONNECT,
						disconnectDate > 0 AND (portedDate = 0 OR (disconnectDate > portedDate AND disconnectDate > reactDate)) => Constants.DisconnectStatus.DISCONNECTED,
						Constants.DisconnectStatus.UNKNOWN);
		SELF.disconnect_status := status;
		SELF.ph_poss_disconnect_date := disconnectDate;
		SELF.ph_ported_date := portedDate;
		SELF.ph_swap_date := swapDate;
		SELF.new_phone_number_from_swap := IF(swapDate>0,r.new_phone_number_from_swap,'');
		//mark all reported invalid numbers
		badNumber := STD.Str.ToLowerCase(trim(r.error_desc)) = Constants.BAD_NUMBER AND status = Constants.DisconnectStatus.UNKNOWN;
		SELF.AppendedPhoneLineType := IF(badNumber,'',r.phone_line_type_desc);
		SELF.AppendedPhoneServiceType := IF(badNumber,'',r.phone_serv_type_desc);
		SELF.AppendedFirstDate := IF(badNumber,today,r.event_date); // check these date with effective date?????? - POSSIBLE FUTURE UPDATE
		SELF.AppendedLastDate := today;		
		SELF.LexisNexisMatchCode := IF(badNumber,Constants.LNMatch.INVALID,'');
		SELF.subj2own_relationship := IF(badNumber,Constants.Relationship.INVALID,'');
		//all records except invalid are marked undetermined since there is no associated names at this point.
		SELF.ownership_index := IF(badNumber,Constants.Ownership.enumIndex.INVALID,Constants.Ownership.enumIndex.UNDETERMINED); 
		SELF.ownership_likelihood := IF(badNumber,Constants.Ownership.INVALID,'');
		SELF.reason_codes := IF(badNumber,Constants.Reason_Codes.INVALID_NUMBER,'');
		SELF.source_category := Constants.LIDB;
		SELF.Source := r.source; // preserves PG,PJ,PK,PB,PR source labels
		SELF.error_desc:=r.error_desc;
		SELF:=l.batch_in;		
		SELF:=l;		
		SELF:=[];
	END;																
	dsPhonesMetadataByEffectiveDate := JOIN(dsBatchUnrestricted,dsPhoneswMetadata, //effectiveDate is only applicable for phone records Req 3.2.10
											LEFT.acctno=RIGHT.acctno AND
											LEFT.phone=RIGHT.phoneno,
											appendLIDB(LEFT,RIGHT),LEFT OUTER, KEEP(1));

	//***************Get REAB identities for Zumigo and to compare with callerNames from AccuData **************************************************
	dsBatchwBestInfo := Functions.GetBestInfo(dsBatchUnrestricted);//Get bestinfo for name variations.
	dsBatchwREAB := PhoneOwnership.GetREAB(dsBatchwBestInfo,inMod);//use dsBatchwBestInfo with alternate name and REAB in sequencing	

	PhoneOwnership.Layouts.BatchOut appendReabMetadata(PhoneOwnership.Layouts.BatchOut l, PhoneOwnership.Layouts.Phone_Relationship r) := TRANSFORM
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.seq := r.seq;
		SELF.validatedRecord := FALSE;
		SELF.AppendedDID := (STRING)r.did;
		SELF.AppendedFirstName := r.fname;
		SELF.AppendedMiddleName := r.mname;
		SELF.AppendedSurname := r.lname;
		SELF.AppendedEmailAddress := r.EmailAddress;
		SELF.AppendedCompanyName := r.companyname;
		SELF.AppendedStreetNumber := r.prim_range;
		SELF.AppendedPreDirectional := r.predir;
		SELF.AppendedStreetName := r.prim_name;
		SELF.AppendedStreetSuffix := r.suffix;
		SELF.AppendedPostDirectional := r.postdir;
		SELF.AppendedUnitDesignator := r.unit_desig;
		SELF.AppendedUnitNumber := r.sec_range;
		SELF.AppendedCity := r.city_name;
		SELF.AppendedStateCode := r.st;
		SELF.AppendedZipCode := r.zip;
		SELF.AppendedZipCodeExtension := r.zip4;
		SELF.DotID := r.DotID;
		SELF.EmpID := r.EmpID;
		SELF.POWID := r.POWID;
		SELF.ProxID := r.ProxID;
		SELF.SELEID := r.SELEID;  
		SELF.OrgID := r.OrgID;
		SELF.UltID := r.UltID;
		SELF.AppendedFirstDate := IF(r.phone = r.batch_in.phone_number,(UNSIGNED)r.dt_first_seen,l.AppendedFirstDate);
		businessMatch := IF(r.subj2own_relationship IN Constants.BUSINESS_RELATIONS,Phones.Constants.ListingType.Business,''); //could check bip also
		SELF.AppendedRecordType := businessMatch;
		inNameMatch := Functions.evaluateNameMatch(l.name_first,l.name_last,r.fname,r.lname);
		fullNameMatch := inNameMatch = Constants.NameMatch.FIRSTLAST; 	
		nameMatch := IF(STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.NAME,false) OR //accounting for name match from accudata results - LexisNexisMatchCode
										inNameMatch > Constants.NameMatch.NONE,Constants.LNMatch.NAME,'');							
		SELF.subj2own_relationship := MAP(fullNameMatch AND r.companyname = '' => Constants.Relationship.SUBJECT,
											r.subj2own_relationship='' => Constants.Relationship.NONE,
											l.subj2own_relationship='' => r.subj2own_relationship,
											l.subj2own_relationship);										

		relationalMatch := MAP(r.titleno > 0 => Constants.LNMatch.RELATIVE,
								r.subj2own_relationship IN Constants.BUSINESS_RELATIONS => Constants.LNMatch.EMPLOYER,
								'');
		addressMatch := IF(Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(
																				l.prim_range,l.prim_name,l.sec_range,
																				r.prim_range,r.prim_name,r.sec_range,
																				Risk_Indicators.AddrScore.zip_score(l.zip,r.zip),
																				Risk_Indicators.AddrScore.citystate_score(l.p_city_name,l.st,r.city_name,r.st,''))),
																				Constants.LNMatch.ADDRESS,'');
		phoneMatch := IF(nameMatch<> '' OR relationalMatch <> '',Constants.LNMatch.PHONE,'');
		SELF.LexisNexisMatchCode := MAP(l.LexisNexisMatchCode = Constants.LNMatch.INVALID => Constants.LNMatch.INVALID, 
										fullNameMatch => nameMatch + relationalMatch + addressMatch + phoneMatch + businessMatch,
										relationalMatch + addressMatch + phoneMatch);			
		ownership := MAP(l.ownership_index!=Constants.Ownership.enumIndex.UNDETERMINED => l.ownership_index,
						r.subj2own_relationship=Constants.Relationship.SUBJECT => Constants.Ownership.enumIndex.HIGH,
						l.subj2own_relationship = Constants.Relationship.RELATIVE  => Constants.Ownership.enumIndex.MEDIUM,
						r.titleno > 0 OR businessMatch<>'' => Constants.Ownership.enumIndex.MEDIUM_HIGH,
						l.AppendedSurname='' OR l.AppendedFirstName='' => Constants.Ownership.enumIndex.UNDETERMINED,
						NOT fullNameMatch => Constants.Ownership.enumIndex.LOW,
						l.ownership_index);
		SELF.ownership_index := ownership;
		SELF.ownership_likelihood := Functions.getOwnershipValue(ownership);		
		SELF := l;
		SELF := [];
	END;
	dsREABwMetadata := JOIN(dsPhonesMetadataByEffectiveDate,dsBatchwREAB,
							LEFT.acctno = RIGHT.acctno,
							appendReabMetadata(LEFT,RIGHT),
							LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));	

	// *************************Zumigo************************//	
	zFinal := PhoneOwnership.AppendCarrierValidations(dsREABwMetadata,inMod);
	dsZumigoValidatedPhones := DEDUP(SORT(zFinal.Results(validatedRecord),acctno),acctno);  

	//******************Get CallerID for PREMIUM and unresolved Ultimate********************************
	dsCallerIDRequest := IF(inMod.useZumigo, zFinal.Results(acctno NOT IN SET(dsZumigoValidatedPhones,acctno)),
											dsREABwMetadata); //If not useZumigo, account for all input phone #s	
	//Send unique phones avoid sending identified invalid numbers											
	dsAccudataRequest := DEDUP(SORT(dsCallerIDRequest(LexisNexisMatchCode != Constants.LNMatch.INVALID),phone),phone);
	dsPhones:= PROJECT(dsAccudataRequest(NOT validatedRecord),TRANSFORM(Phones.Layouts.PhoneAcctno, SELF.acctno:=LEFT.acctno, SELF.phone:=LEFT.phone));// only get CallerName for phones not validated.
	dsAccuData := IF(EXISTS(dsPhones) AND inMod.useAccudataCNAM,Phones.GetAccuData_CallerName(dsPhones,inMod.gateways,inMod.ApplicationType,inMod.GLBPurpose,inMod.DPPAPurpose),
													DATASET([],Phones.Layouts.AccuDataCNAM));	
	dsPhoneswCallerName := IF(inMod.useAccudataCNAM,PhoneOwnership.AppendCallerName(dsAccuData, dsCallerIDRequest),dsCallerIDRequest);
	// selecting by account since accudata phone results were appended to acctno and returned relatives is based on input subject
	// this could change later when we will expect multiple records per acctno.
	dsAccudataValidatedResults := DEDUP(SORT(dsPhoneswCallerName(validatedRecord),acctno,-ownership_index,seq),acctno);

	// *************************Get in-house phone records***********************//	
	// Only passing acctno not validated for LNPhones search. Need to add ***ATT*** phones that did not go through Accudata here
	// Need more info from Product about ATT phones.
	dsLNData := PhoneOwnership.AppendLNPhonesData(dsPhoneswCallerName(acctno NOT IN SET(dsAccudataValidatedResults,acctno)),inMod);									
	
	//compiling all processed phones including invalid responses
	dsAllPhones := dsPhonesMetadataByEffectiveDate(LexisNexisMatchCode = Constants.LNMatch.INVALID) + 
					IF(inMod.useZumigo,zFinal.Results(validatedRecord)) + 
					IF(inMod.useAccudataCNAM,dsAccudataValidatedResults) + 
					dsLNData;

	//result record count will always be one per acctno for this release.
	dsPhoneResults := UNGROUP(TOPN(GROUP(SORT(dsAllPhones,acctno),acctno),inMod.MaxIdentityCount,acctno,-validatedRecord,ownership_index=Constants.Ownership.enumIndex.UNDETERMINED,-ownership_index,-TotalZumigoScore,reason_codes='',reason_codes,seq)); 
	
	PhoneOwnership.Layouts.BatchOut UpdateUnknownRelationships (PhoneOwnership.Layouts.BatchOut l):= TRANSFORM
		availableListingName := l.AppendedListingName <>'';
		names := STD.Str.SplitWords(l.AppendedListingName,' ');
		inNameMatch := Functions.evaluateNameMatch(l.name_first,l.name_last,l.AppendedFirstName,l.AppendedSurname);
		FullNameMatch :=	inNameMatch = Constants.NameMatch.FIRSTLAST;
		listingMatch := availableListingName AND (l.AppendedFirstName IN names) AND (l.AppendedSurname IN names);
		inputMatch := FullNameMatch OR l.ownership_index > Constants.Ownership.enumIndex.UNDETERMINED;
		ownershipPossible := listingMatch OR inputMatch OR l.ValidatedRecord;
		SELF.AppendedDID := IF(ownershipPossible,l.AppendedDID,'');
		SELF.AppendedFirstName := IF(ownershipPossible,l.AppendedFirstName,'');
		SELF.AppendedMiddleName := IF(ownershipPossible,l.AppendedMiddleName,'');
		SELF.AppendedSurname := IF(ownershipPossible,l.AppendedSurname,'');	
		SELF.AppendedCompanyName := IF(ownershipPossible,l.AppendedCompanyName,'');
		SELF.AppendedStreetNumber := IF(ownershipPossible,l.AppendedStreetNumber,'');
		SELF.AppendedPreDirectional := IF(ownershipPossible,l.AppendedPreDirectional,'');
		SELF.AppendedStreetName := IF(ownershipPossible,l.AppendedStreetName,'');
		SELF.AppendedStreetSuffix := IF(ownershipPossible,l.AppendedStreetSuffix,'');
		SELF.AppendedPostDirectional := IF(ownershipPossible,l.AppendedPostDirectional,'');
		SELF.AppendedUnitDesignator := IF(ownershipPossible,l.AppendedUnitDesignator,'');
		SELF.AppendedUnitNumber := IF(ownershipPossible,l.AppendedUnitNumber,'');
		SELF.AppendedCity := IF(ownershipPossible,l.AppendedCity,'');
		SELF.AppendedStateCode := IF(ownershipPossible,l.AppendedStateCode,'');
		SELF.AppendedZipCode := IF(ownershipPossible,l.AppendedZipCode,'');		
		SELF.AppendedZipCodeExtension := IF(ownershipPossible,l.AppendedZipCodeExtension,'');		
		SELF.AppendedEmailAddress := IF(ownershipPossible,l.AppendedEmailAddress,'');	
		isInvalid := l.LexisNexisMatchCode = Constants.LNMatch.INVALID;
		SELF.LexisNexisMatchCode := MAP(l.validatedRecord AND l.LexisNexisMatchCode<>''  => TRIM(l.LexisNexisMatchCode,ALL),
										isInvalid => Constants.LNMatch.INVALID,
										l.AppendedPhoneLineType = Phones.Constants.PhoneServiceType.Wireless[1] => Constants.LNMatch.CELL,
										l.AppendedRecordType = Constants.LNMatch.BUSINESS => Constants.LNMatch.BUSINESS,
										l.AppendedRecordType <> Constants.LNMatch.BUSINESS => Constants.LNMatch.NON_CELL_CONSUMER,
										'');
		isDisconnected := l.disconnect_status = Constants.DisconnectStatus.DISCONNECTED;
		isSuspended	   := l.disconnect_status = Constants.DisconnectStatus.CONFIRMED_SUSPENDED;
		noOwner := NOT l.validatedRecord OR (l.AppendedFirstName='' AND l.AppendedSurname='' AND l.AppendedCompanyName='' AND l.AppendedEmailAddress='');
		confirmedDisconnected := noOwner AND isDisconnected;
		noRelationship := NOT confirmedDisconnected AND l.subj2own_relationship = Constants.Relationship.NONE; 
		finalOwnershipIndex := IF(noRelationship,Functions.checkOwnership(l.name_first,l.name_last,l.AppendedFirstName,l.AppendedSurname,'',Constants.Relationship.NONE),Constants.Ownership.enumIndex.UNDETERMINED);
		ownership := MAP(confirmedDisconnected OR isInvalid => Constants.Ownership.enumIndex.INVALID,//both invalid and confirmedDisconnected have an ownership index of zero
							NOT l.validatedRecord => Constants.Ownership.enumIndex.UNDETERMINED,
							FullNameMatch => Constants.Ownership.enumIndex.HIGH, //will update Zumigo index
							noRelationship => finalOwnershipIndex,
							ownershipPossible =>  l.ownership_index, 
							Constants.Ownership.enumIndex.LOW);	
		
		zumigoSource := STD.Str.Contains(l.source_category,Constants.CARRIER,FALSE);
		gatewayResponse := zumigoSource OR STD.Str.Contains(l.source_category,Constants.CNAM,FALSE);	
		ownershipStatus := IF(NOT gatewayResponse AND isDisconnected AND ownership > 2,ownership - 1, ownership);
		SELF.ownership_index := ownershipStatus;
		SELF.ownership_likelihood := MAP(zumigoSource =>l.ownership_likelihood,
										confirmedDisconnected => Constants.Ownership.NONE,
										isInvalid => Constants.Ownership.INVALID,	
										Functions.getOwnershipValue(ownershipStatus));			
		SELF.subj2own_relationship := MAP(	confirmedDisconnected => Constants.Relationship.NO_OWNER,
											isInvalid => Constants.Relationship.INVALID,
											NOT l.validatedRecord => Constants.Relationship.NO_IDENTITY,
											FullNameMatch => Constants.Relationship.SUBJECT,
											noRelationship => Functions.getRelationship(finalOwnershipIndex),
											ownershipPossible => l.subj2own_relationship,
											Constants.Relationship.NONE);	
		SELF.reason_codes := MAP(isInvalid => Constants.Reason_Codes.INVALID_NUMBER,
									confirmedDisconnected => Constants.Reason_Codes.CONFIRMED_DISCONNECTED,
									zumigoSource => l.reason_codes,
									Functions.getReasonCodes(SELF.ownership_index = Constants.Ownership.enumIndex.HIGH,SELF.ownership_index = Constants.Ownership.enumIndex.UNDETERMINED,l.ph_poss_disconnect_date > 0,isSuspended));
		SELF:=l;
	END;
	dsPhonesFinal := PROJECT(dsPhoneResults,UpdateUnknownRelationships(LEFT));
	
	//************************Reports if identified owner might be involved in a litigation.**************************
	dsContactRisk := IF(inMod.contactRiskFlag,
							BatchServices.PossibleLitigiousDebtor_BatchService_Records(PROJECT(dsPhonesFinal,TRANSFORM(BatchServices.Layouts.PLD.rec_batch_PLD_input,
																														SELF.acctno:=LEFT.acctno,
																														SELF.name_first:=LEFT.appendedfirstname,
																														SELF.name_middle:=LEFT.appendedmiddlename,
																														SELF.name_last:=LEFT.appendedsurname,
																														SELF.courtjurisdiction:=LEFT.appendedstatecode))),
							DATASET([],BatchServices.Layout_PLD_Batch_out));
	dsResults := JOIN(dsPhonesFinal,dsContactRisk,
						LEFT.acctno=RIGHT.acctno,
						TRANSFORM(PhoneOwnership.Layouts.BatchOut,
									SELF.contact_risk_flag:=(STRING)RIGHT.LitigiousDebtor_Flag,
									SELF:=LEFT,
									SELF:=[]),
						LEFT OUTER,LIMIT(Constants.MAX_RECORDS,SKIP));

	//*****************************Compute Royalties*****************************
	dsRoyaltiesZumigoIdentity := Royalty.RoyaltyZumigoGetLineIdentity.GetBatchRoyaltiesByAcctno(zFinal.ZumigoResults);
	dsRealTimeATT_LIDB := dsPhoneswMetadata(source = Phones.Constants.PhoneAttributes.ATT_LIDB_RealTime);
	dsRoyaltiesATT_LIDB_GetLine := Royalty.RoyaltyATT.GetBatchRoyaltiesByAcctno(dsRealTimeATT_LIDB, source, phoneno, acctno);	
	dsRoyaltiesAccudata_CNAM  := Royalty.RoyaltyAccudata_CNAM.GetBatchRoyaltiesByAcctno(dsAccuData);
	dsRoyaltiesByAcctno := 	IF(inMod.useZumigo, dsRoyaltiesZumigoIdentity) + 
							IF(inMod.useAccudataCNAM, dsRoyaltiesAccudata_CNAM) + 
							IF(inMod.useRealTimeLIDB,dsRoyaltiesATT_LIDB_GetLine);

	//*****************************Generating final results - 3 datasets*****************************
	PhoneOwnership.Layouts.Final ResultswRoyalties () := TRANSFORM
		SELF.Results := dsResults;
		SELF.Royalties:= IF(EXISTS(dsRoyaltiesByAcctno),PROJECT(dsRoyaltiesByAcctno,Royalty.Layouts.RoyaltyForBatch),DATASET([], Royalty.Layouts.RoyaltyForBatch));
		SELF.ZumigoResults:= IF(inMod.useZumigo,zFinal.ZumigoResults,DATASET([],Phones.Layouts.ZumigoIdentity.zOut));
	END;

	dsFinal := DATASET([ResultswRoyalties()])[1];	
	
	#IF(PhoneOwnership.Constants.Debug.Main)
		OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
		OUTPUT(dsBatch,NAMED('dsBatch'));
		OUTPUT(dsBatchwDIDs,NAMED('dsBatchwDIDs'));
		OUTPUT(dsBatchwInput,NAMED('dsBatchwInput'));
		OUTPUT(dsBatchUnrestricted,NAMED('dsBatchUnrestricted'));
		OUTPUT(dsBatchwBestInfo,NAMED('dsBatchwBestInfo'));
		OUTPUT(dsPhoneswMetadata,NAMED('dsPhoneswMetadata'));
		OUTPUT(dsPhonesMetadataByEffectiveDate,NAMED('dsPhonesMetadataByEffectiveDate'));
		OUTPUT(dsBatchwREAB,NAMED('dsBatchwREAB'));
		OUTPUT(dsREABwMetadata,NAMED('dsREABwMetadata'));
		OUTPUT(dsPhoneResults,NAMED('dsPhoneResults'));
		OUTPUT(dsPhonesFinal,NAMED('dsPhonesFinal'));
		OUTPUT(dsContactRisk,NAMED('dsContactRisk'));
		OUTPUT(dsResults,NAMED('dsResults'));
	#END
	RETURN 	dsFinal;																							 
																										 
END;