import Address,iesp,InsuranceContext_iesp, PropertyCharacteristics_Services, Doxie; 

export	Records(	PropertyCharacteristics_Services.IParam.SearchRecords											pInMod,
									InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext	pInsContext,
									iesp.property_info.t_PropertyInformationRequest														pRequest,
									Address.ICleanAddress																											clean_addr
								)	:=
module
  SHARED mod_access := Doxie.compliance.GetGlobalDataAccessModuleTranslated(AutoStandardI.GlobalModule());
  layouts.CleanAddressRec CreateBatchRecord () := transform
		Self.acctno := ''; // this is a formality in case of a single-row request
		Self.prim_range  := clean_addr.prim_range;
		Self.predir      := clean_addr.predir;
		Self.prim_name   := clean_addr.prim_name;
		Self.addr_suffix := clean_addr.suffix;
		Self.postdir     := clean_addr.postdir;
		Self.unit_desig  := clean_addr.unit_desig;
		Self.sec_range   := clean_addr.sec_range;
		Self.p_city_name := clean_addr.p_city;
		Self.st          := clean_addr.state;
		Self.zip         := clean_addr.zip;
		Self.zip4        := clean_addr.zip4;
    self.geo_blk     := clean_addr.geo_blk;
		self.geo_match   := clean_addr.geo_match;
    self.err_stat    := clean_addr.error_msg;
    self.is_cleaned  := clean_addr.error_msg[1] != 'E';
  end;

  // if address was successfully cleaned, get inhouse data
  shared dPropPayload := GetPropertyData (dataset ([CreateBatchRecord()]) (is_cleaned));
	
	//Obtain Lexid
	SHARED Lexid				:= IF(pInMod.ResultOption <> Constants.Default_Option,
                          Get_Lexid(pRequest.ReportBy.Name, pRequest.ReportBy.dob, pRequest.ReportBy.ssn, pRequest.ReportBy.DLNumber, pRequest.ReportBy.DLState, clean_addr),
                          0);
	//Determine if opted out under ccpa
	SHARED IsOptedOut		:= IF(Lexid <> 0, PropertyCharacteristics_Services.Functions.isOptOut(Lexid, mod_access), FALSE);

  // Replicated the batch functionallity.  QB 5501
  dLNPropResultsFiltered := dPropPayload(
    ((pInMod.ReportType = Constants.Inspection_ReportType) AND (pInMod.ResultOption IN [Constants.Default_Option, Constants.Default_Plus_Option]) AND (vendor_source = Constants.Best_CoreLogic_Blacknight)) OR 
    ((pInMod.ReportType = Constants.Property_ReportType) AND pInMod.ResultOption = Constants.Default_Option AND (vendor_source IN [Constants.Blacknight_LocalizedAverages, Constants.CoreLogic]) ) OR 
    ((pInMod.ReportType = Constants.Property_ReportType) AND pInMod.ResultOption = Constants.Default_Plus_Option AND ~IsOptedOut AND (vendor_source IN [Constants.Blacknight_LocalizedAverages, Constants.CoreLogic, Constants.MLS]) ) OR 
    ((pInMod.ReportType = Constants.Property_ReportType) AND pInMod.ResultOption = Constants.Default_Plus_Option AND IsOptedOut AND (vendor_source IN [Constants.Blacknight_LocalizedAverages, Constants.CoreLogic]) ) OR 
    ((pInMod.ResultOption = Constants.Selected_Source_Option) AND ~IsOptedOut AND (vendor_source = Constants.Best_AllSources)) OR
    ((pInMod.ResultOption = Constants.Selected_Source_Option) AND IsOptedOut AND (vendor_source = Constants.Best_All_NoMLS)) OR
    ((pInMod.ResultOption = Constants.Selected_Source_Plus_Option) AND ~IsOptedOut AND (vendor_source IN [Constants.Best_AllSources, Constants.MLS, Constants.CoreLogic, Constants.Blacknight])) OR	
    ((pInMod.ResultOption = Constants.Selected_Source_Plus_Option) AND IsOptedOut AND (vendor_source IN [Constants.Best_All_NoMLS, Constants.CoreLogic, Constants.Blacknight])));	
	
	// back to original layout: "payload" without cleaned address and batch-acctno
	shared inhouse_results := project (dLNPropResultsFiltered, layouts.Payload);

	// validate request, including whether address wasn cleaned properly
	shared combined_err := Functions.GetCombinedErrors (inhouse_results, pRequest, pInMod.ReportType, clean_addr.error_msg[1]	!= 'E');
