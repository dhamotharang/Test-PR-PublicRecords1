IMPORT iesp, Gateway, FCRAGateway_Services, Royalty, InsuranceHeader_RemoteLinking, STD;

EXPORT EquifaxEms_Records(dataset(iesp.mergedcreditreport_fcra.t_FcraMergedCreditReportRequest) in_req, FCRAGateway_Services.IParam.common_params in_mod) :=  FUNCTION

  //Create user param from in_mod to use for lexID resolution.
  //Use existing TuFraudAlert transform for now.
  user := ROW(FCRAGateway_Services.TuFraudAlert_Transforms.in_mod_to_user(in_mod));

  //Create lexID resoultion request from input PII. Layout is named picklist, but using didville.
  //Do not want to modify iesp attribute at this time.
  ds_lexID_req := project(in_req, TRANSFORM(iesp.person_picklist.t_PersonPickListRequest,
    SELF.User := user,
    SELF.SearchBy := LEFT.ReportBy.Consumer, SELF := LEFT, SELF := []));

  //Retrieve credit alerts, consumer statements, freeze information, and ensure we can resolve to a did.
  ds_compliance_data := FCRAGateway_Services.GetComplianceData(ds_lexID_req, in_mod);
  input_lexID := (unsigned6)ds_compliance_data[1].consumer.lexID;
  is_suppressed_by_alert := ds_compliance_data[1].is_suppressed_by_alert;
  consumer_alerts := ds_compliance_data[1].ConsumerAlerts;
  consumer_statements := ds_compliance_data[1].ConsumerStatements;
  consumer := ds_compliance_data[1].Consumer;


  //Transform the transactional ESP request to the gateway ESP format.
  //GatewayParams is filled out in the function.
  ds_gateway_request := PROJECT(in_req, TRANSFORM(iesp.equifax_ems.t_EquifaxEmsRequest,
    SELF.SearchBy := LEFT.ReportBy;
    SELF.SearchBy.Account := LEFT.ReportBy.AccountInfo;
    SELF.SearchBy.Requestor := LEFT.ReportBy.VendorInfo;
    SELF.SearchBy.IncludeEquifax := LEFT.Options.IncludeEquifax;
    SELF.SearchBy.IncludeTransunion := LEFT.Options.IncludeTransunion;
    SELF.SearchBy.IncludeExperian := LEFT.Options.IncludeExperian;
    SELF := LEFT;
    SELF := [];
  ));

  //Call the credit gateway if we are allowed. (no suppression by credit alerts)
  make_gateway_call :=  NOT is_suppressed_by_alert;

  ems_soap_response := IF(make_gateway_call, Gateway.SoapCall_EquifaxEms(ds_gateway_request, in_mod.gateways, make_gateway_call));

  // no of bureaus returned from initial gateway response
  no_of_bureaus := COUNT(ems_soap_response.EmsResponse.CreditReports);

  // set of bureaus returned from vendor gateway
  initial_bureaus_set := SET(ems_soap_response.EmsResponse.CreditReports, SourceBureau);

  // no of bureaus with a Lock or Freeze
  no_of_bureaus_locked := COUNT(ems_soap_response.EmsResponse.CreditReports(LockFound or FreezeFound));

  // check if all bureaus has credit freeze or lock
  isCompleteFreeze := no_of_bureaus = no_of_bureaus_locked;

  // number of bureaus with no lock/freeze
  no_lf_bureaus_count := COUNT(ems_soap_response.EmsResponse.CreditReports(~LockFound AND ~FreezeFound));

  //Get royalties from vendor gateway response.
  royalties := Royalty.RoyaltyEquifaxEMS.GetRoyalties(ems_soap_response);

  //Check the gateway response for exceptions.
  is_gateway_response_okay := make_gateway_call AND ~EXISTS(ems_soap_response._header.Exceptions);

  // Filter out bureaus with lock/freeze and Append lexIDs to each report using that reports PII.
  ds_credit_reports_w_lexIDs := IF(is_gateway_response_okay and ~isCompleteFreeze,
    FCRAGateway_Services.EquifaxEmsAppendLexIDs(ems_soap_response.EmsResponse.CreditReports(~LockFound AND ~FreezeFound), user));

  ds_mismatched_credit_reports := ds_credit_reports_w_lexIDs(resolved_lexID <> input_lexID);

  has_lexID_mismatch := make_gateway_call AND EXISTS(ds_mismatched_credit_reports);

  //Since all lexIDs from the gateway output must match, we can grab one or set it to 0.
  output_lexID := IF(is_gateway_response_okay AND ~has_lexID_mismatch, ds_credit_reports_w_lexIDs[1].resolved_lexID, 0);

  validation_code := MAP(
    is_suppressed_by_alert => FCRAGateway_Services.Constants.ValidationCode.NO_CALL,
    ems_soap_response._header.status = FCRAGateway_Services.Constants.GatewayStatus.ERROR
      => FCRAGateway_Services.Constants.ValidationCode.INVALID_RESPONSE,
    has_lexID_mismatch => FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH,
    isCompleteFreeze => FCRAGateway_Services.Constants.ValidationCode.LOCK_AND_FREEZE,
    FCRAGateway_Services.Functions.GetValidationCode(input_lexID, output_lexID));

  // Check if the validation code is Did_Mismatch or Input/output Lexid = 0 and go for an additional check with remote linking
  InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch ip_op_to_remote_linking(
        FCRAGateway_Services.Layouts.equifax_ems.lexID_appended_report L, integer cnt) := TRANSFORM

          toUpper := STD.Str.ToUpperCase;
          inquiry_subject := in_req[1].Reportby.Consumer;
          response_subject := L.BureauBorrower;

          SELF.ReferenceId := cnt;
          //Lexids
          SELF.Inquiry_Lexid	:= input_lexID;
          SELF.Results_Lexid	:= L.resolved_lexID;

          //Inquiry Input data
          SELF.SSN_Inq := INTFORMAT((INTEGER)inquiry_subject.SSN, 9, 1);
          SELF.DOB_Inq := STD.Date.DateFromParts(inquiry_subject.DOB.Year,inquiry_subject.DOB.Month,inquiry_subject.DOB.Day);

          SELF.FNAME_Inq := toUpper(inquiry_subject.Name.First);
          SELF.MNAME_Inq := toUpper(inquiry_subject.Name.Middle);
          SELF.LNAME_Inq := toUpper(inquiry_subject.Name.Last);
          SELF.PRIM_NAME_Inq := toUpper(inquiry_subject.Address.StreetName);
          SELF.PRIM_RANGE_Inq := toUpper(inquiry_subject.Address.StreetNumber);
          SELF.SEC_RANGE_Inq := toUpper(inquiry_subject.Address.UnitNumber);
          SELF.CITY_Inq := toUpper(inquiry_subject.Address.City);
          SELF.ST_Inq := toUpper(inquiry_subject.Address.State);
          SELF.ZIP_Inq := toUpper(inquiry_subject.Address.Zip5);

          //Equifax Output Data
          SELF.SSN_Res := INTFORMAT((INTEGER)response_subject.SSN, 9, 1);
          SELF.DOB_Res:= STD.Date.DateFromParts(response_subject.DOB.Year,response_subject.DOB.Month,response_subject.DOB.Day);
          SELF.FNAME_Res := toUpper(response_subject.Name.First);
          SELF.MNAME_Res := toUpper(response_subject.Name.Middle);
          SELF.LNAME_Res := toUpper(response_subject.Name.Last);
          SELF.PRIM_NAME_Res := toUpper(L.parsed_Address.StreetName);
          SELF.PRIM_RANGE_Res := toUpper(L.parsed_Address.StreetNumber);
          SELF.SEC_RANGE_Res := toUpper(L.parsed_Address.UnitNumber);
          SELF.CITY_Res := toUpper(L.parsed_Address.City);
          SELF.ST_Res := toUpper(L.parsed_Address.State);
          SELF.ZIP_Res := toUpper(L.parsed_Address.Zip5);

          SELF := [];
      END;

  RL_In := Project(ds_mismatched_credit_reports,ip_op_to_remote_linking(Left, COUNTER));

  RL_resp := IF(validation_code = FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH or
                validation_code = FCRAGateway_Services.Constants.ValidationCode.INPUT_DID_NOTFOUND or
                validation_code = FCRAGateway_Services.Constants.ValidationCode.OUTPUT_DID_NOTFOUND,
                Gateway.SoapCall_RemoteLinking_Batch(RL_In, in_mod.gateways));


  //Check if all reports pass Remote linking match
  is_RL_match := EXISTS(RL_resp) AND NOT EXISTS(RL_resp(~match));

  // check if there is a partial RL match
  is_RL_partialMatch := EXISTS(RL_resp(~match)) AND COUNT(RL_resp(~match)) < no_lf_bureaus_count;

  // get source bureaus for Remote Linking mismatched lexID's
  {string12 source} getSource(RL_resp L) := TRANSFORM
      SELF.Source :=  ds_mismatched_credit_reports[L.ReferenceId].SourceBureau;
  END;

  partially_mismatched_bureau_set := SET(IF(is_RL_partialMatch, PROJECT(RL_resp(~match), getSource(LEFT))), source);

  // if remote linking has partial match, set flags for vendor gateway retry
  // and construct a retry request with CreditReportId
  IncludeEquifax    := FCRAGateway_Services.Constants.Bureaus.Equifax NOT IN partially_mismatched_bureau_set AND
                       FCRAGateway_Services.Constants.Bureaus.Equifax IN initial_bureaus_set;

  IncludeExperian   := FCRAGateway_Services.Constants.Bureaus.Experian NOT IN partially_mismatched_bureau_set AND
                       FCRAGateway_Services.Constants.Bureaus.Experian IN initial_bureaus_set;

  IncludeTransunion := FCRAGateway_Services.Constants.Bureaus.Transunion NOT IN partially_mismatched_bureau_set AND
                       FCRAGateway_Services.Constants.Bureaus.Transunion IN initial_bureaus_set;

  ds_gateway_retry_request := PROJECT(in_req, TRANSFORM(iesp.equifax_ems.t_EquifaxEmsRequest,
    SELF.SearchBy := LEFT.ReportBy;
    SELF.SearchBy.Account := LEFT.ReportBy.AccountInfo;
    SELF.SearchBy.Requestor := LEFT.ReportBy.VendorInfo;
    SELF.SearchBy.CreditReportId := ems_soap_response.EmsResponse.CreditReportId;
    SELF.SearchBy.IncludeEquifax := IncludeEquifax;
    SELF.SearchBy.IncludeTransunion := IncludeTransunion;
    SELF.SearchBy.IncludeExperian := IncludeExperian;
    SELF := LEFT;
    SELF := [];
  ));

  ems_retry_response := IF(make_gateway_call and is_RL_partialMatch,
                              Gateway.SoapCall_EquifaxEms(ds_gateway_retry_request, in_mod.gateways, make_gateway_call));

  // in case of a partial match replace initial response pdf report with the pdf report from retry response
  iesp.equifax_ems.t_EquifaxEmsResponse finalResp_xform(iesp.equifax_ems.t_EquifaxEmsResponse L) := TRANSFORM
    SELF.EmsResponse.PdfReport := ems_retry_response.EmsResponse.PdfReport;
    SELF := L;
  END;

  final_response := IF(make_gateway_call and is_RL_partialMatch, Project(ems_soap_response, finalResp_xform(LEFT)));

  //If RL is a match for all records, its a DID match
  final_validation_code := IF(is_RL_match or is_RL_partialMatch, FCRAGateway_Services.Constants.ValidationCode.DID_MATCH, validation_code);

  validation_code_desc := FCRAGateway_Services.Constants.GetValidationCodeDesc(final_validation_code);
  validation_ok := FCRAGateway_Services.Functions.IsValidationOk(final_validation_code);

  //Only return report information if our DIDs match, and we have no suppression from credit alerts.
  return_results := (validation_ok OR isCompleteFreeze or is_RL_partialMatch) AND ~is_suppressed_by_alert;

  result := IF(isCompleteFreeze or is_RL_match or validation_ok, ems_soap_response, final_response);

  FCRAGateway_Services.Layouts.equifax_ems.records_out xtOut() := TRANSFORM
    //Always return the header, royalties, gateway status, errors, and DID validation.
    self.response._header := ems_soap_response._header;
    self.response.emsResponse.errorInfo := ems_soap_response.emsResponse.errorInfo;
    self.unique_validation := ROW({final_validation_code, validation_code_desc}, iesp.share.t_CodeMap);
    self.Royalties := royalties;

    //If we were able to retrieve consumer data it means we were able to resolve a lexID.
    //Return what we have regardless of the vendor response.
    self.Consumer := consumer;
    self.ConsumerStatements := consumer_statements;
    self.ConsumerAlerts := consumer_alerts;

    //Only return results if we have no suppression from personContext and
    //if all three bureaus pass LexID check or if all three bureaus has Lock/Freeze on them or
    //if any one of the bureaus pass LexID check
    self.response.emsResponse.BorrowerInputEcho := IF(return_results, result.emsResponse.BorrowerInputEcho);
    self.response.emsResponse.CreditReportId := IF(return_results, result.emsResponse.CreditReportId, '');
    CreditReports := IF(return_results, PROJECT(result.emsResponse.CreditReports,
                             TRANSFORM(FCRAGateway_Services.Layouts.equifax_ems.CreditReportRecord,
                               Code := MAP(
                                 LEFT.LockFound AND LEFT.FreezeFound => FCRAGateway_Services.Constants.ValidationCode.LOCK_AND_FREEZE,
                                 LEFT.LockFound => FCRAGateway_Services.Constants.ValidationCode.LOCK,
                                 LEFT.FreezeFound => FCRAGateway_Services.Constants.ValidationCode.FREEZE,
                                 LEFT.SourceBureau in partially_mismatched_bureau_set => FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH,
                                 FCRAGateway_Services.Constants.ValidationCode.DID_MATCH
                               );
                               Description := FCRAGateway_Services.Constants.GetValidationCodeDesc(Code);
                               bureau_validation := ROW({Code, Description}, iesp.share.t_CodeMap);
                               SELF.Validations := bureau_validation,
                               SELF := LEFT,
                               SELF := [];
                             )));
    self.response.emsResponse.CreditReports := CreditReports;
    self.response.emsResponse.PdfReport := IF(return_results,result.emsResponse.PdfReport, '');
    self := [];
  END;

  ds_ems_recs := DATASET([xtOut()]);

  #IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsRecords)
    OUTPUT(ds_compliance_data, NAMED('ds_compliance_data'));
    OUTPUT(ds_gateway_request, NAMED('ds_gateway_request'));
    OUTPUT(ems_soap_response, NAMED('ems_soap_response'));
    OUTPUT(ds_ems_recs, NAMED('ds_ems_recs'));
  #END

  return ds_ems_recs;
END;
