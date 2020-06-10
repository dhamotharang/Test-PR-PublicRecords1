IMPORT didville, FraudShared_Services, iesp, RiskIntelligenceNetwork_Services, STD;

EXPORT Functions := MODULE

 SHARED _Constants := RiskIntelligenceNetwork_Services.Constants;
 SHARED Fragment_Types_const := _Constants.Fragment_Types;
 SHARED FRAUD_PLATFORM := _Constants.FRAUD_PLATFORM;
 SHARED _rin_Layout := RiskIntelligenceNetwork_Services.Layouts;
 SHARED _sharedLayout := FraudShared_Services.Layouts;

 EXPORT getRealtimePRAppends(DATASET(DidVille.Layout_Did_OutBatch) ds_best_in, 
                             RiskIntelligenceNetwork_Services.IParam.Params params) := FUNCTION

  ds_appends_in := PROJECT(ds_best_in, 
                    TRANSFORM(_sharedLayout.BatchIn_rec,
                      SELF.acctno := (string) LEFT.seq,
                      SELF.seq := LEFT.seq,
                      SELF.ssn := LEFT.best_ssn,
                      SELF.dob := LEFT.best_dob,
                      SELF.did := LEFT.did,
                      SELF.name_first := LEFT.best_fname,
                      SELF.name_middle := LEFT.best_mname,
                      SELF.name_last := LEFT.best_lname,
                      SELF.name_suffix := LEFT.best_name_suffix,
                      SELF.addr := LEFT.best_addr1,
                      SELF.p_city_name := LEFT.best_city,
                      SELF.st := LEFT.best_state,
                      SELF.z5 := LEFT.best_zip,
                      SELF.zip4 := LEFT.best_zip4,
                      SELF.phoneno := LEFT.best_phone,
                      SELF := [];
                  ));

  _PRAppends := RiskIntelligenceNetwork_Services.fn_GetPubRecordAppends(ds_appends_in, params);

  recs_Criminal := _PRAppends.GetCriminal();
  recs_advo := _PRAppends.GetAdvo();
  recs_prepaid_phone := _PRAppends.GetPrepaidPhone();
  recs_dl := _PRAppends.GetDL();
  recs_boca_shell := _PRAppends.GetBocaShell();

  _rin_Layout.realtime_appends_rec xfm_Compilation(_sharedLayout.BatchIn_rec L) := TRANSFORM
    SELF.batchin_rec := L;
    SELF.crim_appends := recs_Criminal;
    SELF.advo_appends := recs_advo;
    SELF.pr_best_appends := ds_best_in;
    SELF.prepaid_phone_appends := recs_prepaid_phone;
    SELF.dl_appends := recs_dl;
    SELF.boca_shell_appends := recs_boca_shell;
  END;

  final_recs := PROJECT(ds_appends_in, xfm_Compilation(LEFT));

  // output(ds_appends_in, named('ds_appends_in'));
  // output(recs_Criminal, named('recs_Criminal'));
  // output(recs_advo, named('recs_advo'));
  // output(ds_best_in, named('ds_best_in'));
  // output(recs_prepaid_phone, named('recs_prepaid_phone'));
  // output(recs_dl, named('recs_dl'));
  // output(recs_boca_shell, named('recs_boca_shell'));

  return final_recs;
 END;

 EXPORT GetFragmentRecs(DATASET(_sharedLayout.BatchInExtended_rec) ds_freg_recs_in,
                        DATASET(_sharedLayout.Raw_Payload_rec) ds_payload,
                        Boolean skip_autokey_ds_matching = FALSE) := FUNCTION

  ds_fragment_recs := FraudShared_Services.Functions.getMatchedEntityTypes(ds_freg_recs_in, ds_payload, skip_autokey_ds_matching, FRAUD_PLATFORM);

  _rin_Layout.fragment_w_value_recs ds_fragment_recs_w_trans(_sharedLayout.layout_velocity_in L, 
                                                             _sharedLayout.Raw_Payload_rec R)  := TRANSFORM
  
    BOOLEAN isBankAccountNumber1 := EXISTS(ds_freg_recs_in(bank_account_number <> '' AND bank_account_number = R.bank_account_number_1));
    BOOLEAN isBankAccountNumber2 := EXISTS(ds_freg_recs_in(bank_account_number <> '' AND bank_account_number = R.bank_account_number_2));
    
    bankRountingNumber1 := IF(isBankAccountNumber1 AND R.bank_routing_number_1 <> '', TRIM(R.bank_routing_number_1, LEFT, RIGHT), ' '); 
    bankRountingNumber2 := IF(isBankAccountNumber2 AND R.bank_routing_number_2 <> '', TRIM(R.bank_routing_number_2, LEFT, RIGHT), ' ');
    
    bank_info_to_use := MAP(isBankAccountNumber1 => bankRountingNumber1 + _Constants.FRAGMENT_SEPARATOR + R.bank_account_number_1,
                            isBankAccountNumber2 => bankRountingNumber2 + _Constants.FRAGMENT_SEPARATOR + R.bank_account_number_2,
                            '');
    
    //GEOLOCATION_FRAGMENT and MAILING_ADDRESS_FRAGMENT are not element yet, but will be in future. left in there for future use.
    SELF.fragment_value := CASE(L.fragment, 
                                Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => bank_info_to_use,
                                Fragment_Types_const.DEVICE_ID_FRAGMENT => R.device_id,
                                Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => TRIM(R.drivers_license) + _Constants.FRAGMENT_SEPARATOR + TRIM(R.Drivers_License_State),
                                // Fragment_Types_const.GEOLOCATION_FRAGMENT => R.clean_address.geo_lat + ' ' + R.clean_address.R.geo_long,
                                Fragment_Types_const.IP_ADDRESS_FRAGMENT => R.ip_address,
                                // Fragment_Types_const.MAILING_ADDRESS_FRAGMENT => (STD.Str.CleanSpaces(R.additional_address.address_1 + ' ' + R.additional_address.address_2)),
                                Fragment_Types_const.NAME_FRAGMENT => TRIM(R.cleaned_name.fname) + ' ' + TRIM(R.cleaned_name.lname),
                                Fragment_Types_const.PERSON_FRAGMENT => (string) R.did,
                                Fragment_Types_const.PHONE_FRAGMENT => R.clean_phones.phone_number,
                                Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => STD.Str.CleanSpaces(R.address_1) + _Constants.FRAGMENT_SEPARATOR + STD.Str.CleanSpaces(R.address_2),
                                Fragment_Types_const.SSN_FRAGMENT => R.ssn,
                                Fragment_Types_const.EMAIL_FRAGMENT => R.email_address,
                                '');
    SELF := L;
  END;

  ds_fragment_recs_w_value := JOIN(ds_fragment_recs, ds_payload, 
                                LEFT.record_id = RIGHT.record_id,
                                ds_fragment_recs_w_trans(LEFT, RIGHT),
                              LIMIT(_Constants.MAX_JOIN_LIMIT, SKIP));
  
  RETURN ds_fragment_recs_w_value;
 END;

 EXPORT getAnalyticsUID(DATASET(_rin_Layout.fragment_w_value_recs) ds_entity_rolled) := FUNCTION

  Entity_Type_Identifier := _Constants.KelEntityIdentifier;

  ds_entityNameValue := PROJECT(ds_entity_rolled,TRANSFORM(_rin_Layout.entity_uid_recs, SELF := LEFT));

  // All the commneted Fragment Types in the below project are not supported as of now (in MVP), However, 
  // ... they will be supported for the final product. 
  analytics_uids := PROJECT(ds_entityNameValue, 
                      TRANSFORM(_rin_Layout.entity_uid_recs,
                        uid := CASE(LEFT.fragment,
                                    Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT => Entity_Type_Identifier.DLNUMBER + HASH64(STD.Str.FindReplace(LEFT.fragment_value,_Constants.FRAGMENT_SEPARATOR,'|')),
                                    Fragment_Types_const.IP_ADDRESS_FRAGMENT => Entity_Type_Identifier.IPADDRESS + HASH64(LEFT.fragment_value),
                                    Fragment_Types_const.PERSON_FRAGMENT => Entity_Type_Identifier.LEXID + LEFT.fragment_value,
                                    Fragment_Types_const.PHONE_FRAGMENT => Entity_Type_Identifier.PHONENO + LEFT.fragment_value,
                                    Fragment_Types_const.SSN_FRAGMENT => Entity_Type_Identifier.SSN +  HASH64(LEFT.fragment_value),
                                    Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT => Entity_Type_Identifier.PHYSICAL_ADDRESS + HASH64(STD.Str.FindReplace(LEFT.fragment_value,_Constants.FRAGMENT_SEPARATOR,'|')),
                                    Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT => Entity_Type_Identifier.BANKACCOUNT + HASH64(STD.Str.FindReplace(LEFT.fragment_value,_Constants.FRAGMENT_SEPARATOR,'|')),
                                    Fragment_Types_const.EMAIL_FRAGMENT => Entity_Type_Identifier.EMAIL + HASH64(LEFT.fragment_value),
                                    '');
                        SELF.entity_context_uid := uid;
                        SELF := LEFT));

  RETURN analytics_uids;
 END;

 EXPORT getGovernmentBest(DATASET(didville.Layout_Did_OutBatch) ds_best_in, 
                          RiskIntelligenceNetwork_Services.IParam.Params params) := FUNCTION

  ds_best := DidVille.did_service_common_function(ds_best_in,
                                                  appends_value    := _Constants.appends_value,
                                                  verify_value     := _Constants.verify_value,
                                                  glb_flag         := params.isValidGLB(),
                                                  glb_purpose_value:= params.glb,
                                                  appType          := params.application_type,
                                                  include_minors   := TRUE,
                                                  IndustryClass_val:= params.industry_class,
                                                  DRM_val          := params.DataRestrictionMask,
                                                  GetSSNBest       := TRUE);
  RETURN ds_best; 
 END;

 EXPORT GetCleanAddressFragmentValue(string address) := FUNCTION
  return REGEXREPLACE(RiskIntelligenceNetwork_Services.Constants.FRAGMENT_SEPARATOR ,address,', ');
 END;	

 EXPORT GetCleanFragmentValue(string FragmentValue, integer pos) := FUNCTION
  return REGEXFIND('(.*)' + RiskIntelligenceNetwork_Services.Constants.FRAGMENT_SEPARATOR + '(.*)$',FragmentValue, pos);
 END;

 EXPORT IsValidInputDate(iesp.share.t_Date date) := FUNCTION
  date_int := iesp.ECL2ESP.DateToInteger(date);
  return STD.Date.IsValidDate(date_int) OR date_int = 0;
 END;

END;