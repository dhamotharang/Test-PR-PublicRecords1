IMPORT AutoStandardI, Citizenship, DueDiligence, iesp, STD, WSInput;

EXPORT DueDiligence_Service := MACRO

      SHARED getComboValidRequest(DATASET(DueDiligence.Layouts.Input) input, UNSIGNED1 glbaPurpose, UNSIGNED1 dppaPurpose, STRING15 modelName, STRING ddAttrsRequested) := FUNCTION
          
          validateCit := Citizenship.Common.ValidateInput(input, glbaPurpose, dppaPurpose, modelName);
          validateDD := DueDiligence.CommonQuery.ValidateRequest(input, glbaPurpose, dppaPurpose, DueDiligence.Constants.ATTRIBUTES);
          
          citizenshipError := TRIM(validateCit[1].errorMessage);
          dueDiligenceError := TRIM(validateDD[1].errorMessage);
          
          newErrorMessage := MAP(ddAttrsRequested IN DueDiligence.Constants.VALID_BUS_ATTRIBUTE_VERSIONS => DueDiligence.CitDDShared.VALIDATION_INVALID_DD_ATTRIBUTE_REQUEST_WITH_CITIZENSHIP,
                                 citizenshipError <> DueDiligence.Constants.EMPTY AND 
                                    dueDiligenceError <> DueDiligence.Constants.EMPTY => citizenshipError + ' \n ' + dueDiligenceError,
                                 citizenshipError + ' ' + dueDiligenceError);
                                    
          trimErrorMessage := TRIM(newErrorMessage, LEFT, RIGHT);                          
          
          //both products will be in the same input layout, so only need to return 1 back to pass back to each product and update error message of 1 request
          validatedRequest := PROJECT(input, TRANSFORM(RECORDOF(LEFT),
                                                        SELF.errorMessage := trimErrorMessage;
                                                        SELF.validRequest := trimErrorMessage = DueDiligence.Constants.EMPTY;
                                                        SELF := LEFT;));
          
          RETURN validatedRequest;          
      END;









      requestName := 'DueDiligenceAttributesRequest';
      requestLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesRequest;

      requestResponseLayout := iesp.duediligenceattributes.t_DueDiligenceAttributesResponse;

      //The following macro defines the field sequence on WsECL page of query.
      WSInput.MAC_DueDiligence_Service(requestName);

      DueDiligence.CommonQuery.mac_CreateInputFromXML(requestLayout, requestName, FALSE, DueDiligence.Constants.ATTRIBUTES);

      //determine which product(s) are being requested
      selectedProduct := STD.Str.ToLowerCase(input[1].productRequested);
      modelName := STD.Str.ToUpperCase(TRIM(input[1].modelName));

      IF(selectedProduct = DueDiligence.Constants.EMPTY OR selectedProduct NOT IN DueDiligence.CitDDShared.VALID_REQUESTED_PRODUCTS , FAIL(DueDiligence.CitDDShared.VALIDATION_INVALID_PRODUCT_REQUEST_TYPE));


      reqProduct := MAP(selectedProduct = 'attributesandcitizenship' => DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.BOTH,
                        selectedProduct = 'citizenshiponly' => DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY,
                        DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.ATTRIBUTES_ONLY);
                                
                                
      validatedRequest := CASE(reqProduct,
                                DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.BOTH => getComboValidRequest(input, glba, dppa, modelName, requestedVersion),
                                DueDiligence.CitDDShared.PRODUCT_REQUESTED_ENUM.CITIZENSHIP_ONLY => Citizenship.Common.ValidateInput(input, glba, dppa, modelName),
                                DueDiligence.CommonQuery.ValidateRequest(input, glba, dppa, DueDiligence.Constants.ATTRIBUTES));
                              
                              
      DueDiligence.CommonQuery.mac_FailOnError(validatedRequest(validRequest = FALSE));

      validRequest := validatedRequest(validRequest);



      citResults := IF(reqProduct IN DueDiligence.CitDDShared.CITIZENSHIP_PRODUCTS, 
                            Citizenship.CitizenshipServiceMain(wseq, validRequest, glba, dppa, drm, dpm, modelName, intermediates, debugIndicator),
                            DATASET([], requestResponseLayout));
                            
      ddResults := IF(reqProduct IN DueDiligence.CitDDShared.DUEDILIGENCE_PRODUCTS, 
                            DueDiligence.DueDiligenceServiceMain(wseq, validRequest), 
                            DATASET([], requestResponseLayout));



      //since we only process 1 record at a time via XML
      //there could be a max of 2 records (Due Diligence + Citizenship)
      //so they would be for the same request
      allProducts := PROJECT(citResults + ddResults, TRANSFORM(requestResponseLayout,
                                                                SELF.Result.AdditionalInput := optionsIn.AdditionalInput;
                                                                SELF := LEFT;));
                                                                
      sortProducts := SORT(allProducts, Result.UniqueID, Result.BusinessID);


      final := ROLLUP(sortProducts,
                      LEFT.Result.inputEcho.productRequestType = RIGHT.Result.inputEcho.productRequestType,
                      TRANSFORM(requestResponseLayout,
                                SELF.Result.PersonLexIDMatch := DueDiligence.Common.firstNonZeroNumber(Result.PersonLexIDMatch);
                                SELF.Result.BusinessLexIDMatch := DueDiligence.Common.firstNonZeroNumber(Result.BusinessLexIDMatch);
                                SELF.Result.AttributeGroup.Attributes :=  LEFT.Result.AttributeGroup.Attributes + RIGHT.Result.AttributeGroup.Attributes;
                                SELF.Result.AttributeGroup.AttributeLevelHits := LEFT.Result.AttributeGroup.AttributeLevelHits + RIGHT.Result.AttributeGroup.AttributeLevelHits;
                                SELF.Result.AttributeGroup.Name := DueDiligence.Common.firstPopulatedString(Result.AttributeGroup.Name);
                                SELF.Result.CitizenshipResults.CitizenshipScore := DueDiligence.Common.firstPopulatedString(Result.CitizenshipResults.CitizenshipScore);
                                SELF.Result.CitizenshipResults.CitizenshipAttributes := LEFT.Result.CitizenshipResults.CitizenshipAttributes + RIGHT.Result.CitizenshipResults.CitizenshipAttributes;
                                SELF := LEFT;));





      IF(intermediates, output(citResults, NAMED('citResults')));
      IF(intermediates, output(ddResults, NAMED('ddResults')));



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
