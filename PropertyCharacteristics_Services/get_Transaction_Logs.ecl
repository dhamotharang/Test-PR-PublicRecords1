import	iesp,InsuranceContext_iesp,ut, doxie;

export	Get_Transaction_Logs(	iesp.property_info.t_PropertyInformationRequest														pRequest,
															InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext	pInsContext,
															iesp.property_info.t_PropertyInformation																	pResponse,
															// iesp.property_value_report.t_PropertyValueReportResponseEx								pGatewayResponse,
															PropertyCharacteristics_Services.IParam.SearchRecords											pInMod,
                              doxie.IDataAccess                                                         mod_access
														)	:=
function
	// ITV transaction log ?
    BOOLEAN ITV                   :=  pInMod.ReportType	in	['I','K','L','P'];
	  BOOLEAN isAgent								:=  pInsContext.Products.PROPINFO.AccountType = Constants.Agent;
	  BOOLEAN errorStatus           :=  pInsContext.Account.MBSId	=	''	or	pInsContext.Account.Status	!=	'A'	or	pInsContext.Products.PROPINFO.Status	!=	'A';
		
	// Default transaction log
	PropertyCharacteristics_Services.Layouts.TransactionLog	tFormatDefaultTransactionLog()	:=
	transform
		string8	vDateOrder						:=	iesp.ECL2ESP.t_DateToString8(pRequest.InquiryInfo.DateOfOrder);
		self.transaction_id						:=	pInsContext.Common.TransactionId;
		self.product_id								:=	(integer)PropertyCharacteristics_Services.Constants.ProductID;
		self.date_added								:=	ut.GetTimeDate()[1..10];
		self.login_id									:=	'';
		self.billing_code							:=	pRequest.User.BillingCode;
		self.function_name						:=	pInMod.ReportType;

		self.report_code							:=	MAP(pInMod.isHomeGateway AND isAgent => Constants.HGW_Agent,
																					pInMod.isHomeGateway             => Constants.HGW_Underwriter,
																					'');

		self.account_base							:=	pInsContext.Account.Legacy.Base;
		self.account_suffix						:=	pInsContext.Account.Legacy.Suffix;
		self.account_id								:=	(integer)pInsContext.Account.MBSId;
		self.customer_number					:=	(integer)pInsContext.Products.PROPINFO.CustomerNumber;
		self.customer_reference_code	:=	pRequest.User.ReferenceCode;
		self.i_date_ordered						:=	vDateOrder[1..4]	+	'-'	+	vDateOrder[5..6]	+	'-'	+	vDateOrder[7..8];

		self.i_person_ssn							:=	'';
		self.i_person_name_prefix			:=	pRequest.ReportBy.Name.Prefix;
		self.i_person_last_name				:=	pRequest.ReportBy.Name.Last;
		self.i_person_first_name			:=	pRequest.ReportBy.Name.First;
		self.i_person_middle_name			:=	pRequest.ReportBy.Name.Middle;
		self.i_person_name_suffix			:=	pRequest.ReportBy.Name.Suffix;
		self.i_person_dob							:=	'';
		self.count_person_in					:=	1;

		self.i_dl1_number							:=	'';
		self.i_dl1_state							:=	'';
		self.i_dl1_type								:=	0;
		self.count_dl_in							:=	0;

		self.i_addr_line							:=	if(	pRequest.ReportBy.AddressInfo.StreetAddress2	!=	'',
																					stringlib.stringcleanspaces(pRequest.ReportBy.AddressInfo.StreetAddress1	+	' '	+	pRequest.ReportBy.AddressInfo.StreetAddress2),
																					pRequest.ReportBy.AddressInfo.StreetAddress1
																				);
		self.i_addr_street_type				:=	0;
		self.i_addr_state							:=	pRequest.ReportBy.AddressInfo.State;
		self.i_addr_zip								:=	pRequest.ReportBy.AddressInfo.Zip5;
		self.i_addr_city							:=	pRequest.ReportBy.AddressInfo.City;
		self.i_addr_county						:=	pRequest.ReportBy.AddressInfo.County;
		self.i_addr_country						:=	'';
		self.i_addr_type							:=	1;
		self.count_addr_in						:=	1;

		self.reference_number					:=	pInsContext.Common.ReferenceNumber;

		self.free											:=	0;
		self.result_format						:=	2;
		self.return_node_id						:=	'';
		self.request_node_id					:=	pInsContext.Common.CustomerNodeId;
		self.product_line							:=	pInsContext.Products.PROPINFO.IndResultOption;
		self.login_history_id					:=	(integer)pRequest.User.LoginHistoryId;
		self.ip_address								:=	pRequest.User.IP;
		self.esp_method								:=	PropertyCharacteristics_Services.Constants.ESPMethod;

		self.i_unique_id							:=	''; //pGatewayResponse.Response.Result.Report.Properties[1].PropertyId;
		self.i_unique_id_type					:=	0;  //IF(ITV AND self.i_unique_id	!=	'',8,0);

		self.processing_status				:=	MAP(pInMod.isHomeGateway and pResponse.Report.ReportIdSection.ProcessingStatus	=	'5' => '401',
		                                      pInMod.isHomeGateway and pResponse.Report.ReportIdSection.ProcessingStatus	=	'4' => '402',
																					pInMod.isHomeGateway and pResponse.Report.ReportIdSection.ProcessingStatus	in	['1', '9'] => '501',
																					pInMod.isHomeGateway                                                              => '503',
																					~ITV                                   => '',    
                                            pResponse.Report.ReportIdSection.ProcessingStatus	in	['1', '9']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	in	['1', '6']	=>	'A',
																						pResponse.Report.ReportIdSection.ProcessingStatus	in	['1', '9']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'2'	=>	'B',
																						pResponse.Report.ReportIdSection.ProcessingStatus	in	['1', '9']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'7'	=>	'I',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'2'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	in	['1', '6']	=>	'C',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'2'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'2'	=>	'D',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'2'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'7'	=>	'L',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'4'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'4'	=>	'E',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'5'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	in	['1', '6']	=>	'G',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'5'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'2'	=>	'M',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'5'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'5'	=>	'F',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'5'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'7'	=>	'N',
																						pResponse.Report.ReportIdSection.ProcessingStatus	in	['7', '6']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	in	['1', '6']	=>	'J',
																						pResponse.Report.ReportIdSection.ProcessingStatus	in	['7', '6']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'2'	=>	'O',
																						pResponse.Report.ReportIdSection.ProcessingStatus	in	['7', '6']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'5'	=>	'P',
																						pResponse.Report.ReportIdSection.ProcessingStatus	in	['7', '6']	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'7'	=>	'H',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'8'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	in	['1', '6']	=>	'K',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'8'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'2'	=>	'Q',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'8'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'5'	=>	'R',
																						pResponse.Report.ReportIdSection.ProcessingStatus	=	'8'	and	pResponse.Report.ReportIdSection.AttachmentProcessingStatus	=	'7'	=>	'S',
																						''
																					);

		self.order_status_code				:=	map(  pInMod.isHomeGateway  and self.processing_status = '401'                      =>  401,
		                                        pInMod.isHomeGateway  and self.processing_status = '402'                      =>  402,
		                                        pInMod.isHomegateway                                                          =>  100,
		                                        ~ITV and errorStatus                                                          =>  402,
		                                        ~ITV                                                                          =>  401,
		                                        errorStatus	or	self.processing_status	=	'E'	                                =>	402,
																						self.processing_status	in	['A','B','C','D','G','I','J','K','L','M','O','Q'] =>	201,
																						self.processing_status	in	['F','N','P','R']																	=>	401,
																						self.processing_status	in	['H','S']																					=>	404,
																						0
																					);

		self.record_count_1						:=	IF(ITV,(integer)pResponse.Report.ReportIdSection.ProcessingStatus,0);
		self.record_count_1_type			:=	IF(ITV,1,0);
		self.record_count_2						:=	IF(ITV,(integer)pResponse.Report.ReportIdSection.AttachmentProcessingStatus,0);
		self.record_count_2_type			:=	IF(ITV,2,0);
		self.glba_code      					:=	(STRING3)mod_access.glb;

		self													:=	[];
	end;
	
	dDefaultTransactionLog	:=	dataset([tFormatDefaultTransactionLog()]);
	
	PropertyCharacteristics_Services.Layouts.TransactionLogRec	tFormat2Mbsi(PropertyCharacteristics_Services.Layouts.TransactionLog	pInput)	:=
	transform
		self.Rec	:=	pInput;
	end;
	
	dTransactionLog	:=	project(dDefaultTransactionLog,tFormat2Mbsi(left));
	return	dTransactionLog;
end;