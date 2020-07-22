IMPORT doxie, FraudShared_Services, RiskIntelligenceNetwork_Services, STD;

EXPORT fn_GetRawContributedRecs(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_search_in,
                                RiskIntelligenceNetwork_Services.IParam.Params search_params) := FUNCTION

 _Constants := RiskIntelligenceNetwork_Services.Constants;
 //Since its batch of 1 record, there will always be only one row of input.
 in_rec := ds_search_in[1];
 fraud_platform := _Constants.FRAUD_PLATFORM;

 //Following project is necessary to transform "BatchInExtended_rec" back to "BatchIn_rec" , which is actually used by Batch & Report & FDN services.
 ds_search_in_orig := PROJECT(ds_search_in, FraudShared_Services.Layouts.BatchIn_rec);

 /* First "Normalize" the sequenced input, 5 times to split out the 5 pieces of data
  // (to be checked for in the FraudGov Auto keys for getting all the fuzzy data) onto
  // separate records since that is what the new  requirement is expecing
  // Check the counter: when 1 assign did,
  // 									 when 2 assign address fields,
  //                    when 3 assign ssn,
  // 									 when 4 assign phone,
                       when 5 assign names.
 */
 FraudShared_Services.Layouts.BatchIn_rec tf_NormAndSlim(FraudShared_Services.Layouts.BatchIn_rec L, INTEGER C) := TRANSFORM
  self.acctno      := L.acctno;
  self.did         := CHOOSE(C,(unsigned6)L.did,0,0,0,0);
  self.addr        := CHOOSE(C,'',L.addr,'','','');
  self.prim_range  := CHOOSE(C,'',L.prim_range,'','','');
  self.predir      := CHOOSE(C,'',L.predir,'','','');
  self.prim_name   := CHOOSE(C,'',L.prim_name,'','','');
  self.addr_suffix := CHOOSE(C,'',L.addr_suffix,'','','');
  self.postdir     := CHOOSE(C,'',L.postdir,'','','');
  self.unit_desig  := CHOOSE(C,'',L.unit_desig,'','','');
  self.sec_range   := CHOOSE(C,'',L.sec_range,'','','');
  self.p_city_name := CHOOSE(C,'',L.p_city_name,'','','');
  self.st          := CHOOSE(C,'',L.st,'','','');
  self.z5          := CHOOSE(C,'',L.z5,'','','');
  self.zip4        := CHOOSE(C,'',L.zip4,'','','');
  self.ssn         := CHOOSE(C,'','',L.ssn,'','');
  self.phoneno     := CHOOSE(C,'','','',L.phoneno,'');
  self.name_first  := CHOOSE(C,'','','','',L.name_first);
  self.name_middle := CHOOSE(C,'','','','',L.name_middle);
  self.name_last   := CHOOSE(C,'','','','',L.name_last);
  self             := [];  // Added for FDN Expanded layout
 end;

 ds_search_in_norm5slim := NORMALIZE(ds_search_in_orig,5,tf_NormAndSlim(LEFT,COUNTER));

 //Hitting the auto keys.
 ds_auto_name   := RiskIntelligenceNetwork_Services.fn_postautokey_joins(ds_search_in_norm5slim(name_last != ''), fraud_platform);
 ds_auto_address:= RiskIntelligenceNetwork_Services.fn_postautokey_joins(ds_search_in_norm5slim((prim_name <> '' or addr <> '') AND ((p_city_name <> '' AND st <> '') OR z5 <> '')), fraud_platform);
 ds_auto_ssn    := RiskIntelligenceNetwork_Services.fn_postautokey_joins(ds_search_in_norm5slim(ssn !=''), fraud_platform);
 ds_auto_phone  := RiskIntelligenceNetwork_Services.fn_postautokey_joins(ds_search_in_norm5slim(phoneno !=''), fraud_platform);

 //Hitting the Fraud shared keys.. which are based on BatchIn_rec record structure.
 ds_valid_in  := FraudShared_Services.ValidateInput.BuildValidityRecs(ds_search_in_orig,fraud_platform);
 EntitiesIds_ := FraudShared_Services.EntitiesIds(ds_valid_in, fraud_platform, FALSE ,_Constants.MAX_JOIN_LIMIT);

 ds_did                  := EntitiesIds_.GetLexID();
 ds_linkId               := EntitiesIds_.GetLinkIds();
 ds_device_id            := EntitiesIds_.GetDeviceID();
 ds_professional_id      := EntitiesIds_.GetProfessionalID();
 ds_tin                  := EntitiesIds_.GetTIN();
 ds_appended_provider_id := EntitiesIds_.GetAppendedProviderID();
 ds_provider_npi         := EntitiesIds_.GetNPI();
 ds_provider_lnpid       := EntitiesIds_.GetLNPID();

 //Hitting the Advance Search spcific only keys.. which are based on BatchInExtended_rec record structure.
 Search_EntitiesIDs_ := RiskIntelligenceNetwork_Services.fn_GetEntityRecordIds(ds_search_in, fraud_platform);
 ds_householdid      := Search_EntitiesIDs_.GetHouseHoldIDs();
 ds_CustomerPersonId := Search_EntitiesIDs_.GetCustomerPersonIds();
 ds_AmountRangeIds 	 := Search_EntitiesIDs_.GetAmountRangeIds();
 ds_BankNameIds      := Search_EntitiesIDs_.GetBankNameIds();
 ds_BankRoutingIds	 := Search_EntitiesIDs_.GetBankRoutingIds();
 ds_ReportedDateIds	 := Search_EntitiesIDs_.GetReportedDateIds();
 ds_ISPNameIds       := Search_EntitiesIDs_.GetISPNameIds();
 ds_MACAddressIds    := Search_EntitiesIDs_.GetMACAddressIds();
 ds_SerialNumberIds	 := Search_EntitiesIDs_.GetSerialNumberIds();
 ds_CityStateIds     := Search_EntitiesIDs_.GetCityStateIds();
 ds_CountyIds        := Search_EntitiesIDs_.GetCountyIds();
 ds_ZipIds           := Search_EntitiesIDs_.GetZipIds();
 ds_DriverLicensesIds:= Search_EntitiesIDs_.GetDriverLicenses();
 ds_bankaccountnumberIds:= Search_EntitiesIDs_.GetBankAccountNumber();
 
 //Find which email key to hit.
 email_user_name   :=  TRIM(regexfind('(.*)@(.*)$',in_rec.email_address,1));
 email_user_domain := TRIM(regexfind('(.*)@(.*)$',in_rec.email_address,2));

 boolean userNameOnly := email_user_name <> '' and email_user_domain = '';
 boolean domainNameOnly := email_user_name = ''  and email_user_domain <> '';
 boolean fullemail := email_user_name <> '' and email_user_domain <> '';

 ds_emailIds := MAP (userNameOnly => Search_EntitiesIDs_.GetEmailUserIds(),
                    domainNameOnly => Search_EntitiesIDs_.GetEmailDomainIds(),
                    fullemail => Search_EntitiesIDs_.GetEmail(),
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
 isIPRange12  := in_rec.ip_address <> '' AND isIPRangeKey AND octet1 <> 0 AND octet2 <> 0 AND octet3 = 0 AND octet4 = 0;
 isIPRange1   := in_rec.ip_address <> '' AND isIPRangeKey AND octet1 <> 0 AND octet2 = 0 AND octet3 = 0 AND octet4 = 0;

 ds_ip := MAP(isIPRangeKey => Search_EntitiesIDs_.GetIPRangeIds(octet1, octet2, octet3, isIPRange123, isIPRange12, isIPRange1),
              NOT isIPRangeKey => Search_EntitiesIDs_.GetIp(),
              dataset([], FraudShared_Services.Layouts.Recid_rec));

 initial_rec := RECORD
  integer2 cnt;
  string100 key_identifier;
  dataset(FraudShared_Services.Layouts.Recid_rec) ds_rec_ids;
 END;

 ds_recs := if(search_params.IsOnline,
              dataset([ {count(ds_auto_name), 'autoname', ds_auto_name},
                        {count(ds_auto_address), 'autoaddress', ds_auto_address},
                        {count(ds_auto_ssn), 'autossn', ds_auto_ssn},
                        {count(ds_auto_phone), 'autophone', ds_auto_phone},
                        {count(ds_did), 'DID', ds_did},
                        {IF(EXISTS(ds_ip(record_id=0)),-1,count(ds_ip)), 'IpAddress', ds_ip},
                        {count(ds_linkId), 'LinkID', ds_linkId},
                        {count(ds_device_id), 'DeviceID', ds_device_id},
                        {count(ds_professional_id), 'ProfessionalID', ds_professional_id},
                        {count(ds_tin), 'TIN', ds_tin},
                        {IF(EXISTS(ds_emailIds(record_id=0)),-1,count(ds_emailIds)), 'EMAIL', ds_emailIds},
                        {count(ds_appended_provider_id), 'PROVIDERID', ds_appended_provider_id},
                        {count(ds_provider_npi), 'NPI', ds_provider_npi},
                        {count(ds_provider_lnpid), 'LNPID', ds_provider_lnpid},
                        {IF(EXISTS(ds_householdid(record_id=0)),-1,count(ds_householdid)), 'HOUSEHOLDID', ds_householdid},
                        {IF(EXISTS(ds_CustomerPersonId(record_id=0)),-1,count(ds_CustomerPersonId)), 'CustomerPersonId', ds_CustomerPersonId},
                        {IF(EXISTS(ds_AmountRangeIds(record_id=0)),-1,count(ds_AmountRangeIds)), 'AmountRange', ds_AmountRangeIds},
                        {IF(EXISTS(ds_BankNameIds(record_id=0)),-1,count(ds_BankNameIds)), 'BankName', ds_BankNameIds},
                        {IF(EXISTS(ds_BankRoutingIds(record_id=0)),-1,count(ds_BankRoutingIds)), 'BankRoutingNumber', ds_BankRoutingIds},
                        {IF(EXISTS(ds_bankaccountnumberIds(record_id=0)),-1,count(ds_bankaccountnumberIds)), 'BankAccountNumber', ds_bankaccountnumberIds},
                        {IF(EXISTS(ds_ReportedDateIds(record_id=0)),-1,count(ds_ReportedDateIds)), 'ReportedDate', ds_ReportedDateIds},
                        {IF(EXISTS(ds_ISPNameIds(record_id=0)),-1,count(ds_ISPNameIds)), 'ISPName', ds_ISPNameIds},
                        {IF(EXISTS(ds_MACAddressIds(record_id=0)),-1,count(ds_MACAddressIds)), 'MACAddress', ds_MACAddressIds},
                        {IF(EXISTS(ds_SerialNumberIds(record_id=0)),-1,count(ds_SerialNumberIds)), 'SerialNumber', ds_SerialNumberIds},
                        {IF(EXISTS(ds_CityStateIds(record_id=0)),-1,count(ds_CityStateIds)), 'CityState', ds_CityStateIds},
                        {IF(EXISTS(ds_CountyIds(record_id=0)),-1,count(ds_CountyIds)), 'County', ds_CountyIds},
                        {IF(EXISTS(ds_ZipIds(record_id=0)),-1,count(ds_ZipIds)), 'Zip', ds_ZipIds},
                        {IF(EXISTS(ds_DriverLicensesIds(record_id=0)),-1,count(ds_DriverLicensesIds)), 'DLNumber', ds_DriverLicensesIds}], initial_rec),
            dataset([], initial_rec));

 ds_recs_sorted := SORT(ds_recs(cnt > 0), cnt);
 ds_final_rec_ids := ds_recs_sorted[1].ds_rec_ids;
 ds_payload_recs := RiskIntelligenceNetwork_Services.fn_GetPayloadRecords(ds_final_rec_ids, search_params, fraud_platform := fraud_platform);

 //Applying the all AND filters based on all the Search Fields.
 ds_recs_filtered := ds_payload_recs(if(in_rec.p_city_name <> '', clean_address.p_city_name = in_rec.p_city_name, true) AND
                                     if(in_rec.st <> '', clean_address.st = in_rec.st, true) AND
                                     if(in_rec.z5 <> '', clean_address.zip = in_rec.z5, true) AND
                                     if(in_rec.HouseholdId <> '', household_id = in_rec.HouseholdId, true) AND
                                     if(in_rec.CustomerPersonId <> '', customer_person_id = in_rec.CustomerPersonId, true) AND
                                     if(in_rec.transactionstartdate <> '' AND in_rec.transactionenddate <> '',
                                        reported_date BETWEEN in_rec.transactionstartdate AND in_rec.transactionenddate , true) AND
                                     if(in_rec.amountmin <> '', amount_paid >= in_rec.amountmin, true) AND
                                     if(in_rec.amountmax <> '', amount_paid <= in_rec.amountmax, true) AND
                                     if(in_rec.bank_routing_number <> '', bank_routing_number_1 = in_rec.bank_routing_number OR
                                                                          bank_routing_number_2 = in_rec.bank_routing_number, true) AND
                                     if(in_rec.bank_account_number <> '', bank_account_number_1 = in_rec.bank_account_number OR
                                                                          bank_account_number_2 = in_rec.bank_account_number, true) AND
                                     if(in_rec.ip_address <> '' AND NOT isIPRangeKey , ip_address = in_rec.ip_address, true) AND
                                     if(isIPRange123 ,(unsigned1)STD.STr.SplitWords(ip_address,'.')[1] = octet1 AND
                                                      (unsigned1)STD.STr.SplitWords(ip_address,'.')[2] = octet2 AND
                                                      (unsigned1)STD.STr.SplitWords(ip_address,'.')[3] = octet3 , true) AND
                                     if(isIPRange12	, (unsigned1)STD.STr.SplitWords(ip_address,'.')[1] = octet1 AND
                                                      (unsigned1)STD.STr.SplitWords(ip_address,'.')[2] = octet2 , true) AND
                                     if(isIPRange1 	, (unsigned1)STD.STr.SplitWords(ip_address,'.')[1] = octet1 , true) AND
                                     if(in_rec.MACAddress <> '', mac_address = in_rec.MACAddress, true) AND
                                     if(in_rec.device_id <> '', device_id = in_rec.device_id, true) AND
                                     if(in_rec.DeviceSerialNumber <> '', serial_number = in_rec.DeviceSerialNumber, true) AND
                                     if((integer)in_rec.dob [1..4] <> 0 , dob[1..4] = in_rec.dob [1..4] , true) AND
                                     if((integer)in_rec.dob [5..6] <> 0 , dob[5..6] = in_rec.dob [5..6] , true) AND
                                     if((integer)in_rec.dob [7..8] <> 0 , dob[7..8] = in_rec.dob [7..8] , true) AND
                                     if(userNameOnly, TRIM(regexfind('(.*)@(.*)$',email_address,1)) = email_user_name, true) AND
                                     if(domainNameOnly, TRIM(regexfind('(.*)@(.*)$',email_address,2)) = email_user_domain, true) AND
                                     if(fullemail, email_address = TRIM(in_rec.email_address), true) AND
                                     if(in_rec.dl_number <> '', drivers_license = in_rec.dl_number, true) AND
                                     if(in_rec.dl_state <> '', drivers_license_state = in_rec.dl_state, true) AND
                                     if(in_rec.ProgramCode <> '', classification_permissible_use_access.ind_type_description	= in_rec.ProgramCode, true)
                                   );

 //AND filter with BankName , explicit join because we do not have BankName field in the payload.
 ds_recs_filtered_bankname := IF(in_rec.BankName <> '' AND ~EXISTS(ds_BankNameIds(record_id=0)),
                                JOIN(ds_recs_filtered, ds_BankNameIds,
                                  LEFT.record_id = RIGHT.record_id,
                                  TRANSFORM(LEFT)),
                                ds_recs_filtered);

 //AND filter with County , explicit join because we wanted to use recordid filtering...
 ds_recs_filtered_county := IF(in_rec.county_name <> '' AND ~EXISTS(ds_CountyIds(record_id=0)),
                              JOIN(ds_recs_filtered_bankname, ds_CountyIds,
                                LEFT.record_id = RIGHT.record_id,
                                TRANSFORM(LEFT)),
                              ds_recs_filtered_bankname);

 //AND filter with ISP dataset, explicit join because we do not have ISPName populated in the payload field.
 ds_recs_filtered_isp := IF(in_rec.ispname <> '' AND ~EXISTS(ds_ISPNameIds(record_id=0)),
                            JOIN(ds_recs_filtered_county, ds_ISPNameIds,
                              LEFT.record_id = RIGHT.record_id,
                              TRANSFORM(LEFT)),
                            ds_recs_filtered_county);

 //AND Filter with Name Autokey,
 ds_recs_filtered_name := IF(in_rec.name_last <> '',
                              JOIN(ds_recs_filtered_isp, ds_auto_name,
                                LEFT.record_id = RIGHT.record_id,
                                TRANSFORM(LEFT)),
                              ds_recs_filtered_isp);

 //AND Filter with Address Autokey,
 ds_recs_filtered_address := IF(in_rec.prim_name <> '' AND ((in_rec.p_city_name <> '' AND in_rec.st <> '') OR in_rec.z5 <> ''),
                              JOIN(ds_recs_filtered_name, ds_auto_address,
                                LEFT.record_id = RIGHT.record_id,
                                TRANSFORM(LEFT)),
                              ds_recs_filtered_name);

 //AND Filter with Phone Autokey,
 ds_recs_filtered_phone := IF(in_rec.phoneno <> '',
                              JOIN(ds_recs_filtered_address, ds_auto_phone,
                                LEFT.record_id = RIGHT.record_id,
                                TRANSFORM(LEFT)),
                              ds_recs_filtered_address);

 //AND Filter with ssn Autokey,
 ds_recs_filtered_final := IF(in_rec.ssn <> '',
                              JOIN(ds_recs_filtered_phone, ds_auto_ssn,
                                LEFT.record_id = RIGHT.record_id,
                                TRANSFORM(LEFT)),
                              ds_recs_filtered_phone);

 // If there is a key join that failed due to limit and no other key joins yielded any records, fail with code 203
 IF(EXISTS(ds_recs(cnt = -1)) AND NOT EXISTS(ds_final_rec_ids), FAIL(_Constants.TOO_MAY_RECORDS_CODE, _Constants.TOO_MAY_RECORDS_MSG));

 ds_allPayloadRecs := LIMIT(ds_recs_filtered_final,_Constants.MAX_JOIN_LIMIT , FAIL(_Constants.TOO_MAY_RECORDS_CODE, _Constants.TOO_MAY_RECORDS_MSG));
 
 // output(ds_search_in, named('ds_search_in'));
 // output(ds_payload_recs, named('ds_payload_recs'));
 // output(ds_recs_filtered, named('ds_recs_filtered'));
 // output(ds_allPayloadRecs, named('ds_allPayloadRecs'));
 RETURN ds_allPayloadRecs;
END;
