IMPORT BIPV2, Business_Risk_BIP, DueDiligence, Risk_Indicators, STD;


EXPORT DDBusiness := MODULE

    EXPORT GetKfetch2LinkIDs(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION
        RETURN PROJECT(inData, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids2,
                                          SELF.UniqueID		:= LEFT.seq;                                          
                                          SELF.UltID			:= LEFT.inquiredBusiness.ultID;
                                          SELF.OrgID			:= LEFT.inquiredBusiness.orgID;
                                          SELF.SeleID			:= LEFT.inquiredBusiness.seleID;
                                          SELF := [];));
    END;
    
    
    EXPORT GetKfetchLinkIDs(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION
        RETURN PROJECT(GetKfetch2LinkIDs(inData), TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
                                                  SELF := LEFT;));
    END;
    
    
    EXPORT AppendSeq(rawData, datasetToJoinTo, rawIncludesUniqueID) := FUNCTIONMACRO
		
		//create the where clause based on if rawData has uniqueID or not
		LOCAL whereClause := 'LEFT.UltID = RIGHT.inquiredBusiness.ultID AND ' +
										'LEFT.OrgID = RIGHT.inquiredBusiness.orgID AND ' +
										'LEFT.SeleID = RIGHT.inquiredBusiness.seleID' + 
										IF(rawIncludesUniqueID, ' AND LEFT.uniqueID = RIGHT.seq', DueDiligence.Constants.EMPTY);
				
		//if rawData has uniqueID field, assuming unquieness - otherwise remove duplicate rows
		//should only have duplicate rows if a given business was added to the file twice
		LOCAL uniqueRawRows := IF(rawIncludesUniqueID = FALSE, DEDUP(rawData, ALL), rawData);
		
		LOCAL joinResult := JOIN(uniqueRawRows, datasetToJoinTo, 
												#EXPAND(whereClause), 
												TRANSFORM({RECORDOF(LEFT), UNSIGNED4 seq, UNSIGNED4 historyDate},
																	SELF.seq := RIGHT.seq;
																	SELF.historyDate := RIGHT.historyDate;
																	SELF := LEFT), 
												FEW); 
												
		RETURN joinResult;										
	ENDMACRO;
  
  
  EXPORT GetBEOAsSlimPerson(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData, BOOLEAN onlyUniqueBEOs) := FUNCTION
  
    //get all the BEOs with lexID
    allBEOs := NORMALIZE(inData, LEFT.beos(lexID > 0), TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails,
                                                              SELF.lexID := RIGHT.lexID;
                                                              SELF.historyDate := LEFT.historyDate;
                                                              SELF := [];));
  
  
    uniqueBEOs := DEDUP(SORT(allBEOs, lexID), lexID);
    
    finalBEOs := IF(onlyUniqueBEOs, uniqueBEOs, allBEOs);

    RETURN finalBEOs;
  END;
  
  
  EXPORT GetBEOBusiness(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION
    
    //get all the BEOs with lexID
    RETURN NORMALIZE(inData, LEFT.beos(lexID > 0), TRANSFORM(DueDiligence.v3Layouts.InternalBusiness.BusinessBEO,
                                                              SELF.seq := LEFT.seq;
                                                              SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                              SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                              SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                              SELF.beoLexID := RIGHT.lexID;
                                                              SELF := [];));
  END;
  
  EXPORT GetBusinessShellOptions(DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION
  
    options := MODULE(Business_Risk_BIP.LIB_Business_Shell_LIBIN)
        EXPORT UNSIGNED1	DPPA_Purpose 				:= regulatoryAccess.dppa;
        EXPORT UNSIGNED1	GLBA_Purpose 				:= regulatoryAccess.glba;
        EXPORT STRING50		DataRestrictionMask	:= regulatoryAccess.drm;
        EXPORT STRING50		DataPermissionMask	:= regulatoryAccess.dpm;
        EXPORT STRING10		IndustryClass				:= regulatoryAccess.industryClass;
        EXPORT UNSIGNED1	LinkSearchLevel			:= Business_Risk_BIP.Constants.LinkSearch.SeleID;
        EXPORT UNSIGNED1	BusShellVersion			:= Business_Risk_BIP.Constants.Default_BusShellVersion;
        EXPORT UNSIGNED1	MarketingMode				:= Business_Risk_BIP.Constants.Default_MarketingMode;
        EXPORT STRING50		AllowedSources			:= Business_Risk_BIP.Constants.Default_AllowedSources;
        EXPORT UNSIGNED1	BIPBestAppend	 			:= Business_Risk_BIP.Constants.BIPBestAppend.OverwriteWithBest;  //Get whatever we think is the best data
    END;
    
    RETURN options;  
  END;
  
  EXPORT GetLinkingOptions(DueDiligence.DDInterface.iDDRegulatoryCompliance regulatoryAccess) := FUNCTION
    
    linkingOptions := MODULE(BIPV2.mod_sources.iParams)
        EXPORT STRING DataRestrictionMask := regulatoryAccess.drm;
        EXPORT BOOLEAN ignoreFares := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore FARES data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
        EXPORT BOOLEAN ignoreFidelity := FALSE; // From AutoStandardI.DataRestrictionI, this is a User Configurable Input Option to Ignore Fidelity data - default it to FALSE to always utilize whatever the DataRestrictionMask allows
        EXPORT BOOLEAN AllowAll := FALSE;
        EXPORT BOOLEAN AllowGLB := Risk_Indicators.iid_constants.GLB_OK(regulatoryAccess.glba, FALSE);
        EXPORT BOOLEAN AllowDPPA := Risk_Indicators.iid_constants.DPPA_OK(regulatoryAccess.dppa, FALSE);
        EXPORT UNSIGNED1 DPPAPurpose := regulatoryAccess.dppa;
        EXPORT UNSIGNED1 GLBPurpose := regulatoryAccess.glba;
        EXPORT BOOLEAN IncludeMinors := TRUE; // Shouldn't really have an impact on business searches, set to TRUE for now
        EXPORT BOOLEAN LNBranded := TRUE; // Not entirely certain what effect this has	
    END;
    
    RETURN linkingOptions;
  END;
  
  EXPORT IsRequestedModuleBeingRequested(STRING moduleName, DueDiligence.DDInterface.iDDv3BusinessAttributes attributesRequested) := FUNCTION
        
        economicAttrs := attributesRequested.includeAssetOwnProperty OR attributesRequested.includeAssetOwnAircraft OR
                          attributesRequested.includeAssetOwnWatercraft OR attributesRequested.includeAssetOwnVehicle OR
                          attributesRequested.includeAccessToFundSales OR attributesRequested.includeAccessToFundsProperty;
                          
        operatingAttrs := attributesRequested.includeGeographic OR attributesRequested.includeValidity OR
                          attributesRequested.includeStability OR attributesRequested.includeIndustry OR
                          attributesRequested.includeStructureType OR attributesRequested.includeSOSAgeRange OR
                          attributesRequested.includePublicRecordAgeRange OR attributesRequested.includeShellShelf;
                          
        legalAttrs := attributesRequested.includeStateLegalEvent OR attributesRequested.includeCivilLegalEvent OR attributesRequested.includeOffenseType;
        networkAttrs := attributesRequested.includeBEOProfLicense OR attributesRequested.includeBEOUSResidency;
        
        
        modUpper := STD.Str.ToUpperCase(moduleName);
        
        RETURN MAP(modUpper = DueDiligence.ConstantsQuery.MODULE_ECONOMIC AND (attributesRequested.includeAll OR economicAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_OPERATING AND (attributesRequested.includeAll OR operatingAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_LEGAL AND (attributesRequested.includeAll OR legalAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_NETWORK AND (attributesRequested.includeAll OR networkAttrs) => TRUE,
                   FALSE);
    END;
END;