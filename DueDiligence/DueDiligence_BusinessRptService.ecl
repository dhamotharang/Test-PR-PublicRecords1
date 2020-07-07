IMPORT AutoStandardI, DueDiligence, iesp, STD, WSInput;


EXPORT DueDiligence_BusinessRptService := MACRO
	
    requestName := 'DueDiligenceBusinessReportRequest';
    requestLayout := iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportRequest;

    requestResponseLayout := iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportResponse;

    productsRequested := DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY;


    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_DueDiligence_Service(requestName);

    DueDiligence.CommonQuery.mac_CreateInputFromXML(requestLayout, requestName, TRUE, DueDiligence.Constants.BUSINESS);

    validatedRequest := DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa, DueDiligence.Constants.BUSINESS);

    DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));

    cleanData := DueDiligence.CommonQuery.GetCleanData(validatedRequest(validRequest));


    //********************************************************BUSINESS ATTRIBUTES STARTS HERE********************************************************
    DueDiligence.CommonQuery.mac_GetBusinessOptionSettings(dppa, glba, drm, dpm, userIn.IndustryClass);

    //retrieve the data based on input to be used in searches (PII vs LexID vs Combo of PII and LexID)
    dataToSearchBy := DueDiligence.fn_getProductInput(productsRequested, cleanData, busOptions, busLinkingOptions,
                                                                                                 LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                 TransactionID := TransactionID, 
                                                                                                 BatchUID := BatchUID, 
                                                                                                 GlobalCompanyID := GlobalCompanyID);

    businessResults := DueDiligence.getBusAttributes(dataToSearchBy, DD_SSNMask, TRUE, busOptions, busLinkingOptions, debugIndicator,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);

    busnIndex := DueDiligence.CommonQuery.GetBusinessAttributes(businessResults);
    busIndexHits := DueDiligence.CommonQuery.GetBusinessAttributeFlags(businessResults);


    final := DueDiligence.CommonQuery.mac_GetESPReturnData(wseq, businessResults, requestResponseLayout, DueDiligence.Constants.BUSINESS,
                                                            DueDiligence.Constants.STRING_TRUE, busnIndex, busIndexHits, requestedVersion,
                                                            optionsIn.AdditionalInput);


    OUTPUT(final, NAMED('Results')); //This is the customer facing output    

    IF(debugIndicator, OUTPUT(cleanData, NAMED('cleanData'))); //This is for debug mode 	
    IF(debugIndicator, OUTPUT(wseq, NAMED('wseq'))); //This is for debug mode 
    IF(intermediates, OUTPUT(businessResults, NAMED('busResults'))); //This is for debug mode

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