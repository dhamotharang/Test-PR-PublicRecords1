IMPORT AutoStandardI, DueDiligence, iesp, STD, WSInput;


EXPORT DueDiligence_PersonRptService := MACRO

    requestName := 'DueDiligencePersonReportRequest';
    requestLayout := iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest;

    requestResponseLayout := iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse;
    
    productsRequested := DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY;
    
    

    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_DueDiligence_Service(requestName);

    DueDiligence.CommonQuery.mac_CreateInputFromXML(requestLayout, requestName, TRUE, DueDiligence.Constants.INDIVIDUAL);

    validatedRequest := DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa, DueDiligence.Constants.INDIVIDUAL);

    DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));

    cleanData := DueDiligence.CommonQuery.GetCleanData(validatedRequest(validRequest));


    //********************************************************PERSON REPORT LOGIC HERE**********************************************************
    DueDiligence.CommonQuery.mac_GetBusinessOptionSettings(dppa, glba, drm, dpm, userIn.IndustryClass);
    
    //retrieve the data based on input to be used in searches (PII vs LexID vs Combo of PII and LexID)
    dataToSearchBy := DueDiligence.fn_getProductInput(productsRequested, cleanData, busOptions, busLinkingOptions,
                                                                                                 LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                 TransactionID := TransactionID, 
                                                                                                 BatchUID := BatchUID, 
                                                                                                 GlobalCompanyID := GlobalCompanyID);

    consumerResults := DueDiligence.getIndAttributes(dataToSearchBy, DD_SSNMask, TRUE, busOptions, busLinkingOptions, debugIndicator,
                                                                                            LexIdSourceOptout := LexIdSourceOptout, 
                                                                                            TransactionID := TransactionID, 
                                                                                            BatchUID := BatchUID, 
                                                                                            GlobalCompanyID := GlobalCompanyID);

    indIndex := DueDiligence.CommonQuery.GetIndividualAttributes(consumerResults);
    indIndexHits := DueDiligence.CommonQuery.GetIndividualAttributeFlags(consumerResults);

    final_actual := DueDiligence.CommonQuery.mac_GetESPReturnData(wseq, consumerResults, requestResponseLayout, DueDiligence.Constants.INDIVIDUAL,
                                                                  DueDiligence.Constants.STRING_TRUE, indIndex, indIndexHits, requestedVersion,
                                                                  optionsIn.AdditionalInput);
    
    
    
    
    //********************************************************PERSON TEST SEED LOGIC HERE**********************************************************
    final_testSeeds := DueDiligence.TestSeeds.TestSeedFunction(input, testSeedTableName, optionsIn.AdditionalInput).GetPersonReportSeeds;

    final := IF(executeTestSeeds, final_testSeeds, final_actual);



    OUTPUT(final, NAMED('Results')); //This is the customer facing output    



    IF(debugIndicator, OUTPUT(cleanData, NAMED('cleanData')));
    IF(debugIndicator, OUTPUT(wseq, NAMED('wseq')));
    IF(intermediates, OUTPUT(consumerResults, NAMED('indResults')));

	

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