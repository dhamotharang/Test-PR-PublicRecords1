﻿IMPORT Autokey_batch,BatchServices,Gateway,MDR, Phones, PhoneOwnership, Risk_Indicators,Royalty, STD, Suppress, ut;
EXPORT BatchRecords(DATASET(PhoneOwnership.Layouts.BatchIn) ds_batch_in,
																		PhoneOwnership.IParams.BatchParams inMod) := FUNCTION
	Functions := PhoneOwnership.Functions;
	Constants := PhoneOwnership.Constants;
	today := STD.Date.Today();
	//get unknown DIDs
	dsBatch := PROJECT(ds_batch_in(did=0),TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster,SELF.homephone := LEFT.phone_number,SELF.z5 := LEFT.zip,SELF:=LEFT,SELF:=[]));
	dsBatchwDIDs := Functions.GetDIDs(dsBatch);
	dsBatchwInput := JOIN(ds_batch_in,dsBatchwDIDs, 
												LEFT.acctno = RIGHT.acctno,
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
	dsBatchwBestInfo := Functions.GetBestInfo(dsBatchUnrestricted);// needed later for Zumigo to validate identities.

	//*******************Get Phone Metadata - ATT LIDB(Carrier data) and porting info - reuse PhoneAttributes code***************************
	tempMod := MODULE(PROJECT(inMod,Phones.IParam.PhoneAttributes.BatchParams,OPT))
		EXPORT BOOLEAN 		return_current								:= TRUE; // Required for initial release
		EXPORT UNSIGNED		max_lidb_age_days						 	:= Phones.Constants.PhoneAttributes.LastActivityThreshold; 
		EXPORT BOOLEAN		use_realtime_lidb				 			:= inMod.useRealTimeLIDB;
	END;
	dsPhoneswMetadata := Phones.PhoneAttributes_BatchRecords(PROJECT(ds_batch_in,TRANSFORM(Phones.Layouts.PhoneAttributes.BatchIn,
																																											SELF.acctno:=LEFT.acctno,SELF.phoneno:=LEFT.phone_number,SELF:=[])),
																														tempMod);

	PhoneOwnership.Layouts.BatchOut appendLIDB(PhoneOwnership.Layouts.PhonesCommon l, Phones.Layouts.PhoneAttributes.BatchOut r):= TRANSFORM
		nullEffectiveDay := l.batch_in.effective_date=0;
		disconnectDate := IF(nullEffectiveDay OR l.batch_in.effective_date >=r.disconnect_date,r.disconnect_date,0);
		portedDate := IF(nullEffectiveDay OR l.batch_in.effective_date >=r.ported_date,r.ported_date,0);
		swapDate := IF(nullEffectiveDay OR l.batch_in.effective_date >=r.swapped_phone_number_date,r.swapped_phone_number_date,0);
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.dob := (STRING)l.dob;
		SELF.AppendedTelcoName := r.operator_name; //carrier or operator?
		SELF.PrepaidPhoneFlag := (BOOLEAN)r.prepaid; //newly added to PhoneAttribute layout
		status := MAP(disconnectDate > 0 AND portedDate > 0 AND  ut.DaysApart((STRING)disconnectDate, (STRING)portedDate)<=7 => Constants.DisconnectStatus.UNDETERMINED,
																	disconnectDate > 0 AND (portedDate = 0 OR (portedDate > 0 AND ut.DaysApart((STRING)disconnectDate, (STRING)portedDate)>7)) => Constants.DisconnectStatus.DISCONNECTED,
																	Constants.DisconnectStatus.UNKNOWN);
		SELF.disconnect_status := status;
		SELF.ph_poss_disconnect_date := disconnectDate;
		SELF.ph_ported_date := portedDate;
		SELF.ph_swap_date := swapDate;
		SELF.new_phone_number_from_swap := IF(swapDate>0,r.new_phone_number_from_swap,'');
		//mark all reported invalid numbers
		badNumber := STD.Str.ToLowerCase(trim(r.error_desc)) = Constants.BAD_NUMBER AND status = Constants.DisconnectStatus.UNKNOWN;
		SELF.AppendedPhoneLineType := IF(badNumber,Phones.Constants.PhoneServiceType.Other,Phones.Functions.LineServiceTypeDesc((INTEGER)r.phone_line_type));
		SELF.AppendedPhoneServiceType := IF(badNumber,Phones.Constants.PhoneServiceType.Other,Phones.Functions.LineServiceTypeDesc((INTEGER)r.phone_serv_type));
		SELF.AppendedFirstDate := IF(badNumber,today,r.event_date); // check these date with effective date?????? - POSSIBLE FUTURE UPDATE
		SELF.AppendedLastDate := today;		
		SELF.LexisNexisMatchCode := IF(badNumber,Constants.LNMatch.INVALID,'');
		SELF.subj2own_relationship := IF(badNumber,Constants.Relationship.INVALID,'');
		//all records except invalid are marked undetermined since there is no associated names at this point.
		SELF.ownership_index := IF(badNumber,Constants.Ownership.enumIndex.INVALID,Constants.Ownership.enumIndex.UNDETERMINED); 
		SELF.ownership_likelihood := IF(badNumber,Constants.Ownership.INVALID,'');
		SELF.reason_codes := IF(badNumber,Constants.Reason_Codes.INVALID_NUMBER,'');
		SELF.source_category := Constants.LIDB;
		SELF.Source := r.source; // preserves PJ,PK,PB,PG source labels to identify gateway records
		SELF.error_desc:=r.error_desc;		//newly added to PhoneAttribute layout
		SELF:=l.batch_in;		
		SELF:=l;		
		SELF:=[];
	END;																
	dsPhonesMetadataByEffectiveDate := JOIN(dsBatchUnrestricted,dsPhoneswMetadata, //effectiveDate is only applicable for phone records Req 3.2.10
																LEFT.acctno=RIGHT.acctno AND
																LEFT.phone=RIGHT.phoneno,
																appendLIDB(LEFT,RIGHT),LEFT OUTER, KEEP(1));

	//***************Get REAB identities for Zumigo and to compare with callerID from AccuData **************************************************
	dsBatchwREAB := PhoneOwnership.GetREAB(dsBatchwBestInfo,inMod);//use dsBatchwBestInfo alternate name record in sequencing	
	// *************************Zumigo to be added later***********************//	
/*	dsZumigoRequest :=IF(inMod.useZumigo, PROJECT(dsBatchwREAB,TRANSFORM(Phones.Layouts.ZumigoIdentity.subjectVerificationRequest,
																																							SELF.acctno:= LEFT.acctno,
																																							SELF.sequence_number:= LEFT.seq,
																																							SELF.phone:= LEFT.batch_in.phone_number,
																																							SELF.lexid:= LEFT.did,
																																							SELF.first_name:= LEFT.fname,
																																							SELF.last_name:= LEFT.lname,
																																							SELF.nameType:= LEFT.subj2own_relationship,
																																							SELF.busult_id:=LEFT.ultid,
																																							SELF.busorg_id:=LEFT.orgid,
																																							SELF.bussele_id:=LEFT.seleid,
																																							SELF.busprox_id:=LEFT.proxid,
																																							SELF.buspow_id:=LEFT.powid,
																																							SELF.busemp_id:=LEFT.empid,
																																							SELF.busdot_id:=LEFT.dotid,
																																							SELF.business_name:=LEFT.companyname,
																																							SELF.addr_suffix:=LEFT.suffix,
																																							SELF.p_city_name:=LEFT.city_name,
																																							SELF.z5:=LEFT.zip,
																																							SELF.addressType:=LEFT.subj2own_relationship,
																																							SELF:=LEFT )),
																					DATASET([],Phones.Layouts.ZumigoIdentity.subjectVerificationRequest));
	zMod := MODULE(Phones.IParam.inZumigoParams)
		EXPORT STRING20 useCase := inMod.useCase;
		EXPORT STRING3 	productCode := inMod.productCode;
		EXPORT STRING8	billingId := inMod.billingId;
		EXPORT STRING20 productName := inMod.productName;
		EXPORT BOOLEAN 	NameAddressValidation := inMod.NameAddressValidation;
		EXPORT STRING10 optInType := inMod.optInType;
		EXPORT STRING5 	optInMethod := inMod.optInMethod;
		EXPORT STRING3 	optinDuration := inMod.optinDuration;
		EXPORT STRING 	optinId := inMod.optinId;
		EXPORT STRING 	optInVersionId := inMod.optInVersionId;
		EXPORT STRING15 optInTimestamp := IF(inMod.optInTimestamp='',(STRING)STD.Date.CurrentDate(TRUE)+' '+(STRING)STD.Date.CurrentTime(TRUE),inMod.optInTimestamp);			
		EXPORT DATASET(Gateway.Layouts.Config) gateways := inMod.gateways(Gateway.Configuration.IsZumigoIdentity(servicename));
	END;
	dsZumigoScores := IF(EXISTS(dsZumigoRequest),
															Phones.GetZumigoIdentity(dsZumigoRequest,zMod,inMod.GLBPurpose,inMod.DPPAPurpose,inMod.DataRestrictionMask),
															DATASET([],Phones.Layouts.ZumigoIdentity.zOut));

*/


	//******************Get CallerID for PREMIUM and later unresolved Ultimate********************************
	dsPhones:= PROJECT(dsPhonesMetadataByEffectiveDate(LexisNexisMatchCode != Constants.LNMatch.INVALID),TRANSFORM(Phones.Layouts.PhoneAcctno, SELF.acctno:=LEFT.acctno, SELF.phone:=LEFT.phone)); //avoid sending identified invalid numbers
	dsAccuData := IF(EXISTS(dsPhones) AND inMod.useAccudataCNAM,Phones.GetAccuData_CallerName(dsPhones,inMod.gateways),
													DATASET([],Phones.Layouts.AccuDataCNAM));	
	
	PhoneOwnership.Layouts.BatchOut formatCNAM(Phones.Layouts.AccuDataCNAM l):= TRANSFORM
		validCNAMResponse := l.listingname<>'' AND l.listingname<>'ERROR';
		nameIsAvailable := l.availabilityindicator = 0 AND validCNAMResponse AND l.privateflag = 0;
		SELF.AppendedListingName := IF(validCNAMResponse,l.listingname,'');
		SELF.AppendedLastDate := IF(validCNAMResponse,today,0);			
		SELF.source_category := IF(validCNAMResponse,Constants.CNAM,'');
		//report error results and mark any reported bad numbers not caught by ATT LIDB gateway.
		SELF.error_desc := IF(l.listingname='ERROR', 'CNAM: '+ l.error_desc,'');	
		SELF.AppendedDID := (STRING)l.did;
		SELF.AppendedFirstName := l.name_first;
		SELF.AppendedSurname := l.name_last;
		badNumber := STD.Str.ToLowerCase(l.error_desc) = 'missingorinvalidbtn';
		SELF.subj2own_relationship := IF(badNumber,Constants.Relationship.INVALID,'');
		SELF.LexisNexisMatchCode := IF(badNumber,Constants.LNMatch.INVALID,'');	
		SELF.reason_codes := IF(badNumber,Constants.Reason_Codes.INVALID_NUMBER,'');
		SELF.ownership_index := IF(badNumber,Constants.Ownership.enumIndex.INVALID,Constants.Ownership.enumIndex.UNDETERMINED); //marked undetermined until connected with an identity
		SELF := l;
		SELF := [];	
	END;
	dsAccuDataFormatted := PROJECT(dsAccuData,formatCNAM(LEFT));

	PhoneOwnership.Layouts.BatchOut appendCNAM(PhoneOwnership.Layouts.BatchOut l,PhoneOwnership.Layouts.BatchOut r):= TRANSFORM
		inputNameMatch := Functions.evaluateNameMatch(l.name_first,l.name_last,r.AppendedFirstName,r.AppendedSurname);
		nameMatch := IF(inputNameMatch,Constants.LNMatch.NAME,'');
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.AppendedFirstName := r.AppendedFirstName;
		SELF.AppendedSurname := r.AppendedSurname;
		SELF.AppendedListingName := r.AppendedListingName;
		SELF.AppendedLastDate := MAX(l.AppendedLastDate,r.AppendedLastDate);			
		SELF.source_category := l.source_category + r.source_category;
		SELF.error_desc := l.error_desc + r.error_desc;	
		SELF.subj2own_relationship := IF(r.subj2own_relationship='',l.subj2own_relationship,r.subj2own_relationship);
		SELF.LexisNexisMatchCode := MAP(inputNameMatch => nameMatch,
																		r.LexisNexisMatchCode<>'' => r.LexisNexisMatchCode,
																		l.LexisNexisMatchCode);
		SELF.reason_codes := MAP(inputNameMatch => Constants.Reason_Codes.MATCH,
														 r.LexisNexisMatchCode<>'' => r.reason_codes,
														 l.reason_codes);
		SELF.ownership_index := MAP(inputNameMatch => Constants.Ownership.enumIndex.HIGH,
																r.LexisNexisMatchCode <>'' => r.ownership_index,
																l.ownership_index);
		SELF := l;
	END;
	dsPhoneswCallerName :=  JOIN(dsPhonesMetadataByEffectiveDate,dsAccuDataFormatted,
													LEFT.phone=RIGHT.phone,
													appendCNAM(LEFT,RIGHT),
													LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));
													
	
	PhoneOwnership.Layouts.BatchOut updateREABInfo(PhoneOwnership.Layouts.BatchOut l, PhoneOwnership.Layouts.Phone_Relationship r) := TRANSFORM
		SELF.acctno:= l.acctno;
		SELF.phone := l.phone;
		blankName := l.AppendedFirstName = '' AND l.AppendedSurname = '' AND l.lexisnexismatchcode != Constants.LNMatch.INVALID;
		SELF.AppendedListingName := l.AppendedListingName;
		SELF.AppendedDID := (STRING)r.did;
		SELF.AppendedFirstName := IF(blankName,r.fname,l.AppendedFirstName);
		SELF.AppendedMiddleName := IF(blankName,r.mname,l.AppendedMiddleName);
		SELF.AppendedSurname := IF(blankName,r.lname,l.AppendedSurname);
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
		SELF.subj2own_relationship := IF(l.subj2own_relationship='',r.subj2own_relationship,l.subj2own_relationship);
		business := [Constants.Relationship.EMPLOYER,Constants.Relationship.BUSINESS];
		SELF.AppendedRecordType := IF(r.subj2own_relationship IN business,'B','');
		nameMatch := IF(STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.NAME,false) OR //accounting for name match from accudata results - LexisNexisMatchCode
										Functions.evaluateNameMatch(l.name_first,l.name_last,r.fname,r.lname),Constants.LNMatch.NAME,'');
		relationalMatch := MAP(r.titleno > 0 => Constants.LNMatch.RELATIVE,
												   r.subj2own_relationship IN business => Constants.LNMatch.EMPLOYER,
												   '');
		addressMatch := IF(Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore(
																																						l.prim_range,l.prim_name,l.sec_range,
																																						r.prim_range,r.prim_name,r.sec_range,
																																						Risk_Indicators.AddrScore.zip_score(l.zip,r.zip),
																																						Risk_Indicators.AddrScore.citystate_score(l.p_city_name,l.st,r.city_name,r.st,''))),
																																						Constants.LNMatch.ADDRESS,'');
		phoneMatch := IF(relationalMatch <> '',Constants.LNMatch.PHONE,'');
		SELF.LexisNexisMatchCode := IF(l.LexisNexisMatchCode = Constants.LNMatch.INVALID, Constants.LNMatch.INVALID, nameMatch + relationalMatch + addressMatch + phoneMatch);			
		ownership := MAP(l.ownership_index!=Constants.Ownership.enumIndex.UNDETERMINED => l.ownership_index,
										 nameMatch<>'' AND l.subj2own_relationship=Constants.Relationship.SUBJECT => Constants.Ownership.enumIndex.HIGH,
										 nameMatch<>'' AND r.titleno > 0 => Constants.Ownership.enumIndex.MEDIUM_HIGH,
										 nameMatch<>'' AND l.subj2own_relationship = Constants.Relationship.RELATIVE => Constants.Ownership.enumIndex.MEDIUM,
										 l.AppendedSurname='' OR l.AppendedFirstName='' => Constants.Ownership.enumIndex.UNDETERMINED,
										 nameMatch='' AND l.AppendedListingName<>'' => Constants.Ownership.enumIndex.LOW,
										 l.ownership_index);
		SELF.ownership_index := ownership;
		SELF.ownership_likelihood := Functions.getOwnershipValue(ownership);
		SELF.reason_codes := l.reason_codes;// acknowledges MATCH reason_codes from accudata
		SELF := l; 
		SELF := [];	
	END;
	dsCallerNamewREAB := JOIN(dsPhoneswCallerName(AppendedFirstName<>'' AND AppendedSurname<>''),dsBatchwREAB,
															LEFT.acctno=RIGHT.acctno AND
															LEFT.phone=RIGHT.batch_in.phone_number AND
															//trying to match callerID with REAB info - hence names and company
															((LEFT.AppendedFirstName = RIGHT.fname AND 
															LEFT.AppendedSurname = RIGHT.lname) OR
															LEFT.AppendedListingName = RIGHT.companyname),
															updateREABInfo(LEFT,RIGHT),
															LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));
	dsAllREAB := JOIN(dsPhoneswCallerName(AppendedFirstName='' AND AppendedSurname=''),dsBatchwREAB,
															LEFT.acctno=RIGHT.acctno AND
															LEFT.phone=RIGHT.batch_in.phone_number,
															updateREABInfo(LEFT,RIGHT),
															LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));
	dsPhoneswREAB := dsCallerNamewREAB + dsAllREAB;

	// *************************Get in-house phone records***********************//	
	dsLNPhonesRequest := PROJECT(DEDUP(SORT(dsPhoneswREAB,acctno,phone),acctno),TRANSFORM(Phones.Layouts.PhoneIdentity,SELF:=LEFT,SELF:=[]));
	
	//passing through all phones to get latest LN phone associates. Trying to match with identified owner from Accudata. Then append latest data e.g.address, business flag.
	dsLNIdentities := SORT(Phones.GetLNIdentity_byPhone(dsLNPhonesRequest,inMod.GLBPurpose,inMod.DPPAPurpose,inMod.DataRestrictionMask,inMod.Industryclass),acctno,phone,lname='',fname='',-dt_last_seen,dt_first_seen);

	// Note that ownership is defined by accudata or data match with input - this will be replaced with a scoring model later.
	PhoneOwnership.Layouts.BatchOut appendLNData(PhoneOwnership.Layouts.BatchOut l, Phones.Layouts.PhoneIdentity r) := TRANSFORM
		match := r.phone <> '';
		recordNameMatch := match AND Functions.evaluateNameMatch(l.AppendedFirstName,l.AppendedSurname,r.fname,r.lname);
		inputNameMatch :=	match AND Functions.evaluateNameMatch(l.name_first,l.name_last,r.fname,r.lname);
		blankName := l.AppendedFirstName ='' AND l.AppendedSurname='';
		noCallerName:= match AND l.AppendedListingName='';
		// internalPhoneMatch := match AND blankName;// (OR nameMatch='');
		noOwner := NOT match AND blankName; //(OR inMod.search_level = Constants.SearchLevel.BASIC);
		SELF.acctno := l.acctno;
		SELF.phone := l.phone;
		SELF.AppendedDID := IF(noCallerName,(STRING)r.did,l.AppendedDID);
		SELF.AppendedFirstName := IF(noCallerName,r.fname,l.AppendedFirstName);
		SELF.AppendedMiddleName := IF(noCallerName,r.mname,l.AppendedMiddleName);
		SELF.AppendedSurname := IF(noCallerName,r.lname,l.AppendedSurname);
		SELF.AppendedListingName := IF(noCallerName,r.listed_name,l.AppendedListingName);
		SELF.AppendedFirstDate := ut.Min2(l.AppendedFirstDate,(UNSIGNED)r.dt_first_seen);
		SELF.AppendedLastDate := MAX((UNSIGNED)r.dt_last_seen,l.AppendedLastDate);
		SELF.AppendedCompanyName := IF(match,r.companyname,l.AppendedCompanyName);
		SELF.AppendedStreetNumber := IF(match,r.prim_range,l.AppendedStreetNumber);
		SELF.AppendedPreDirectional := IF(match,r.predir,l.AppendedPreDirectional);
		SELF.AppendedStreetName := IF(match,r.prim_name,l.AppendedStreetName);
		SELF.AppendedStreetSuffix := IF(match,r.suffix,l.AppendedStreetSuffix);
		SELF.AppendedPostDirectional := IF(match,r.postdir,l.AppendedPostDirectional);
		SELF.AppendedUnitDesignator := IF(match,r.unit_desig,l.AppendedUnitDesignator);
		SELF.AppendedUnitNumber := IF(match,r.sec_range,l.AppendedUnitNumber);
		SELF.AppendedCity := IF(match,r.city_name,l.AppendedCity);
		SELF.AppendedStateCode := IF(match,r.st,l.AppendedStateCode);
		SELF.AppendedZipCode := IF(match,r.zip,l.AppendedZipCode);
		SELF.AppendedZipCodeExtension := IF(match,r.zip4,l.AppendedZipCodeExtension);
		nameMatch := IF(STD.Str.Contains(l.LexisNexisMatchCode,Constants.LNMatch.NAME,false) OR inputNameMatch,Constants.LNMatch.NAME,'');
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
		noEntityMatch := MAP(NOT includeEntity AND l.AppendedPhoneLineType = 'WIRELESS' => Constants.LNMatch.CELL,
											 NOT includeEntity AND l.AppendedPhoneLineType <> 'WIRELESS' AND businessMatch <> '' => Constants.LNMatch.BUSINESS,
											 NOT includeEntity AND l.AppendedPhoneLineType <> 'WIRELESS' AND businessMatch = '' => Constants.LNMatch.NON_CELL_CONSUMER,
											 '');
		// subjectMatch := match AND((l.did > 0 AND l.did IN [(UNSIGNED)l.AppendedDID,r.did]) OR (l.name_first IN [r.fname,l.AppendedFirstName] AND l.name_last IN [r.lname,l.AppendedSurname])) AND
										// l.subj2own_relationship = Constants.Relationship.SUBJECT;
		badNumber := l.LexisNexisMatchCode=Constants.LNMatch.INVALID;
		SELF.LexisNexisMatchCode := MAP(badNumber => Constants.LNMatch.INVALID,
																		noOwner => Constants.LNMatch.NONE,
																		nameMatch + relationalMatch + addressMatch + phoneMatch + businessMatch + noEntityMatch);
		//********************determine phone Ownership*******************************************
		SELF.subj2own_relationship := MAP(badNumber => Constants.Relationship.INVALID, 
																			noCallerName AND NOT inputNameMatch => '',
																			l.subj2own_relationship);
		isDisconnected := l.disconnect_status = Constants.DisconnectStatus.DISCONNECTED;
		isCloseRelative := l.subj2own_relationship NOT IN ['',Constants.Relationship.INVALID,Constants.Relationship.RELATIVE,Constants.Relationship.SUBJECT];
		SELF.reason_codes := MAP(badNumber => Constants.Reason_Codes.INVALID_NUMBER,
														isDisconnected AND l.reason_codes<>'' => l.reason_codes + Constants.Reason_Codes.DISCONNECTED,
														Functions.GetReasonCodes(nameMatch<>'' OR sameDID,noOwner,l.disconnect_status = Constants.DisconnectStatus.DISCONNECTED) );	
		ownership := MAP(l.ownership_index != Constants.Ownership.enumIndex.UNDETERMINED => l.ownership_index,
											recordNameMatch AND inputNameMatch AND l.subj2own_relationship=Constants.Relationship.SUBJECT => Constants.Ownership.enumIndex.HIGH,
											recordNameMatch AND inputNameMatch AND isCloseRelative => Constants.Ownership.enumIndex.MEDIUM_HIGH,
											recordNameMatch AND inputNameMatch AND l.subj2own_relationship = Constants.Relationship.RELATIVE => Constants.Ownership.enumIndex.MEDIUM,
											noOwner => Constants.Ownership.enumIndex.UNDETERMINED,
											NOT inputNameMatch => Constants.Ownership.enumIndex.LOW,									
											l.ownership_index);
		ownershipStatus := IF(l.reason_codes='' AND isDisconnected AND ownership > 2,ownership - 1, ownership);
		SELF.ownership_index := IF(badNumber,Constants.Ownership.enumIndex.INVALID,ownershipStatus);
		SELF.ownership_likelihood := IF(badNumber,Constants.Ownership.INVALID,Functions.getOwnershipValue(ownershipStatus));
		SELF.AppendedRecordType := businessMatch; 
		SELF:=l;
		SELF:=[];
	END;
	dsLNData := JOIN(dsPhoneswREAB,dsLNIdentities,
															LEFT.phone=RIGHT.phone AND
															(LEFT.AppendedDID = (STRING)RIGHT.DID OR
															//account for name or company matches
															(Functions.fuzzyString(LEFT.AppendedFirstName) = Functions.fuzzyString(RIGHT.fname) AND 
															 Functions.fuzzyString(LEFT.AppendedSurname) = Functions.fuzzyString(RIGHT.lname)) OR
															Functions.fuzzyString(LEFT.AppendedListingName) = Functions.fuzzyString(RIGHT.companyname)),
															appendLNData(LEFT,RIGHT),
															LEFT OUTER, LIMIT(Constants.MAX_RECORDS,SKIP));		
	//result record count will always be one per acctno for this release.
	dsPhoneResults := UNGROUP(TOPN(GROUP(SORT(dsLNData,acctno),acctno),inMod.MaxIdentityCount,acctno,-ownership_index,reason_codes,seq)); 
	
	PhoneOwnership.Layouts.BatchOut UpdateUnknownRelationships (PhoneOwnership.Layouts.BatchOut l):= TRANSFORM
		availableListingName := l.AppendedListingName <>'';
		names := STD.Str.SplitWords(l.AppendedListingName,' ');
		inputMatch :=	Functions.evaluateNameMatch(l.name_first,l.name_last,l.AppendedFirstName,l.AppendedSurname);
		listingMatch := availableListingName AND (l.AppendedFirstName IN names) AND (l.AppendedSurname IN names);
		inputNameMatch := NOT availableListingName AND inputMatch;
		ownershipPossible := listingMatch OR inputNameMatch;
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
		SELF.LexisNexisMatchCode := MAP(ownershipPossible => l.LexisNexisMatchCode,
																		l.LexisNexisMatchCode = Constants.LNMatch.INVALID => Constants.LNMatch.INVALID,
																		l.AppendedPhoneLineType = 'WIRELESS' => Constants.LNMatch.CELL,
																		l.AppendedRecordType = Constants.LNMatch.BUSINESS => Constants.LNMatch.BUSINESS,
																		l.AppendedRecordType <> Constants.LNMatch.BUSINESS => Constants.LNMatch.NON_CELL_CONSUMER,
																		'');	
		SELF.ownership_index := IF(ownershipPossible OR l.ownership_index = Constants.Ownership.enumIndex.INVALID, l.ownership_index,Constants.Ownership.enumIndex.UNDETERMINED);																		
		SELF.ownership_likelihood := IF(ownershipPossible OR l.ownership_likelihood = Constants.Ownership.INVALID, l.ownership_likelihood, Constants.Ownership.UNDETERMINED);	
		SELF.subj2own_relationship := IF(ownershipPossible OR l.subj2own_relationship = Constants.Relationship.INVALID, l.subj2own_relationship,'');																			
		SELF:=l;
	END;
	dsPhonesFinal := PROJECT(dsPhoneResults,UpdateUnknownRelationships(LEFT));
	
