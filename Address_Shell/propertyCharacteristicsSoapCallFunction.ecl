IMPORT iesp, InsuranceContext_iesp, ut,std, Gateway;

EXPORT propertyCharacteristicsSoapCallFunction (DATASET(Address_Shell.layoutInput) input, UNSIGNED1 propertyInformationAttributesVersion, UNSIGNED1 ercAttributesVersion,
 DATASET(Gateway.Layouts.Config) gateway_cfg) := FUNCTION
/* ************************************************************
	 *       Convert input into ReportService() input:          *
	 ************************************************************ */

	propertyInformationGatewayURL := gateway_cfg(STD.Str.ToLowerCase(servicename) = 'reportservice')[1].url;
	ercGatewayURL := gateway_cfg(STD.Str.ToLowerCase(servicename) = 'erc')[1].url;
	 
	iesp.property_info.t_PropertyInformationRequest intoPropertyInformationRequest(Address_Shell.layoutInput le) := TRANSFORM
		SELF.User.GLBPurpose := le.GLBPurpose;
		SELF.User.DLPurpose := le.DPPAPurpose;
		SELF.InquiryInfo.SpecialBillId := '1';
		SELF.InquiryInfo.ReportType := IF(propertyInformationAttributesVersion >= 2, 'I', 'P'); // Note: K is no longer a valid report type, P is the replacement - returns the same results that K did
		SELF.ReportBy.Name.First := 'PRAddressShell';
		SELF.ReportBy.Name.Last := 'PRAddressShell';
				
		SELF.ReportBy.AddressInfo.StreetNumber := le.StreetNumber;
		SELF.ReportBy.AddressInfo.StreetPreDirection := le.StreetPreDirection;
		SELF.ReportBy.AddressInfo.StreetName := le.StreetName;
		SELF.ReportBy.AddressInfo.StreetSuffix := le.StreetSuffix;
		SELF.ReportBy.AddressInfo.StreetPostDirection := le.StreetPostDirection;
		SELF.ReportBy.AddressInfo.UnitDesignation := le.UnitDesignation;
		SELF.ReportBy.AddressInfo.UnitNumber := le.UnitNumber;
		SELF.ReportBy.AddressInfo.StreetAddress1 := le.StreetAddress1;
		SELF.ReportBy.AddressInfo.StreetAddress2 := le.StreetAddress2;
		SELF.ReportBy.AddressInfo.City := le.City;
		SELF.ReportBy.AddressInfo.State := le.State;
		SELF.ReportBy.AddressInfo.Zip5 := le.Zip5;
		SELF.ReportBy.AddressInfo.Zip4 := le.Zip4;
		SELF.ReportBy.AddressInfo.County := le.County;
		SELF.ReportBy.AddressInfo.PostalCode := le.PostalCode;
		
		SELF := [];
	END;
	
	InsuranceContext_iesp.insurance_risk_context.t_PropertyInformationContext intoInsuranceContextRequest(Address_Shell.layoutInput le) := TRANSFORM
		gateway := PROJECT(dataset([{1}], {unsigned a}), TRANSFORM(InsuranceContext_iesp.AccountInformation.t_Gateway,
																							SELF.ServiceName := 'property_value';
																							// Engineering test URL: 'http://rw_score_dev:[PASSWORD_REDACTED]@10.176.68.164:7726/WsGatewayEx?ver_=1.7';
																							SELF.URL := ercGatewayURL;
																							SELF := []));

		SELF.Account.MBSId := '1';
		SELF.Account.Name := '';
		SELF.Account.Status := 'A';
		SELF.Gateways := gateway;
		SELF.Products.PROPINFO.CustomerName := '';
		SELF.Products.PROPINFO.CustomerNumber := '';
		SELF.Products.PROPINFO.Status := 'A';
		//SELF.Products.PROPINFO.IsReseller := FALSE;
		SELF.Products.PROPINFO.IncludeConfidenceFactors := TRUE;
		SELF := [];
	END;
																													
	Address_Shell.layoutPropertyCharacteristicsRequest intoPropertyCharacteristicRequest(Address_Shell.layoutInput le) := TRANSFORM
		pRequest := PROJECT(le, intoPropertyInformationRequest(LEFT));
		iRequest := PROJECT(le, intoInsuranceContextRequest(LEFT));
		SELF.PropertyInformationRequest := pRequest;
		SELF.InsuranceContext := iRequest;
		SELF._Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
	END;
	
	reportServiceRequest := PROJECT(input, intoPropertyCharacteristicRequest(LEFT));
	
/* ************************************************************
	 *      Call out to the ReportService Internal gateway:     *
	 ************************************************************ */
	extendedSoapResponse := RECORD
		iesp.property_info.t_PropertyInformation;
		INTEGER code 				:= 0;
		STRING soapMessage	:= '';
	END;
	
	extendedSoapResponse soapFailure(Address_Shell.layoutPropertyCharacteristicsRequest le) := TRANSFORM
		SELF.code 				:= IF(FAILCODE = 0, -1, FAILCODE);
		SELF.soapMessage	:= FAILMESSAGE;
		SELF							:= []; // In case of SOAP call failure we don't wan't anything else
	END;

	// Only make the soap call if we have a URL and the attributes were requested
	soapResponse := IF(TRIM(propertyInformationGatewayURL) != '' AND (propertyInformationAttributesVersion > 0 OR ercAttributesVersion > 0),
											SOAPCALL(reportServiceRequest,
															 propertyInformationGatewayURL,
															 'PropertyCharacteristics_Services.ReportService',
															 {reportServiceRequest},
															 DATASET(extendedSoapResponse),
															 ONFAIL(soapFailure(LEFT)),
															 XPATH('PropertyCharacteristics_Services.ReportServiceResponse/Results/Result/Dataset[@name=\'Results\']/Row'),
															 TRIM),
											DATASET([], extendedSoapResponse));
	
	// Populate the exceptions section in the header if failure occurs
	iesp.property_info.t_PropertyInformation parseSoapFailure(extendedSoapResponse le) := TRANSFORM
		datasetError := DATASET([{'SoapCall', le.code, '', le.soapMessage}], iesp.share.t_WsException);
		
		SELF._Header.Exceptions := IF(le.code != 0, datasetError, DATASET([], iesp.share.t_WsException));
		SELF := le;
	end;

	reportServiceResult := PROJECT(soapResponse, parseSoapFailure(LEFT));
	
/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.  ECL Developers use only.   *
   ************************************************************ */
	#if(Address_Shell.Constants.debugging)
		#STORED('PCSCReportServiceRequest', reportServiceRequest);
		#STORED('PCSCSoapResponse', soapResponse);
	#end	
	
	RETURN reportServiceResult;
END;