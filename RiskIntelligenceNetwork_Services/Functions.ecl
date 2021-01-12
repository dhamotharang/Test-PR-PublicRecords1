IMPORT Address, didville, FraudShared_Services, iesp, RiskIntelligenceNetwork_Services, STD, UT;

EXPORT Functions := MODULE

 SHARED _Constants := RiskIntelligenceNetwork_Services.Constants;
 SHARED Fragment_Types_const := _Constants.Fragment_Types;
 SHARED FRAUD_PLATFORM := _Constants.FRAUD_PLATFORM;
 SHARED _rin_Layout := RiskIntelligenceNetwork_Services.Layouts;
 SHARED _sharedLayout := FraudShared_Services.Layouts;

 EXPORT getPublicRecordsAppends(DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_in,
                                DATASET(DidVille.Layout_Did_OutBatch) ds_best_in,
                                RiskIntelligenceNetwork_Services.IParam.Params params) := FUNCTION

  _PRAppends := RiskIntelligenceNetwork_Services.fn_GetPubRecordAppends(ds_in, params);

  recs_Criminal := _PRAppends.GetCriminal();
  recs_advo := _PRAppends.GetAdvo();
  recs_prepaid_phone := _PRAppends.GetPrepaidPhone();
  recs_dl := _PRAppends.GetDL();
  recs_boca_shell := _PRAppends.GetBocaShell();
  recs_ip_meta_data := _PRAppends.GetIPMetaData();
  
  ds_in_w_crim := JOIN(ds_in, recs_Criminal, 
                    LEFT.acctno = RIGHT.acctno,
                    TRANSFORM(_rin_Layout.realtime_appends_rec, 
                      SELF.batchin_rec := LEFT,
                      SELF.crim_appends := RIGHT,
                      SELF := []),
                    LEFT OUTER);
  
  ds_in_w_advo := JOIN(ds_in_w_crim, recs_advo,
                    LEFT.batchin_rec.acctno = RIGHT.acctno,
                    TRANSFORM(_rin_Layout.realtime_appends_rec, 
                      SELF.advo_appends := RIGHT,
                      SELF := LEFT,
                      SELF := []),
                    LEFT OUTER);
  
  ds_in_w_pr_best := JOIN(ds_in_w_advo, ds_best_in,
                       LEFT.batchin_rec.acctno = (string) RIGHT.seq,
                      TRANSFORM(_rin_Layout.realtime_appends_rec, 
                        SELF.pr_best_appends := RIGHT,
                        SELF := LEFT,
                        SELF := []),
                    LEFT OUTER);
                    
  ds_in_w_prepaid_phone := JOIN(ds_in_w_pr_best, recs_prepaid_phone,
                            LEFT.batchin_rec.acctno = RIGHT.acctno,
                            TRANSFORM(_rin_Layout.realtime_appends_rec, 
                              SELF.prepaid_phone_appends := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                           LEFT OUTER);
                           
  ds_in_w_dl := JOIN(ds_in_w_prepaid_phone, recs_dl,
                  LEFT.batchin_rec.acctno = RIGHT.acctno,
                  TRANSFORM(_rin_Layout.realtime_appends_rec,
                    SELF.dl_appends := RIGHT,
                    SELF := LEFT,
                    SELF := []),
                  LEFT OUTER);
                  
  ds_in_w_boca_shell := JOIN(ds_in_w_prepaid_phone, recs_boca_shell,
                          LEFT.batchin_rec.acctno = (string) RIGHT.seq,
                          TRANSFORM(_rin_Layout.realtime_appends_rec, 
                            SELF.boca_shell_appends := RIGHT,
                            SELF := LEFT,
                            SELF := []),
                          LEFT OUTER);
                          
  ds_in_w_ip_meta_data := JOIN(ds_in_w_boca_shell, recs_ip_meta_data,
                            LEFT.batchin_rec.acctno = RIGHT.acctno,
                            TRANSFORM(_rin_Layout.realtime_appends_rec,
                              SELF.ip_meta_data := RIGHT,
                              SELF := LEFT,
                              SELF := []),
                            LEFT OUTER);

  // output(ds_in, named('ds_in'));
  // output(recs_Criminal, named('recs_Criminal'));
  // output(recs_advo, named('recs_advo'));
  // output(ds_best_in, named('ds_best_in'));
  // output(recs_prepaid_phone, named('recs_prepaid_phone'));
  // output(recs_dl, named('recs_dl'));
  // output(recs_boca_shell, named('recs_boca_shell'));
  // output(recs_ip_meta_data, named('recs_ip_meta_data'));
  // output(ds_in_w_ip_meta_data, named('ds_in_w_ip_meta_data'));

  return ds_in_w_ip_meta_data;
 END;
 
 EXPORT getRealtimePRAppends(DATASET(DidVille.Layout_Did_OutBatch) ds_best_in,
                             RiskIntelligenceNetwork_Services.IParam.Params params) := FUNCTION
                             
  ds_appends_in := PROJECT(ds_best_in,
                    TRANSFORM(_sharedLayout.BatchInExtended_rec,
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
  
  return getPublicRecordsAppends(ds_appends_in, ds_best_in, params);                          
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
 
 EXPORT GetRiskLevel (integer riskindex) := FUNCTION
  RETURN CASE(riskindex,
              3 => 'HIGH',
              2 => 'MEDIUM',
              1 => 'LOW',
              '');
 END;
 
 EXPORT GetDeltabaseLogDataSet (DATASET(FraudShared_Services.Layouts.BatchInExtended_rec) ds_in,
                                RiskIntelligenceNetwork_Services.IParam.Params params) := FUNCTION

  today := STD.Date.CurrentDate(True);
  time := STD.Date.CurrentTime(True);
  today_str :=  intformat(STD.Date.Year(today),4,1)  + '-' + intformat(STD.Date.Month(today),2,1) + '-' + 
                intformat(STD.Date.Day(today),2,1)   + ' ' + intformat(STD.Date.Hour(time),2,1)   + ':' + 
                intformat(STD.Date.Minute(time),2,1) + ':' + intformat(STD.Date.Second(time),2,1);
                  
  RiskIntelligenceNetwork_Services.Layouts.LOG_Deltabase_Layout_Record xform_deltabase_log():= TRANSFORM
    SELF.gc_id := (STRING)params.GlobalCompanyId;
    SELF.client_uid := ds_in[1].CustomerPersonId;
    SELF.case_id := ds_in[1].HouseholdId;    
    SELF.program_name := params.IndustryTypeName;
    SELF.inquiry_reason := params.InquiryReason;
    SELF.inquiry_source := _Constants.INQUIRY_SOURCE;
    SELF.ssn := ds_in[1].ssn;
    SELF.dob := ds_in[1].DOB;
    SELF.lex_id := ds_in[1].did;
    SELF.name_full := TRIM(ut.fn_FormatFullName(ds_in[1].name_last, ds_in[1].name_first, ds_in[1].name_middle) + ' ' + ds_in[1].name_suffix);
    SELF.name_first := ds_in[1].name_first;
    SELF.name_middle := ds_in[1].name_middle;
    SELF.name_last := ds_in[1].name_last;
    SELF.name_suffix := ds_in[1].name_suffix;
    // If StreetAddress is empty, then use the parsed address fields
    Physical_address:= 	IF(ds_in[1].addr = '',
                            Address.Addr1FromComponents(ds_in[1].prim_range, 
                                                        ds_in[1].predir,
                                                        ds_in[1].prim_name, 
                                                        ds_in[1].addr_suffix,
                                                        ds_in[1].postdir,
                                                        ds_in[1].unit_desig,
                                                        ds_in[1].sec_range),
                            STD.Str.CleanSpaces(ds_in[1].addr + ' ' + ds_in[1].p_city_name + ' ' + ds_in[1].st + ' ' +  ds_in[1].z5));			
    SELF.full_address := Physical_address;
    SELF.physical_address := Physical_address;
    SELF.physical_city := ds_in[1].p_city_name;
    SELF.physical_state := ds_in[1].st;
    SELF.physical_zip := ds_in[1].z5;
    SELF.phone := ds_in[1].phoneno;
    SELF.email_address := ds_in[1].email_address;
    SELF.ip_address := ds_in[1].ip_address;
    SELF.device_id := ds_in[1].device_id;
    SELF.bank_routing_number := ds_in[1].bank_routing_number;
    SELF.bank_account_number := ds_in[1].bank_account_number;
    SELF.dl_state := ds_in[1].dl_state;
    SELF.dl_number := ds_in[1].dl_number;
    SELF.geo_lat := ds_in[1].geo_lat;
    SELF.geo_long := ds_in[1].geo_long;    
    SELF.date_added := today_str;
    SELF.file_type := _Constants.PayloadFileTypeEnum.IdentityActivity;  
    SELF.deceitful_confidence := '';
    SELF.user_added := '';
    SELF.reason_description := params.InquiryReason;
    SELF.event_type_1 := '';
    SELF.event_entity_1 := '';
    SELF.context_uid := '';
    SELF := [];
  END;  
  
  deltabase_inquiry_log_records := DATASET([xform_deltabase_log()]);
  RiskIntelligenceNetwork_Services.Layouts.LOG_Deltabase_Layout xForm_get_records(RiskIntelligenceNetwork_Services.Layouts.LOG_Deltabase_Layout_Record L) := TRANSFORM
    SELF.records := deltabase_inquiry_log_records; 
  END;

  deltabase_inquiry_log := PROJECT(deltabase_inquiry_log_records,xForm_get_records(LEFT));
  RETURN deltabase_inquiry_log;
 END;

 EXPORT GetElementType (integer element_type) := FUNCTION
 
  RETURN CASE(element_type,
              _Constants.EntityType.LEXID => _Constants.Fragment_Types.PERSON_FRAGMENT,
              _Constants.EntityType.PHYSICAL_ADDRESS => _Constants.Fragment_Types.PHYSICAL_ADDRESS_FRAGMENT,
              _Constants.EntityType.SSN => _Constants.Fragment_Types.SSN_FRAGMENT,
              _Constants.EntityType.PHONENO => _Constants.Fragment_Types.PHONE_FRAGMENT,
              _Constants.EntityType.EMAIL => _Constants.Fragment_Types.EMAIL_FRAGMENT,
              _Constants.EntityType.IPADDRESS => _Constants.Fragment_Types.IP_ADDRESS_FRAGMENT,
              _Constants.EntityType.BANKACCOUNT => _Constants.Fragment_Types.BANK_ACCOUNT_NUMBER_FRAGMENT,
              _Constants.EntityType.DLNUMBER => _Constants.Fragment_Types.DRIVERS_LICENSE_NUMBER_FRAGMENT,
              '');
 END;
 
 EXPORT hasValue(string s1) := FUNCTION
  RETURN s1 != '';
 END;
 

END;