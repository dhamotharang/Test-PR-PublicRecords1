EXPORT DueDiligenceServiceMain(rawWithSeq, validRequests) := FUNCTIONMACRO   
      
      
      //********************************************************PERSON ATTRIBUTES HERE**********************************************************
      SHARED mac_getPersonAttributes(cleaned, rawPlusSeq, busOptions, busLinkingOptions) := FUNCTIONMACRO
          consumerResults := DueDiligence.getIndAttributes(cleaned, dppa, glba, drm, DD_SSNMask, includeReport, displayAttributeText, debugIndicator, busOptions, busLinkingOptions);
		 
          indIndex := DueDiligence.CommonQuery.GetIndividualAttributes(consumerResults);
          indIndexHits := DueDiligence.CommonQuery.GetIndividualAttributeFlags(consumerResults);
          
          finalInd := DueDiligence.CommonQuery.mac_GetESPReturnData(rawPlusSeq, consumerResults, requestResponseLayout, DueDiligence.Constants.INDIVIDUAL,
                                                                    DueDiligence.Constants.STRING_FALSE, indIndex, indIndexHits, requestedVersion,
                                                                    optionsIn.AdditionalInput);
          
          
          IF(intermediates, OUTPUT(consumerResults, NAMED('indResults')));
          
          RETURN finalInd;
      ENDMACRO;
      
      
      //********************************************************BUSINESS ATTRIBUTES HERE********************************************************
      SHARED mac_getBusinessAttributes(cleaned, rawPlusSeq, busOptions, busLinkingOptions) := FUNCTIONMACRO
          businessResults := DueDiligence.getBusAttributes(cleaned, busOptions, busLinkingOptions, includeReport, displayAttributeText, DD_SSNMask, debugIndicator);

          busIndex := DueDiligence.CommonQuery.GetBusinessAttributes(businessResults);
          busIndexHits := DueDiligence.CommonQuery.GetBusinessAttributeFlags(businessResults);
          
          finalBus := DueDiligence.CommonQuery.mac_GetESPReturnData(rawPlusSeq, businessResults, requestResponseLayout, DueDiligence.Constants.BUSINESS,
                                                                    DueDiligence.Constants.STRING_FALSE, busIndex, busIndexHits, requestedVersion,
                                                                    optionsIn.AdditionalInput);
          
          
          IF(intermediates, OUTPUT(businessResults, NAMED('busResults'))); 
          
          RETURN finalBus;
      ENDMACRO;
      
      
      
      
      
      
      
      
      cleanData := DueDiligence.CommonQuery.GetCleanData(validRequests);
      
      DueDiligence.CommonQuery.mac_GetBusinessOptionSettings(dppa, glba, drm, dpm, userIn.IndustryClass);
      
      //based on what was requested, call the appropriate attributes  
      ddFinal := IF(requestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, mac_getPersonAttributes(cleanData, rawWithSeq, busOptions, busLinkingOptions), mac_getBusinessAttributes(cleanData, rawWithSeq, busOptions, busLinkingOptions));
      


		

      IF(debugIndicator, OUTPUT(cleanData, NAMED('cleanData')));                         //This is for debug mode 	
      IF(debugIndicator, OUTPUT(rawWithSeq, NAMED('rawWithSeq')));                       //This is for debug mode 
      IF(debugIndicator, OUTPUT(DD_SSNMask, NAMED('DD_SSNMask')));
      
      
      RETURN ddFinal;

ENDMACRO;