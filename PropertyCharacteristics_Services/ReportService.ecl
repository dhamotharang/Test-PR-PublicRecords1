/*--SOAP--
<message name="PropertyCharacteristicsReportService">	
	<part name="PropertyInformationRequest"	type="tns:XmlDataSet" cols="80"		rows="30"/>
	<part	name="InsuranceContext"	type="tns:Xmldataset"	cols="70"		rows="10"/>
</message>
*/

/*--INFO-- 
		Return the attributes, characteristics and ERC for a property
*/


import Address,AutoStandardI,iesp,insurancecontext_iesp,PropertyCharacteristics,ut,gateway;

export ReportService() := macro

	// get XML input
	dIn			:=	dataset([],iesp.property_info.t_PropertyInformationRequest)	:	stored('PropertyInformationRequest',FEW);
	Request	:=	dIn[1]	:	independent;

	// insurance context
	dInsContext	:=	dataset([],InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext)	:	stored('InsuranceContext',FEW);
	InsContext	:=	dInsContext[1]	:	independent;
	
	// check account validity and authorization
	boolean	isAccountExists			:=	InsContext.Account.MBSId	!=	'';
	boolean isAccountValid			:=	InsContext.Account.Status	=	'A';
	boolean	isAccountAuthorized	:=	InsContext.Products.PROPINFO.Status	=	'A';
	boolean	isAuthorized	:=	isAccountExists	and	isAccountValid	and	isAccountAuthorized;
	
	// set property search criteria
	ReportBy	:=	global(Request.ReportBy);

  clean_addr := PropertyCharacteristics_Services.Get_Clean_Address(Request.ReportBy.AddressInfo);
	
	// get gateway information. this is slightly different than other calls to common gateway config 
	// in the sense that it extracts the gateway information from the iesp request (InsContext).
	// vGatewayCfg 		:= PropertyCharacteristics_Services.GatewayFunctions.GetGatewayConfig(InsContext);
	
	tempMod	:=	module(PropertyCharacteristics_Services.IParam.SearchRecords)
											export	string1		ReportType									:=	PropertyCharacteristics_Services.Functions.fnClean2Upper(Request.InquiryInfo.ReportType);
											export	boolean		Reseller										:=	InsContext.Products.PROPINFO.IsReseller;
											export	boolean		IncludeConfidenceFactors		:=	InsContext.Products.PROPINFO.IncludeConfidenceFactors;
											// export 	dataset(Gateway.Layouts.Config) GatewayConfig	:=	vGatewayCfg;
											// export 	boolean		RunGateway_ERC						 	:=	isAuthorized;
											export  boolean isHomeGateway			            :=  Request.User.BillingCode IN PropertyCharacteristics_Services.Constants.HGW_ReportCodes;

											export	string60	addr 	:=	Address.Addr1FromComponents(clean_addr.prim_range,
																																							clean_addr.predir,
																																							clean_addr.prim_name,
																																							clean_addr.suffix,
																																							clean_addr.postdir,
																																							clean_addr.unit_desig,
																																							clean_addr.sec_range);
											export	string25	city	:=	clean_addr.v_city;
											export	string2		state	:=	clean_addr.state;
											export	string5		zip		:=	clean_addr.zip;

							end;	
	
	// generate exception code and message
	iesp.share.t_WsException	tException()	:=
	transform
		self.Code			:=	map(	~isAccountExists			=>	1,
														~isAccountValid				=>	2,
														~isAccountAuthorized	=>	3,
														0
													);
		self.Message	:=	map(	~isAccountExists			=>	'Account does not exist',
														~isAccountValid				=>	'Account is not valid',
														~isAccountAuthorized	=>	'Account is not authorized to use Property Characteristics Service',
														''
													);
		self					:=	[];
	end;
	
	dExceptions	:=	dataset([tException()]);
	
	iesp.property_info.t_PropertyInformation	tInvalidAcctPropResult()	:= transform
		self._Header																						:=	row(	{0,'',Request.User.QueryId,InsContext.Common.TransactionId,dExceptions},
																																			iesp.share.t_ResponseHeader
																																		);
		self.ReportBy																						:=	Request.ReportBy;
		self.Report.ReportIdSection.ServiceType									:=	tempMod.ReportType;
		self.Report.ReportIdSection.AccountNumber								:=	InsContext.Account.Legacy.Base;
		self.Report.ReportIdSection.AccountSuffix								:=	InsContext.Account.Legacy.Suffix;
		self.Report.ReportIdSection.OrderDate										:=	iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
		self.Report.ReportIdSection.ReceiptDate									:=	iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
		self.Report.ReportIdSection.CompletionDate							:=	iesp.ECL2ESP.toDate((INTEGER)Std.Date.Today());
		self.Report.ReportIdSection.ProcessingStatus						:=	'4';
		self.Report.ReportIdSection.AttachmentProcessingStatus	:=	if(tempMod.isHomeGateway,'','4');
		self																										:=	[];
	end;
	
	// Result Section
	RecordsMod	:=	PropertyCharacteristics_Services.Records(tempMod,InsContext,Request, clean_addr);

	PropDescReport	:=	if(isAuthorized,RecordsMod.PropInfoReport,row(tInvalidAcctPropResult()));
	
	output(PropDescReport,named('Results'));

	output(RecordsMod.IntermediateLog,named('LOG_log__mbsi_intermediate__log'));
	output(RecordsMod.TransactionLog,named('LOG_log__mbsi_transaction__log'));
