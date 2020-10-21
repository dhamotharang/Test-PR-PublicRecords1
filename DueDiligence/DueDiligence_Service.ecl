IMPORT DueDiligence, iesp, STD, WSInput;

EXPORT DueDiligence_Service := MACRO

    requestName := 'DueDiligenceAttributesRequest';
    requestLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesRequest;

    requestResponseLayout := DueDiligence.Constants.ATTRIBUTE_RESPONSE_LAYOUT;

    //The following macro defines the field sequence on WsECL page of query.
    WSInput.MAC_DueDiligence_Service(requestName);

  

    //get the input used for Citizenship and Due Diligence from the request (DueDiligence.Layouts.Input)
    DueDiligence.CommonQueryXML.mac_CreateInputFromXML(requestLayout, requestName, FALSE, DueDiligence.Constants.ATTRIBUTES);

    //determine which product(s) are being requested
    selectedProduct := STD.Str.ToLowerCase(input[1].productRequested);
    modelName := STD.Str.ToUpperCase(TRIM(input[1].modelName));

    validatedRequest := DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa, DueDiligence.Constants.ATTRIBUTES, FALSE, modelName);                              
                           
    DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));

    
    
    validRequest := validatedRequest(validRequest);
    
    //clean the input of the valid requests for requested products Citizenship and Due Diligence (DueDiligence.Layouts.CleanedData)
    cleanData := DueDiligence.CommonQuery.GetCleanData(validRequest);
   
    //retrieve compliance information
    regulatoryCompliance := DueDiligence.CommonQuery.GetCompliance(dppa, glba, drm, dpm, userIn.IndustryClass, lexIdSourceOptout, transactionID, batchUID, globalCompanyID);

    //based on what was requested, call the appropriate attributes  
    ddResults := DueDiligence.CommonQueryXML.mac_processV3XMLRequest(wseq, cleanData, regulatoryCompliance, DDssnMask, optionsIn.AdditionalInput, 
                                                                      DueDiligence.Constants.ATTRIBUTE_RESPONSE_LAYOUT, DueDiligence.Constants.STRING_FALSE, debugIndicator, intermediates);


 
    //********************************************************PERSON TEST SEED LOGIC HERE**********************************************************

    reqProduct := DueDiligence.CommonQuery.getProductEnum(selectedProduct);
    
    testSeedFunction := DueDiligence.TestSeeds.TestSeedFunction(input, testSeedTableName, optionsIn.AdditionalInput);
    final_testSeeds := CASE(reqProduct,
                            DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY => IF(requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, 
                                                                                                        testSeedFunction.GetPersonAttributeSeeds,
                                                                                                        testSeedFunction.GetBusinessAttributeSeeds),
                            DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY => testSeedFunction.GetCitizenshipSeeds);







    final := MAP(executeTestSeeds AND reqProduct IN [DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.DUEDILIGENCE_ONLY, DueDiligence.ConstantsQuery.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY] => final_testSeeds,
                  ddResults);



    IF(debugIndicator, OUTPUT(input, NAMED('rawInput')));
    IF(debugIndicator, OUTPUT(cleanData, NAMED('cleanData')));
    OUTPUT(final, NAMED('Results')); //This is the customer facing output   

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