/*//reports that identified owner might be involved in a litigation. Moved to next phase.
	dsContactRisk := IF(inMod.contactRiskFlag,BatchServices.PossibleLitigiousDebtor_BatchService_Records(PROJECT(dsPhoneResults,TRANSFORM(BatchServices.Layouts.PLD.rec_batch_PLD_input,
																																																																		SELF.acctno:=LEFT.acctno,
																																																																		SELF.name_first:=LEFT.appendedfirstname,
																																																																		SELF.name_middle:=LEFT.appendedmiddlename,
																																																																		SELF.name_last:=LEFT.appendedsurname,
																																																																		SELF.courtjurisdiction:=LEFT.appendedstatecode))),
																					DATASET([],BatchServices.Layout_PLD_Batch_out));
	dsResults := JOIN(dsPhoneResults,dsContactRisk,
								LEFT.acctno=RIGHT.acctno,
								TRANSFORM(Phones.PhoneOwnership_Layouts.BatchOut,
													SELF.contact_risk_flag:=(STRING)RIGHT.LitigiousDebtor_Flag,
													SELF:=LEFT,
													SELF:=[]),
									LEFT OUTER,LIMIT(Constants.MAX_RECORDS,SKIP));
*/
	dsResults := dsPhonesFinal;
	// dsRoyaltiesZumigoIdentity := Royalty.RoyaltyZumigoGetLineIdentity.GetBatchRoyaltiesByAcctno(sort(dsZumigoScores, acctno, phone,-rec_source), rec_source, phone, acctno);
	dsRealTimeATT_LIDB := dsPhoneswMetadata(source = Phones.Constants.PhoneAttributes.ATT_LIDB_RealTime);
	dsRoyaltiesATT_LIDB_GetLine := Royalty.RoyaltyATT.GetBatchRoyaltiesByAcctno(dsRealTimeATT_LIDB, source, phoneno, acctno);	
	dsRoyaltiesAccudata_CNAM  := Royalty.RoyaltyAccudata_CNAM.GetBatchRoyaltiesByAcctno(dsAccuData);
	dsRoyaltiesByAcctno := 
										// IF(inMod.useZumigo, dsRoyaltiesZumigoIdentity) + 
										IF(inMod.useAccudataCNAM, dsRoyaltiesAccudata_CNAM) + 
										IF(inMod.useRealTimeLIDB,dsRoyaltiesATT_LIDB_GetLine);
	
	PhoneOwnership.Layouts.Final ResultswRoyalties () := TRANSFORM
		SELF.Results := PROJECT(dsResults,TRANSFORM(PhoneOwnership.Layouts.BatchOut,SELF:=LEFT,SELF:=[]));
		SELF.Royalties:= IF(EXISTS(dsRoyaltiesByAcctno),PROJECT(dsRoyaltiesByAcctno,Royalty.Layouts.RoyaltyForBatch),DATASET([], Royalty.Layouts.RoyaltyForBatch));
	END;

	dsFinal := DATASET([ResultswRoyalties()])[1];	

	#IF(PhoneOwnership.Constants.Debug.Main)
		OUTPUT(ds_batch_in,NAMED('ds_batch_in'));
		OUTPUT(dsBatch,NAMED('dsBatch'));
		OUTPUT(dsBatchwBestInfo,NAMED('dsBatchwBestInfo'));
		OUTPUT(dsBatchwDIDs,NAMED('dsBatchwDIDs'));
		OUTPUT(dsBatchwInput,NAMED('dsBatchwInput'));
		OUTPUT(dsPhoneswMetadata,NAMED('dsPhoneswMetadata'));
		OUTPUT(dsPhonesMetadataByEffectiveDate,NAMED('dsPhonesMetadataByEffectiveDate'));
		// OUTPUT(dsBatchwREAB,NAMED('dsBatchwREAB'));
		// OUTPUT(dsZumigoRequest,NAMED('dsZumigoRequest'));
		// OUTPUT(dsZumigoScores,NAMED('dsZumigoScores'));
		OUTPUT(dsAccuData,NAMED('dsAccuData'));
		OUTPUT(dsAccuDataFormatted,NAMED('dsAccuDataFormatted'));
		OUTPUT(dsPhoneswCallerName,NAMED('dsPhoneswCallerName'));
		OUTPUT(dsPhoneswREAB,NAMED('dsPhoneswREAB'));		
		OUTPUT(dsLNIdentities,NAMED('dsLNIdentities'));
		OUTPUT(dsLNData,NAMED('dsLNData'));
		OUTPUT(dsPhoneResults,NAMED('dsPhoneResults'));
		OUTPUT(dsPhonesFinal,NAMED('dsPhonesFinal'));
		// OUTPUT(dsContactRisk,NAMED('dsContactRisk'));
		// OUTPUT(dsResults,NAMED('dsResults'));
		// OUTPUT(dsRealTimeATT_LIDB,NAMED('dsRealTimeATT_LIDB'));
		OUTPUT(dsRoyaltiesByAcctno,NAMED('dsRoyaltiesByAcctno'));
		// OUTPUT(dsFinal,NAMED('dsFinal'));
	#END
	// OUTPUT(inMod);
	RETURN 	dsFinal;																							 
																										 
END;