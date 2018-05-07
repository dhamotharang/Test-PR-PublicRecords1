IMPORT FraudShared_Services, iesp, STD, ut, FraudShared;

EXPORT fn_getadvsearch_raw_recs (
	DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_batch_in,
	unsigned6 gc_id_in, 
	unsigned2 ind_type_in, 
	unsigned6 product_code_in, 
	DATASET(iesp.frauddefensenetwork.t_FDNIndType) ds_industry_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNIndType),             
	DATASET(iesp.frauddefensenetwork.t_FDNFileType) ds_file_types_in = DATASET([],iesp.frauddefensenetwork.t_FDNFileType),
	INTEGER DeltaUse = 0,
	INTEGER DeltaStrict = 0,
	string fraud_platform = FraudShared_Services.Constants.Platform.FraudGov,
	boolean filterBy_entity_type = FALSE,
	boolean IsOnline = FALSE) := FUNCTION

	//Since its batch of 1 record, there will always be only one row of input. 
	in_rec := ds_batch_in[1];
	
	//Following project is necessary to transform "BatchInExtended_rec" back to "BatchIn_rec" , which is actually used by Batch & Report & FDN services.
	ds_batch_in_orig := PROJECT(ds_batch_in, FraudShared_Services.Layouts.BatchIn_rec);
	
	
	/* First "Normalize" the sequenced input, 5 times to split out the 5 pieces of data 
	// (to be checked for in the FraudGov Auto keys for getting all the fuzzy data) onto 
	// separate records since that is what the new  requirement is expecing 
	// Check the counter: when 1 assign did, 
	// 										when 2 assign address fields, 
	// 										when 3 assign ssn, 
	// 										when 4 assign phone, 
												when 5 assign names.
	*/
	FraudShared_Services.Layouts.BatchIn_rec tf_NormAndSlim(FraudShared_Services.Layouts.BatchIn_rec L, INTEGER C) := TRANSFORM
		self.acctno			 := L.acctno;
		self.did         := CHOOSE(C,(unsigned6)L.did,0,0,0,0);
		self.addr				 := CHOOSE(C,'',L.addr,'','','');
		self.prim_range  := CHOOSE(C,'',L.prim_range,'','','');
		self.predir      := CHOOSE(C,'',L.predir,'','','');
		self.prim_name   := CHOOSE(C,'',L.prim_name,'','','');
		self.addr_suffix := CHOOSE(C,'',L.addr_suffix,'','','');
		self.postdir     := CHOOSE(C,'',L.postdir,'','','');
		self.unit_desig  := CHOOSE(C,'',L.unit_desig,'','','');
		self.sec_range   := CHOOSE(C,'',L.sec_range,'','','');
		self.p_city_name := CHOOSE(C,'',L.p_city_name,'','','');
		self.st          := CHOOSE(C,'',L.st,'','','');
		self.z5       	 := CHOOSE(C,'',L.z5,'','','');
		self.zip4        := CHOOSE(C,'',L.zip4,'','','');
		self.ssn         := CHOOSE(C,'','',L.ssn,'','');
		self.phoneno     := CHOOSE(C,'','','',L.phoneno,'');
		self.name_first  := CHOOSE(C,'','','','',L.name_first);
		self.name_middle := CHOOSE(C,'','','','',L.name_middle);
		self.name_last   := CHOOSE(C,'','','','',L.name_last);
		self 						 := [];  // Added for FDN Expanded layout
	end;

	ds_batch_in_norm5slim := NORMALIZE(ds_batch_in_orig,5,tf_NormAndSlim(LEFT,COUNTER));	

	//Hitting the auto keys.
	ds_auto_name 		:= FraudGovPlatform_Services.fn_postautokey_joins(ds_batch_in_norm5slim(name_first != '' or name_last != ''), fraud_platform);	
	ds_auto_address := FraudGovPlatform_Services.fn_postautokey_joins(ds_batch_in_norm5slim(prim_name !='' or p_city_name !='' or st !='' or z5 !='' or addr != ''), fraud_platform);
	ds_auto_ssn 		:= FraudGovPlatform_Services.fn_postautokey_joins(ds_batch_in_norm5slim(ssn !=''), fraud_platform);
	ds_auto_phone 	:= FraudGovPlatform_Services.fn_postautokey_joins(ds_batch_in_norm5slim(phoneno !=''), fraud_platform);	

	//Hitting the shared keys.. which are based on BatchIn_rec record structure. 
	ds_valid_in 	:= FraudShared_Services.ValidateInput.BuildValidityRecs(ds_batch_in_orig);
	EntitiesIds_ 	:= FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, filterBy_entity_type);
	
	// Cannot send IsOnline inside to FraudShared_Services.EntitiesIds, since its being used by both FraudGov Batch & Report and FDN Search services. 
	ds_did                  := EntitiesIds_.GetLexID();
	ds_linkId               := EntitiesIds_.GetLinkIds();
	ds_device_id            := EntitiesIds_.GetDeviceID();
	ds_professional_id      := EntitiesIds_.GetProfessionalID();
	ds_tin                  := EntitiesIds_.GetTIN();
	ds_appended_provider_id := EntitiesIds_.GetAppendedProviderID();
	ds_provider_npi         := EntitiesIds_.GetNPI();
	ds_provider_lnpid       := EntitiesIds_.GetLNPID();

	//Hitting the Advance Search spcific only keys.. which are based on BatchInExtended_rec record structure.
	Search_EntitiesIDs_ := FraudGovPlatform_Services.Search_EntitiesIDs(ds_batch_in, fraud_platform, filterBy_entity_type, IsOnline);
	ds_householdid 			:= Search_EntitiesIDs_.GetHouseHoldIDs();
	ds_CustomerPersonId := Search_EntitiesIDs_.GetCustomerPersonIds();
	ds_AmountRangeIds 	:= Search_EntitiesIDs_.GetAmountRangeIds();
	ds_BankNameIds 			:= Search_EntitiesIDs_.GetBankNameIds();
	ds_BankRoutingIds		:= Search_EntitiesIDs_.GetBankRoutingIds();
	ds_ReportedDateIds	:= Search_EntitiesIDs_.GetReportedDateIds();
	ds_ISPNameIds				:= Search_EntitiesIDs_.GetISPNameIds();
	ds_MACAddressIds		:= Search_EntitiesIDs_.GetMACAddressIds();
	ds_SerialNumberIds	:= Search_EntitiesIDs_.GetSerialNumberIds();
	ds_CityStateIds			:= Search_EntitiesIDs_.GetCityStateIds();
	ds_CountyIds				:= Search_EntitiesIDs_.GetCountyIds();
	ds_ZipIds						:= Search_EntitiesIDs_.GetZipIds();
	//Find which email key to hit.
	email_user_name :=  STD.Str.CleanSpaces(regexfind('(.*)@(.*)$',in_rec.email_address,1));
	email_user_domain := STD.Str.CleanSpaces(regexfind('(.*)@(.*)$',in_rec.email_address,2));
	
	ds_emailIds := MAP (email_user_name <> '' and email_user_domain = '' => Search_EntitiesIDs_.GetEmailUserIds(),
											email_user_name = ''  and email_user_domain <> '' => Search_EntitiesIDs_.GetEmailDomainIds(),
											IsOnline and email_user_name <> '' and email_user_domain <> '' => EntitiesIds_.GetEmail(),
											dataset([], FraudShared_Services.Layouts.Recid_rec));
	
	//Find which IP_Address key to hit.
	BOOLEAN isIPRangeKey := STD.Str.Contains(in_rec.ip_address, 'XXX', true);

	octets := STD.STr.SplitWords(in_rec.ip_address,'.');										
	octet1 := (unsigned1) IF(STD.Str.EqualIgnoreCase(octets[1], 'xxx'), '', octets[1]);
	octet2 := (unsigned1) IF(STD.Str.EqualIgnoreCase(octets[2], 'xxx'), '', octets[2]);
	octet3 := (unsigned1) IF(STD.Str.EqualIgnoreCase(octets[3], 'xxx'), '', octets[3]);
	octet4 := (unsigned1) IF(STD.Str.EqualIgnoreCase(octets[4], 'xxx'), '', octets[4]);	
	
	//Flags for IP Range Filtering.
	isIPRange123 := in_rec.ip_address <> '' AND isIPRangeKey AND octet1 <> 0 AND octet2 <> 0 AND octet3 <> 0 AND octet4 = 0;
	isIPRange12 := in_rec.ip_address <> '' AND isIPRangeKey AND octet1 <> 0 AND octet2 <> 0 AND octet3 = 0 AND octet4 = 0;
	isIPRange1 := in_rec.ip_address <> '' AND isIPRangeKey AND octet1 <> 0 AND octet2 = 0 AND octet3 = 0 AND octet4 = 0;		

	ds_ip := MAP(	isIPRangeKey => Search_EntitiesIDs_.GetIPRangeIds(octet1, octet2, octet3, octet4, isIPRange123, isIPRange12, isIPRange1), 
								IsOnline and NOT isIPRangeKey => EntitiesIds_.GetIp(),
								dataset([], FraudShared_Services.Layouts.Recid_rec));


	
	//Get Payload Records for all the invidual keys.
	// ds_payload_autoname 	:= IF(EXISTS(ds_auto_name), FraudShared_Services.GetPayloadRecords(ds_auto_name, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_autoaddress 	:= IF(EXISTS(ds_auto_address), FraudShared_Services.GetPayloadRecords(ds_auto_address, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_autossn 	:= IF(EXISTS(ds_auto_ssn), FraudShared_Services.GetPayloadRecords(ds_auto_ssn, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_autophone 	:= IF(EXISTS(ds_auto_phone), FraudShared_Services.GetPayloadRecords(ds_auto_phone, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_did 	:= IF(EXISTS(ds_did), FraudShared_Services.GetPayloadRecords(ds_did, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_ip := IF(EXISTS(ds_ip), FraudShared_Services.GetPayloadRecords(ds_ip, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_linkids := IF(EXISTS(ds_linkId), FraudShared_Services.GetPayloadRecords(ds_linkId, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_deviceid := IF(EXISTS(ds_device_id), FraudShared_Services.GetPayloadRecords(ds_device_id, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_profid := IF(EXISTS(ds_professional_id), FraudShared_Services.GetPayloadRecords(ds_professional_id, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_tin := IF(EXISTS(ds_tin), FraudShared_Services.GetPayloadRecords(ds_tin, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_email := IF(EXISTS(ds_emailIds), FraudShared_Services.GetPayloadRecords(ds_emailIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_providerid := IF(EXISTS(ds_appended_provider_id), FraudShared_Services.GetPayloadRecords(ds_appended_provider_id, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_npi := IF(EXISTS(ds_provider_npi), FraudShared_Services.GetPayloadRecords(ds_provider_npi, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_lnpid:= IF(EXISTS(ds_provider_lnpid), FraudShared_Services.GetPayloadRecords(ds_provider_lnpid, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_householdid := IF(EXISTS(ds_householdid), FraudShared_Services.GetPayloadRecords(ds_householdid, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_CustomerPersonId := IF(EXISTS(ds_CustomerPersonId), FraudShared_Services.GetPayloadRecords(ds_CustomerPersonId, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_AmountRange := IF(EXISTS(ds_AmountRangeIds), FraudShared_Services.GetPayloadRecords(ds_AmountRangeIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_BankName := IF(EXISTS(ds_BankNameIds), FraudShared_Services.GetPayloadRecords(ds_BankNameIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_BankRouting := IF(EXISTS(ds_BankRoutingIds), FraudShared_Services.GetPayloadRecords(ds_BankRoutingIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_ISPName := IF(EXISTS(ds_ISPNameIds), FraudShared_Services.GetPayloadRecords(ds_ISPNameIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_MACAddress := IF(EXISTS(ds_MACAddressIds), FraudShared_Services.GetPayloadRecords(ds_MACAddressIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	// ds_payload_SerialNumber := IF(EXISTS(ds_SerialNumberIds), FraudShared_Services.GetPayloadRecords(ds_SerialNumberIds, fraud_platform), dataset([], FraudShared_Services.Layouts.Raw_Payload_rec));
	
	initial_rec := RECORD
		unsigned1 cnt;
		string100 key_identifier;
		dataset(FraudShared_Services.Layouts.Recid_rec) Recid_rec;
	END;

	ds_recs := if(IsOnline, 
								dataset([	{count(ds_auto_name), 'autoname', ds_auto_name},
													{count(ds_auto_address), 'autoaddress', ds_auto_address},
													{count(ds_auto_ssn), 'autossn', ds_auto_ssn},
													{count(ds_auto_phone), 'autophone', ds_auto_phone},
													{count(ds_did), 'DID', ds_did},
													{count(ds_ip), 'IpAddress', ds_ip},
													{count(ds_linkId), 'LinkID', ds_linkId},
													{count(ds_device_id), 'DeviceID', ds_device_id},
													{count(ds_professional_id), 'ProfessionalID', ds_professional_id},
													{count(ds_tin), 'TIN', ds_tin},
													{count(ds_emailIds), 'EMAIL', ds_emailIds},
													{count(ds_appended_provider_id), 'PROVIDERID', ds_appended_provider_id},
													{count(ds_provider_npi), 'NPI', ds_provider_npi},
													{count(ds_provider_lnpid), 'LNPID', ds_provider_lnpid},
													{count(ds_householdid), 'HOUSEHOLDID', ds_householdid},
													{count(ds_CustomerPersonId), 'CustomerPersonId', ds_CustomerPersonId},
													{count(ds_AmountRangeIds), 'AmountRange', ds_AmountRangeIds},
													{count(ds_BankNameIds), 'BankName', ds_BankNameIds},
													{count(ds_BankRoutingIds), 'BankRoutingNumber', ds_BankRoutingIds},
													{count(ds_ReportedDateIds), 'ReportedDate', ds_ReportedDateIds},
													{count(ds_ISPNameIds), 'ISPName', ds_ISPNameIds},
													{count(ds_MACAddressIds), 'MACAddress', ds_MACAddressIds},
													{count(ds_SerialNumberIds), 'SerialNumber', ds_SerialNumberIds},
													{count(ds_CityStateIds), 'CityState', ds_CityStateIds},
													{count(ds_CountyIds), 'County', ds_CountyIds},
													{count(ds_ZipIds), 'Zip', ds_ZipIds}], initial_rec),
								dataset([], initial_rec));
	
	ds_recs_sorted := SORT(ds_recs(cnt > 0), cnt);
	
	ds_ids := ds_recs_sorted[1].Recid_rec;
	
	ds_payload_recs := FraudShared_Services.GetPayloadRecords(ds_ids, fraud_platform);
	
	ds_recs_filtered := ds_payload_recs(if(in_rec.did <> 0, did = in_rec.did, true) AND
																			if(in_rec.name_last <> '', raw_last_name = in_rec.name_last, true) AND
																			if(in_rec.addr <> '', street_1 = in_rec.addr, true) AND
																			if(in_rec.ssn <> '', ssn = in_rec.ssn, true) AND 
																			if(in_rec.phoneno <> '', phone_number = in_rec.phoneno, true) AND
																			if(in_rec.HouseholdId <> '', household_id = in_rec.HouseholdId, true) AND
																			if(in_rec.CustomerPersonId <> '', customer_person_id = in_rec.CustomerPersonId, true) AND
																			if(in_rec.transactionstartdate <> '' AND in_rec.transactionenddate <> '', reported_date BETWEEN in_rec.transactionstartdate AND in_rec.transactionenddate , true) AND
																			if(in_rec.amountmin <> '', amount_paid >= in_rec.amountmin, true) AND
																			if(in_rec.amountmax <> '', amount_paid <= in_rec.amountmax, true) AND
																			// if(in_rec.bankname <> '', in_rec.bankname = , true) AND 
																			if(in_rec.bank_routing_number <> '', bank_routing_number_1 = in_rec.bank_routing_number OR bank_routing_number_2 = in_rec.bank_routing_number, true) AND 
																			if(in_rec.ispname <> '', isp = in_rec.ispname, true) AND 
																			if(in_rec.ip_address <> '' AND NOT isIPRangeKey , ip_address = in_rec.ip_address, true) AND
																			if(isIPRange123 , (unsigned1)STD.STr.SplitWords(ip_address,'.')[1] = octet1 AND 
																												(unsigned1)STD.STr.SplitWords(ip_address,'.')[2] = octet2 AND
																												(unsigned1)STD.STr.SplitWords(ip_address,'.')[3] = octet3 , true) AND
																			if(isIPRange12	, (unsigned1)STD.STr.SplitWords(ip_address,'.')[1] = octet1 AND 
																												(unsigned1)STD.STr.SplitWords(ip_address,'.')[2] = octet2 , true) AND
																			if(isIPRange1 	, (unsigned1)STD.STr.SplitWords(ip_address,'.')[1] = octet1 , true) AND
																			if(in_rec.MACAddress <> '', mac_address = in_rec.MACAddress, true) AND
																			if(in_rec.device_id <> '', device_id = in_rec.device_id, true) AND
																			if(in_rec.DeviceSerialNumber <> '', serial_number = in_rec.DeviceSerialNumber, true)																			
																		 );
																		 
  // *** No filtering in FraudGov
  ds_recs_pulled := FraudShared_Services.Common_Suppress(ds_recs_filtered);
	
	// --- TO BE USED LATER ON WHEN ITS READY TO USE----- //
  // ds_appendDeltabase := FraudShared_Services.Common_Deltabase(ds_batch_in, ds_recs_pulled, ds_file_types_in, DeltaUse, DeltaStrict);
  ds_FilterThruMBS := FraudShared_Services.FilterThruMBS(ds_recs_pulled, gc_id_in, ind_type_in, product_code_in, ds_industry_types_in, ds_file_types_in, fraud_platform);

  ds_allPayloadRecs := ds_FilterThruMBS;

	// output(FraudShared.Key_AmountPaid('FraudGov'));
	// output(FraudShared.Key_BankName('FraudGov'));
	// output(FraudShared.Key_BankRoutingNumber('FraudGov'));
	// output(FraudShared.Key_CityState('FraudGov'));
	// output(FraudShared.Key_County('FraudGov'));
	// output(FraudShared.Key_CustomerID('FraudGov'));
	// output(FraudShared.Key_CustomerProgram('FraudGov'));
	// output(FraudShared.Key_Host('FraudGov'));
	// output(FraudShared.Key_HouseholdID('FraudGov'));
	// output(FraudShared.Key_IPRange('FraudGov'));
	// output(FraudShared.Key_Isp('FraudGov'));
	// output(FraudShared.Key_MACAddress('FraudGov'));
	// output(FraudShared.Key_ReportedDate('FraudGov'));
	// output(FraudShared.Key_SerialNumber('FraudGov'));
	// output(FraudShared.Key_User('FraudGov'));
	// output(FraudShared.Key_Zip('FraudGov'));
	// output(ds_recs_filtered, named('ds_recs_filtered'));
	// output(ds_recs_pulled, named('ds_recs_pulled'));
	// output(ds_FilterThruMBS, named('ds_FilterThruMBS'));
	
	RETURN ds_allPayloadRecs;
END; 
