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

  //TODO: Rework Gateway Soapcall here to return a single row instead of a dataset.
  //There will only be a single response, having a dataset complicates it for no reason.
  ds_ems_soap_response := IF(make_gateway_call, Gateway.SoapCall_EquifaxEms(ds_gateway_request, in_mod.gateways, make_gateway_call));
  ems_response_first_row := ds_ems_soap_response[1].response;

  //Get royalties from vendor gateway response.
  royalties := Royalty.RoyaltyEquifaxEMS.GetRoyalties(ems_response_first_row);

  //Check the gateway response for exceptions.
  is_gateway_response_okay := make_gateway_call AND ~EXISTS(ems_response_first_row._header.Exceptions);

  //Append lexIDs to each report using that reports PII.
  ds_credit_reports_w_lexIDs := IF(is_gateway_response_okay,
    FCRAGateway_Services.EquifaxEmsAppendLexIDs(ems_response_first_row.EmsResponse.CreditReports, user));

  //All lexIDs from the reports' PII must match in order to return the PDF report.
  //This is due to the base64 encoded PDF being generated by the vendor, we cannot modify this file.
  has_lexID_mismatch := make_gateway_call AND EXISTS(ds_credit_reports_w_lexIDs(resolved_lexID <> input_lexID));

  //Since all lexIDs from the gateway output must match, we can grab one or set it to 0.
  output_lexID := IF(is_gateway_response_okay AND ~has_lexID_mismatch, ds_credit_reports_w_lexIDs[1].resolved_lexID, 0);

  validation_code := MAP(
    is_suppressed_by_alert => FCRAGateway_Services.Constants.ValidationCode.NO_CALL,
    ems_response_first_row._header.status = FCRAGateway_Services.Constants.GatewayStatus.ERROR
      => FCRAGateway_Services.Constants.ValidationCode.INVALID_RESPONSE,
    has_lexID_mismatch => FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH,
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

  RL_In := Project(ds_credit_reports_w_lexIDs(resolved_lexID <> input_lexID),ip_op_to_remote_linking(Left, COUNTER));

  RL_resp := IF(validation_code = FCRAGateway_Services.Constants.ValidationCode.DID_MISMATCH or
                validation_code = FCRAGateway_Services.Constants.ValidationCode.INPUT_DID_NOTFOUND or
                validation_code = FCRAGateway_Services.Constants.ValidationCode.OUTPUT_DID_NOTFOUND,
                Gateway.SoapCall_RemoteLinking_Batch(RL_In, in_mod.gateways));


  //Check if all reports pass Remote linking match
  is_RL_match := EXISTS(RL_resp) AND NOT EXISTS(RL_resp(~match));

  //If RL is a match for all records, its a DID match
  final_validation_code := IF(is_RL_match, FCRAGateway_Services.Constants.ValidationCode.DID_MATCH, validation_code);

  validation_code_desc := FCRAGateway_Services.Constants.GetValidationCodeDesc(final_validation_code);
  validation_ok := FCRAGateway_Services.Functions.IsValidationOk(final_validation_code);

  //Only return report information if our DIDs match, and we have no suppression from credit alerts.
  return_results := validation_ok AND ~is_suppressed_by_alert;

  FCRAGateway_Services.Layouts.equifax_ems.records_out xtOut() := TRANSFORM
    //Always return the header, royalties, gateway status, errors, and DID validation.
    self.response._header := ems_response_first_row._header;
    self.response.emsResponse.errorInfo := ems_response_first_row.emsResponse.errorInfo;
    self.unique_validation := ROW({final_validation_code, validation_code_desc}, iesp.share.t_CodeMap);
    self.Royalties := royalties;

    //If we were able to retrieve consumer data it means we were able to resolve a lexID.
    //Return what we have regardless of the vendor response.
    self.Consumer := consumer;
    self.ConsumerStatements := consumer_statements;
    self.ConsumerAlerts := consumer_alerts;

    //Only return results if we have no suppression from personContext and have a matching input and output lexID.
    self := IF(return_results, ds_ems_soap_response[1]);
    self := [];
  END;

  ds_ems_recs := DATASET([xtOut()]);


  #IF(FCRAGateway_Services.Constants.Debug.EquifaxEmsRecords)
    OUTPUT(ds_compliance_data, NAMED('ds_compliance_data'));
    OUTPUT(ds_gateway_request, NAMED('ds_gateway_request'));
    OUTPUT(ds_ems_soap_response, NAMED('ds_ems_soap_response'));
    OUTPUT(ds_ems_recs, NAMED('ds_ems_recs'));
  #END

  return ds_ems_recs;
END;