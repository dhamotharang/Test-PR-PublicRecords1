﻿IMPORT AutoStandardI, DueDiligence, Gateway, iesp, STD, WSInput;


EXPORT DueDiligence_PersonRptService := MACRO

			requestName := 'DueDiligenceAttributeRequest';
			requestLayout := iesp.duediligenceattributes.t_DueDiligenceAttributeRequest;
			
			requestResponseLayout := iesp.duediligenceattributes.t_DueDiligenceAttributeResponse;
			
			//The following macro defines the field sequence on WsECL page of query.
			WSInput.MAC_DueDiligence_Service(requestName);
	
			DueDiligence.CommonQuery.mac_CreateInputFromXML(requestLayout, requestName, TRUE, DueDiligence.Constants.INDIVIDUAL);
			
			validatedRequest := DueDiligence.Common.ValidateRequest(input, glba, dppa);
			
			DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));
			
			cleanData := DueDiligence.Common.GetCleanData(validatedRequest(validRequest));
			

		//********************************************************PERSON ATTRIBUTES STARTS HERE**********************************************************
			consumerResults := DueDiligence.getIndAttributes(cleanData, DPPA, glba, drm, gateways, includeReport, displayAttributeText, debugIndicator);
		 
			indIndex := DueDiligence.CommonQuery.GetIndividualAttributes(consumerResults);
			indIndexHits := DueDiligence.CommonQuery.GetIndividualAttributeFlags(consumerResults);
			
			final := DueDiligence.CommonQuery.mac_GetESPReturnData(wseq, consumerResults, requestResponseLayout, DueDiligence.Constants.INDIVIDUAL,
																																DueDiligence.Constants.STRING_FALSE, indIndex, indIndexHits, requestedVersion);


			output(final, NAMED('Results')); //This is the customer facing output    

			IF(debugIndicator, output(cleanData, NAMED('cleanData')));                         //This is for debug mode 	
			IF(debugIndicator, output(wseq, NAMED('wseq')));                              					//This is for debug mode 
			IF(intermediates, output(consumerResults, NAMED('indResults')));                   //This is for debug mode 
	

ENDMACRO;


/*--SOAP-- 
<message name="duediligence.duediligence_personrptservice">
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