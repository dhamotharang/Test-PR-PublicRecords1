import ThreatMetrix, Risk_Indicators, Gateway, iesp, Models, riskwise, ut, address, PublicRecords_KEL;

// this function assumes the indata has been run through the KEL cleaning functions for shell 5.5 and higher
export getThreatMetrix(dataset(Risk_Indicators.layouts.layout_trustdefender_in) indata, dataset(Gateway.Layouts.Config) gateways) := Function

gateway_cfg	:= gateways(Gateway.Configuration.IsThreatMetrix(servicename))[1];

ThreatMetrix.gateway_trustdefender.t_TrustDefenderRequest prep(indata le) := transform
	self.User.QueryId := (string)le.seq;
	self.Options.TrustDefenderUserAccount.OrgId := trim(le.OrgId);
	self.Options.TrustDefenderUserAccount.ApiKey := trim(le.ApiKey);
	self.Options.Policy := trim(le.Policy);
	self.Options.serviceType := trim(le.serviceType);
  self.Options.ApiType := trim(le.ApiType);
  self.Options.NoPIIPersistence := le.NoPIIPersistence;
  self.Options.DigitalIdReadOnly := le.DigitalIdReadOnly;
  self.Options.EventType := trim(le.Event_Type);
	self.searchby.MerchantData.MerchantId := trim(le.MerchantID);
	self.searchby.MerchantData.MerchantName := trim(le.MerchantName);

	self.searchby.Identity.TrustDefenderAccount.AccountName := trim( trim(le.fname) + ' ' + trim(le.lname) );
	self.searchby.Identity.TrustDefenderAccount.AccountEmail := trim(le.email_address);  
	self.searchby.Identity.TrustDefenderAccount.AccountTelephone := trim(le.phone10);  
	self.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressStreet1 := trim(address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name,
                                                                                                                le.addr_suffix, le.postdir, le.unit_desig, le.sec_range));  
	self.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressCity := trim(le.p_city_name);  
	self.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressState := trim(le.st);  
	self.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressZip := trim(le.z5);  
	self.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressCountry := if(le.z5<>'', 'US', '');  // USA and US give back same results, so i'll just use US for now anytime the z5 is populated
 
	self := [];
end;

threatmetrix_in := project(indata, prep(left));

makeGatewayCall := gateway_cfg.url!='' and count(threatmetrix_in)>0;
tm_results := if(makeGatewayCall, Gateway.SoapCall_ThreatMetrix(threatmetrix_in, gateway_cfg, makeGatewayCall), dataset([],ThreatMetrix.gateway_trustdefender.t_TrustDefenderResponseEX));

// local constant values to this function
rc_invalid_account_email := 'invalid_account_email';
rc_invalid_account_telephone := 'invalid_account_telephone';
not_found := 'not found';
code_1 := '1';
code_0 := '0';
not_enough_attributes := 'not_enough_attribs';
new_digital_id := 'new_digital_id';
no_data_check(string my_attribute) := if(trim(my_attribute)='', PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, my_attribute);
 
risk_indicators.layouts.layout_threatmetrix_shell_internal_results map_tmx_fields(threatmetrix_in inrec, tm_results le) := transform
  
  set_reason_codes := set(le.response.Summary.ReasonCodes, trim(stringlib.stringtolowercase(value)));
  digital_id_result := trim(le.response._Data.DigitalIdResult);
  account_telephone_result := trim(le.response._Data.AccountTelephoneResult);
  account_email_result := trim(le.response._Data.Accountemailresult);
  account_name_result := trim(le.response._Data.AccountNameResult);
  account_address_result := trim(le.response._Data.AccountAddressResult);
  missing_input_telephone := trim(inrec.searchby.Identity.TrustDefenderAccount.AccountTelephone)='' or rc_invalid_account_telephone in set_reason_codes;
  missing_input_email := trim(inrec.searchby.Identity.TrustDefenderAccount.AccountEmail)='' or rc_invalid_account_email in set_reason_codes;
  missing_input_name := trim(inrec.searchby.Identity.TrustDefenderAccount.AccountName)='';
  missing_input_address := trim(inrec.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressStreet1)='' and trim(inrec.searchby.Identity.TrustDefenderAccount.AccountAddress.AddressZip)='';

// digital ID requires at least 2 of these elements to be populated on input
missing_minimum_elements := ((integer)missing_input_telephone + (integer)missing_input_email + (integer)missing_input_name + (integer)missing_input_address) > 2;

invalid_account_email := rc_invalid_account_email in set_reason_codes;
invalid_account_telephone := rc_invalid_account_telephone in set_reason_codes;

// these 7 fields are for UAT, not to be returned in final version of Risk_Indicators.Layout_Boca_Shell_Edina_v55
self.invalid_account_email := if(invalid_account_email, '1', '0');
self.invalid_account_telephone := if(invalid_account_telephone, '1', '0');
//self.digital_id_result := trim(le.response._Data.DigitalIdResult);
self.account_telephone_result := trim(le.response._Data.AccountTelephoneResult);
self.account_email_result := trim(le.response._Data.Accountemailresult);
self.account_name_result := trim(le.response._Data.AccountNameResult);
self.account_address_result := trim(le.response._Data.AccountAddressResult);
//

/*///////////////////////////////////////////////////////////////////////////////////*
//  Hijacking digital_id_result, setting to error code from TM gateway failure
//  Need to pass back to FraudAdvisor Service
*////////////////////////////////////////////////////////////////////////////////////*
tmFailMessage := tm_results[1].response._header.message;
tmFailCode := tm_results[1].response._header.status;
self.digital_id_result := if(tmFailMessage <> '' or tmFailCode <> 0, 
                             'gateway-error:' + tmFailCode,
                             trim(le.response._Data.DigitalIdResult));
 
self.seq := (unsigned)inrec.User.QueryId;
self.TxinqWAddrFirst := map(
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  Stringlib.StringFilterOut(le.response._Data.AccountAddressFirstSeen, '-')
  );
