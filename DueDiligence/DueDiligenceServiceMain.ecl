IMPORT BIPV2, Business_Risk_BIP, DueDiligence, iesp;

EXPORT DueDiligenceServiceMain(DATASET(DueDiligence.LayoutsInternal.SharedInput) inData, 
                               STRING inRequestedVersion,
                               STRING ssnMask,
                               Business_Risk_BIP.LIB_Business_Shell_LIBIN busOptions, 
                               BIPV2.mod_sources.iParams busLinkingOptions,
                               iesp.duediligenceshared.t_DDRAttributesAdditionalInfo additionalInfo,
                               DATASET({INTEGER4 seq, iesp.duediligenceattributes.t_DueDiligenceAttributesRequest}) rawReqInputWithSeq,
                               BOOLEAN intermidatesRequested = FALSE,
                               BOOLEAN debugMode = FALSE,
                               unsigned1 LexIdSourceOptout = 1,
                               string TransactionID = '',
                               string BatchUID = '',
                               unsigned6 GlobalCompanyId = 0) := FUNCTION   
      
      
      //********************************************************PERSON ATTRIBUTES HERE**********************************************************
      SHARED mac_getPersonAttributes() := FUNCTIONMACRO
          consumerResults := DueDiligence.getIndAttributes(inData, ssnMask, FALSE, busOptions, busLinkingOptions, debugMode,
                                                                                                  LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                  TransactionID := TransactionID, 
                                                                                                  BatchUID := BatchUID, 
                                                                                                  GlobalCompanyID := GlobalCompanyID);
		 
          indIndex := DueDiligence.CommonQuery.GetIndividualAttributes(consumerResults);
          indIndexHits := DueDiligence.CommonQuery.GetIndividualAttributeFlags(consumerResults);
          
          finalInd := DueDiligence.CommonQuery.mac_GetESPReturnData(rawReqInputWithSeq, consumerResults, DueDiligence.Constants.ATTRIBUTE_RESPONSE_LAYOUT, DueDiligence.Constants.INDIVIDUAL,
                                                                    DueDiligence.Constants.STRING_FALSE, indIndex, indIndexHits, inRequestedVersion, additionalInfo);
          
          
          IF(intermidatesRequested, OUTPUT(consumerResults, NAMED('indResults')));
          
          RETURN finalInd;
      ENDMACRO;
      
      
      //********************************************************BUSINESS ATTRIBUTES HERE********************************************************
      SHARED mac_getBusinessAttributes() := FUNCTIONMACRO
          businessResults := DueDiligence.getBusAttributes(inData, ssnMask, FALSE, busOptions, busLinkingOptions, debugMode,
                                                                                                  LexIdSourceOptout := LexIdSourceOptout, 
                                                                                                  TransactionID := TransactionID, 
                                                                                                  BatchUID := BatchUID, 
                                                                                                  GlobalCompanyID := GlobalCompanyID);

          busIndex := DueDiligence.CommonQuery.GetBusinessAttributes(businessResults);
          busIndexHits := DueDiligence.CommonQuery.GetBusinessAttributeFlags(businessResults);
          
          finalBus := DueDiligence.CommonQuery.mac_GetESPReturnData(rawReqInputWithSeq, businessResults, DueDiligence.Constants.ATTRIBUTE_RESPONSE_LAYOUT, DueDiligence.Constants.BUSINESS,
                                                                    DueDiligence.Constants.STRING_FALSE, busIndex, busIndexHits, inRequestedVersion, additionalInfo);
          
          
          IF(intermidatesRequested, OUTPUT(businessResults, NAMED('busResults'))); 
          
          RETURN finalBus;
      ENDMACRO;
      
      
      
      
      
      
      

      

      //based on what was requested, call the appropriate attributes  
      ddFinal := IF(inRequestedVersion IN DueDiligence.Constants.VALID_IND_ATTRIBUTE_VERSIONS, mac_getPersonAttributes(), mac_getBusinessAttributes());

      
      RETURN ddFinal;

END;