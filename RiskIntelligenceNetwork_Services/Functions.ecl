﻿IMPORT didville, FraudShared_Services, iesp, RiskIntelligenceNetwork_Services, STD;

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

 EXPORT GetFragmentRecs(DATASET(_sharedLayout.BatchInExtended_rec) ds_recs_in,
                        DATASET(_sharedLayout.Raw_Payload_rec) ds_payload) := FUNCTION

  ds_person_elements := IF(EXISTS(ds_payload(did <> 0)), 
                            DEDUP(SORT(PROJECT(ds_payload(did <> 0), TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                       SELF.Acctno := LEFT.Acctno,
                                                                       SELF.fragment := Fragment_Types_const.PERSON_FRAGMENT,
                                                                       SELF.fragment_value := (string) LEFT.did)), 
                                  Acctno, fragment_value), Acctno, fragment_value),
                            DATASET([], _rin_Layout.fragment_w_value_recs));
  
  generateAddressElement := (ds_recs_in[1].Addr <> '' OR ds_recs_in[1].prim_name <> '') AND ((ds_recs_in[1].p_city_name <> '' AND ds_recs_in[1].st <> '') OR ds_recs_in[1].z5 <> '');
  ds_addresss_elements := IF(generateAddressElement, 
                              DEDUP(SORT(PROJECT(ds_payload, TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                               SELF.Acctno := LEFT.Acctno,
                                                               SELF.fragment := Fragment_Types_const.PHYSICAL_ADDRESS_FRAGMENT,
                                                               SELF.fragment_value := STD.Str.CleanSpaces(LEFT.address_1) + 
                                                                                      _Constants.FRAGMENT_SEPARATOR + 
                                                                                      STD.Str.CleanSpaces(LEFT.address_2))), 
                                    Acctno, fragment_value), Acctno, fragment_value),
                              DATASET([], _rin_Layout.fragment_w_value_recs));
                                 
  ds_ssn_elements := IF(ds_recs_in[1].ssn <> '', 
                          DEDUP(SORT(PROJECT(ds_payload(SSN <> ''), TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                      SELF.Acctno := LEFT.Acctno,
                                                                      SELF.fragment := Fragment_Types_const.SSN_FRAGMENT,
                                                                      SELF.fragment_value := LEFT.ssn)),
                                Acctno, fragment_value), Acctno, fragment_value),
                          DATASET([], _rin_Layout.fragment_w_value_recs));
  
  ds_phone_elements := IF(ds_recs_in[1].phoneno <> '', 
                          DEDUP(SORT(PROJECT(ds_payload(clean_phones.phone_number <> ''), TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                                            SELF.Acctno := LEFT.Acctno,
                                                                                            SELF.fragment := Fragment_Types_const.PHONE_FRAGMENT,
                                                                                            SELF.fragment_value := LEFT.clean_phones.phone_number)),
                                Acctno, fragment_value), Acctno, fragment_value),
                          DATASET([], _rin_Layout.fragment_w_value_recs));

  ds_email_elements := IF(ds_recs_in[1].email_address <> '', 
                          DEDUP(SORT(PROJECT(ds_payload(email_address <> ''), TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                                SELF.Acctno := LEFT.Acctno,
                                                                                SELF.fragment := Fragment_Types_const.EMAIL_FRAGMENT,
                                                                                SELF.fragment_value := LEFT.email_address)),
                                Acctno, fragment_value), Acctno, fragment_value),
                          DATASET([], _rin_Layout.fragment_w_value_recs));

  ds_ipaddress_elements := IF(ds_recs_in[1].ip_address <> '', 
                            DEDUP(SORT(PROJECT(ds_payload(ip_address <> ''), TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                               SELF.Acctno := LEFT.Acctno,
                                                                               SELF.fragment := Fragment_Types_const.IP_ADDRESS_FRAGMENT,
                                                                               SELF.fragment_value := LEFT.ip_address)),
                                  Acctno, fragment_value), Acctno, fragment_value),
                            DATASET([], _rin_Layout.fragment_w_value_recs));

  ds_bankaccount1_elements := IF(ds_recs_in[1].bank_account_number <> '', 
                                DEDUP(SORT(PROJECT(ds_payload, TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                 SELF.Acctno := LEFT.Acctno,
                                                                 SELF.fragment := Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT,
                                                                 SELF.fragment_value := IF(LEFT.bank_routing_number_1 <> '', TRIM(LEFT.bank_routing_number_1), ' ') + 
                                                                                           _Constants.FRAGMENT_SEPARATOR + 
                                                                                           TRIM(LEFT.bank_account_number_1))),
                                      Acctno, fragment_value), Acctno, fragment_value),
                                DATASET([], _rin_Layout.fragment_w_value_recs));

  ds_bankaccount2_elements := IF(ds_recs_in[1].bank_account_number <> '', 
                                DEDUP(SORT(PROJECT(ds_payload, TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                 SELF.Acctno := LEFT.Acctno,
                                                                 SELF.fragment := Fragment_Types_const.BANK_ACCOUNT_NUMBER_FRAGMENT,
                                                                 SELF.fragment_value := IF(LEFT.bank_routing_number_2 <> '', TRIM(LEFT.bank_routing_number_2), ' ') + 
                                                                                           _Constants.FRAGMENT_SEPARATOR + 
                                                                                           TRIM(LEFT.bank_account_number_2))),
                                      Acctno, fragment_value), Acctno, fragment_value),
                                DATASET([], _rin_Layout.fragment_w_value_recs));

  ds_DL_elements := IF(ds_recs_in[1].dl_number <> '',
                        DEDUP(SORT(PROJECT(ds_payload(drivers_license <> ''), TRANSFORM(_rin_Layout.fragment_w_value_recs,
                                                                                SELF.Acctno := LEFT.Acctno,
                                                                                SELF.fragment := Fragment_Types_const.DRIVERS_LICENSE_NUMBER_FRAGMENT,
                                                                                SELF.fragment_value := TRIM(LEFT.drivers_license) + _Constants.FRAGMENT_SEPARATOR + TRIM(LEFT.Drivers_License_State))),
                              Acctno, fragment_value), Acctno, fragment_value),
                        DATASET([], _rin_Layout.fragment_w_value_recs));
                        
  ds_fragment_recs_w_value := ds_person_elements + ds_addresss_elements + ds_ssn_elements + ds_phone_elements + 
                              ds_email_elements + ds_ipaddress_elements + ds_bankaccount1_elements + ds_bankaccount2_elements +
                              ds_DL_elements;                              
  
  RETURN ds_fragment_recs_w_value;
 END;

 EXPORT getAnalyticsUID(DATASET(_rin_Layout.fragment_w_value_recs) ds_entity_rolled) := FUNCTION

  Entity_Type_Identifier := _Constants.KelEntityIdentifier;

  ds_entityNameValue := PROJECT(ds_entity_rolled,TRANSFORM(_rin_Layout.entity_uid_recs, SELF := LEFT));

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
  return REGEXREPLACE(_Constants.FRAGMENT_SEPARATOR ,address,', ');
 END;

 EXPORT GetCleanFragmentValue(string FragmentValue, integer pos) := FUNCTION
  return REGEXFIND('(.*)' + _Constants.FRAGMENT_SEPARATOR + '(.*)$',FragmentValue, pos);
 END;

 EXPORT IsValidInputDate(iesp.share.t_Date date) := FUNCTION
  date_int := iesp.ECL2ESP.DateToInteger(date);
  return STD.Date.IsValidDate(date_int) OR date_int = 0;
 END;
 
 EXPORT GetFormatted_IP (string octet) := FUNCTION
  Len := length(trim(octet, all));
  append_zero := MAP(Len = 0 => _Constants.IP_ADDRESS_ELEMENT.APPEND_THREE_ZERO, 
                     Len = 1 => _Constants.IP_ADDRESS_ELEMENT.APPEND_TWO_ZERO,
                     Len = 2 => _Constants.IP_ADDRESS_ELEMENT.APPEND_ONE_ZERO,
                     '');
  out := trim(append_zero) + octet;
  return out;
 END;


END;