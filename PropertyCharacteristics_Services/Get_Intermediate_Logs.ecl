import	iesp,InsuranceContext_iesp,PropertyCharacteristics;

export	Get_Intermediate_Logs(	iesp.property_info.t_PropertyInformationRequest														pRequest,
																dataset(PropertyCharacteristics_Services.Layouts.Payload)									pResponse,
																InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext	pInsContext,
																PropertyCharacteristics_Services.IParam.SearchRecords											pInMod
															)	:=
function
	vTransactionID		:=	pInsContext.Common.TransactionId;
	vReferenceNumber	:=	pInsContext.Common.ReferenceNumber;
	
	// Populate input request data
	dRequest	:=	PropertyCharacteristics_Services.Functions.RequestIntLogging(pRequest.ReportBy,pInMod);
	
	rReqXML_layout	:=
	record
		dataset(PropertyCharacteristics_Services.Layouts.Input)	InputLog;
	end;
	
	// Dummy transform needed for toxml to work so as to display all the request data
	rReqXML_layout	tRequestXML()	:=
	transform
		self.InputLog	:=	dRequest;
	end;
	
	// Create request dataset for logging
	dReqIntLogs	:=	dataset(	[{'Intermediate Request',PropertyCharacteristics_Services.Constants.Version,TOXML(row(tRequestXML())),vTransactionID,PropertyCharacteristics_Services.Constants.ProductID,PropertyCharacteristics_Services.Constants.ProcessType.REQUEST,PropertyCharacteristics_Services.Constants.ProcessingTime,PropertyCharacteristics_Services.Constants.SourceCode,vReferenceNumber}],
														iesp.intermediate_log.t_IntermediateLogRecord
													);
	
	// Create response dataset for logging	
	PropertyCharacteristics_Services.Functions.Mac_Map_SourceID(pResponse,dResponseSlimmed);
	
	rResXML_layout	:=
	record
		dataset(PropertyCharacteristics.Layouts.Base)	PropInfo;
	end;

	rResXML_layout	tResponseXML()	:=
	transform
		self.PropInfo	:=	dResponseSlimmed;
	end;
	
	dResIntLogs	:=	dataset(	[{'Intermediate Results',PropertyCharacteristics_Services.Constants.Version,TOXML(row(tResponseXML())),vTransactionID,PropertyCharacteristics_Services.Constants.ProductID,PropertyCharacteristics_Services.Constants.ProcessType.RESPONSE,PropertyCharacteristics_Services.Constants.ProcessingTime,PropertyCharacteristics_Services.Constants.SourceCode,vReferenceNumber}],
														iesp.intermediate_log.t_IntermediateLogRecord
													);
	
	dCombinedLogs	:=	if(	exists(pResponse),
												dReqIntLogs	+	dResIntLogs,
												dReqIntLogs
											);
	
	// Project it to the final layout to facilitate ESP to correctly to Mbsi
	iesp.intermediate_log.t_IntermediateLogRecords	tFormat2Mbsi(dCombinedLogs	pInput)	:=
	transform
		self.Records	:=	pInput;
	end;
	
	return project(dCombinedLogs,tFormat2Mbsi(left));
end;