IMPORT AutoStandardI, DueDiligence, iesp, STD, WSInput;

EXPORT DueDiligence_Service := MACRO

			requestName := 'DueDiligenceAttributesRequest';
			requestLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesRequest;
			
			requestResponseLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesResponse;
	
			//The following macro defines the field sequence on WsECL page of query.
			WSInput.MAC_DueDiligence_Service(requestName);
			
			DueDiligence.CommonQuery.mac_CreateInputFromXML(requestLayout, requestName, FALSE, DueDiligence.Constants.ATTRIBUTES);
			
			validatedRequest := DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa);
			
			DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE), DueDiligence.Constants.ATTRIBUTES);
			
			cleanData := DueDiligence.CommonQuery.GetCleanData(validatedRequest(validRequest));


			//********************************************************PERSON ATTRIBUTES STARTS HERE**********************************************************
			consumerResults := DueDiligence.getIndAttributes(cleanData, DPPA, glba, drm, DD_SSNMask, includeReport, displayAttributeText, debugIndicator);
		 
			indIndex := DueDiligence.CommonQuery.GetIndividualAttributes(consumerResults);
			indIndexHits := DueDiligence.CommonQuery.GetIndividualAttributeFlags(consumerResults);
			
			finalInd := DueDiligence.CommonQuery.mac_GetESPReturnData(wseq, consumerResults, requestResponseLayout, DueDiligence.Constants.INDIVIDUAL,
																																DueDiligence.Constants.STRING_FALSE, indIndex, indIndexHits, requestedVersion);
																					
		
			
			
			//********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
			DueDiligence.CommonQuery.mac_GetBusinessOptionSettings(dppa, glba, drm, dpm, userIn.IndustryClass);

			businessResults := DueDiligence.getBusAttributes(cleanData, busOptions, busLinkingOptions, includeReport, displayAttributeText, DD_SSNMask, debugIndicator);

			busIndex := DueDiligence.CommonQuery.GetBusinessAttributes(businessResults);
			busIndexHits := DueDiligence.CommonQuery.GetBusinessAttributeFlags(businessResults);
			
			finalBus := DueDiligence.CommonQuery.mac_GetESPReturnData(wseq, businessResults, requestResponseLayout, DueDiligence.Constants.BUSINESS,
																															  DueDiligence.Constants.STRING_FALSE, busIndex, busIndexHits, requestedVersion);




			//Depending if business or individual was requested, return corresponding data
			final := IF(requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, finalInd, finalBus);


			output(final, NAMED('Results')); //This is the customer facing output    

			IF(debugIndicator, output(cleanData, NAMED('cleanData')));                         //This is for debug mode 	
			IF(debugIndicator, output(wseq, NAMED('wseq')));                              		 //This is for debug mode 
			IF(intermediates, output(businessResults, NAMED('busResults')));                   //This is for debug mode 
			IF(intermediates, output(consumerResults, NAMED('indResults')));                   //This is for debug mode
      IF(debugIndicator, output(DD_SSNMask, NAMED('DD_SSNMask')));

ENDMACRO;


/*--SOAP-- 
<message name="duediligence.duediligence_service">
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
