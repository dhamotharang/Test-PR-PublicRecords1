IMPORT DueDiligence, iesp, WSInput;


EXPORT DueDiligence_PersonRptService := MACRO

    requestName := 'DueDiligencePersonReportRequest';
    requestLayout := iesp.duediligencepersonreport.t_DueDiligencePersonReportRequest;

    requestResponseLayout := iesp.duediligencepersonreport.t_DueDiligencePersonReportResponse;

    productsRequested := DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY;



    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_DueDiligence_Service(requestName);

    DueDiligence.CommonQueryXML.mac_CreateInputFromXML(requestLayout, requestName, TRUE, DueDiligence.Constants.INDIVIDUAL);

    validatedRequest := DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa, DueDiligence.Constants.INDIVIDUAL, TRUE);

    DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));



    validRequest := validatedRequest(validRequest);

    //clean the input of the valid requests for requested products Citizenship and Due Diligence (DueDiligence.Layouts.CleanedData)
    cleanData := DueDiligence.CommonQuery.GetCleanData(validRequest);

    //retrieve options & compliance information
    regulatoryCompliance := DueDiligence.CommonQuery.GetCompliance(dppa, glba, drm, dpm, userIn.IndustryClass, lexIdSourceOptout, transactionID, batchUID, globalCompanyID, DDssnMask);

    //based on what was requested, call the appropriate attributes
    ddResults := DueDiligence.CommonQueryXML.mac_v3PersonXML(wseq, cleanData, regulatoryCompliance, optionsIn.AdditionalInput,
                                                             requestResponseLayout, DueDiligence.Constants.STRING_TRUE, debugIndicator, FALSE);




    //********************************************************PERSON TEST SEED LOGIC HERE**********************************************************
    final_testSeeds := DueDiligence.TestSeeds.TestSeedFunction(input, testSeedTableName, optionsIn.AdditionalInput).GetPersonReportSeeds;

    final := IF(executeTestSeeds, final_testSeeds, ddResults);


    IF(debugIndicator, OUTPUT(cleanData, NAMED('cleanData')));
    IF(debugIndicator, OUTPUT(wseq, NAMED('wseq')));


    OUTPUT(final, NAMED('Results')); //This is the customer facing output

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
