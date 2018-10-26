IMPORT doxie, dx_InquiryHistory, Gateway, iesp, Data_Services, STD, InquiryHistory;

EXPORT Functions := MODULE

  EXPORT GetDateTimeGMT() := STD.Date.SecondsToString(Std.date.CurrentSeconds(FALSE), '%Y-%m-%d %H:%M:%S');

  EXPORT PerformDeltabaseCall(DATASET(doxie.layout_references) in_dids,
                              DATASET(Gateway.Layouts.Config) in_gateways) := FUNCTION

    dsIHReq := DATASET(1,TRANSFORM(InquiryHistory.Layouts.InquiryHistoryDeltabaseRequest,
                        SELF.SearchBy.LexIds := PROJECT(in_dids, TRANSFORM(iesp.share.t_StringArrayItem,
                                                 SELF.value := (STRING)LEFT.did));
                        SELF        := [];
                    ));

    //  map out the failcode and message to the response if we have a failure in the soapcall. As of now, we aren't
    //  expecting the products to do anything with a soapcall failure because we don't want the products to fail their
    //  transactions if Inquiry History deltabase is unavailable for a short period of time. However, I will trap the error
    //  in the case that we do want to use it for some purpose in the future. Keep in mind, even though the deltabase may
    //  not be available the keys still contain data that Inquiry History can return regardless.

    InquiryHistory.Layouts.InquiryHistoryDeltabaseResponseEx failx() := TRANSFORM
      SELF.response._Header.Exceptions := IF(FAILMESSAGE <> '', DATASET([{'Roxie', FAILCODE,InquiryHistory.Constants.ESP_Method,FAILMESSAGE}],iesp.share.t_WsException));
      SELF.response._Header.Status  := InquiryHistory.Constants.StatusCodes.SOAPError;
      SELF.response._Header.Message := InquiryHistory.Constants.GetStatusMessage(InquiryHistory.Constants.StatusCodes.SOAPError);
      SELF := [];
    END;

    URL := in_gateways(Gateway.Configuration.IsDeltaInquiryHistory(servicename))[1].URL;

    dsSoapRes := SOAPCALL(dsIHReq,
                          URL,
                          InquiryHistory.Constants.ESP_Method,
                          InquiryHistory.Layouts.InquiryHistoryDeltabaseRequest,
                          TRANSFORM(InquiryHistory.Layouts.InquiryHistoryDeltabaseRequest, SELF := LEFT),
                          DATASET(InquiryHistory.Layouts.InquiryHistoryDeltabaseResponseEx),
                          XPATH(InquiryHistory.Constants.ResultStructure),
                          RETRY(InquiryHistory.Constants.SOAPCallRetry),
                          TIMEOUT(InquiryHistory.Constants.SOAPWaitTime),
                          TRIM);

    dsSoapOut := PROJECT(dsSoapRes, TRANSFORM(InquiryHistory.Layouts.InquiryHistoryDeltabaseResponseEx,
                              _error_code := LEFT.response._Header.Status;
                              _error_msg  := LEFT.response._Header.Message;
                              SELF.response._Header.Status := IF(_error_code <> 0, ERROR(_error_code, _error_msg), 0);
                              SELF.response._Header.Message := IF(_error_code <> 0, _error_msg, '');
                              SELF := LEFT));

     dsIHDBOut := CATCH(dsSoapOut, ONFAIL(failx()));

     dsIHDB := IF(EXISTS(in_dids(did>0)), dsIHDBOut[1]);

     RETURN dsIHDB;

  END;//PerformDeltabaseCall

  EXPORT GetIHPayloadData(DATASET(doxie.layout_references) in_dids, BOOLEAN isFCRA = FALSE) := FUNCTION
    _env := IF(isFCRA, Data_Services.data_env.iFCRA, Data_Services.data_env.iNonFCRA);

    //perform a join only on LexID key to get all matches that match the search LexID.
    lexid_group_rids := JOIN(in_dids, dx_InquiryHistory.Key_Lexid(_env),
                          KEYED(LEFT.did = RIGHT.appended_did),
                          TRANSFORM(RIGHT), KEEP(InquiryHistory.Constants.MaxIHperLexId), LIMIT(0));

    ih_payload_final := JOIN(lexid_group_rids, dx_InquiryHistory.Key_Group_RID(_env),
                          KEYED(LEFT.group_rid = RIGHT.group_rid),
                          TRANSFORM(InquiryHistory.Layouts.inquiry_history_rec,
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
                            SELF:=[]),
                          KEEP(InquiryHistory.Constants.MaxIHperLexId),LIMIT(0));

    RETURN ih_payload_final;
  END;      

END;