self.TxinqWAddrLast := map(
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  Stringlib.StringFilterOut(le.response._Data.AccountAddressLastEvent, '-')
  );
self.TxinqAddrStatusInd := map(
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_address_result = not_found => code_0,
  account_address_result = 'success' => code_1,
  PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND);
  
self.TxinqWEmailFirst := map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  Stringlib.StringFilterOut(le.response._Data.AccountEmailFirstSeen, '-')
  );
self.TxinqWEmailLast := map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,  
  Stringlib.StringFilterOut(le.response._Data.AccountEmailLastEvent, '-')
  );
self.TxinqEmailStatusInd := map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => code_0, 
  code_1);
self.TxinqWNameFirst := map(
  missing_input_name => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,   
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  Stringlib.StringFilterOut(le.response._Data.accountnamefirstseen, '-')
  );
self.TxinqWNameLast := map(
  missing_input_name => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,   
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  Stringlib.StringFilterOut(le.response._Data.accountnamelastevent, '-')
  );
self.TxinqNameStatusInd	:= map(
  missing_input_name => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,   
  account_name_result = not_found => code_0, 
  code_1);
self.TxinqWPhoneFirst := map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  Stringlib.StringFilterOut(le.response._Data.accounttelephonefirstseen, '-')
  );
self.TxinqWPhoneLast := map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,  
  Stringlib.StringFilterOut(le.response._Data.accounttelephonelastevent, '-')
  );
self.TxinqPhoneStatusInd := map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => code_0, 
  code_1);

  
self.Tmxid	:= map(digital_id_result in [not_found, not_enough_attributes] or missing_minimum_elements => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
                  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
                  le.response._Data.DigitalId
                  );
self.TmxidConfidenceScore	:= map(digital_id_result in [not_found, not_enough_attributes] or missing_minimum_elements => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
                  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
                  (string)le.response._Data.DigitalIdConfidence
                  );
self.TxinqWTmxidFirst := map(digital_id_result in [not_found, not_enough_attributes] or missing_minimum_elements => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
                  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
                  Stringlib.StringFilterOut(le.response._Data.DigitalIdFirstSeen, '-')
                  );
self.TxinqWTmxidLast := map(digital_id_result in [not_found, not_enough_attributes] or missing_minimum_elements => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
                  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
                  Stringlib.StringFilterOut(le.response._Data.DigitalIdLastEvent, '-')
                  );
self.TxinqTmxidStatusInd := map(digital_id_result = not_enough_attributes or missing_minimum_elements => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
                  digital_id_result in [not_found, new_digital_id] => code_0,
                  digital_id_result = 'success' => code_1,
                  le.response._Data.DigitalIdResult);
self.TmxPolicyScore	:= if(trim(le.response._Data.PolicyScore)='',
                  PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
                  le.response._Data.PolicyScore
                  );
self.SmartidPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_email_alltime')[1].value
  );
self.SmartidPerEmailInTxinqCnt1Y	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_email_year')[1].value
  );
self.SmartidPerEmailInTxinqCnt6M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_email_6_months')[1].value
  );
self.SmartidPerEmailInTxinqCnt3M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_email_3_months')[1].value
  );
self.SmartidPerEmailInTxinqCnt1M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_email_month')[1].value
  );
self.SmartidPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_phone_alltime')[1].value
  ) ;
self.SmartidPerPhoneInTxinqCnt1Y	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_phone_year')[1].value
  );
self.SmartidPerPhoneInTxinqCnt6M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_phone_6_months')[1].value
  );
self.SmartidPerPhoneInTxinqCnt3M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_phone_3_months')[1].value
  );
self.SmartidPerPhoneInTxinqCnt1M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='smartid_per_phone_month')[1].value
  );
self.ExactidPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_email_alltime')[1].value
  );
self.ExactidPerEmailInTxinqCnt1Y	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_email_year')[1].value
  );
self.ExactidPerEmailInTxinqCnt6M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_email_6_months')[1].value
  );
self.ExactidPerEmailInTxinqCnt3M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_email_3_months')[1].value
  );
self.ExactidPerEmailInTxinqCnt1M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_email_month')[1].value
  );
self.ExactidPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_phone_alltime')[1].value
  );
self.ExactidPerPhoneInTxinqCnt1Y	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_phone_year')[1].value
  );
self.ExactidPerPhoneInTxinqCnt6M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_phone_6_months')[1].value
  );
self.ExactidPerPhoneInTxinqCnt3M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_phone_3_months')[1].value
  );
self.ExactidPerPhoneInTxinqCnt1M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='exactid_per_phone_month')[1].value
  );
self.EmailPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='email_per_phone_all_time')[1].value
  );
self.EmailPerPhoneInTxinqCnt1Y	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='email_per_phone_year')[1].value
  );
self.EmailPerPhoneInTxinqCnt1M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='email_per_phone_month')[1].value
  );
self.EmailPerPhoneInTxinqCnt3M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='email_per_phone_3_months')[1].value
  );
self.EmailPerPhoneInTxinqCnt6M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='email_per_phone_6_months')[1].value
  );
self.PhonePerEmailInTxinqCnt1Y	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='phone_per_email_year')[1].value
  );
self.PhonePerEmailInTxinqCnt1M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='phone_per_email_month')[1].value 
  );
self.PhonePerEmailInTxinqCnt3M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='phone_per_email_3_months')[1].value 
  );
self.TmxidPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_email_alltime')[1].value 
  );
self.TmxidPerEmailInTxinqCnt1Y	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_email_year')[1].value 
  );
self.TmxidPerEmailInTxinqCnt6M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_email_6_months')[1].value 
  );
self.TmxidPerEmailInTxinqCnt3M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_email_3_months')[1].value
  );
self.TmxidPerEmailInTxinqCnt1M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_email_month')[1].value 
  );
self.TmxidPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_phone_alltime')[1].value 
  );
self.TmxidPerPhoneInTxinqCnt1Y	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_phone_year')[1].value 
  );
