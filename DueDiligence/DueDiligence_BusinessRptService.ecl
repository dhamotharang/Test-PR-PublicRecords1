IMPORT DueDiligence, iesp, WSInput;


EXPORT DueDiligence_BusinessRptService := MACRO

    requestName := 'DueDiligenceBusinessReportRequest';
    requestLayout := iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportRequest;

    requestResponseLayout := iesp.duediligencebusinessreport.t_DueDiligenceBusinessReportResponse;

    productsRequested := DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY;


    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_DueDiligence_Service(requestName);


    DueDiligence.CommonQueryXML.mac_CreateInputFromXML(requestLayout, requestName, TRUE, DueDiligence.Constants.BUSINESS);

    validatedRequest := DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa, DueDiligence.Constants.BUSINESS, TRUE);

    DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));



    validRequest := validatedRequest(validRequest);

    //clean the input of the valid requests for requested products Citizenship and Due Diligence (DueDiligence.Layouts.CleanedData)
    cleanData := DueDiligence.CommonQuery.GetCleanData(validRequest);

    //retrieve options & compliance information
    regulatoryCompliance := DueDiligence.CommonQuery.GetCompliance(dppa, glba, drm, dpm, userIn.IndustryClass, lexIdSourceOptout, transactionID, batchUID, globalCompanyID, DDssnMask);

    //based on what was requested, call the appropriate attributes
    ddResults := DueDiligence.CommonQueryXML.mac_v3BusinessXML(wseq, cleanData, regulatoryCompliance, optionsIn.AdditionalInput,
                                                               requestResponseLayout, DueDiligence.Constants.STRING_TRUE, FALSE);





    IF(debugIndicator, OUTPUT(cleanData, NAMED('cleanData'))); //This is for debug mode
    IF(debugIndicator, OUTPUT(wseq, NAMED('wseq'))); //This is for debug mode


    OUTPUT(ddResults, NAMED('Results')); //This is the customer facing output

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
