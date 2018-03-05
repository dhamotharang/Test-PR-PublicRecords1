Import Gateway, iesp, WorkforceSolutionServices, Royalty, FCRA, FFD, Doxie, BatchShare;

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
		dsResponseData := OutputFromEquifax[1].Response.EvsResponse.TsVerMsgsRsV1.TsVTwnSelectTrnRs.TsVTwnSelectRs.TsVResponseData;

		EquifaxStatusCode :=  OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Code;
		EquifaxStatusMessage := OutputFromEquifax[1].Response.EvsResponse.SignonMsgsRsV1.SonRs.Status.Message;

		isEquifaxSentData :=  trim(EquifaxStatusCode,LEFT,RIGHT) = '0';
		isEquifaxSentError := ~isEquifaxSentData;

		isAvailable_EmpRec_1 := count(dsResponseData) > 0 and isEquifaxSentData;
		isAvailable_EmpRec_2 := count(dsResponseData) > 1 and isEquifaxSentData;

		EmployeeRecord_1 := if(isAvailable_EmpRec_1, dsResponseData[1].TsVEmployee_V100);
		EmployeeRecord_2 := if(isAvailable_EmpRec_2, dsResponseData[2].TsVEmployee_V100);

		EmpRec1_picklist_in := project(EmployeeRecord_1,
													WorkforceSolutionServices.transforms.GwEmployee_to_Picklist(left,InputParams));

		EmpRec1_picklist_out := doxie.get_remote_picklist (dataset(EmpRec1_picklist_in), gateways);

		OutputDID_1 := if(isAvailable_EmpRec_1 and EmpRec1_picklist_out[1].SubjectTotalCount = 1,
									(unsigned)EmpRec1_picklist_out[1].Records[1].UniqueId,0);
									
		EmpRec2_picklist_in :=	project(EmployeeRecord_2,WorkforceSolutionServices.transforms.GwEmployee_to_Picklist(left,InputParams));																												 														
		EmpRec2_picklist_out := doxie.get_remote_picklist (dataset(EmpRec1_picklist_in), gateways);

		OutputDID_2 := if(isAvailable_EmpRec_2 and EmpRec2_picklist_out[1].SubjectTotalCount = 1,
									(unsigned)EmpRec2_picklist_out[1].Records[1].UniqueId,0);

		//Find DID for Output PII
		OutputDID :=  map( isAvailable_EmpRec_1 and isAvailable_EmpRec_2 and OutputDID_1 = OutputDID_2 => OutputDID_1,
											 isAvailable_EmpRec_1 and ~isAvailable_EmpRec_2  and OutputDID_1 <> 0  => OutputDID_1,
										0 
								);
		isFoundOutputDid := OutputDID <> 0;

		//Query Status Code
		StatusCode := map(	isEquifaxSentError => 4,
												~isFoundInputDid => 1,
												~isFoundOutputDid => 2,
												(isFoundInputDid and isFoundOutputDid and InputDid <> OutputDid) => 3, 
												(InputDid = OutputDid) and isFoundInputDid = true => 0,
											5);
									
		//Return only success & Equifax Failure 
		isReturnResults := StatusCode = 0 or StatusCode = 4;

		GatewayResponse := if(isReturnResults,OutputFromEquifax);

		//Fetch Consumer Level Statements
		boolean isShowConsumerStatements := isFoundInputDid and FFD.FFDMask.isShowConsumerStatements(InputParams.FFDOptionsMask);	 
		ConsumerStatements := if(isShowConsumerStatements, 
												    WorkforceSolutionServices.functions.fetchConsumerStatementsForDID(InputDid, gateways));

		//Calculate Royalty

		royal_out_voe := if(isEquifaxSentData,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOE());
		royal_out_voi := if(isEquifaxSentData,Royalty.RoyaltyEquifaxEVS.GetOnlineRoyaltiesVOI());	 

		Royalties  :=  if(InputParams.IncludeIncome,royal_out_voi,royal_out_voe);


		//Exceptions 
		GatewayExceptions := OutputFromEquifax[1].response._Header.Exceptions ;
		AllExceptions := 	GatewayExceptions;

		//Response Header 
		r := iesp.ECL2ESP.GetHeaderRow();
		validation_row := row(r, 
										transform(iesp.share.t_CodeMap,
															self.Code := (string) StatusCode;
															self.Description := WorkforceSolutionServices.functions.StatusMessages(StatusCode,EquifaxStatusCode +':'+ EquifaxStatusMessage);
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