/* mc
	shared boolean	isValidGatewayCall	:=	pInMod.ReportType	in	['K','L'] and
																					pInMod.RunGateway_ERC			and
																					pInMod.GatewayConfig[1].Url	!=	''	and
																					combined_err = 0;

	// get best inhouse record, which may be needed to fill in gateway request;
	// in case of report=K: if isValidGatewayCall = TRUE, best record is guaranteed to exist
  inhouse_bob := if (pInMod.ReportType = 'K', Functions.GetBestInhouseRecord (inhouse_results, pRequest));

	// Function for getting ERC data from the gateway
	shared	dPropGatewayResponse	:=	if(	isValidGatewayCall,
																				PropertyCharacteristics_Services.Get_ERC_Data(pInMod,pRequest,inhouse_bob, clean_addr)
																			); // returns a row, not a dataset

	shared exceps := dPropGatewayResponse.Response._Header.Exceptions;

	// process errors, appending gateway errors, if any
	iesp.property_info.t_NarrativeARecordReport SetGatewayMessages (iesp.property_value_report.t_PropertyOut L) := transform
		Self.Code := (string) Constants.ErrorCodes.GATEWAY_XML_ERROR;
		Self.Remarks := (string) L.Response.ErrorCode + ': ' + L.Response.Status;
  end;
	dGatewayXMLError := project (dPropGatewayResponse.Response.Result.Report.Properties, SetGatewayMessages (Left));
*/ 
	dCombinedErrors :=	project (Constants.dErrors (combined_err & internal_code = internal_code), iesp.property_info.t_PropertyNarrativeARecordReport)
											// +	dGatewayXMLError
											// +	if(	exists(exceps), dataset([{Constants.ErrorCodes.GATEWAY_EXCEPTION, exceps[1].Message}],iesp.property_info.t_NarrativeARecordReport))
											;

	shared dCombinedErrorsSorted	:=	sort(dCombinedErrors,(unsigned)Code);

	// Remove default data from the property report
	PropertyCharacteristics_Services.Functions.Mac_Remove_Default_Data(inhouse_results, dLNPropRemoveDefaultData);
	
	// Split out source B records from others.
	shared ds_acctno 				:= project (dLNPropRemoveDefaultData, TRANSFORM(layouts.inhouse_layout, SELF.acctno := '', SELF := LEFT));
	export dsFilterB				:= ds_acctno(vendor_source IN [Constants.Blacknight_LocalizedAverages, Constants.Blacknight]);
	export dsFilterOthers		:= ds_acctno(vendor_source IN [Constants.Best_CoreLogic_Blacknight, Constants.CoreLogic, Constants.MLS]);

	// JOIN B and A (and MLS E) records to clear B record DEFLT
	export dsJoinBA := join(dsFilterB, dsFilterOthers, TRUE, PropertyCharacteristics_Services.Functions.xJoinAB(LEFT, RIGHT), left outer, ALL);

	// Rollup source B records where you have move than one value for a field.
	export dsRollB := rollup(dsJoinBA, TRUE, PropertyCharacteristics_Services.Functions.xRollUpB_Rec(LEFT, RIGHT));

	// Combine source A and B (and MLS E + best of all F or G) records
	export dsSourceAll := dsRollB + dsFilterOthers + PROJECT (inhouse_results(vendor_source in [Constants.Best_AllSources, Constants.Best_All_NoMLS]), TRANSFORM(layouts.inhouse_layout, SELF.acctno := '', SELF := LEFT));

	//For Default Plus Option, combine B OKCITY and E MLS records, MLS has higher priority
  shared DPO_BandE := ROLLUP(dsSourceAll(vendor_source in [Constants.MLS, Constants.Blacknight_LocalizedAverages]), TRUE, PropertyCharacteristics_Services.Functions.DPOJOin (LEFT, RIGHT));
	SHARED ds_DPO := dsSourceAll(vendor_source = Constants.CoreLogic) + DPO_BandE;

	SHARED FinaldsSourceAll := IF (pInMod.ResultOption = Constants.Default_Plus_Option, ds_DPO, dsSourceAll);
	shared ds_noacctno := project (FinaldsSourceAll, layouts.Payload);
	
	// Combine all the sections to generate the combined report
	shared ModPropInfo	:=	PropertyCharacteristics_Services.Convert2IESP(pInMod,pRequest);
	
	// Build report dataset.
	export dsReport := sort(project (ds_noacctno, ModPropInfo.Convert2PropDataItem(left, IsOptedOut)), Functions.DataSource_SortOrder(DataSource)); 

	iesp.property_info.t_PropertyInformation	tCombineReportSections()	:= transform
		self._Header													:=	row({0,'',pRequest.User.QueryId,pInsContext.Common.TransactionId,[],[]},iesp.share.t_ResponseHeader);
		self.ReportBy													:=	ModPropInfo.SetReportBy(clean_addr);
		self.Report.ReportIdSection						:=	ModPropInfo.SetReportID(pInsContext
																																			// ,dPropGatewayResponse
																																			,combined_err
																																			,exists (inhouse_results) OR (IsOptedOut AND COUNT(dPropPayload) = 2)
																																			,pInMod.isHomegateway
																																			,IsOptedOut
																																			);
		self.Report.Messages									:=	dCombinedErrorsSorted;
		
		self.Report.PropertyData							:= dsReport;
		// itv := project (dPropGatewayResponse.Response.Result.Report.Properties, ModPropInfo.ConvertGatewayResponse2ITV (Left));
		// self.Report.EstimatedReplacementCost	:=	itv[1];
		self := [];
	end;
	
	export	PropInfoReport	:=	row (tCombineReportSections());
	
	// Intermediate Logging
	export	IntermediateLog	:=	PropertyCharacteristics_Services.Get_Intermediate_Logs(pRequest,inhouse_results,pInsContext,pInMod);
	
	// Transaction Logging
	export	TransactionLog	:=	PropertyCharacteristics_Services.Get_Transaction_Logs(pRequest
																																										,pInsContext
																																										,PropInfoReport
																																										// ,dPropGatewayResponse
																																										,pInMod,
                                                                                    mod_access
																																										);
																																										
		// Transaction Logging
	export	TransactionLogExtension	:=	IF(Lexid <> 0 AND EXISTS(ds_noacctno), 
																				PropertyCharacteristics_Services.Get_Transaction_Log_Extension(pInsContext.Common.TransactionId
																																										,Lexid
																																										,ds_noacctno
																																										));

end;