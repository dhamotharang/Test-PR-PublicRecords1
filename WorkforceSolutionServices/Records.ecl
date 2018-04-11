Import Gateway, iesp, WorkforceSolutionServices, Royalty, FCRA, FFD, Doxie, BatchShare, STD;

EXPORT Records(dataset(iesp.employment_verification_fcra.t_FcraVerificationOfEmploymentReportRequest) Input,
							 WorkforceSolutionServices.IParam.report_params	InputParams
							) := function

		gateways := Gateway.Configuration.Get();

		pick_request := project(Input,WorkforceSolutionServices.transforms.InRequest_to_picklist(left,InputParams)); 
		pick_response := doxie.get_remote_picklist (pick_request, gateways);	

		InputDid := if (pick_response[1].SubjectTotalCount = 1, (integer) pick_response.Records[1].UniqueId, 0);

		isFoundInputDid := InputDid <> 0; 
		makeGatewayCall := isFoundInputDid; // just to be on the extra safe side, in case IF below decides to act out.

		//Send Input SSN to Equifax
		OutputFromEquifax := if(isFoundInputDid, WorkforceSolutionServices.getVerificationDataFromEquifax(Input, InputParams, makeGatewayCall, gateways));

		//Get PII from Equifax
		dsResponseData_pre := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.TsVTwnSelectRs.TsVResponseData;
		
		// Try match PII with an active record if available
		dsResponseData := sort(dsResponseData_pre,STD.Str.ToUpperCase(trim(TsVEmployee_V100.EmployeeStatus.Message))= 'ACTIVE',TsVEmployee_V100.EmployeeStatus.Message);
		
		//Error codes are sent in 2 places. 
		SignonMsgs_StatusCode :=  OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Code;		
		SignonMsgs_StatusMessage := OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Message;		
		
		TsVTwnSelectTrnRs_StatusCode :=  OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.Status.Code;		
		TsVTwnSelectTrnRs_StatusMessage := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.Status.Message;				
		useSignon := trim(SignonMsgs_StatusCode,LEFT,RIGHT) <> '0'; 				
		
		EquifaxStatusCode := if(useSignon,SignonMsgs_StatusCode,TsVTwnSelectTrnRs_StatusCode);		
		EquifaxStatusMessage := if(useSignon,SignonMsgs_StatusMessage,TsVTwnSelectTrnRs_StatusMessage);

		isEquifaxSentData :=  trim(EquifaxStatusCode,LEFT,RIGHT) = '0';
		isEquifaxSentError := ~isEquifaxSentData;

		isAvailable_EmpRec_1 := count(dsResponseData) > 0 and isEquifaxSentData;

		EmployeeRecord_1 := if(isAvailable_EmpRec_1, dsResponseData[1].TsVEmployee_V100);

		EmpRec1_picklist_in := project(EmployeeRecord_1,
													WorkforceSolutionServices.transforms.GwEmployee_to_Picklist(left,InputParams));

		EmpRec1_picklist_out := doxie.get_remote_picklist (dataset(EmpRec1_picklist_in), gateways);

		OutputDID_1 := if(isAvailable_EmpRec_1 and EmpRec1_picklist_out[1].SubjectTotalCount = 1,
									(unsigned)EmpRec1_picklist_out[1].Records[1].UniqueId,0);
									

		//Find DID for Output PII
		OutputDID :=  if(isAvailable_EmpRec_1,OutputDID_1,0);
		
		isFoundOutputDid := OutputDID <> 0;

		//Query Status Code
		StatusCode := map(	~isFoundInputDid => 1,
												isEquifaxSentError => 4,
												~isFoundOutputDid => 2,
												(isFoundInputDid and isFoundOutputDid and InputDid <> OutputDid) => 3, 
												(InputDid = OutputDid) and isFoundInputDid = true => 0,
											5);
									
    isSuccess := StatusCode = 0 ;
		
		//Return data only for success 
		GatewayResponse := if(isSuccess,OutputFromEquifax);

		//Fetch Consumer Level Statements
		boolean isShowConsumerStatements := isSuccess  and FFD.FFDMask.isShowConsumerStatements(InputParams.FFDOptionsMask);	 
		ConsumerStatements := if(isShowConsumerStatements, 
												    WorkforceSolutionServices.functions.fetchConsumerStatementsForDID(InputDid, gateways));

		//Calculate Royalty
		royal_out_voe := if(makeGatewayCall,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOE(isEquifaxSentData));
		royal_out_voi := if(makeGatewayCall,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOI(isEquifaxSentData));	 

		//Return Royalty almost aslways		
		Royalties  :=  if(InputParams.IncludeIncome,royal_out_voi,royal_out_voe);


		//Exceptions 
		GatewayExceptions := OutputFromEquifax[1].response._Header.Exceptions ;
		AllExceptions := 	GatewayExceptions;

		//Response Header 
		r := iesp.ECL2ESP.GetHeaderRow();
		validation_row := row(r, 
										transform(iesp.share.t_CodeMap,
															self.Code := (string) StatusCode;
															self.Description := WorkforceSolutionServices.functions.StatusMessages(StatusCode,EquifaxStatusMessage+'('+ EquifaxStatusCode +').');
															)
										);

		// Prepare the output. If data is blanked makes sure to fill the output message.
		combined := record
			unsigned DID;	
			dataset(iesp.equifax_evs.t_EquifaxEvsResponseEx) GWResponse;
			dataset(iesp.share_fcra.t_ConsumerStatement)Statements; 
			dataset(Royalty.Layouts.Royalty) Royalty;
			iesp.share.t_CodeMap Validation;
		end;
		out_row := row({OutputDID,GatewayResponse,ConsumerStatements,Royalties,validation_row},combined);

/* 		output(OutputFromEquifax,named('OutputFromEquifax'));
   		output(pick_request,named('pick_request_input'));
   		output(pick_response,named('pick_response_input'));
   
   		output(EmpRec2_picklist_in,named('pick_request_equifax'));
   		output(EmpRec2_picklist_out,named('pick_response_equifax'));
   
   		output(isAvailable_EmpRec_1,named('isAvailable_EmpRec_1'));
   		output(isAvailable_EmpRec_2,named('isAvailable_EmpRec_2'));
   		output(isFoundInputDid,named('isFoundInputDid'));
*/


return out_row;
end;