self.TmxidPerPhoneInTxinqCnt6M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_phone_6_months')[1].value
  );
self.TmxidPerPhoneInTxinqCnt3M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_phone_3_months')[1].value
  );
self.TmxidPerPhoneInTxinqCnt1M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmxid_per_phone_month')[1].value
  );
self.OrgidPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='orgid_per_email_alltime')[1].value
  );
self.TrueipPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='trueip_per_email_alltime')[1].value
  );
self.TrueipgPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='trueip_geo_per_email_alltime')[1].value
  );
self.TrueipPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='trueip_per_phone_alltime')[1].value
  );
self.DnsipPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='dnsip_per_email_alltime')[1].value
  );
self.DnsipgPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='dnsip_geo_per_email_alltime')[1].value
  );
self.ProxyipPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='proxyip_per_email_alltime')[1].value
  );
self.ProxyipgPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='proxyip_geo_per_email_alltime')[1].value
  );
self.BrowserPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='browser_per_email_alltime')[1].value
  );
self.BrowserHashPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='browserhash_per_email_alltime')[1].value
  );
self.BrowserHashPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='browserhash_per_phone_alltime')[1].value
  );
self.ScreenResPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='screenres_per_email_alltime')[1].value
  );
self.TimeZonePerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='timezone_per_email_alltime')[1].value
  );
self.CurrencyPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='currency_per_email_alltime')[1].value
  );
self.LoginidPerPhoneInTxinqCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='loginid_per_phone_alltime')[1].value
  );
self.AchPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='ach_nums_per_email_alltime')[1].value
  );
self.AgentpubkeyPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='agentpubkey_per_email_alltime')[1].value
  );
self.CarrieridPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='carrier_id_per_email_alltime')[1].value
  );
self.CcardPerEmailInTxinqCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='ccard_per_email_alltime')[1].value
  );
self.TxinqCorrEmailWPhoneNameCnt	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found  or account_telephone_result = not_found or account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_all')[1].value
  ) ;
self.TxinqCorrEmailWPhoneNameCnt1Y	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found  or account_telephone_result = not_found or account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_year')[1].value
  );
self.TxinqCorrEmailWPhoneNameCnt6M	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found  or account_telephone_result = not_found or account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_6mo')[1].value
  );
self.TxinqCorrEmailWPhoneNameCnt3M	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found  or account_telephone_result = not_found  or account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_3mo')[1].value
  );
self.TxinqCorrEmailWPhoneNameCnt1M	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found  or account_telephone_result = not_found or account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_1mo')[1].value
  );
self.TxinqCorrEmailWPFLACnt	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone or 
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_telephone_result = not_found or 
  account_name_result = not_found or
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_addr_all')[1].value
  );
self.TxinqCorrEmailWPFLACnt1Y	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone or 
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_telephone_result = not_found or 
  account_name_result = not_found or
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_addr_year')[1].value
  );
self.TxinqCorrEmailWPFLACnt6M	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone or 
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_telephone_result = not_found or 
  account_name_result = not_found or
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_addr_6mo')[1].value
  );
self.TxinqCorrEmailWPFLACnt3M	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone or 
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_telephone_result = not_found or 
  account_name_result = not_found or
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_addr_3mo')[1].value
  );
self.TxinqCorrEmailWPFLACnt1M	:= map(
  missing_input_name or
  missing_input_email or
  missing_input_telephone or 
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_telephone_result = not_found or 
  account_name_result = not_found or
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_name_addr_1mo')[1].value
  ) ;
self.TxinqCorrEmailWPhoneCnt	:= map(
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found or 
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_all')[1].value
  );
self.TxinqCorrEmailWPhoneCnt1Y	:= map(
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found or 
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_year')[1].value
  );
self.TxinqCorrEmailWPhoneCnt6M	:= map(
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found or 
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_6mo')[1].value
  );
self.TxinqCorrEmailWPhoneCnt3M	:= map(
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found or 
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_3mo')[1].value
  );
self.TxinqCorrEmailWPhoneCnt1M	:= map(
  missing_input_email or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found or 
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_phn_1mo')[1].value
  );
self.TxinqWEmailCnt1Y	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_year')[1].value
  );
self.TxinqWEmailCnt6M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_6mo')[1].value
  );
self.TxinqWPhoneCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_all')[1].value
  );
self.TxinqWPhoneCnt1Y	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_year')[1].value
  );
self.TxinqWPhoneCnt6M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_6mo')[1].value
  );
self.TxinqCorrEmailWAddressCnt	:= map(
  missing_input_email or
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
  account_email_result = not_found or 
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_addr_all')[1].value
  );
self.TxinqCorrEmailWAddressCnt1Y	:= map(
  missing_input_email or
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
  account_email_result = not_found or 
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_addr_year')[1].value
  );
self.TxinqCorrEmailWAddressCnt6M	:= map(
  missing_input_email or
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
  account_email_result = not_found or 
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_addr_6mo')[1].value
  );
self.TxinqCorrEmailWAddressCnt3M	:= map(
  missing_input_email or
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
  account_email_result = not_found or 
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_addr_3mo')[1].value
  );
self.TxinqCorrEmailWAddressCnt1M	:= map(
  missing_input_email or
  missing_input_address => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA, 
  account_email_result = not_found or 
  account_address_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_addr_1mo')[1].value
  );
self.TxinqCorrEmailWNameCnt	:= map(
  missing_input_name or
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_name_all')[1].value
  );
self.TxinqCorrEmailWNameCnt1Y	:= map(
  missing_input_name or
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_name_year')[1].value
  );
self.TxinqCorrEmailWNameCnt6M	:= map(
  missing_input_name or
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_name_6mo')[1].value
  );
self.TxinqCorrEmailWNameCnt3M	:= map(
  missing_input_name or
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_name_3mo')[1].value
  );
self.TxinqCorrEmailWNameCnt1M	:= map(
  missing_input_name or
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_name_1mo')[1].value
  );
