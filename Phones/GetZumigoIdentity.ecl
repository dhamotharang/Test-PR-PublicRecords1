/*
This function prepare phones request to call Zumigo.
As of 07/2018 Zumigo is configured to call 9 functions.
When available lineType and carrier name are returned for all requests.
NameAddressValidation: scores up to 15 submitted firstname/lastname/address 
						- a value of 80-100 inclusively determines a passing score
NameAddressInfo: returns owners info from carrier - subscriber name and email, billing address
				 - we are not able to store this data unless we find an inhouse match.
				 - we must execute this function with a call for NameAddressValidation.				
AccountInfo: returns phone account info - type, line & acct activation date, duration, primary account holder, serv type & status
CarrierInfo: carrier info only-OriginalCarrierNumber, MobileCountryCode,MobileNetworkCode, whether location and identity are supported.
CallHandlingInfo: Call forwarding indicator and forwarded phone number - as of 04/2018 not currently getting forwarded phone#.
DeviceInfo: returning device information - model and make.
			 - also returns IntlMobileSubscriberId(IMSI), IntlMobileEquipmentId(IMEI), IntlMobileSubscriberId (IMSI), IntegratedCircuitCardId (ICC ID).
			 - The IDs above are hashed before outputting. 
DeviceHistory: history of device with phone# - must be requested with DeviceInfo function
			 - returns imsi or imei SeenSince/ChangedThisTime/ChangedCount/TrackedSince
DeviceChangeOption - 			 
AccountStatusInfo: Returns ServiceStatus - active/cancelled/suspended 

After obtaining Zumigo, we process results to populate what we are legally allowed to store.
*/
IMPORT Address,Codes, Doxie,DidVille,Email_Data, Gateway, iesp, Phones,Risk_Indicators,STD, ut;
EXPORT GetZumigoIdentity(DATASET(Phones.Layouts.ZumigoIdentity.subjectVerificationRequest) inRecs,
						Phones.IParam.inZumigoParams inMod,
						UNSIGNED1 GLBPurpose = 0,
						UNSIGNED1 DPPAPurpose = 0,
						STRING DataRestrictionMask = '',
						STRING IndustryClass = '',
						STRING32 ApplicationType='') := FUNCTION
													
	//Note that Zumigo does not permit NameAddressInfo without NameAddressValidation
	nameAddrRequested := inMod.NameAddressValidation OR inMod.NameAddressInfo;		
	
	dsZumigoRequest := inRecs(phone<>'');//all records going to Zumigo request MUST have a phone populated.
	
	// records suitable for nameAddressValidation and nameAddressInfo - should include phone with name(s) and address(es) pair. BusinessName should be added.
	dsNameAddrRequest := dsZumigoRequest((first_name<>'' AND last_name<>'') OR  (prim_name<>'' OR p_city_name<>'' OR st<>'' OR z5<>''));
	
	Phones.Layouts.ZumigoIdentity.zIn prepZumigoInput (Phones.Layouts.ZumigoIdentity.subjectVerificationRequest l):= TRANSFORM
		// validForNameAddrRequest := l.phone<>'' AND l.first_name<>'' AND l.last_name<>'' AND l.prim_name<>'' AND l.p_city_name<>'' AND l.st<>'' AND l.z5<>'';
		//preserve the acctno and seq for each record sent to Zumigo. This will be group by phone number across multiple account to avoid duplicate calls for the same phone.
		acctSeqPrefix := l.acctno + '|'+ l.sequence_number + '|';
		SELF.acctno := l.acctno;
		SELF.sequence_number := l.sequence_number;
		SELF.MobileDeviceNumber := l.phone;
		SELF.Name.NameType := acctSeqPrefix + l.NameType;
		SELF.Name.FirstName := l.first_name;
		SELF.Name.LastName := l.last_name;
		//According to email from Zumigo, BusinessName is only supported for ATT and TMO
		SELF.Name.BusinessName := l.business_name; 
		SELF.Address.AddressType := acctSeqPrefix + l.AddressType;
		SELF.Address.AddressLine1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, '', l.sec_range);
		SELF.Address.City := l.p_city_name;
		SELF.Address.state := l.st;
		SELF.Address.PostalCode := l.z5;
		SELF.Email.EmailType := acctSeqPrefix + l.EmailType;
		SELF.Email.EmailAddress := l.email_address;		
		SELF:=[];
	END;
	zumNameAddrRequest := PROJECT(dsNameAddrRequest,prepZumigoInput(LEFT));
	validNameAddrRequests := TOPN(GROUP(SORT(zumNameAddrRequest,MobileDeviceNumber,acctno,sequence_number), MobileDeviceNumber),inMod.NameAddressPairs,MobileDeviceNumber);

	iesp.zumigo_identity.t_ZIdIdentitySearch rollInput (Phones.Layouts.ZumigoIdentity.zIn l, DATASET(Phones.Layouts.ZumigoIdentity.zIn) r):= TRANSFORM
		SELF.MobileDeviceNumber := l.MobileDeviceNumber;
		SELF.NameAddrValidation.NameList := PROJECT(r,TRANSFORM(iesp.zumigo_identity.t_ZIdNameToVerify,SELF:=LEFT.Name));
		SELF.NameAddrValidation.AddressList := PROJECT(r,TRANSFORM(iesp.zumigo_identity.t_ZIdSubjectAddress,SELF:=LEFT.Address));
		SELF.NameAddrValidation.EmailList := PROJECT(r,TRANSFORM(iesp.zumigo_identity.t_ZIdEmailToVerify,SELF:=LEFT.Email));
		SELF:=[];
	END;
	zumValidationRequest := ROLLUP(validNameAddrRequests,GROUP, rollInput(LEFT,ROWS(LEFT))); // a single call for each phone across all accounts		
	zumNonValidationRequest := PROJECT(DEDUP(SORT(dsZumigoRequest, phone), phone), TRANSFORM(iesp.zumigo_identity.t_ZIdIdentitySearch,SELF.MobileDeviceNumber:=LEFT.phone,SELF:=[]));
	zumIn := IF(nameAddrRequested,zumValidationRequest,zumNonValidationRequest);									
	//Call to Zumigo gateway
	zumOut:=Gateway.Soapcall_ZumigoIdentity(zumIn,inMod,doxie.DataPermission.use_ZumigoIdentity);
	
	//***Preserve populated emails with Email_rec_key - using TransactionID to establish link since the actual email address will not be saved
	setRoyaltyEmailSources := SET(codes.Key_Codes_V3(file_name	=	'EMAIL_SOURCES',field_name	=	'ROYALTY'),code);
	zEmails := zumOut(response.LineIdentityResponse.Subscriber.FirstName<>'' AND response.LineIdentityResponse.Subscriber.LastName<>'' AND response.LineIdentityResponse.Subscriber.Email<>'');
	zEmailMatch := JOIN(zEmails, Email_Data.Key_Email_Address,
						KEYED(LEFT.response.LineIdentityResponse.Subscriber.Email = RIGHT.Clean_email) AND
						RIGHT.email_src NOT in	setRoyaltyEmailSources AND
						ut.NameMatch(LEFT.response.LineIdentityResponse.Subscriber.FirstName,'',
									 LEFT.response.LineIdentityResponse.Subscriber.LastName,RIGHT.orig_first_name,'',RIGHT.orig_last_name)<=Phones.Constants.STRING_MATCH_THRESHOLD,
						TRANSFORM(Phones.Layouts.ZumigoIdentity.zOutEmail,
									SELF.lexid := RIGHT.did,
									SELF.Email_rec_key := RIGHT.Email_rec_key,
									SELF.TransactionID := LEFT.response._Header.TransactionID, 
									SELF.FirstName := LEFT.response.LineIdentityResponse.Subscriber.FirstName,
									SELF.LastName := LEFT.response.LineIdentityResponse.Subscriber.LastName,
									SELF.Email := LEFT.response.LineIdentityResponse.Subscriber.Email,
									SELF:=[]),
						KEEP(1), LIMIT(0));											
																						
	//***Preserve forwarding info	- getLNIdentity_byPhone dedups phone 
	// being discussed in email. Zumigo is not returning forwarded phone numbers.
	// will retain code since included in requirements and there is no foreseeable decision before release.
	// No harm since code is based on filtered records by forwarded phone #s.
	zForwardedPhones := zumOut(response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwarding AND response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwardedNumber<>'');
	dsForwardedPhones := PROJECT(zForwardedPhones,TRANSFORM(Phones.Layouts.PhoneIdentity,SELF.phone:=LEFT.response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwardedNumber, SELF:=[]));
	dsForwardedPhoneswIdentity := Phones.getLNIdentity_byPhone(dsForwardedPhones,GLBPurpose,DPPAPurpose,DataRestrictionMask);

	//***flatten by creating a record for each name/address validation pair	
	iesp.zumigo_identity.t_ZumigoIdentityResponseEx normZumigo (iesp.zumigo_identity.t_ZumigoIdentityResponseEx l,  INTEGER c) := TRANSFORM
		SELF.response.LineIdentityResponse.NameAddrValidation.NameList := l.response.LineIdentityResponse.NameAddrValidation.NameList[c];
		SELF.response.LineIdentityResponse.NameAddrValidation.AddressList := l.response.LineIdentityResponse.NameAddrValidation.AddressList[c];
		SELF.response.LineIdentityResponse.NameAddrValidation.EmailList := l.response.LineIdentityResponse.NameAddrValidation.EmailList[c];
		SELF := l;
	END;
	normZResults := NORMALIZE(zumOut, LEFT.response.LineIdentityResponse.NameAddrValidation.Namelist,normZumigo(LEFT,COUNTER)); 
	
	//***normalization drops error records, hence we re-append here.
	dsZResults_wErrors := zumOut(response._header.transactionID NOT IN SET(normZResults,response._header.transactionID)) + normZResults;
	batch_jobid_val := Gateway.Configuration.GetBatchJobId(inMod.gateways(Gateway.Configuration.IsZumigoIdentity(ServiceName))[1]);
	//**********************start building the gateway history table.******************************
	Phones.Layouts.gatewayHistory populateZumigoData(iesp.zumigo_identity.t_ZumigoIdentityResponseEx l) := TRANSFORM
		SELF.transaction_id := l.response._header.TransactionId;
		SELF.batch_job_id := (STRING)batch_jobid_val;
		SELF.source := IF(l.response._header.Message='' AND l.response.LineIdentityResponse.Error.ErrorCode = '',Phones.Constants.GatewayValues.ZumigoIdentity,'');
		SELF.vendor_transaction_id := l.response.LineIdentityResponse.TrackingId;
		SELF.submitted_phonenumber := l.response.LineIdentityResponse.MobileDeviceNumber[2..11];
		SELF.optin_type := inMod.OptInType;
		SELF.optin_method := inMod.OptInMethod;
		SELF.optin_duration := inMod.OptInDuration;
		SELF.optin_id := inMod.OptInID;
		SELF.optin_version_id := inMod.OptInVersionId;
		SELF.optin_timestamp := inMod.OptInTimestamp;
		SELF.result_phonenumber := l.response.LineIdentityResponse.MobileDeviceNumber;
		// SELF.device_onetime_id;
		// SELF.device_session_id;
		// SELF.lexid;
		// SELF.busult_id;
		// SELF.busorg_id;
		// SELF.bussele_id;
		// SELF.busprox_id;
		// SELF.buspow_id;
		// SELF.busemp_id;
		// SELF.busdot_id;
		SELF.first_name := l.response.LineIdentityResponse.Subscriber.FirstName;
		SELF.middle_name := l.response.LineIdentityResponse.Subscriber.MiddleName;
		SELF.last_name := l.response.LineIdentityResponse.Subscriber.LastName;
		SELF.business_name := l.response.LineIdentityResponse.Subscriber.BusinessName;
		// SELF.full_name;
		// SELF.ln_match_code;
		// SELF.email_rec_key;
		addr2:= IF(l.response.LineIdentityResponse.Account.BillingAddress.AddressLine2 = '',
					Address.Addr2FromComponents(l.response.LineIdentityResponse.Account.BillingAddress.City, 
												l.response.LineIdentityResponse.Account.BillingAddress.State, 
												l.response.LineIdentityResponse.Account.BillingAddress.PostalCode),
					l.response.LineIdentityResponse.Account.BillingAddress.AddressLine2);
					
		clean_addr := Address.GetCleanAddress(l.response.LineIdentityResponse.Account.BillingAddress.AddressLine1,addr2,address.Components.country.US).results;
		SELF.prim_range := clean_addr.prim_range;
		SELF.predir := clean_addr.predir;
		SELF.prim_name := clean_addr.prim_name;
		SELF.addr_suffix := clean_addr.suffix;
		SELF.postdir := clean_addr.postdir;
		SELF.unit_desig := clean_addr.unit_desig;
		SELF.sec_range := clean_addr.sec_range;		
		SELF.city := l.response.LineIdentityResponse.Account.BillingAddress.City;
		SELF.state := l.response.LineIdentityResponse.Account.BillingAddress.State;
		SELF.zip := l.response.LineIdentityResponse.Account.BillingAddress.PostalCode;
		// SELF.zip4;
		// SELF.county;
		SELF.country := l.response.LineIdentityResponse.Account.BillingAddress.Country;
		string8 t_Date2ToString (iesp.share.t_Date2 Date) := Date.Year + Date.Month + Date.Day;
		SELF.imsi	:= IF(l.response.LineIdentityResponse.Subscriber.IntlMobileSubscriberId='','',(STRING)HASH64(l.response.LineIdentityResponse.Subscriber.IntlMobileSubscriberId));
		SELF.imsi_seensince := l.response.LineIdentityResponse.Subscriber.Identifier.Imsi.SeenSince;
		SELF.imsi_changedthis_time := (INTEGER)l.response.LineIdentityResponse.Subscriber.Identifier.Imsi.ChangedThisTime;
		SELF.imsi_changedate := t_Date2ToString(l.response.LineIdentityResponse.Subscriber.Identifier.Imsi.ChangeDate);
		SELF.imsi_ActivationDate := t_Date2ToString(l.response.LineIdentityResponse.Subscriber.Identifier.Imsi.ActivationDate);
		SELF.imsi_change_count := l.response.LineIdentityResponse.Subscriber.Identifier.Imsi.ChangeCount;
		SELF.imsi_trackedsince := t_Date2ToString(l.response.LineIdentityResponse.Subscriber.Identifier.Imsi.TrackedSince);
		SELF.iccid	:= IF(l.response.LineIdentityResponse.Subscriber.IntegratedCircuitCardId='','',(STRING)HASH64(l.response.LineIdentityResponse.Subscriber.IntegratedCircuitCardId));
		SELF.iccid_changedthis_time := (INTEGER)l.response.LineIdentityResponse.Subscriber.Identifier.Iccid.ChangedThisTime;
		SELF.iccid_seensince := l.response.LineIdentityResponse.Subscriber.Identifier.Iccid.SeenSince;
		SELF.subscriber_id	:= IF(l.response.LineIdentityResponse.Subscriber.SubscriberId='','',(STRING)HASH64(l.response.LineIdentityResponse.Subscriber.SubscriberId));
		SELF.call_forwarding := (INTEGER)l.response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwarding;
		SELF.call_forwarding_linked_toSubject := l.response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwardedNumber; //Call Forwarded Number held temporarily
		SELF.line_type := l.response.LineIdentityResponse.Account.LineType;
		SELF.carrier_name := l.response.LineIdentityResponse.Carrier.Name;
		SELF.carrier_original_name := l.response.LineIdentityResponse.Carrier.OriginalName;
		// SELF.carrier_category;
		SELF.carrier_ocn := l.response.LineIdentityResponse.Carrier.OriginalCarrierNumber;
		SELF.carrier_mcc := l.response.LineIdentityResponse.Carrier.MobileCountryCode;
		SELF.carrier_mnc := l.response.LineIdentityResponse.Carrier.MobileNetworkCode;
		SELF.carrier_identity_supported := (INTEGER)l.response.LineIdentityResponse.Carrier.IdentitySupported;
		SELF.carrier_location_supported := (INTEGER)l.response.LineIdentityResponse.Carrier.LocationSupported;
		// SELF.lrn;
		SELF.device_make := l.response.LineIdentityResponse.Device.Make;
		SELF.device_model := l.response.LineIdentityResponse.Device.Model;
		// SELF.device_type;
		// SELF.deviceOS;
		SELF.imei	:= IF(l.response.LineIdentityResponse.Device.IntlMobileEquipmentId='','',(STRING)HASH64(l.response.LineIdentityResponse.Device.IntlMobileEquipmentId));
		SELF.loststolen := (INTEGER)l.response.LineIdentityResponse.Device.LostStolen;
		SELF.loststolen_date := t_Date2ToString(l.response.LineIdentityResponse.Device.LostStolenDate);
		// SELF.imei_type;
		SELF.imei_seensince := l.response.LineIdentityResponse.Device.Identifier.Imei.SeenSince;
		SELF.imei_changed_this_time := (INTEGER)l.response.LineIdentityResponse.Device.Identifier.Imei.ChangedThisTime;
		SELF.imei_changedate := t_Date2ToString(l.response.LineIdentityResponse.Device.Identifier.Imei.ChangeDate);
		SELF.imei_change_count := l.response.LineIdentityResponse.Device.Identifier.Imei.ChangeCount;
		SELF.imei_tracked_since := t_Date2ToString(l.response.LineIdentityResponse.Device.Identifier.Imei.TrackedSince);
		SELF.first_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].FirstNameScore;
		SELF.last_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].LastNameScore;
		SELF.addr_score := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressScore;
		SELF.billing_first_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].BillingFirstNameScore;
		SELF.billing_last_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].BillingLastNameScore;
		SELF.business_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].BusinessNameScore;		
		SELF.email_address_score := l.response.LineIdentityResponse.NameAddrValidation.EmailList[1].EmailScore;		
		// SELF.cnm_availability_indicator;
		// SELF.cnm_presentation_indicator;
		// SELF.port_date;
		// SELF.lata;
		// SELF.reply_code;
		// SELF.point_code;
		// SELF.prepaid;
		SELF.account_status := l.response.LineIdentityResponse.Account.ServiceStatus;
		// SELF.language;
		// SELF.tele_type;
		// SELF.bill_block;
		// SELF.purchase_block;
		// SELF.loc_latitude;
		// SELF.loc_longitude;
		// SELF.loc_address;
		// SELF.loc_accuracy;
		// SELF.sub_position;
		// SELF.sub_lexid;
		// SELF.sub_busult_id;
		// SELF.sub_busorg_id;
		// SELF.sub_bussele_id;
		// SELF.sub_busprox_id;
		// SELF.sub_buspow_id;
		// SELF.sub_busemp_id;
		// SELF.sub_busdot_id;
		SELF.sub_name_type := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].NameType;
		SELF.sub_first_name := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].FirstName;
		SELF.sub_last_name := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].LastName;
		SELF.sub_business_name := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].BusinessName;
		SELF.sub_addr_type := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressType;
		SELF.sub_addr1 := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressLine1;
		SELF.sub_addr2 := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressLine2;
		SELF.sub_city := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].City;
		SELF.sub_state := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].State;
		SELF.sub_postal_code := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].PostalCode;
		SELF.sub_country := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].Country;
		SELF.sub_email_address := l.response.LineIdentityResponse.NameAddrValidation.EmailList[1].EmailAddress;
		// SELF.customer_bill_acct_type;
		// SELF.customer_bill_acct;
		SELF.device_mgmt_status := MAP(l.response.LineIdentityResponse.Error.ErrorCode <> '' => l.response.LineIdentityResponse.Error.ErrorInfo,
										l.response._header.Message <> '' => l.response._header.Message,
										'');	
		// SELF.date_added;
		SELF := l.response.LineIdentityResponse;
		SELF := [];
	
	END;
	zProcessedOutput := PROJECT(dsZResults_wErrors,populateZumigoData(LEFT));
	
	//***repopulate acctno and seq in correct fields for nameAddressValidation records.
	Phones.Layouts.ZumigoIdentity.zOut extractAcctnoNSeq(Phones.Layouts.gatewayHistory l) := TRANSFORM
		setStr:=STD.Str.SplitWords(l.sub_name_type,'|'); // defined on lines 22 and 26. Index 1 is the acctno, 2 is the seq#
		addressType:=STD.Str.SplitWords(l.sub_addr_type,'|'); // and 3 is the name/address/email type. 
		SELF.acctno := IF(l.sub_name_type<>'',setStr[1],addressType[1]);
		SELF.sequence_number := (UNSIGNED)IF(l.sub_name_type<>'',setStr[2],addressType[2]);
		SELF.sub_name_type := setStr[3];
		SELF.sub_addr_type := addressType[3];
		SELF := l;
		SELF :=[];
	END;
	dsRepopulateAcctnoNSeq := PROJECT(zProcessedOutput,extractAcctnoNSeq(LEFT));
	
	//***Re-append IDs for submitted identities	 
	Phones.Layouts.ZumigoIdentity.zOut updateIDs (Phones.Layouts.ZumigoIdentity.subjectVerificationRequest l, Phones.Layouts.ZumigoIdentity.zOut r):= TRANSFORM
		SELF.acctno := l.acctno;
		SELF.sequence_number := l.sequence_number;
		SELF.submitted_phonenumber := l.phone;
		SELF.sub_lexid := l.lexid;
		SELF.sub_busult_id := l.busult_id;
		SELF.sub_busorg_id := l.busorg_id;
		SELF.sub_bussele_id := l.bussele_id;
		SELF.sub_busprox_id := l.busprox_id;
		SELF.sub_buspow_id := l.buspow_id;
		SELF.sub_busemp_id := l.busemp_id;
		SELF.sub_busdot_id := l.busdot_id;
		SELF.sub_name_type := l.nameType;
		SELF.sub_first_name := l.first_name;
		SELF.sub_last_name := l.last_name;
		SELF.sub_addr_type := l.addressType;
		SELF.sub_addr1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name, l.addr_suffix, l.postdir, '', l.sec_range);
		SELF.sub_city := l.p_city_name;																									 
		SELF.sub_state := l.st;																									 
		SELF.sub_postal_code := l.z5;																									 
		//source and optin fields will be blank for any record that was not sent to Zumigo. //eg. blank phones - can be filtered out later
		SELF.transaction_id := r.transaction_id;
		SELF:= r;
		SELF:=[]
	END;
	zHistoryRecs := JOIN(inRecs,dsRepopulateAcctnoNSeq,
							LEFT.phone 	= RIGHT.submitted_phonenumber AND
							(LEFT.acctno	= RIGHT.acctno OR RIGHT.acctno='') AND
							(LEFT.sequence_number = RIGHT.sequence_number OR RIGHT.sequence_number=0),
							updateIDs(LEFT,RIGHT),
							LEFT OUTER, KEEP(1),LIMIT(0));	

	//***For NameAddressInfo - get Phone Subscribers' name and billing address to lexID results
	zPhoneOwners := IF(inMod.NameAddressInfo,PROJECT(DEDUP(SORT(zHistoryRecs(vendor_transaction_id<>''),submitted_phonenumber),submitted_phonenumber),
													TRANSFORM(Didville.Layout_Did_OutBatch,
																SELF.seq:=counter,
																SELF.phone10:=LEFT.submitted_phonenumber,
																SELF.fname := LEFT.first_name,
																SELF.mname := LEFT.middle_name,
																SELF.lname := LEFT.last_name,
																SELF.p_city_name := LEFT.city,
																SELF.st := LEFT.state,
																SELF.z5 := LEFT.zip,
																SELF := LEFT,
																SELF := [])),
			DATASET([],Didville.Layout_Did_OutBatch));

 zPhoneOwners_wDIDs := Phones.Functions.GetDIDs(zPhoneOwners,ApplicationType,GLBPurpose,DPPAPurpose);			
	zHistoryRecs_wDIDs := JOIN(zHistoryRecs,zPhoneOwners_wDIDs,
								LEFT.submitted_phonenumber = RIGHT.phone10,
								TRANSFORM(Phones.Layouts.ZumigoIdentity.zOut,SELF.lexid:=RIGHT.did,SELF:=LEFT,SELF:=[]),
								LEFT OUTER,LIMIT(Phones.Constants.MAX_RECORDS,SKIP));
	//***For NameAddressInfo - now that we have a DID populate output dataset from matching request data.
	// legally we are not allowed to store Zumigo data																								
	Phones.Layouts.ZumigoIdentity.zOut matchSubmittedData(Phones.Layouts.ZumigoIdentity.zOut l, Phones.Layouts.ZumigoIdentity.subjectVerificationRequest r) := TRANSFORM			
		FirstNameMatch := IF(l.first_name<>'' AND ut.StringSimilar(l.first_name,r.first_name)<=Phones.Constants.STRING_MATCH_THRESHOLD,'F','');
		MiddleNameMatch := IF(l.middle_name<>'' AND ut.StringSimilar(l.middle_name,r.middle_name)<=Phones.Constants.STRING_MATCH_THRESHOLD,'M','');
		LastNameMatch := IF(l.last_name<>'' AND ut.StringSimilar(l.last_name,r.last_name)<=Phones.Constants.STRING_MATCH_THRESHOLD,'L','');
		BusinessNameMatch := IF(l.business_name<>'' AND ut.StringSimilar(l.business_name,r.business_name)<=Phones.Constants.STRING_MATCH_THRESHOLD,'B','');
		AddressMatch := IF(l.prim_range<>'' AND Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore( //matching address
																					l.prim_range,l.prim_name,l.sec_range,
																					r.prim_range,r.prim_name,r.sec_range,
																					Risk_Indicators.AddrScore.zip_score(l.zip,r.z5),
																					Risk_Indicators.AddrScore.citystate_score(l.city,l.state,r.p_city_name,r.st,''))),'A','');
		// if we cannot match Zumigo data names will be blank.
		SELF.first_name := r.first_name;
		SELF.middle_name := r.middle_name;
		SELF.last_name := r.last_name;
		SELF.full_name := IF(r.last_name<>'' AND r.first_name<>'', 
									TRIM(r.last_name) + ', ' + TRIM(r.first_name) + ' ' + TRIM(r.middle_name),
									r.last_name);
		SELF.busUlt_id := r.busUlt_id;
		SELF.busOrg_id := r.busOrg_id;
		SELF.busSELE_id := r.busSELE_id;
		SELF.busProx_id := r.busProx_id;
		SELF.busPow_id := r.busPow_id;
		SELF.busEmp_id := r.busEmp_id;
		SELF.busDot_id := r.busDot_id;				
		SELF.business_name := r.business_name;		
		SELF.ln_match_code := FirstNameMatch + 	MiddleNameMatch + LastNameMatch + BusinessNameMatch + AddressMatch;	
		SELF := l;
		SELF := [];	
	END;																									
 zHistoryRecs_wInputMatch	:= JOIN(zHistoryRecs_wDIDs,dsNameAddrRequest,
									LEFT.submitted_phonenumber = RIGHT.phone AND
									((LEFT.lexid  > 0 AND LEFT.lexid = RIGHT.lexid) OR 
									(LEFT.first_name<>'' AND LEFT.last_name<>'' AND
									ut.NameMatch(LEFT.first_name,LEFT.middle_name,LEFT.last_name,RIGHT.first_name,RIGHT.middle_name,RIGHT.last_name)<=Phones.Constants.STRING_MATCH_THRESHOLD) OR 
									(LEFT.business_name<>'' AND ut.StringSimilar(LEFT.business_name,RIGHT.business_name)<=Phones.Constants.STRING_MATCH_THRESHOLD)),
									matchSubmittedData(LEFT,RIGHT),
									LEFT OUTER,LIMIT(Phones.Constants.MAX_RECORDS,SKIP));		
	//***For NameAddressInfo - now that we have a DID populate output dataset with inhouse data.
	LNPhoneOwnership := Phones.GetLNIdentity_byPhone(PROJECT(zPhoneOwners,TRANSFORM(Phones.Layouts.PhoneIdentity, //processes unique phones and reported owner
																					SELF.acctno := (STRING)LEFT.seq,
																					SELF.did := LEFT.did,
																					SELF.phone := LEFT.phone10,
																					SELF.suffix := LEFT.addr_suffix,
																					SELF.city_name := LEFT.p_city_name,
																					SELF.listed_name := LEFT.fname + ' ' + LEFT.lname,
																					SELF.zip := LEFT.z5,
																					SELF:=LEFT,SELF:=[])),
														GLBPurpose,DPPAPurpose,DataRestrictionMask,Industryclass);
	Phones.Layouts.ZumigoIdentity.zOut matchSubscriber(Phones.Layouts.ZumigoIdentity.zOut l, Phones.Layouts.PhoneIdentity r) := TRANSFORM					
				FirstNameMatch := IF(l.first_name<>'' AND ut.StringSimilar(l.first_name,r.fname)<=Phones.Constants.STRING_MATCH_THRESHOLD,'F','');
				MiddleNameMatch := IF(l.middle_name<>'' AND ut.StringSimilar(l.middle_name,r.mname)<=Phones.Constants.STRING_MATCH_THRESHOLD,'M','');
				LastNameMatch := IF(l.last_name<>'' AND ut.StringSimilar(l.last_name,r.lname)<=Phones.Constants.STRING_MATCH_THRESHOLD,'L','');
				BusinessNameMatch := IF(l.business_name<>'' AND ut.StringSimilar(l.business_name,r.companyname)<=Phones.Constants.STRING_MATCH_THRESHOLD,'B','');
				AddressMatch := IF(l.prim_range <>'' AND Risk_Indicators.iid_constants.ga(Risk_Indicators.AddrScore.AddressScore( //matching address
																						l.prim_range,l.prim_name,l.sec_range,
																						r.prim_range,r.prim_name,r.sec_range,
																						Risk_Indicators.AddrScore.zip_score(l.zip,r.zip),
																						Risk_Indicators.AddrScore.citystate_score(l.city,l.state,r.city_name,r.st,''))),'A','');
					// if we cannot match Zumigo data names will be blank.
				SELF.first_name := r.fname;
				SELF.middle_name := r.mname;
				SELF.last_name := r.lname;
				SELF.busUlt_id := r.UltID;
				SELF.busOrg_id := r.OrgID;
				SELF.busSELE_id := r.SELEID;
				SELF.busProx_id := r.ProxID;
				SELF.busPow_id := r.PowID;
				SELF.business_name := r.companyname;						
				SELF.ln_match_code := FirstNameMatch + MiddleNameMatch + LastNameMatch + BusinessNameMatch + AddressMatch;						
				SELF := l;
				SELF := [];			
	END;
	zHistoryRecs_wLNIdentityMatch := JOIN(zHistoryRecs_wDIDs,LNPhoneOwnership,
											LEFT.submitted_phonenumber = RIGHT.phone AND
											(LEFT.lexid = RIGHT.did OR 
											(LEFT.first_name<>'' AND LEFT.last_name<>'' AND
											(ut.NameMatch(LEFT.first_name,LEFT.middle_name,LEFT.last_name,RIGHT.fname,RIGHT.mname,RIGHT.lname)<=Phones.Constants.STRING_MATCH_THRESHOLD OR
											ut.StringSimilar(LEFT.first_name + ' ' + LEFT.last_name,RIGHT.listed_name)<=Phones.Constants.STRING_MATCH_THRESHOLD)) OR 
											(LEFT.business_name<>'' AND ut.StringSimilar(LEFT.business_name,RIGHT.companyname)<=Phones.Constants.STRING_MATCH_THRESHOLD)),
											matchSubscriber(LEFT,RIGHT),
											LEFT OUTER, KEEP(1), LIMIT(0));	
	// keep records with populated names
	zHistoryRecs_wMatchedSubscriber := DEDUP(SORT(zHistoryRecs_wInputMatch + zHistoryRecs_wLNIdentityMatch,
													acctno,sequence_number,first_name='',last_name='',business_name='',RECORD),acctno,sequence_number);

	zHistoryRecs_wEmailMatched := JOIN(zHistoryRecs_wMatchedSubscriber,zEmailMatch,
										LEFT.Transaction_ID = RIGHT.TransactionID,
										TRANSFORM(Phones.Layouts.ZumigoIdentity.zOut,
										SELF.Email_rec_key := RIGHT.Email_rec_key,
										SELF.lexid := IF(LEFT.lexid=0,RIGHT.lexid,LEFT.lexid),
										SELF.ln_match_code := IF(RIGHT.Email_rec_key>0,LEFT.ln_match_code+'NE',LEFT.ln_match_code),//need to clarify N vs FML
										SELF := LEFT),
										LEFT OUTER, LIMIT(Phones.Constants.MAX_RECORDS,SKIP));
																														
	zHistoryRecs_wForwardMatched := JOIN(zHistoryRecs_wEmailMatched,dsForwardedPhoneswIdentity,
											LEFT.call_forwarding_linked_toSubject = RIGHT.phone AND
											(LEFT.lexid = RIGHT.did OR 
											(LEFT.first_name<>'' AND LEFT.last_name<>'' AND
											(ut.NameMatch(LEFT.first_name,LEFT.middle_name,LEFT.last_name,RIGHT.fname,RIGHT.mname,RIGHT.lname)<=Phones.Constants.STRING_MATCH_THRESHOLD OR
											ut.StringSimilar(LEFT.first_name + ' ' + LEFT.last_name,RIGHT.listed_name)<=Phones.Constants.STRING_MATCH_THRESHOLD)) OR 
											(LEFT.business_name<>'' AND ut.StringSimilar(LEFT.business_name,RIGHT.companyname)<=Phones.Constants.STRING_MATCH_THRESHOLD)),
											TRANSFORM(Phones.Layouts.ZumigoIdentity.zOut,
														SELF.call_forwarding_linked_toSubject := IF(RIGHT.phone<>'','TRUE',''),
														SELF:=LEFT,
														SELF:=[]),
											LEFT OUTER, LIMIT(Phones.Constants.MAX_RECORDS,SKIP));
																						
	dsZumigoHistory	:= IF(EXISTS(dsForwardedPhoneswIdentity),zHistoryRecs_wForwardMatched,zHistoryRecs_wEmailMatched);

										
													
													
	#IF(Phones.Constants.Debug.Zumigo)		
		//OUTPUT(zumIn,NAMED('zumIn'));
		OUTPUT(zumOut,NAMED('zumOut'));
		OUTPUT(zEmailMatch,NAMED('zEmailMatch'));
		//OUTPUT(zForwardedPhones,NAMED('zForwardedPhones'));
		//OUTPUT(normzResults,NAMED('normzResults'));
		//OUTPUT(dsZResults_wErrors,NAMED('dsZResults_wErrors'));
		//OUTPUT(dsRepopulateAcctnoNSeq,NAMED('dsRepopulateAcctnoNSeq'));
		//OUTPUT(zProcessedOutput,NAMED('zProcessedOutput'));	
		//OUTPUT(zHistoryRecs,NAMED('zHistoryRecs'));
		//OUTPUT(zPhoneOwners,NAMED('zPhoneOwners'));
		//OUTPUT(zPhoneOwners_wDIDs,NAMED('zPhoneOwners_wDIDs'));
		//OUTPUT(zHistoryRecs_wDIDs,NAMED('zHistoryRecs_wDIDs'));
		//OUTPUT(LNPhoneOwnership,NAMED('LNPhoneOwnership'));
		//OUTPUT(zHistoryRecs_wInputMatch,NAMED('zHistoryRecs_wInputMatch'));
		//OUTPUT(zHistoryRecs_wLNIdentityMatch,NAMED('zHistoryRecs_wLNIdentityMatch'));
		//OUTPUT(zHistoryRecs_wMatchedSubscriber,NAMED('zHistoryRecs_wMatchedSubscriber'));
		//OUTPUT(zHistoryRecs_wEmailMatched,NAMED('zHistoryRecs_wEmailMatched'));
		//OUTPUT(zHistoryRecs_wForwardMatched,NAMED('zHistoryRecs_wForwardMatched'));
		// OUTPUT(dsZumigoHistory,NAMED('dsZumigoHistory'));
	#END;
	RETURN dsZumigoHistory;
END;