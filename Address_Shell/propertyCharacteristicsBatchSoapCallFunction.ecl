IMPORT iesp, InsuranceContext_iesp, ut, PropertyCharacteristics_Services, Gateway;

EXPORT propertyCharacteristicsBatchSoapCallFunction (DATASET(Address_Shell.layouts.address_shell_input) input, UNSIGNED1 propertyInformationAttributesVersion, DATASET(Gateway.Layouts.Config) gateway_cfg) := FUNCTION
/* ************************************************************
	 *       Convert input into Batch_Service() input:          *
	 ************************************************************ */ 
	propertyInformationGatewayURL := gateway_cfg(StringLib.StringToLowerCase(servicename) = 'reportservice')[1].url;
	
	PropertyCharacteristics_Services.layouts.batch_in createBatchIn(input le) := TRANSFORM
	  SELF.acctno 				:= le.seq;
	  SELF.StreetAddress  := le.StreetAddress1;
	  SELF.City 					:= le.City;
	  SELF.State 			:= le.State;
	  SELF.Zip5 			:= le.Zip5;
	  SELF := [];
		END;

	Address_Shell.layouts.PC_Soap_In
	intoPropertyCharacteristicBatchRequest(ut.ds_oneRecord le) := TRANSFORM
		BatchIn := PROJECT(input, createBatchIn(LEFT));
		SELF.batch_in := BatchIn;
		SELF.includeconfidencefactors := 1;
		SELF.product := IF(propertyInformationAttributesVersion >= 2, 'I', 'P');
		SELF.reporttype := IF(propertyInformationAttributesVersion >= 2, 'I', 'P'); // Note: K is no longer a valid report type, P is the replacement - returns the same results that K did
		SELF._Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		SELF := [];
		END;

	reportServiceRequest := PROJECT(ut.ds_oneRecord,
	intoPropertyCharacteristicBatchRequest(LEFT));

	// Address_Shell.layouts.PC_Soap_In intoPropertyCharacteristicBatchRequest(Address_Shell.layouts.address_shell_input le) := TRANSFORM
		// BatchIn := PROJECT(le, createBatchIn(LEFT));
		// SELF.batch_in := BatchIn;
		// SELF.includeconfidencefactors := 1;
		// SELF.product := IF(propertyInformationAttributesVersion >= 2, 'I', 'P');
		// SELF.reporttype := IF(propertyInformationAttributesVersion >= 2, 'I', 'P'); // Note: K is no longer a valid report type, P is the replacement - returns the same results that K did
		// SELF._Blind := Gateway.Configuration.GetBlindOption(gateway_cfg);
		// SELF := [];
	// END;
	
	// reportServiceRequest := PROJECT(input, intoPropertyCharacteristicBatchRequest(LEFT));
	
/* *************************************************************
	 *      Call out to the ReportService Internal gateway:      *
	 ************************************************************* */
	extendedSoapResponse := RECORD
		Address_Shell.layouts.PC_Soap_out;
		INTEGER code 				:= 0;
		STRING soapMessage	:= '';
		END;
	
	extendedSoapResponse soapFailure(Address_Shell.layouts.PC_Soap_In le) := TRANSFORM
		SELF.code 				:= IF(FAILCODE = 0, -1, FAILCODE);
		SELF.soapMessage	:= FAILMESSAGE;
		SELF							:= []; // In case of SOAP call failure we don't wan't anything else
		END;

	// Only make the soap call if we have a URL and the attributes were requested
	soapResponse := IF(TRIM(propertyInformationGatewayURL) != '' AND propertyInformationAttributesVersion > 0 ,
											SOAPCALL(reportServiceRequest,
															 propertyInformationGatewayURL,
															 'PropertyCharacteristics_Services.BatchService',
															 {reportServiceRequest},
															 DATASET(Address_Shell.layouts.PC_Soap_out),
															 TRIM),
											DATASET([], Address_Shell.layouts.PC_Soap_out));

	reportServiceResult := soapResponse;
	
/* ************************************************************
	 * Debugging section.  This is only turned on when          *
   * Address_Shell.Constants.debugging is set to TRUE and     *
   * then the service is redeployed.  Allows the dev to look  *
   * at each step of the process.  ECL Developers use only.   *
   ************************************************************ */
	// #if(Address_Shell.Constants.debugging)
		// #STORED('PCSCReportServiceRequest', reportServiceRequest);
		// #STORED('PCSCSoapResponse', soapResponse);
	// #end	
	
	RETURN reportServiceResult;
	END;