self.TxinqCorrNameWPhoneCnt	:= map(
  missing_input_name or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_name_phn_all')[1].value
  );
self.TxinqCorrNameWPhoneCnt1Y	:= map(
  missing_input_name or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_name_phn_year')[1].value
  );
self.TxinqCorrNameWPhoneCnt6M	:= map(
  missing_input_name or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_name_phn_6mo')[1].value
  );
self.TxinqCorrNameWPhoneCnt3M	:= map(
  missing_input_name or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_name_phn_3mo')[1].value
  );
self.TxinqCorrNameWPhoneCnt1M	:= map(
  missing_input_name or
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found or 
  account_name_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_name_phn_1mo')[1].value
  );
self.TxinqWEmailFinStatusRejCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_finalstatus_rej_all')[1].value
  );
self.TxinqWEmailFinStatusRejCnt1M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_finalstatus_rej_1mo')[1].value
  );
self.TxinqWEmailFinStatusAccCnt	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_finalstatus_acc_all')[1].value
  );
self.TxinqWEmailFinStatusAccCnt1M	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_email_finalstatus_acc_1mo')[1].value
  );
self.TxinqWPhoneFinStatusRejCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_finalstatus_rej_all')[1].value
  );
self.TxinqWPhoneFinStatusRejCnt1M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_finalstatus_rej_1mo')[1].value
  );
self.TxinqWPhoneFinStatusAccCnt	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_finalstatus_acc_all')[1].value
  );
self.TxinqWPhoneFinStatusAccCnt1M	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='evt_phn_finalstatus_acc_1mo')[1].value
  );
self.DistBtwTrueipWEmailAvg	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_g36')[1].value
  );
self.DistBtwTrueipWPhoneAvg	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_g37')[1].value
  );
self.TimeBtwTxinqWEmailAvg	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_g41')[1].value
  );
self.TimeBtwTxinqWPhoneAvg	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_g42')[1].value
  );
self.TrueiprcPerPhoneInTxinqCnt1W	:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_v260')[1].value
  );
self.TrueiprcPerEmailInTxinqCnt1W	:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_v261')[1].value
  );
self.ExactidPerTmxidInTxinqCnt1W	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did26')[1].value
  );
self.TrueipgPerTmxidInTxinqCnt1W	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did31')[1].value 
  );
self.TrueipPerTmxidInTxinqCnt1W	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did46')[1].value
  );
self.TrueipPerTmxidInTxinqCnt1M	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did47')[1].value
  );
self.TxinqWTmxidCnt1M	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did63')[1].value
  );
self.ExactidPerTmxidInTxinqDoCnt1W	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did86')[1].value
  );
self.TrueipgPerTmxidInTxinqDoCnt1W	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did88')[1].value
  );
self.SmartidPerTmxidInTxinqCnt	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did95')[1].value
  );
self.ExactidPerTmxidInTxinqCnt	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did96')[1].value
  );
self.EmailPerTmxidInTxinqCnt	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did97')[1].value
  );
self.PhonePerTmxidInTxinqCnt	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did98')[1].value
  );
self.NamePerTmxidInTxinqCnt	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did101')[1].value
  );
self.TrueipPerTmxidInTxinqCnt	:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  le.response._Data.TmxVariables(stringlib.stringtolowercase(name)='tmx_did107')[1].value
  );

// rules based off of digital_id
self.RuleTmxidTrustVeryHighFlag:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id trust very high' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidTrustHighFlag:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id trust high' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidTrustMediumFlag:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id trust medium' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidTrustedByUserFlag1M:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged trusted g 1 month' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidTrustedByUserFlag3M:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged trusted g 3 month' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidTrustedByUserFlag6M:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged trusted g 6 month' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidTrustedByUserFlag1Y:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged trusted g 12 month' in set_reason_codes => code_1,code_0) ;

// rules based off of email  
self.RuleEmailTrustedByUserFlag1M:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'eml tagged trusted g 1 month' in set_reason_codes => code_1,code_0) ;
self.RuleEmailTrustedByUserFlag3M:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,   
  'eml tagged trusted g 3 month' in set_reason_codes => code_1,code_0) ;
self.RuleEmailTrustedByUserFlag6M:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'eml tagged trusted g 6 month' in set_reason_codes => code_1,code_0) ;
self.RuleEmailTrustedByUserFlag1Y:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'eml tagged trusted g 12 month' in set_reason_codes => code_1,code_0) ;

// rules based off of digital_id
self.RuleTmxidFraudByUserFlag1M:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged fraud g 1 month' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidFraudByUserFlag3M:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged fraud g 3 month' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidFraudByUserFlag6M:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged fraud g 6 month' in set_reason_codes => code_1,code_0) ;
self.RuleTmxidFraudByUserFlag1Y:= map(
  digital_id_result in [not_found, not_enough_attributes] => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  digital_id_result = new_digital_id => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'digital id tagged fraud g 12 month' in set_reason_codes => code_1,code_0) ;

// rules based off of email  
self.RuleEmailBlistFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'email in global blacklist' in set_reason_codes => code_1,code_0) ;
self.RuleEmailBlistByBankFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'account email in global blacklist_banking_all' in set_reason_codes => code_1,code_0) ;
self.RuleEmailBlistByFinTechFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'account email in global blacklist_fintech_all' in set_reason_codes => code_1,code_0) ;
self.RuleEmailBlistByEcommFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'account email in global blacklist_ecomm_all' in set_reason_codes => code_1,code_0) ;
self.RuleExactidBlistInTxinqWEFlag1M:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'email_related_exactid_blacklist_month' in set_reason_codes => code_1,code_0) ;
self.RuleExactidBlistInTxinqWEFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'email_related_exactid_blacklist_alltime' in set_reason_codes => code_1,code_0) ;
self.RuleSmartidBlistInTxinqWEFlag1M:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'email_related_smartid_blacklist_month' in set_reason_codes => code_1,code_0) ;
self.RuleSmartidBlistInTxinqWEFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND,
  'email_related_smartid_blacklist_alltime' in set_reason_codes => code_1,code_0) ;

