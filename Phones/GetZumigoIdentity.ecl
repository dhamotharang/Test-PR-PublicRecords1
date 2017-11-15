IMPORT Address, Doxie, Gateway, iesp, Phones,STD;

EXPORT GetZumigoIdentity(DATASET(Phones.Layouts.ZumigoIdentity.subjectVerificationRequest) inRecs,
													Phones.IParam.inZumigoParams inMod,
													UNSIGNED1 GLBPurpose = 0,
													UNSIGNED1 DPPAPurpose = 0,
													STRING DataRestrictionMask = '') := FUNCTION
	
	Phones.Layouts.ZumigoIdentity.zIn prepZumigoInput (Phones.Layouts.ZumigoIdentity.subjectVerificationRequest l):= TRANSFORM
		//NameAddressValidation service should include phone with name(s) and address(es) pair.
		isValidNameAddrRequest := l.phone<>'' AND l.first_name<>'' AND l.last_name<>'' AND l.prim_name<>'' AND l.p_city_name<>'' AND l.st<>'' AND l.z5<>'';
		//preserve the acctno and seq for each record sent to Zumigo. This will be group by phone number across multiple account to avoid duplicate calls for the same phone.
		acctSeqPrefix := l.acctno + '|'+ l.sequence_number + '|';
		SELF.acctno := l.acctno;
		SELF.sequence_number := l.sequence_number;
		SELF.MobileDeviceNumber := l.phone;
		SELF.Name.NameType := IF(isValidNameAddrRequest,acctSeqPrefix + l.NameType,'');
		SELF.Name.FirstName := l.first_name;
		SELF.Name.LastName := l.last_name;
		SELF.Address.AddressType := IF(isValidNameAddrRequest,acctSeqPrefix + l.AddressType,'');
		SELF.Address.AddressLine1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
																											 l.addr_suffix, l.postdir, '', l.sec_range);
		SELF.Address.City := l.p_city_name;
		SELF.Address.state := l.st;
		SELF.Address.PostalCode := l.z5;
		SELF:=[];
	END;
	zumIn := PROJECT(inRecs,prepZumigoInput(LEFT));
	// all records going to Zumigo must have a MobileDeviceNumber or populated name and address type based on transform above.
	validZumigoRequests := GROUP(SORT(zumIn((MobileDeviceNumber<>'' AND NOT inMod.NameAddressValidation) OR (Name.NameType <>'' AND Address.AddressType <>'' AND inMod.NameAddressValidation)),MobileDeviceNumber), MobileDeviceNumber);

	iesp.zumigo_identity.t_ZIdIdentitySearch rollInput (Phones.Layouts.ZumigoIdentity.zIn l, DATASET(Phones.Layouts.ZumigoIdentity.zIn) r):= TRANSFORM
		SELF.MobileDeviceNumber := l.MobileDeviceNumber;
		SELF.NameAddrValidation.NameList := PROJECT(r,TRANSFORM(iesp.zumigo_identity.t_ZIdNameToVerify,SELF:=LEFT.Name,SELF:=[]));
		SELF.NameAddrValidation.AddressList := PROJECT(r,TRANSFORM(iesp.zumigo_identity.t_ZIdSubjectAddress,SELF:=LEFT.Address,SELF:=[]));
		SELF:=[];
	END;
	dsZum := ROLLUP(validZumigoRequests,GROUP,
											rollInput(LEFT,ROWS(LEFT))); // a single call for each phone across all accounts		
											
	//Call to Zumigo gateway
	zumOut:=Gateway.Soapcall_ZumigoIdentity(dsZum,inMod,doxie.DataPermission.use_ZumigoIdentity);
	
	// forwardedPhones := zumOut(response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwarding AND response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwardingNumber<>'');
	// setForwardedPhones := SET(forwardedPhones,response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwardingNumber);
	// phoneswIdentity := getLNIdentities_byPhone(setForwardedPhones,GLBPurpose,DPPAPurpose,DataRestrictionMask);
	
	iesp.zumigo_identity.t_ZumigoIdentityResponseEx normZumigo (iesp.zumigo_identity.t_ZumigoIdentityResponseEx l,  INTEGER c) := TRANSFORM
		SELF.response.LineIdentityResponse.NameAddrValidation.NameList := l.response.LineIdentityResponse.NameAddrValidation.Namelist[c];
		SELF.response.LineIdentityResponse.NameAddrValidation.AddressList := l.response.LineIdentityResponse.NameAddrValidation.Addresslist[c];
		SELF := l;
	END;
	//flatten by creating a record for each name/address validation pair
	normZResults := NORMALIZE(zumOut, LEFT.response.LineIdentityResponse.NameAddrValidation.Namelist,normZumigo(LEFT,COUNTER)); 
	
	//normalization drops error records, hence we re-append here.
	dsZResults_wErrors := zumOut(response._header.transactionID NOT IN SET(normZResults,response._header.transactionID)) + normZResults;
	
	//start building the gateway history table.
	Phones.Layouts.gatewayHistory savedAllowedZumigoData(iesp.zumigo_identity.t_ZumigoIdentityResponseEx l) := TRANSFORM
		SELF.transaction_id := l.response._header.TransactionId;
		SELF.source := IF(l.response._header.Message='',Phones.Constants.GatewayValues.ZumigoIdentity,'');
		SELF.vendor_transaction_id := l.response.LineIdentityResponse.TrackingId;
		SELF.submitted_phonenumber := l.response.LineIdentityResponse.MobileDeviceNumber[2..11];
		SELF.optin_type := inMod.OptInType;
		SELF.optin_method := inMod.OptInMethod;
		SELF.optin_duration := inMod.OptInDuration;
		SELF.optin_id := inMod.OptInID;
		SELF.optin_version_id := inMod.OptInVersionId;
		SELF.optin_timestamp := inMod.OptInTimestamp;
		// SELF.result_phonenumber := l.response.LineIdentityResponse.MobileDeviceNumber;
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
		SELF.imsi	:= IF(l.response.LineIdentityResponse.Subscriber.IntlMobileSubscriberId='','',(STRING)hash64(l.response.LineIdentityResponse.Subscriber.IntlMobileSubscriberId));
		SELF.imsi_seensince := l.response.LineIdentityResponse.Subscriber.SeenSince;
		SELF.imsi_changedthis_time := (INTEGER)l.response.LineIdentityResponse.Subscriber.ChangedThisTime;
		SELF.imsi_change_count := l.response.LineIdentityResponse.Subscriber.ChangeCount;
		SELF.imsi_trackedsince := l.response.LineIdentityResponse.Subscriber.TrackedSince;
		SELF.iccid	:= IF(l.response.LineIdentityResponse.Subscriber.IntegratedCircuitCardId='','',(STRING)hash64(l.response.LineIdentityResponse.Subscriber.IntegratedCircuitCardId));
		SELF.subscriber_id	:= IF(l.response.LineIdentityResponse.Subscriber.SubscriberId='','',(STRING)hash64(l.response.LineIdentityResponse.Subscriber.SubscriberId));
		SELF.call_forwarding := (INTEGER)l.response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwarding;
		// SELF.call_forwarding_linked_toSubject := IF(l.response.LineIdentityResponse.Subscriber.CallHandlingInfo.CallForwarding,); //Call Forwarded Number
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
		SELF.imei	:= IF(l.response.LineIdentityResponse.Device.IntlMobileEquipmentId='','',(STRING)hash64(l.response.LineIdentityResponse.Device.IntlMobileEquipmentId));
		// SELF.imei_type;
		SELF.imei_seensince := l.response.LineIdentityResponse.Device.SeenSince;
		SELF.imei_changed_this_time := (INTEGER)l.response.LineIdentityResponse.Device.ChangedThisTime;
		SELF.imei_change_count := l.response.LineIdentityResponse.Device.ChangeCount;
		SELF.imei_tracked_since := l.response.LineIdentityResponse.Device.TrackedSince;
		SELF.first_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].FirstNameScore;
		SELF.last_name_score := l.response.LineIdentityResponse.NameAddrValidation.NameList[1].LastNameScore;
		SELF.addr_score := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressScore;
		// SELF.cnm_availability_indicator;
		// SELF.cnm_presentation_indicator;
		// SELF.port_date;
		// SELF.lata;
		// SELF.reply_code;
		// SELF.point_code;
		// SELF.prepaid;
		// SELF.account_status;
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
		SELF.sub_addr_type := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressType;
		SELF.sub_addr1 := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressLine1;
		SELF.sub_addr2 := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].AddressLine2;
		SELF.sub_city := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].City;
		SELF.sub_state := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].State;
		SELF.sub_postal_code := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].PostalCode;
		SELF.sub_country := l.response.LineIdentityResponse.NameAddrValidation.AddressList[1].Country;
		// SELF.customer_bill_acct_type;
		// SELF.customer_bill_acct;
		SELF.device_mgmt_status := MAP(l.response.LineIdentityResponse.Error.ErrorCode <> '' => l.response.LineIdentityResponse.Error.ErrorInfo,
																	 l.response._header.Message <> '' => l.response._header.Message,
																	 '');	
		// SELF.date_added;
		SELF := l.response.LineIdentityResponse;
		SELF := [];
	
	END;
	zHistoryRecs := PROJECT(dsZResults_wErrors,savedAllowedZumigoData(LEFT));
	
	//repopulate acctno and seq in correct fields for nameAddressValidation records.
	Phones.Layouts.ZumigoIdentity.zOut extractAcctnoNSeq(Phones.Layouts.gatewayHistory l) := TRANSFORM
		setStr:=STD.Str.SplitWords(l.sub_name_type,'|');
		addressType:=STD.Str.SplitWords(l.sub_addr_type,'|')[3];
		SELF.acctno := setStr[1];
		SELF.sequence_number := (UNSIGNED)setStr[2];
		SELF.sub_name_type := setStr[3];
		SELF.sub_addr_type := addressType;
		SELF := l;
		SELF :=[];
	END;
	updateValidationAcctnoNSeq := IF(inMod.NameAddressValidation,PROJECT(zHistoryRecs,extractAcctnoNSeq(LEFT)),
																															 PROJECT(zHistoryRecs,TRANSFORM(Phones.Layouts.ZumigoIdentity.zOut, SELF.sequence_number := (UNSIGNED)LEFT.sequence_number, SELF := LEFT)));
																														 
	Phones.Layouts.ZumigoIdentity.zOut updateIDs (Phones.Layouts.ZumigoIdentity.subjectVerificationRequest l, Phones.Layouts.ZumigoIdentity.zOut r):= TRANSFORM
		//Always used LN data to populate identity data for ZumigoHistory
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
		SELF.sub_addr1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
																											 l.addr_suffix, l.postdir, '', l.sec_range);
		SELF.sub_city := l.p_city_name;																									 
		SELF.sub_state := l.st;																									 
		SELF.sub_postal_code := l.z5;																									 
		//source and optin fields will be blank for any record that was not sent to Zumigo. //eg. blank phones - can be filtered out later
		SELF.transaction_id := r.transaction_id;
		SELF:= r;
		SELF:=[]
	END;
																															 
	dsZumigoHistory := JOIN(inRecs,updateValidationAcctnoNSeq,
													LEFT.phone 	= RIGHT.submitted_phonenumber AND
													(LEFT.acctno	= RIGHT.acctno OR RIGHT.acctno='') AND
													(LEFT.sequence_number 		= RIGHT.sequence_number OR RIGHT.sequence_number=0),
													updateIDs(LEFT,RIGHT),
													LEFT OUTER, KEEP(1),LIMIT(0));
													
	#IF(Phones.Constants.Debug.Zumigo)		
		OUTPUT(zumIn,NAMED('zumIn'));
		OUTPUT(dsZum,NAMED('dsZum'));
		OUTPUT(zumOut,NAMED('zumOut'));
 		OUTPUT(normzResults,NAMED('normzResults'));
   	OUTPUT(dsZResults_wErrors,NAMED('dsZResults_wErrors'));
   	OUTPUT(zHistoryRecs,NAMED('zHistoryRecs'));
   	OUTPUT(updateValidationAcctnoNSeq,NAMED('updateValidationAcctnoNSeq'));
    OUTPUT(dsZumigoHistory,NAMED('dsZumigoHistory'));
	#END;
	RETURN dsZumigoHistory;
END;