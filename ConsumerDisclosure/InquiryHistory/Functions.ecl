IMPORT $, ConsumerDisclosure, doxie, dx_InquiryHistory, Gateway, iesp, Data_Services, STD;

EXPORT Functions := MODULE

  EXPORT GetDateTimeGMT() := STD.Date.SecondsToString(Std.date.CurrentSeconds(FALSE), '%Y-%m-%d %H:%M:%S');

  EXPORT PerformDeltabaseCall(DATASET(doxie.layout_references) in_dids,
                              DATASET(Gateway.Layouts.Config) in_gateways) := FUNCTION

    $.Layouts.InquiryHistoryDeltabaseRequest x2DeltaBaseRequest() := TRANSFORM
      SELF.SearchBy.LexIds := PROJECT(in_dids, TRANSFORM(iesp.share.t_StringArrayItem, SELF.value := (STRING)LEFT.did));
      SELF := [];
    END;
    dsIHReq := DATASET([x2DeltaBaseRequest()]);

    //  map out the failcode and message to the response if we have a failure in the soapcall. As of now, we aren't
    //  expecting the products to do anything with a soapcall failure because we don't want the products to fail their
    //  transactions if Inquiry History deltabase is unavailable for a short period of time. However, I will trap the error
    //  in the case that we do want to use it for some purpose in the future. Keep in mind, even though the deltabase may
    //  not be available the keys still contain data that Inquiry History can return regardless.

    $.Layouts.InquiryHistoryDeltabaseResponseEx failx() := TRANSFORM
      SELF.response._Header.Exceptions := IF(FAILMESSAGE <> '', DATASET([{'Roxie', FAILCODE,$.Constants.ESP_Method,FAILMESSAGE}],iesp.share.t_WsException));
      SELF.response._Header.Status  := ConsumerDisclosure.Constants.StatusCodes.SOAPError;
      SELF.response._Header.Message := ConsumerDisclosure.Constants.GetStatusMessage(ConsumerDisclosure.Constants.StatusCodes.SOAPError);
      SELF := [];
    END;

    URL := in_gateways(Gateway.Configuration.IsDeltaInquiryHistory(servicename))[1].URL;

    dsSoapRes := SOAPCALL(dsIHReq,
                          URL,
                          $.Constants.ESP_Method,
                          $.Layouts.InquiryHistoryDeltabaseRequest,
                          TRANSFORM($.Layouts.InquiryHistoryDeltabaseRequest, SELF := LEFT),
                          DATASET($.Layouts.InquiryHistoryDeltabaseResponseEx),
                          XPATH($.Constants.ResultStructure),
                          RETRY($.Constants.SOAPCallRetry),
                          TIMEOUT($.Constants.SOAPWaitTime),
                          TRIM);

    dsSoapOut :=
      PROJECT(dsSoapRes, TRANSFORM($.Layouts.InquiryHistoryDeltabaseResponseEx,
        _error_code := LEFT.response._Header.Status;
        _error_msg  := LEFT.response._Header.Message;
        SELF.response._Header.Status := IF(_error_code <> 0, ERROR(_error_code, _error_msg), 0);
        SELF.response._Header.Message := IF(_error_code <> 0, _error_msg, '');
        SELF := LEFT));

     dsIHDBOut := CATCH(dsSoapOut, ONFAIL(failx()));

     dsIHDB := IF(EXISTS(in_dids(did>0)), dsIHDBOut[1]);

     RETURN dsIHDB;

  END;//PerformDeltabaseCall

  SHARED getGroupRids(DATASET(doxie.layout_references) in_dids, unsigned1 _env) := FUNCTION

    //perform a join only on LexID key to get all matches that match the search LexID.
    group_rids :=
      JOIN(in_dids, dx_InquiryHistory.Key_Lexid(_env),
      KEYED(LEFT.did = RIGHT.appended_did),
      TRANSFORM(RIGHT),
      KEEP($.Constants.MaxIHperLexId), LIMIT(0));

    return group_rids;

  END;

  SHARED getUnencryptedData(DATASET(dx_InquiryHistory.Layouts.i_lexid) lexid_group_rids, UNSIGNED1 _env) := FUNCTION

    unencrypted_data :=
      JOIN(lexid_group_rids, dx_InquiryHistory.Key_Group_RID(_env),
      KEYED(LEFT.group_rid = RIGHT.group_rid),
      TRANSFORM($.Layouts.inquiry_history_rec,
        SELF.group_rid := LEFT.group_rid;
        SELF.UniqueId := LEFT.appended_did,
        SELF.LexId := RIGHT.lex_id,  // string  (as logged)
        SELF.ProductID := LEFT.product_id,
        SELF.TransactionID := LEFT.transaction_id,
        SELF.InquiryDate := RIGHT.inquiry_date,
        SELF.DateAdded := RIGHT.date_added,
        SELF.CustomerNumber := RIGHT.customer_number,
        SELF.CustomerAccount := RIGHT.customer_account,
        SELF.SSN := RIGHT.ssn,
        SELF.DriversLicenseNumber := RIGHT.drivers_license_number,
        SELF.DriversLicenseState := RIGHT.drivers_license_state,
        SELF.NameFirst := RIGHT.name_first,
        SELF.NameLast := RIGHT.name_last,
        SELF.NameMiddle := RIGHT.name_middle,
        SELF.NameSuffix := RIGHT.name_suffix,
        SELF.AddrStreet := RIGHT.addr_street,
        SELF.AddrCity := RIGHT.addr_city,
        SELF.AddrState := RIGHT.addr_state,
        SELF.AddrZip5 := RIGHT.addr_zip5,
        SELF.AddrZip4 := RIGHT.addr_zip4,
        SELF.DOB := RIGHT.dob,
        SELF.TransactionLocation := RIGHT.transaction_location,
        SELF.PPC := RIGHT.ppc,  // new 3-digit permissible purpose code
        SELF.InternalIdentifier := RIGHT.internal_identifier,
        SELF.StateIDNumber := RIGHT.state_id_number,
        SELF.StateIDState := RIGHT.state_id_state,
        SELF.Phone := RIGHT.phone_nbr,
        SELF.EmailAddress := RIGHT.email_addr,
        SELF.IPAddress := RIGHT.ip_address,

        SELF.EU1CustomerNumber := RIGHT.eu1_customer_number,
        SELF.EU1CustomerAccount := RIGHT.eu1_customer_account,
        SELF.EU2CustomerNumber := RIGHT.eu2_customer_number,
        SELF.EU2CustomerAccount := RIGHT.eu2_customer_account,
        SELF.EUCompanyName := RIGHT.eu_company_name,
        SELF.EUAddrStreet := RIGHT.eu_addr_street,
        SELF.EUAddrCity := RIGHT.eu_addr_city,
        SELF.EUAddrState := RIGHT.eu_addr_state,
        SELF.EUAddrZip5 := RIGHT.eu_addr_zip5,
        SELF.EUPhone := RIGHT.eu_phone_nbr,

        SELF.ProductCode := RIGHT.product_code,
        SELF.TransactionType := RIGHT.transaction_type,
        SELF.FunctionName := RIGHT.function_name,
        SELF.CustomerId := RIGHT.customer_id,
        SELF.CompanyId := RIGHT.company_id,
        SELF.GCId := RIGHT.global_company_id,
        SELF.ReportOptions  := RIGHT.report_options;
        SELF:=[]),
      KEEP($.Constants.MaxIHperLexId),LIMIT(0));

    RETURN unencrypted_data;
  END;

  SHARED PerformKeyDecryptionCall (DATASET($.Layouts.EncryptionKeyRequest) Keys,
                                    DATASET(Gateway.layouts.config) gateways) := FUNCTION

    key_decryption_request_layout  := iesp.ws_securelogaccess.t_KeyDecryptionRequest;
    key_decryption_response_layout := iesp.ws_securelogaccess.t_KeyDecryptionResponseEx;

    key_decryption_request_layout keyDecryptionRequest() := TRANSFORM
      SELF.RSAPublicKeyPEM := $.Constants.key_public;
      SELF.Keys := keys;
      SELF := [];
    END;

    dsKeysRequest := DATASET([keyDecryptionRequest()]);

    key_decryption_response_layout failx() := TRANSFORM
      SELF.response._Header.Exceptions := IF(FAILMESSAGE <> '', DATASET([{'Roxie', FAILCODE,$.Constants.ESP_KeyDecryption_Method,FAILMESSAGE}],iesp.share.t_WsException));
      SELF.response._Header.Status  := ConsumerDisclosure.Constants.StatusCodes.SOAPError;
      SELF.response._Header.Message := ConsumerDisclosure.Constants.GetStatusMessage(ConsumerDisclosure.Constants.StatusCodes.SOAPError);
      SELF := [];
    END;

    URL := gateways(Gateway.Configuration.IsKeyDecryptionInquiryHistory(servicename))[1].URL;

    dsSoapRes := SOAPCALL(dsKeysRequest,
                          URL,
                          $.Constants.ESP_KeyDecryption_Method,
                          key_decryption_request_layout,
                          TRANSFORM(key_decryption_request_layout, SELF := LEFT),
                          DATASET(key_decryption_response_layout),
                          XPATH($.Constants.KeyDecryption_ResultStructure),
                          RETRY($.Constants.SOAPCallRetry),
                          TIMEOUT($.Constants.SOAPWaitTime),
                          TRIM);

    dsSoapOut := PROJECT(dsSoapRes, TRANSFORM(key_decryption_response_layout,
                         _error_code := LEFT.response._Header.Status;
                         _error_msg  := LEFT.response._Header.Message;
                         SELF.response._Header.Status := IF(_error_code <> 0, ERROR(_error_code, _error_msg), 0);
                         SELF.response._Header.Message := IF(_error_code <> 0, _error_msg, '');
                         SELF := LEFT));

    dsIHKDOut := CATCH(dsSoapOut, ONFAIL(failx()));
    dsIHKD := IF(EXISTS(keys(EncryptionKey<>'')), dsIHKDOut[1].response);

    Return dsIHKD;

  END;

  SHARED getEncryptedData(DATASET(dx_InquiryHistory.Layouts.i_lexid) lexid_group_rids, UNSIGNED1 _env,
                            DATASET(Gateway.Layouts.Config) in_gateways) := FUNCTION

    encrypted_key_layout := dx_InquiryHistory.Layouts.i_grouprid_encrypted;

    // Encrypted inquiry history data from Roxie Key
    encrypted_data := JOIN(lexid_group_rids, dx_InquiryHistory.Key_Group_RID_Encrypted(_env),
                              KEYED(LEFT.group_rid = RIGHT.group_rid),
                              TRANSFORM(encrypted_key_layout, SELF := RIGHT),
                              KEEP($.Constants.MaxIHperLexId),LIMIT(0));

    encrypted_data_dedup := DEDUP(SORT(encrypted_data, key_group, key_version, key_encrypted), key_group, key_version, key_encrypted);

    ds_keys := PROJECT(encrypted_data_dedup, TRANSFORM($.Layouts.EncryptionKeyRequest,
                             SELF.EncryptionKey := LEFT.key_encrypted,
                             SELF.KeyGroup := LEFT.key_group,
                             SELF.KeyVersion := LEFT.key_version));

    //SOAP call to ESP to get RSAKey
    RSAKeys := PerformKeyDecryptionCall(ds_keys, in_gateways);

    $.Layouts.decrypted_keys decryptKeys($.Layouts.DecryptionEncryptionKeyResponse L) := TRANSFORM
      SELF.key_group := L.KeyGroup;
      SELF.key_version := L.KeyVersion;
      SELF.key_encrypted := L.EncryptionKey;
      SELF.key_decrypted := $.DecryptionFunctions.PythonDecryptRsaPksc_OAEP(L.RSAProtectedKey); // python function to decrypt RSA key
    END;

    keysDecrypted := PROJECT(RSAKeys.Keys, decryptKeys(LEFT));

    $.Layouts.decrypted_xml_rec decryptText(encrypted_key_layout L,$.Layouts.decrypted_keys R) := TRANSFORM
      SELF.group_rid := L.group_rid;
      SELF.report_options := L.report_options;

      // python function to decrypt the encrypted inquiry
      decrypted_text := $.DecryptionFunctions.pythonDecryptAES(R.key_decrypted, L.query_encrypted);
      _row := IF(decrypted_text <> '', FROMXML($.Layouts.decrypted_xml_rec, decrypted_text));
      SELF := _row;
    END;

    data_decrypted := JOIN(encrypted_data, keysDecrypted,
                      LEFT.key_encrypted = RIGHT.key_encrypted,
                      decryptText(LEFT, RIGHT),
                      LEFT OUTER, KEEP(1), LIMIT(0));

    RETURN data_decrypted;

  END;

  EXPORT GetIHPayloadData(DATASET(doxie.layout_references) in_dids, DATASET(Gateway.Layouts.Config) in_gateways,
                          BOOLEAN isFCRA = FALSE) := FUNCTION

    _env := Data_Services.data_env.GetEnvFCRA(isFCRA);

    // get group_rids for the input DID's
    lexid_group_rids := getGroupRids(in_dids, _env);

    unencrypted_data := getUnencryptedData(lexid_group_rids, _env);
    encrypted_data   := getEncryptedData(lexid_group_rids, _env, in_gateways);

    $.Layouts.inquiry_history_rec finalRes($.Layouts.inquiry_history_rec L, $.Layouts.decrypted_xml_rec R) := TRANSFORM
        SELF.SSN := IF(L.ssn = '', R.ssn, L.ssn),
        SELF.DriversLicenseNumber := IF(L.DriversLicenseNumber = '', R.drivers_license_number, L.DriversLicenseNumber),
        SELF.DriversLicenseState := IF(L.DriversLicenseState = '', R.drivers_license_state, L.DriversLicenseState),
        SELF.NameFirst := IF(L.NameFirst = '', R.name_first, L.NameFirst),
        SELF.NameLast := IF(L.NameLast = '', R.name_last, L.NameLast),
        SELF.NameMiddle := IF(L.NameMiddle = '', R.name_middle, L.NameMiddle),
        SELF.NameSuffix := IF(L.NameSuffix = '', R.name_suffix, L.NameSuffix),
        SELF.AddrStreet := IF(L.AddrStreet = '', R.addr_street, L.AddrStreet),
        SELF.AddrCity := IF(L.AddrCity = '', R.addr_city, L.AddrCity),
        SELF.AddrState := IF(L.AddrState = '', R.addr_state, L.AddrState),
        SELF.AddrZip5 := IF(L.AddrZip5 = '', R.addr_zip5, L.AddrZip5),
        SELF.AddrZip4 := IF(L.AddrZip4 = '', R.addr_zip4, L.AddrZip4),
        SELF.DOB := IF(L.dob = '', R.dob, L.dob),
        SELF.StateIDNumber := IF(L.StateIDNumber = '', R.state_id_number, L.StateIDNumber),
        SELF.StateIDState := IF(L.StateIDState = '', R.state_id_state, L.StateIDState),
        SELF.Phone := IF(L.Phone = '', R.phone_nbr, L.Phone),
        SELF.EmailAddress := IF(L.EmailAddress = '', R.email_addr, L.EmailAddress),
        SELF.EUCompanyName := IF(L.EUCompanyName = '', R.eu_company_name, L.EUCompanyName),
        SELF.EUAddrStreet := IF(L.EUAddrStreet = '', R.eu_addr_street, L.EUAddrStreet),
        SELF.EUAddrCity := IF(L.EUAddrCity = '', R.eu_addr_city, L.EUAddrCity),
        SELF.EUAddrState := IF(L.EUAddrState = '', R.eu_addr_state, L.EUAddrState),
        SELF.EUAddrZip5 := IF(L.EUAddrZip5 = '', R.eu_addr_zip5, L.EUAddrZip5),
        SELF.EUPhone := IF(L.EUPhone = '', R.eu_phone_nbr, L.EUPhone),
        SELF.ReportOptions  := IF(L.ReportOptions = '', R.report_options, L.ReportOptions),
        SELF := L;
    END;

    payload_data := JOIN(unencrypted_data, encrypted_data,
                     LEFT.group_rid = RIGHT.group_rid,
                     finalRes(LEFT, RIGHT), LEFT OUTER,
                     KEEP(1),LIMIT(0));

    Return payload_data;

  END;

END;