// rules about phones
self.RuleExactidBlistInTxinqWPFlag1M:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'phone_related_exactid_blacklist_month' in set_reason_codes => code_1,code_0) ;
self.RuleExactidBlistInTxinqWPFlag1Y:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'phone_related_exactid_blacklist_alltime' in set_reason_codes => code_1,code_0) ;
self.RuleSmartidBlistInTxinqWPFlag1M:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'phone_related_smartid_blacklist_month' in set_reason_codes => code_1,code_0) ;
self.RuleSmartidBlistInTxinqWPFlag1Y:= map(
  missing_input_telephone => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,  
  account_telephone_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'phone_related_smartid_blacklist_alltime' in set_reason_codes => code_1,code_0) ;

// rules based off of email    
self.RuleEmailHighRiskDomainFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'high risk email domain' in set_reason_codes => code_1,code_0) ;
self.RuleEmailAliasFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'email alias used' in set_reason_codes => code_1,code_0) ;
self.RuleEmailMachineGeneratedFlag:= map(
  missing_input_email => PublicRecords_KEL.ECL_Functions.Constants.MISSING_INPUT_DATA,
  account_email_result = not_found => PublicRecords_KEL.ECL_Functions.Constants.NO_DATA_FOUND, 
  'machine generated email' in set_reason_codes => code_1,code_0) ;

  self := [];
end;

tmx_results_transformed1 := join(threatmetrix_in, tm_results, 
  left.User.QueryId = right.response._Header.QueryID,
  map_tmx_fields(left, right), left outer, keep(1)
   );

