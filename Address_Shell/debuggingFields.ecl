IMPORT iesp, InsuranceContext_iesp;

EXPORT debuggingFields := MACRO
	#if(Address_Shell.Constants.debugging)
		// Address Shell Inputs
		OUTPUT(firstRow, NAMED('First_Row_Of_Input'));
		OUTPUT(gatewaysIn, NAMED('Gateways_On_Input'));
		OUTPUT(publicRecordsAttributesVersion, NAMED('Public_Records_Attributes_Version_Number'));
		OUTPUT(propertyInformationAttributesVersion, NAMED('Property_Information_Attributes_Version_Number'));
		OUTPUT(ercAttributesVersion, NAMED('ERC_Attributes_Version_Number'));
		OUTPUT(propertyInformationGatewayURL, NAMED('Property_Information_Gateway_URL'));
		OUTPUT(ercGatewayURL, NAMED('ERC_Gateway_URL'));
		
		// Address_Shell.getPropertyAttributes:
		PR_SafetyExact := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PRSafetyExact');
		OUTPUT(PR_SafetyExact, NAMED('Property_Attributes_SafetyV1Exact'));
		PR_SafetyClose := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PRSafetyClose');
		OUTPUT(PR_SafetyClose, NAMED('Property_Attributes_SafetyV1Close'));
		PA_Firefighters := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PAFirefighters');
		OUTPUT(PA_Firefighters, NAMED('Property_Attributes_Firefighters'));
		PA_Foreclosures := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PAForeclosures');
		OUTPUT(PA_Foreclosures, NAMED('Property_Attributes_Foreclosuress'));
		PA_Assessment := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PAAssessment');
		OUTPUT(PA_Assessment, NAMED('Property_Attributes_Assessment'));
		PA_Indexes := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PAIndexes');
		OUTPUT(PA_Indexes, NAMED('Property_Attributes_Indexes'));
		PA_Advo := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PAAdvo');
		OUTPUT(PA_Advo, NAMED('Property_Attributes_Advo'));
		PA_PubRecs := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PAPubRecs');
		OUTPUT(PA_PubRecs, NAMED('Property_Attributes_Final_Results'));
		
		// Address_Shell.getPropertyCharacteristics:
		PC_JustInput := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PCJustInput');
		OUTPUT(PC_JustInput, NAMED('Property_Characteristics_JustInput'));
		// Address_Shell.propertyCharacteristicsSoapCallFunction:
		PCSC_ReportServiceRequest := DATASET([], Address_Shell.layoutPropertyCharacteristicsRequest) : STORED('PCSCReportServiceRequest');
		OUTPUT(PCSC_ReportServiceRequest, NAMED('Property_Characteristics_SoapCall_ReportServiceRequest'));
		extendedSoapResponse := RECORD
			iesp.property_info.t_PropertyInformation;
			INTEGER code 				:= 0;
			STRING soapMessage	:= '';
		END;
		PCSC_SoapResponse := DATASET([], extendedSoapResponse) : STORED('PCSCSoapResponse');
		OUTPUT(PCSC_SoapResponse, NAMED('Property_Characteristics_SoapCall_SoapResponse'));
		// Address_Shell.getPropertyCharacteristics:
		PC_Report := DATASET([], iesp.property_info.t_PropertyInformationReport) : STORED('PCReport');
		OUTPUT(PC_Report, NAMED('Property_Characteristics_Report'));
		PC_PropertyData := DATASET([], iesp.property_info.t_PropertyDataItem) : STORED('PCPropertyData');
		OUTPUT(PC_PropertyData, NAMED('Property_Characteristics_PropertyData'));
		PC_BestPropertyData := DATASET([], iesp.property_info.t_PropertyDataItem) : STORED('PCBestPropertyData');
		OUTPUT(PC_BestPropertyData, NAMED('Property_Characteristics_BestPropertyData'));
		PC_WithERC := DATASET([], iesp.property_info.t_PropertyInformationReport) : STORED('PCWithERC');
		OUTPUT(PC_WithERC, NAMED('Property_Characteristics_WithERC'));
		PC_FlatProperty := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PCFlatProperty');
		OUTPUT(PC_FlatProperty, NAMED('Property_Characteristics_FlatProperty'));
		PC_FinalJoin := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PCFinalJoin');
		OUTPUT(PC_FinalJoin, NAMED('Property_Characteristics_FinalJoin'));
		PC_PropRecs := DATASET([], Address_Shell.layoutPropertyCharacteristics) : STORED('PCPropRecs');
		OUTPUT(PC_PropRecs, NAMED('Property_Characteristics_Attributes_Final_Results'));
		
		// Final combined attributes result
		OUTPUT(comboAttributes, NAMED('Attribute_Results_Combined'));
	#end
ENDMACRO;