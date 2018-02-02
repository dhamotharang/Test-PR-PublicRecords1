IMPORT AutoStandardI, DueDiligence, Gateway, iesp, STD, WSInput;


EXPORT DueDiligence_BusinessRptService := MACRO
	
			requestName := 'DueDiligenceReportRequest';
			
			//The following macro defines the field sequence on WsECL page of query.
			WSInput.MAC_DueDiligence_Service(requestName);
			
			DueDiligence.CommonQuery.mac_CreateInputFromXML(iesp.duediligencereport.t_DueDiligenceReportRequest, requestName, TRUE);
			
			validatedRequest := DueDiligence.Common.ValidateRequest(input, glba, dppa);
			
			DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));
			
			cleanData := DueDiligence.Common.GetCleanData(validatedRequest(validRequest));

		 
		//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
			DueDiligence.CommonQuery.mac_GetBusinessOptionSettings();

			businessResults := DueDiligence.getBusAttributes(cleanData, options, linkingOptions, includeReport, displayAttributeText, debugIndicator);

			busnIndex := DueDiligence.CommonQuery.GetBusinessAttributes(businessResults);
			busIndexHits := DueDiligence.CommonQuery.GetBusinessAttributeFlags(businessResults);
			
			final := DueDiligence.CommonQuery.mac_GetESPReturnData(wseq, businessResults, iesp.duediligencereport.t_DueDiligenceReportResponse, DueDiligence.Constants.BUSINESS,
																																																										DueDiligence.Constants.STRING_TRUE, busnIndex, busIndexHits, requestedVersion);


			output(final, NAMED('Results')); //This is the customer facing output    

			IF(debugIndicator, output(cleanData, NAMED('cleanData')));                         //This is for debug mode 	
			IF(debugIndicator, output(wseq, NAMED('wseq')));                              					//This is for debug mode 
			IF(intermediates, output(businessResults, NAMED('busResults')));                   //This is for debug mode 


ENDMACRO;


/*--SOAP-- 
<message name="duediligence.duediligence_businessrptservice">
	<part name="duediligencereportrequest" sequence="1" type="tns:XmlDataset"/>
	<part name="datapermissionmask" sequence="2" type="xsd:string"/>
	<part name="datarestrictionmask" sequence="3" type="xsd:string"/>
	<part name="dppapurpose" sequence="4" type="xsd:string"/>
	<part name="glbpurpose" sequence="5" type="xsd:string"/>
	<part name="historydateyyyymmdd" sequence="6" type="xsd:integer"/>
	<part name="debugmode" sequence="7" type="xsd:boolean"/>
	<part name="intermediatevariables" sequence="8" type="xsd:boolean"/>
</message>
*/