// add code to check for no_data and convert to -99998 if missing
tmx_results_transformed := project(tmx_results_transformed1,
  transform(risk_indicators.layouts.layout_threatmetrix_shell_internal_results,
self.TxinqWAddrFirst	:= no_data_check( left.TxinqWAddrFirst	);
self.TxinqWAddrLast	:= no_data_check( left.TxinqWAddrLast	);
self.TxinqAddrStatusInd	:= no_data_check( left.TxinqAddrStatusInd	);
self.TxinqWEmailFirst	:= no_data_check( left.TxinqWEmailFirst	);
self.TxinqWEmailLast	:= no_data_check( left.TxinqWEmailLast	);
self.TxinqEmailStatusInd	:= no_data_check( left.TxinqEmailStatusInd	);
self.TxinqWNameFirst	:= no_data_check( left.TxinqWNameFirst	);
self.TxinqWNameLast 	:= no_data_check( left.TxinqWNameLast 	);
self.TxinqNameStatusInd	:= no_data_check( left.TxinqNameStatusInd	);
self.TxinqWPhoneFirst	:= no_data_check( left.TxinqWPhoneFirst	);
self.TxinqWPhoneLast	:= no_data_check( left.TxinqWPhoneLast	);
self.TxinqPhoneStatusInd	:= no_data_check( left.TxinqPhoneStatusInd	);
self.Tmxid	:= no_data_check( left.Tmxid	);
self.TmxidConfidenceScore	:= no_data_check( left.TmxidConfidenceScore	);
self.TxinqWTmxidFirst	:= no_data_check( left.TxinqWTmxidFirst	);
self.TxinqWTmxidLast	:= no_data_check( left.TxinqWTmxidLast	);
self.TxinqTmxidStatusInd	:= no_data_check( left.TxinqTmxidStatusInd	);
self.TmxPolicyScore	:= no_data_check( left.TmxPolicyScore	);
self.SmartidPerEmailInTxinqCnt	:= no_data_check( left.SmartidPerEmailInTxinqCnt	);
self.SmartidPerEmailInTxinqCnt1Y	:= no_data_check( left.SmartidPerEmailInTxinqCnt1Y	);
self.SmartidPerEmailInTxinqCnt6M	:= no_data_check( left.SmartidPerEmailInTxinqCnt6M	);
self.SmartidPerEmailInTxinqCnt3M	:= no_data_check( left.SmartidPerEmailInTxinqCnt3M	);
self.SmartidPerEmailInTxinqCnt1M	:= no_data_check( left.SmartidPerEmailInTxinqCnt1M	);
self.SmartidPerPhoneInTxinqCnt	:= no_data_check( left.SmartidPerPhoneInTxinqCnt	);
self.SmartidPerPhoneInTxinqCnt1Y	:= no_data_check( left.SmartidPerPhoneInTxinqCnt1Y	);
self.SmartidPerPhoneInTxinqCnt6M	:= no_data_check( left.SmartidPerPhoneInTxinqCnt6M	);
self.SmartidPerPhoneInTxinqCnt3M	:= no_data_check( left.SmartidPerPhoneInTxinqCnt3M	);
self.SmartidPerPhoneInTxinqCnt1M	:= no_data_check( left.SmartidPerPhoneInTxinqCnt1M	);
self.ExactidPerEmailInTxinqCnt	:= no_data_check( left.ExactidPerEmailInTxinqCnt	);
self.ExactidPerEmailInTxinqCnt1Y	:= no_data_check( left.ExactidPerEmailInTxinqCnt1Y	);
self.ExactidPerEmailInTxinqCnt6M	:= no_data_check( left.ExactidPerEmailInTxinqCnt6M	);
self.ExactidPerEmailInTxinqCnt3M	:= no_data_check( left.ExactidPerEmailInTxinqCnt3M	);
self.ExactidPerEmailInTxinqCnt1M	:= no_data_check( left.ExactidPerEmailInTxinqCnt1M	);
self.ExactidPerPhoneInTxinqCnt	:= no_data_check( left.ExactidPerPhoneInTxinqCnt	);
self.ExactidPerPhoneInTxinqCnt1Y	:= no_data_check( left.ExactidPerPhoneInTxinqCnt1Y	);
self.ExactidPerPhoneInTxinqCnt6M	:= no_data_check( left.ExactidPerPhoneInTxinqCnt6M	);
self.ExactidPerPhoneInTxinqCnt3M	:= no_data_check( left.ExactidPerPhoneInTxinqCnt3M	);
self.ExactidPerPhoneInTxinqCnt1M	:= no_data_check( left.ExactidPerPhoneInTxinqCnt1M	);
self.EmailPerPhoneInTxinqCnt	:= no_data_check( left.EmailPerPhoneInTxinqCnt	);
self.EmailPerPhoneInTxinqCnt1Y	:= no_data_check( left.EmailPerPhoneInTxinqCnt1Y	);
self.EmailPerPhoneInTxinqCnt1M	:= no_data_check( left.EmailPerPhoneInTxinqCnt1M	);
self.EmailPerPhoneInTxinqCnt3M	:= no_data_check( left.EmailPerPhoneInTxinqCnt3M	);
self.EmailPerPhoneInTxinqCnt6M	:= no_data_check( left.EmailPerPhoneInTxinqCnt6M	);
self.PhonePerEmailInTxinqCnt1Y	:= no_data_check( left.PhonePerEmailInTxinqCnt1Y	);
self.PhonePerEmailInTxinqCnt1M	:= no_data_check( left.PhonePerEmailInTxinqCnt1M	);
self.PhonePerEmailInTxinqCnt3M	:= no_data_check( left.PhonePerEmailInTxinqCnt3M	);
self.TmxidPerEmailInTxinqCnt	:= no_data_check( left.TmxidPerEmailInTxinqCnt	);
self.TmxidPerEmailInTxinqCnt1Y	:= no_data_check( left.TmxidPerEmailInTxinqCnt1Y	);
self.TmxidPerEmailInTxinqCnt6M	:= no_data_check( left.TmxidPerEmailInTxinqCnt6M	);
self.TmxidPerEmailInTxinqCnt3M	:= no_data_check( left.TmxidPerEmailInTxinqCnt3M	);
self.TmxidPerEmailInTxinqCnt1M	:= no_data_check( left.TmxidPerEmailInTxinqCnt1M	);
self.TmxidPerPhoneInTxinqCnt	:= no_data_check( left.TmxidPerPhoneInTxinqCnt	);
self.TmxidPerPhoneInTxinqCnt1Y	:= no_data_check( left.TmxidPerPhoneInTxinqCnt1Y	);
self.TmxidPerPhoneInTxinqCnt6M	:= no_data_check( left.TmxidPerPhoneInTxinqCnt6M	);
self.TmxidPerPhoneInTxinqCnt3M	:= no_data_check( left.TmxidPerPhoneInTxinqCnt3M	);
self.TmxidPerPhoneInTxinqCnt1M	:= no_data_check( left.TmxidPerPhoneInTxinqCnt1M	);
self.OrgidPerEmailInTxinqCnt	:= no_data_check( left.OrgidPerEmailInTxinqCnt	);
self.TrueipPerEmailInTxinqCnt	:= no_data_check( left.TrueipPerEmailInTxinqCnt	);
self.TrueipgPerEmailInTxinqCnt	:= no_data_check( left.TrueipgPerEmailInTxinqCnt	);
self.TrueipPerPhoneInTxinqCnt	:= no_data_check( left.TrueipPerPhoneInTxinqCnt	);
self.DnsipPerEmailInTxinqCnt	:= no_data_check( left.DnsipPerEmailInTxinqCnt	);
self.DnsipgPerEmailInTxinqCnt	:= no_data_check( left.DnsipgPerEmailInTxinqCnt	);
self.ProxyipPerEmailInTxinqCnt	:= no_data_check( left.ProxyipPerEmailInTxinqCnt	);
self.ProxyipgPerEmailInTxinqCnt	:= no_data_check( left.ProxyipgPerEmailInTxinqCnt	);
self.BrowserPerEmailInTxinqCnt	:= no_data_check( left.BrowserPerEmailInTxinqCnt	);
self.BrowserHashPerEmailInTxinqCnt	:= no_data_check( left.BrowserHashPerEmailInTxinqCnt	);
self.BrowserHashPerPhoneInTxinqCnt	:= no_data_check( left.BrowserHashPerPhoneInTxinqCnt	);
self.ScreenResPerEmailInTxinqCnt	:= no_data_check( left.ScreenResPerEmailInTxinqCnt	);
self.TimeZonePerEmailInTxinqCnt	:= no_data_check( left.TimeZonePerEmailInTxinqCnt	);
self.CurrencyPerEmailInTxinqCnt	:= no_data_check( left.CurrencyPerEmailInTxinqCnt	);
self.LoginidPerPhoneInTxinqCnt	:= no_data_check( left.LoginidPerPhoneInTxinqCnt	);
self.AchPerEmailInTxinqCnt	:= no_data_check( left.AchPerEmailInTxinqCnt	);
self.AgentpubkeyPerEmailInTxinqCnt	:= no_data_check( left.AgentpubkeyPerEmailInTxinqCnt	);
self.CarrieridPerEmailInTxinqCnt	:= no_data_check( left.CarrieridPerEmailInTxinqCnt	);
self.CcardPerEmailInTxinqCnt	:= no_data_check( left.CcardPerEmailInTxinqCnt	);
self.TxinqCorrEmailWPhoneNameCnt	:= no_data_check( left.TxinqCorrEmailWPhoneNameCnt	);
self.TxinqCorrEmailWPhoneNameCnt1Y	:= no_data_check( left.TxinqCorrEmailWPhoneNameCnt1Y	);
self.TxinqCorrEmailWPhoneNameCnt6M	:= no_data_check( left.TxinqCorrEmailWPhoneNameCnt6M	);
self.TxinqCorrEmailWPhoneNameCnt3M	:= no_data_check( left.TxinqCorrEmailWPhoneNameCnt3M	);
self.TxinqCorrEmailWPhoneNameCnt1M	:= no_data_check( left.TxinqCorrEmailWPhoneNameCnt1M	);
self.TxinqCorrEmailWPFLACnt	:= no_data_check( left.TxinqCorrEmailWPFLACnt	);
self.TxinqCorrEmailWPFLACnt1Y	:= no_data_check( left.TxinqCorrEmailWPFLACnt1Y	);
self.TxinqCorrEmailWPFLACnt6M	:= no_data_check( left.TxinqCorrEmailWPFLACnt6M	);
self.TxinqCorrEmailWPFLACnt3M	:= no_data_check( left.TxinqCorrEmailWPFLACnt3M	);
self.TxinqCorrEmailWPFLACnt1M	:= no_data_check( left.TxinqCorrEmailWPFLACnt1M	);
self.TxinqCorrEmailWPhoneCnt	:= no_data_check( left.TxinqCorrEmailWPhoneCnt	);
self.TxinqCorrEmailWPhoneCnt1Y	:= no_data_check( left.TxinqCorrEmailWPhoneCnt1Y	);
self.TxinqCorrEmailWPhoneCnt6M	:= no_data_check( left.TxinqCorrEmailWPhoneCnt6M	);
self.TxinqCorrEmailWPhoneCnt3M	:= no_data_check( left.TxinqCorrEmailWPhoneCnt3M	);
self.TxinqCorrEmailWPhoneCnt1M	:= no_data_check( left.TxinqCorrEmailWPhoneCnt1M	);
self.TxinqWEmailCnt1Y	:= no_data_check( left.TxinqWEmailCnt1Y	);
self.TxinqWEmailCnt6M	:= no_data_check( left.TxinqWEmailCnt6M	);
self.TxinqWPhoneCnt	:= no_data_check( left.TxinqWPhoneCnt	);
self.TxinqWPhoneCnt1Y	:= no_data_check( left.TxinqWPhoneCnt1Y	);
self.TxinqWPhoneCnt6M	:= no_data_check( left.TxinqWPhoneCnt6M	);
self.TxinqCorrEmailWAddressCnt	:= no_data_check( left.TxinqCorrEmailWAddressCnt	);
self.TxinqCorrEmailWAddressCnt1Y	:= no_data_check( left.TxinqCorrEmailWAddressCnt1Y	);
self.TxinqCorrEmailWAddressCnt6M	:= no_data_check( left.TxinqCorrEmailWAddressCnt6M	);
self.TxinqCorrEmailWAddressCnt3M	:= no_data_check( left.TxinqCorrEmailWAddressCnt3M	);
self.TxinqCorrEmailWAddressCnt1M	:= no_data_check( left.TxinqCorrEmailWAddressCnt1M	);
self.TxinqCorrEmailWNameCnt	:= no_data_check( left.TxinqCorrEmailWNameCnt	);
self.TxinqCorrEmailWNameCnt1Y	:= no_data_check( left.TxinqCorrEmailWNameCnt1Y	);
self.TxinqCorrEmailWNameCnt6M	:= no_data_check( left.TxinqCorrEmailWNameCnt6M	);
self.TxinqCorrEmailWNameCnt3M	:= no_data_check( left.TxinqCorrEmailWNameCnt3M	);
self.TxinqCorrEmailWNameCnt1M	:= no_data_check( left.TxinqCorrEmailWNameCnt1M	);
self.TxinqCorrNameWPhoneCnt	:= no_data_check( left.TxinqCorrNameWPhoneCnt	);
self.TxinqCorrNameWPhoneCnt1Y	:= no_data_check( left.TxinqCorrNameWPhoneCnt1Y	);
self.TxinqCorrNameWPhoneCnt6M	:= no_data_check( left.TxinqCorrNameWPhoneCnt6M	);
self.TxinqCorrNameWPhoneCnt3M	:= no_data_check( left.TxinqCorrNameWPhoneCnt3M	);
self.TxinqCorrNameWPhoneCnt1M	:= no_data_check( left.TxinqCorrNameWPhoneCnt1M	);
self.TxinqWEmailFinStatusRejCnt	:= no_data_check( left.TxinqWEmailFinStatusRejCnt	);
self.TxinqWEmailFinStatusRejCnt1M	:= no_data_check( left.TxinqWEmailFinStatusRejCnt1M	);
self.TxinqWEmailFinStatusAccCnt	:= no_data_check( left.TxinqWEmailFinStatusAccCnt	);
self.TxinqWEmailFinStatusAccCnt1M	:= no_data_check( left.TxinqWEmailFinStatusAccCnt1M	);
self.TxinqWPhoneFinStatusRejCnt	:= no_data_check( left.TxinqWPhoneFinStatusRejCnt	);
self.TxinqWPhoneFinStatusRejCnt1M	:= no_data_check( left.TxinqWPhoneFinStatusRejCnt1M	);
self.TxinqWPhoneFinStatusAccCnt	:= no_data_check( left.TxinqWPhoneFinStatusAccCnt	);
self.TxinqWPhoneFinStatusAccCnt1M	:= no_data_check( left.TxinqWPhoneFinStatusAccCnt1M	);
self.DistBtwTrueipWEmailAvg	:= no_data_check( left.DistBtwTrueipWEmailAvg	);
self.DistBtwTrueipWPhoneAvg	:= no_data_check( left.DistBtwTrueipWPhoneAvg	);
self.TimeBtwTxinqWEmailAvg	:= no_data_check( left.TimeBtwTxinqWEmailAvg	);
self.TimeBtwTxinqWPhoneAvg	:= no_data_check( left.TimeBtwTxinqWPhoneAvg	);
self.TrueiprcPerPhoneInTxinqCnt1W	:= no_data_check( left.TrueiprcPerPhoneInTxinqCnt1W	);
self.TrueiprcPerEmailInTxinqCnt1W	:= no_data_check( left.TrueiprcPerEmailInTxinqCnt1W	);
self.ExactidPerTmxidInTxinqCnt1W	:= no_data_check( left.ExactidPerTmxidInTxinqCnt1W	);
self.TrueipgPerTmxidInTxinqCnt1W	:= no_data_check( left.TrueipgPerTmxidInTxinqCnt1W	);
self.TrueipPerTmxidInTxinqCnt1W	:= no_data_check( left.TrueipPerTmxidInTxinqCnt1W	);
self.TrueipPerTmxidInTxinqCnt1M	:= no_data_check( left.TrueipPerTmxidInTxinqCnt1M	);
self.TxinqWTmxidCnt1M	:= no_data_check( left.TxinqWTmxidCnt1M	);
self.ExactidPerTmxidInTxinqDoCnt1W	:= no_data_check( left.ExactidPerTmxidInTxinqDoCnt1W	);
self.TrueipgPerTmxidInTxinqDoCnt1W	:= no_data_check( left.TrueipgPerTmxidInTxinqDoCnt1W	);
self.SmartidPerTmxidInTxinqCnt	:= no_data_check( left.SmartidPerTmxidInTxinqCnt	);
self.ExactidPerTmxidInTxinqCnt	:= no_data_check( left.ExactidPerTmxidInTxinqCnt	);
self.EmailPerTmxidInTxinqCnt	:= no_data_check( left.EmailPerTmxidInTxinqCnt	);
self.PhonePerTmxidInTxinqCnt	:= no_data_check( left.PhonePerTmxidInTxinqCnt	);
self.NamePerTmxidInTxinqCnt	:= no_data_check( left.NamePerTmxidInTxinqCnt	);
self.TrueipPerTmxidInTxinqCnt	:= no_data_check( left.TrueipPerTmxidInTxinqCnt	);
self.RuleTmxidTrustVeryHighFlag	:= no_data_check( left.RuleTmxidTrustVeryHighFlag	);
self.RuleTmxidTrustHighFlag	:= no_data_check( left.RuleTmxidTrustHighFlag	);
self.RuleTmxidTrustMediumFlag	:= no_data_check( left.RuleTmxidTrustMediumFlag	);
self.RuleTmxidTrustedByUserFlag1M	:= no_data_check( left.RuleTmxidTrustedByUserFlag1M	);
self.RuleTmxidTrustedByUserFlag3M	:= no_data_check( left.RuleTmxidTrustedByUserFlag3M	);
self.RuleTmxidTrustedByUserFlag6M	:= no_data_check( left.RuleTmxidTrustedByUserFlag6M	);
self.RuleTmxidTrustedByUserFlag1Y	:= no_data_check( left.RuleTmxidTrustedByUserFlag1Y	);
self.RuleEmailTrustedByUserFlag1M	:= no_data_check( left.RuleEmailTrustedByUserFlag1M	);
self.RuleEmailTrustedByUserFlag3M	:= no_data_check( left.RuleEmailTrustedByUserFlag3M	);
self.RuleEmailTrustedByUserFlag6M	:= no_data_check( left.RuleEmailTrustedByUserFlag6M	);
self.RuleEmailTrustedByUserFlag1Y	:= no_data_check( left.RuleEmailTrustedByUserFlag1Y	);
self.RuleTmxidFraudByUserFlag1M	:= no_data_check( left.RuleTmxidFraudByUserFlag1M	);
self.RuleTmxidFraudByUserFlag3M	:= no_data_check( left.RuleTmxidFraudByUserFlag3M	);
self.RuleTmxidFraudByUserFlag6M	:= no_data_check( left.RuleTmxidFraudByUserFlag6M	);
self.RuleTmxidFraudByUserFlag1Y	:= no_data_check( left.RuleTmxidFraudByUserFlag1Y	);
self.RuleEmailBlistFlag	:= no_data_check( left.RuleEmailBlistFlag	);
self.RuleEmailBlistByBankFlag	:= no_data_check( left.RuleEmailBlistByBankFlag	);
self.RuleEmailBlistByFinTechFlag	:= no_data_check( left.RuleEmailBlistByFinTechFlag	);
self.RuleEmailBlistByEcommFlag	:= no_data_check( left.RuleEmailBlistByEcommFlag	);
self.RuleExactidBlistInTxinqWEFlag1M	:= no_data_check( left.RuleExactidBlistInTxinqWEFlag1M	);
self.RuleExactidBlistInTxinqWEFlag	:= no_data_check( left.RuleExactidBlistInTxinqWEFlag	);
self.RuleSmartidBlistInTxinqWEFlag1M	:= no_data_check( left.RuleSmartidBlistInTxinqWEFlag1M	);
self.RuleSmartidBlistInTxinqWEFlag	:= no_data_check( left.RuleSmartidBlistInTxinqWEFlag	);
self.RuleExactidBlistInTxinqWPFlag1M	:= no_data_check( left.RuleExactidBlistInTxinqWPFlag1M	);
self.RuleExactidBlistInTxinqWPFlag1Y	:= no_data_check( left.RuleExactidBlistInTxinqWPFlag1Y	);
self.RuleSmartidBlistInTxinqWPFlag1M	:= no_data_check( left.RuleSmartidBlistInTxinqWPFlag1M	);
self.RuleSmartidBlistInTxinqWPFlag1Y	:= no_data_check( left.RuleSmartidBlistInTxinqWPFlag1Y	);
self.RuleEmailHighRiskDomainFlag	:= no_data_check( left.RuleEmailHighRiskDomainFlag	);
self.RuleEmailAliasFlag	:= no_data_check( left.RuleEmailAliasFlag	);
self.RuleEmailMachineGeneratedFlag	:= no_data_check( left.RuleEmailMachineGeneratedFlag	);

self := left;   // set the debug fields to what they were above 
 ));

// output(gateway_cfg, named('gateway_cfg'));
// output(threatmetrix_in, named('threatmetrix_in'));
// output(tm_results, named('tm_results'));
// output(tmx_results_transformed, named('tmx_results_transformed'));
// output(tm_results,,'~dvstemp::out::tmx_gateway_results_debugging_' + thorlib.wuid());  // store the results to use in soapcall so we don't keep running the same transactions over and over

return tmx_results_transformed;

end;