endmacro;

// ReportService();

/*
// Request XML
<PropertyInformationRequest xmlns="http://webservices.seisint.com/WsInsuranceRisk">
	<User>
		<ReferenceCode>String</ReferenceCode>
		<BillingCode>String</BillingCode>
		<QueryId>String</QueryId>
		<GLBPurpose>String</GLBPurpose>
		<DLPurpose>String</DLPurpose>
		<EndUser>
			<CompanyName>String</CompanyName>
			<StreetAddress1>String</StreetAddress1>
			<City>String</City>
			<State>String</State>
			<Zip5>String</Zip5>
		</EndUser>
		<MaxWaitSeconds>32716</MaxWaitSeconds>
		<AccountNumber>String</AccountNumber>
	</User>
	<Options/>
	<InquiryInfo>
		<SpecialBillId>String</SpecialBillId>
		<ReportType>String</ReportType>
		<DateOfOrder>
			<Year>4096</Year>
			<Month>4096</Month>
			<Day>4096</Day>
		</DateOfOrder>
	</InquiryInfo>
	<ReportBy>
		<Name>
			<Full>String</Full>
			<First>String</First>
			<Middle>String</Middle>
			<Last>String</Last>
			<Suffix>String</Suffix>
			<Prefix>String</Prefix>
		</Name>
		<NameID>String</NameID>
		<AddressInfo>
			<StreetNumber>String</StreetNumber>
			<StreetPreDirection>String</StreetPreDirection>
			<StreetName>String</StreetName>
			<StreetSuffix>String</StreetSuffix>
			<StreetPostDirection>String</StreetPostDirection>
			<UnitDesignation>String</UnitDesignation>
			<UnitNumber>String</UnitNumber>
			<StreetAddress1>String</StreetAddress1>
			<StreetAddress2>String</StreetAddress2>
			<City>String</City>
			<State>String</State>
			<Zip5>String</Zip5>
			<Zip4>String</Zip4>
			<County>String</County>
			<PostalCode>String</PostalCode>
			<StateCityZip>String</StateCityZip>
			<CensusTract>String</CensusTract>
		</AddressInfo>
		<AddressID>String</AddressID>
		<PolicyNumber>String</PolicyNumber>
		<QuoteBack>String</QuoteBack>
		<PropertyAttributes>
			<LivingAreaSF>0</LivingAreaSF>
			<Stories>3.14159265358979</Stories>
			<Bedrooms>0</Bedrooms>
			<Baths>3.14159265358979</Baths>
			<Fireplaces>0</Fireplaces>
			<Pool>Y</Pool>
			<AC>Y</AC>
			<YearBuilt>0</YearBuilt>
			<SlopeCode>String</SlopeCode>
			<Slope>String</Slope>
			<QualityOfStructCode>String</QualityOfStructCode>
			<QualityOfStruct>String</QualityOfStruct>
			<ReplacementCostReportId>String</ReplacementCostReportId>
			<PolicyCoverageValue>0</PolicyCoverageValue>
		</PropertyAttributes>
		<PropertyCharacteristics>
			<PropertyCharacteristic>
				<Category>String</Category>
				<Material>String</Material>
				<Value>3.14159265358979</Value>
				<Quality>String</Quality>
				<Condition>String</Condition>
				<Age>0</Age>
			</PropertyCharacteristic>
			<PropertyCharacteristic>
				<Category>String</Category>
				<Material>String</Material>
				<Value>3.14159265358979</Value>
				<Quality>String</Quality>
				<Condition>String</Condition>
				<Age>0</Age>
			</PropertyCharacteristic>
		</PropertyCharacteristics>
		<PropertyDescriptionSet>
			<PropertyDescription>
				<Description>String</Description>
				<AdditionValue>0</AdditionValue>
				<AdditionQuality>String</AdditionQuality>
				<AdditionCondition>String</AdditionCondition>
				<LivingAreaIndicator>Y</LivingAreaIndicator>
			</PropertyDescription>
			<PropertyDescription>
				<Description>String</Description>
				<AdditionValue>0</AdditionValue>
				<AdditionQuality>String</AdditionQuality>
				<AdditionCondition>String</AdditionCondition>
				<LivingAreaIndicator>Y</LivingAreaIndicator>
			</PropertyDescription>
		</PropertyDescriptionSet>
	</ReportBy>
</PropertyInformationRequest>
*/