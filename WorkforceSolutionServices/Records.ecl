IMPORT AutoStandardI, Gateway, iesp, WorkforceSolutionServices, Royalty, FCRA, STD, FCRAGateway_Services,InsuranceHeader_RemoteLinking, FFD;

EXPORT Records(DATASET(iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest) Input,
                        WorkforceSolutionServices.IParam.report_params InputParams
                      ) := FUNCTION

  in_gateways := Gateway.Configuration.Get();

  lexid_request := PROJECT(Input,WorkforceSolutionServices.transforms.InRequest_to_lexID_Resolution(LEFT,InputParams));

  gw_params := MODULE(PROJECT(AutoStandardI.GlobalModule(TRUE), FCRAGateway_Services.IParam.common_params, opt))
    EXPORT FFDOptionsMask := InputParams.FFDOptionsMask;
    EXPORT FCRAPurpose := InputParams.FCRAPurpose;
    EXPORT DATASET(Gateway.Layouts.Config) gateways := in_gateways;
  END;

  //Retrieve and ensure we can resolve input to a Lexid.
  dville_resp := FCRA.getDidVilleRecords(lexid_request[1]);
  err_code := dville_resp[1]._Header.Status;
  InputDid := IF(err_code = 0, (UNSIGNED6)dville_resp[1].Records[1].UniqueId, 0);

  isFoundInputDid := InputDid > 0;

  //Send Input SSN to Equifax
  OutputFromEquifax := IF(isFoundInputDid,WorkforceSolutionServices.getVerificationDataFromEquifax(Input, InputParams, isFoundInputDid, in_gateways));

  //Error codes are sent in 2 places.
  SignonMsgs_StatusCode := OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Code;
  SignonMsgs_StatusMessage := OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Message;

  TsVTwnSelectTrnRs_StatusCode := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.Status.Code;
  TsVTwnSelectTrnRs_StatusMessage := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.Status.Message;
  useSignon := TRIM(SignonMsgs_StatusCode,LEFT,RIGHT) <> '0';

  EquifaxStatusCode := IF(useSignon,SignonMsgs_StatusCode,TsVTwnSelectTrnRs_StatusCode);
  EquifaxStatusMessage := IF(useSignon,SignonMsgs_StatusMessage,TsVTwnSelectTrnRs_StatusMessage);

  isEquifaxSentData := TRIM(EquifaxStatusCode,LEFT,RIGHT) = '0';
  isEquifaxSentError := ~isEquifaxSentData AND TRIM(EquifaxStatusCode) <>'';

  //Get PII from Equifax for lexID resolution.
  dsResponseData_pre := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.TsVTwnSelectRs.TsVResponseData;

  // Try match PII with an active record if available
  dsResponseData := SORT(dsResponseData_pre,STD.Str.ToUpperCase(TRIM(TsVEmployee_V100.EmployeeStatus.Message))= 'ACTIVE',TsVEmployee_V100.EmployeeStatus.Message);

  isAvailable_EmpRec_1 := isEquifaxSentData AND count(dsResponseData_pre) > 0;

  EmployeeRecord_1 := IF(isAvailable_EmpRec_1, dsResponseData[1].TsVEmployee_V100);

  EmpRec1_lexID_in := PROJECT(EmployeeRecord_1,
                                              WorkforceSolutionServices.transforms.GwEmployee_to_lexID_Resolution(LEFT,InputParams));

  EmpRec_lexID_out := FCRA.getDidVilleRecords(DATASET(EmpRec1_lexID_in)[1]);

  EmpRec1_lexID_out := IF(isAvailable_EmpRec_1, EmpRec_lexID_out[1]);

  //Didville will return a header message if there are errors.
  is_emprec_plist_ok := EmpRec1_lexID_out._header.message = '' AND EmpRec1_lexID_out.SubjectTotalCount=1;
  //Find DID for Output PII
  OutputDID := IF(is_emprec_plist_ok,
    (UNSIGNED)(EmpRec1_lexID_out.Records[1].UniqueId),0);
  isFoundOutputDid := OutputDID > 0;

  // not sure if that is correct criteria:
  noEqEmploymentData := ~isEquifaxSentError AND ~isAvailable_EmpRec_1;

  validation_code := WorkforceSolutionServices.Constants.ValidationCode;
  //Query Status Code
  StatusCode := MAP( ~isFoundInputDid => validation_code.INPUT_DID_NOTFOUND,
    // is_suppressed_by_alert => validation_code.NO_CALL,
    isEquifaxSentError => validation_code.INVALID_RESPONSE,
    ~isFoundOutputDid => validation_code.OUTPUT_DID_NOTFOUND,
    (InputDid <> OutputDid) => validation_code.DID_MISMATCH,
    (InputDid = OutputDid) AND isFoundInputDid => validation_code.DID_MATCH,
    validation_code.NONE);

  // Check if the status code is Did_Mismatch and go for an additional check with remote linking
  InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch ip_op_to_remote_linking(
          ) := TRANSFORM

          toUpper := STD.Str.ToUpperCase;
          inquiry_subject := lexid_request[1].Searchby;
          response_subject := EmployeeRecord_1;

          SELF.ReferenceId := 1;
          //Lexids
          SELF.Inquiry_Lexid := InputDid;
          SELF.Results_Lexid := OutputDid;

          //Inquiry Input data
          SELF.SSN_Inq := INTFORMAT((INTEGER)inquiry_subject.SSN, 9, 1);
          SELF.DOB_Inq := STD.Date.DateFromParts(inquiry_subject.DOB.Year,inquiry_subject.DOB.Month,inquiry_subject.DOB.Day);

          SELF.FNAME_Inq := toUpper(inquiry_subject.Name.First);
          SELF.MNAME_Inq := toUpper(inquiry_subject.Name.Middle);
          SELF.LNAME_Inq := toUpper(inquiry_subject.Name.Last);
          SELF.PRIM_NAME_Inq := toUpper(inquiry_subject.Address.StreetName);
          SELF.SEC_RANGE_Inq := toUpper(inquiry_subject.Address.UnitNumber);
          SELF.CITY_Inq := toUpper(inquiry_subject.Address.City);
          SELF.ST_Inq := toUpper(inquiry_subject.Address.State);
          SELF.ZIP_Inq := toUpper(inquiry_subject.Address.Zip5);

          //Equifax Output Data
          SELF.SSN_Res := INTFORMAT((INTEGER)response_subject.SSN, 9, 1);
          SELF.DOB_Res:= STD.Date.DateFromParts(response_subject.DtBirth.Year,response_subject.DtBirth.Month,response_subject.DtBirth.Day);
          SELF.FNAME_Res := toUpper(response_subject.FirstName);
          SELF.MNAME_Res := toUpper(response_subject.MiddleName);
          SELF.LNAME_Res := toUpper(response_subject.LastName);
          SELF.PRIM_NAME_Res := toUpper(response_subject.Address1);
          SELF.SEC_RANGE_Res := toUpper(response_subject.Address2);
          SELF.CITY_Res := toUpper(response_subject.City);
          SELF.ST_Res := toUpper(response_subject.State);
          SELF.ZIP_Res := toUpper(response_subject.PostalCode);

          SELF := [];
      END;

  RL_inp := DATASET([ip_op_to_remote_linking()]);
  RL_resp := IF(StatusCode = validation_code.DID_MISMATCH OR StatusCode = validation_code.OUTPUT_DID_NOTFOUND,
    Gateway.SoapCall_RemoteLinking_Batch(RL_inp, in_gateways));

  is_RL_match := RL_resp[1].match;

  StatusCode_Fin := IF(is_RL_match, validation_code.DID_MATCH,StatusCode);

  isSuccess := StatusCode_Fin = validation_code.DID_MATCH ;

  //Retrieve consumer alerts, consumer statements, and ensure we are using the best Lexid in case of Remote Linking match.
  consumer_ip_did := IF(is_RL_match, RL_resp[1].best_lexID , InputDid);

  consumer:= FFD.MAC.PrepareConsumerRecord((STRING)consumer_ip_did, TRUE, lexid_request[1].searchby);

  isReseller := TRUE;

  CIA_data := FFD.ConsumerInitiatedActivities.Get(consumer_ip_did,gw_params.FFDOptionsMask, gw_params.FCRAPurpose, gw_params.gateways,
                                            FFD.Constants.DataGroupSet.Person, isReseller);



  is_suppressed_by_alert := CIA_data[1].suppress_records;

  consumer_alerts := CIA_data[1].ConsumerAlerts;
  Consumer_Statements := CIA_data[1].ConsumerStatements;

  //Only return report information if our Lexids match, and we have no suppression from consumer alerts.
  return_results := isSuccess AND ~is_suppressed_by_alert ;
  //Only return consumer data if we have a valid lexID match or suppress due alerts or no employment data returned by gateway.
  return_consumer_data := isFoundInputDid AND (is_suppressed_by_alert OR noEqEmploymentData OR isSuccess);

  //Calculate Royalty
  royal_out_voe := IF(isFoundInputDid ,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOE(isEquifaxSentData));
  royal_out_voi := IF(isFoundInputDid ,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOI(isEquifaxSentData));

  //Return Royalty almost aslways
  Royalties := IF(InputParams.IncludeIncome,royal_out_voi,royal_out_voe);


  message := STD.STr.RemoveSuffix(TRIM(EquifaxStatusMessage),'.')+' ('+ EquifaxStatusCode +').';
  validation_code_desc := WorkforceSolutionServices.Constants.GetValidationCodeDesc(StatusCode_Fin, message);
  validation_row := ROW(
    TRANSFORM(iesp.share.t_CodeMap,
      SELF.Code := IF(validation_code_desc<>'', (STRING) StatusCode_Fin, ''); // status codes without description are used for internal purpose AND excluded from reporting
      SELF.Description := validation_code_desc;
    ));

  // Prepare the output. If data is blanked makes sure to fill the output message.

  WorkforceSolutionServices.Layouts.record_out xtOut() := TRANSFORM
  //Always return the header, royalties, and DID validation.
    SELF.eq_header := IF(isFoundInputDid AND ~is_suppressed_by_alert ,OutputFromEquifax[1].response._Header); // including exceptions
    SELF.validation := validation_row;
    SELF.Royalty := Royalties;

    //Return consumer data if we don't call gateway due to alerts, or if we do and get a matching lexID or no employement data.
    SELF.LexId := IF(return_consumer_data, consumer_ip_did,0);
    SELF.Consumer := IF(return_consumer_data, consumer);
    SELF.ConsumerStatements := IF(return_consumer_data, consumer_statements);
    SELF.ConsumerAlerts := IF(return_consumer_data, consumer_alerts);

  //Only return results if we have no suppression from personContext and have a matching input and output lexID.
    SELF.GWResponse := IF(return_results, OutputFromEquifax);
    SELF := [];
  END;

  out_row := ROW(xtOut());

/* output(OutputFromEquifax,named('OutputFromEquifax'));
  output(lexid_request,named('lexid_request_input'));
  output(pick_response,named('pick_response_input'));
  output(isFoundInputDid,named('isFoundInputDid'));
  output(isAvailable_EmpRec_1,named('isAvailable_EmpRec_1'));
  output(dsResponseData,named('dsResponseData'));
  output(OutputDID,named('OutputDID')); */


RETURN out_row;
END;
