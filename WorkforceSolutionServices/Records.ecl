Import AutoStandardI, Gateway, iesp, WorkforceSolutionServices, Royalty, FCRA, STD, FCRAGateway_Services;

EXPORT Records(dataset(iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest) Input,
							 WorkforceSolutionServices.IParam.report_params	InputParams
							) := function

		in_gateways := Gateway.Configuration.Get();

		pick_request := project(Input,WorkforceSolutionServices.transforms.InRequest_to_picklist(left,InputParams)); 
    
		gw_params := module(project(AutoStandardI.GlobalModule(true), FCRAGateway_Services.IParam.common_params, opt)) 
		  export FFDOptionsMask := InputParams.FFDOptionsMask;
		  export FCRAPurpose := InputParams.FCRAPurpose;
		  export dataset(Gateway.Layouts.Config) gateways := in_gateways;
    end; 

    //Retrieve consumer alerts, consumer statements, and ensure we can resolve input to a Lexid.
    ds_compliance_data := FCRAGateway_Services.GetComplianceData(pick_request, gw_params);
    
    InputDid := (unsigned6)ds_compliance_data[1].consumer.lexID;
    is_suppressed_by_alert := ds_compliance_data[1].is_suppressed_by_alert;
    consumer_alerts := ds_compliance_data[1].ConsumerAlerts;
    Consumer_Statements := ds_compliance_data[1].ConsumerStatements;
    consumer := ds_compliance_data[1].Consumer;

		isFoundInputDid := InputDid > 0; 
		makeGatewayCall := isFoundInputDid and ~is_suppressed_by_alert; 

		//Send Input SSN to Equifax
		OutputFromEquifax := if(makeGatewayCall, WorkforceSolutionServices.getVerificationDataFromEquifax(Input, InputParams, makeGatewayCall, in_gateways));

		//Error codes are sent in 2 places. 
		SignonMsgs_StatusCode :=  OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Code;		
		SignonMsgs_StatusMessage := OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Message;		
		
		TsVTwnSelectTrnRs_StatusCode :=  OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.Status.Code;		
		TsVTwnSelectTrnRs_StatusMessage := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.Status.Message;				
		useSignon := trim(SignonMsgs_StatusCode,LEFT,RIGHT) <> '0'; 				
		
		EquifaxStatusCode := if(useSignon,SignonMsgs_StatusCode,TsVTwnSelectTrnRs_StatusCode);		
		EquifaxStatusMessage := if(useSignon,SignonMsgs_StatusMessage,TsVTwnSelectTrnRs_StatusMessage);

		isEquifaxSentData :=  trim(EquifaxStatusCode,LEFT,RIGHT) = '0';
		isEquifaxSentError := makeGatewayCall and ~isEquifaxSentData and TRIM(EquifaxStatusCode) <>'';

		//Get PII from Equifax for picklist
		dsResponseData_pre := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.TsVTwnSelectRs.TsVResponseData;
		
		// Try match PII with an active record if available
		dsResponseData := sort(dsResponseData_pre,STD.Str.ToUpperCase(trim(TsVEmployee_V100.EmployeeStatus.Message))= 'ACTIVE',TsVEmployee_V100.EmployeeStatus.Message);
		
		isAvailable_EmpRec_1 := isEquifaxSentData and count(dsResponseData_pre) > 0;

		EmployeeRecord_1 := if(isAvailable_EmpRec_1, dsResponseData[1].TsVEmployee_V100);

		EmpRec1_picklist_in := project(EmployeeRecord_1,
													WorkforceSolutionServices.transforms.GwEmployee_to_Picklist(left,InputParams));

	  FCRA.MAC_GetPickListRecords(dataset(EmpRec1_picklist_in), EmpRec_picklist_out, TRUE);
    
    EmpRec1_picklist_out := if(isAvailable_EmpRec_1, EmpRec_picklist_out[1]);

	  //Picklist with noFail will return a header message if there are errors.
	  is_emprec_plist_ok :=  EmpRec1_picklist_out._header.message = '' and EmpRec1_picklist_out.SubjectTotalCount=1;
		//Find DID for Output PII
		OutputDID := if(makeGatewayCall and is_emprec_plist_ok,
									(unsigned)EmpRec1_picklist_out.Records[1].UniqueId,0);
									
		isFoundOutputDid := makeGatewayCall and OutputDID > 0;
    
    // not sure if that is correct criteria:
    noEqEmploymentData := makeGatewayCall and ~isEquifaxSentError and ~isAvailable_EmpRec_1;

    validation_code := WorkforceSolutionServices.Constants.ValidationCode;
		//Query Status Code
		StatusCode := map(	~isFoundInputDid => validation_code.INPUT_DID_NOTFOUND,
												is_suppressed_by_alert => validation_code.NO_CALL,
												isEquifaxSentError => validation_code.INVALID_RESPONSE,
												~isFoundOutputDid => validation_code.OUTPUT_DID_NOTFOUND,
												(isFoundInputDid and isFoundOutputDid and InputDid <> OutputDid) => validation_code.DID_MISMATCH, 
												(InputDid = OutputDid) and isFoundInputDid => validation_code.DID_MATCH,
											6);
									
    isSuccess := StatusCode = 0 ;
		
    //Only return report information if our Lexids match, and we have no suppression from consumer alerts.
    return_results := makeGatewayCall and isSuccess;
    //Only return consumer data if we have a valid lexID match or suppress due alerts or no employment data returned by gateway.
    return_consumer_data := isFoundInputDid and (is_suppressed_by_alert or noEqEmploymentData or isSuccess);

		//Return data only for success 
		GatewayResponse := if(return_results,OutputFromEquifax);


		//Calculate Royalty
		royal_out_voe := if(makeGatewayCall,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOE(isEquifaxSentData));
		royal_out_voi := if(makeGatewayCall,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOI(isEquifaxSentData));	 

		//Return Royalty almost aslways		
		Royalties  :=  if(InputParams.IncludeIncome,royal_out_voi,royal_out_voe);


		message := 	STD.STr.RemoveSuffix(trim(EquifaxStatusMessage),'.')+' ('+ EquifaxStatusCode +').';
		validation_row := row(
										transform(iesp.share.t_CodeMap,
															self.Code := (string) StatusCode;
															self.Description := WorkforceSolutionServices.Constants.GetValidationCodeDesc(StatusCode,message);
															)
										);

		// Prepare the output. If data is blanked makes sure to fill the output message.

	WorkforceSolutionServices.Layouts.record_out xtOut() := TRANSFORM
		//Always return the header, royalties, and DID validation.
		self.eq_header := if(makeGatewayCall,OutputFromEquifax[1].response._Header);  // including exceptions
		self.validation := validation_row;
		self.Royalty := Royalties;

		//Return consumer data if we don't call gateway  due to alerts, or if we do and get a matching lexID or no employement data.
		self.LexId :=  IF(return_consumer_data, OutputDID,0);
		self.Consumer :=  IF(return_consumer_data, consumer);
		self.ConsumerStatements := IF(return_consumer_data, consumer_statements);
		self.ConsumerAlerts := IF(return_consumer_data, consumer_alerts);

		//Only return results if we have no suppression from personContext and have a matching input and output lexID.
		self.GWResponse := IF(return_results, GatewayResponse);
		self := [];
	END;

	out_row := row(xtOut());
 /*
 		output(OutputFromEquifax,named('OutputFromEquifax'));
		output(pick_request,named('pick_request_input'));
   	output(pick_response,named('pick_response_input'));
  	output(isFoundInputDid,named('isFoundInputDid'));
   	output(isAvailable_EmpRec_1,named('isAvailable_EmpRec_1'));
   	output(dsResponseData,named('dsResponseData'));
   	output(OutputDID,named('OutputDID'));
 */


return out_row;
end;