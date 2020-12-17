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
  
  
  EXPORT GetBEOExecDetails(DATASET(DueDiligence.v3Layouts.Internal.BusinessTemp) inData) := FUNCTION
  
    RETURN NORMALIZE(inData, LEFT.beos, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessExec.ExecDetails,
                                                  SELF.seq := LEFT.seq;
                                                  SELF.ultID := LEFT.inquiredBusiness.ultID;
                                                  SELF.orgID := LEFT.inquiredBusiness.orgID;
                                                  SELF.seleID := LEFT.inquiredBusiness.seleID;
                                                  SELF := RIGHT;
                                                  SELF := [];));
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
                          
        legalAttrs := attributesRequested.includeStateLegalEvent OR attributesRequested.includeCivilLegalEvent OR 
                      attributesRequested.includeOffenseType OR attributesRequested.includeCivilLegalEventFilingAmount;
                      
        networkAttrs := attributesRequested.includeBEOProfLicense OR attributesRequested.includeBEOUSResidency OR attributesRequested.includeBEOAccessToFundsProperty;
        
        
        modUpper := STD.Str.ToUpperCase(moduleName);
        
        RETURN MAP(modUpper = DueDiligence.ConstantsQuery.MODULE_ECONOMIC AND (attributesRequested.includeAll OR economicAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_OPERATING AND (attributesRequested.includeAll OR operatingAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_LEGAL AND (attributesRequested.includeAll OR legalAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_NETWORK AND (attributesRequested.includeAll OR networkAttrs) => TRUE,
                   FALSE);
    END;
    
    
     EXPORT GetUniqueIndustries(industryIn, useSIC) := FUNCTIONMACRO
        
        LOCAL rollCondition := 'LEFT.seq = RIGHT.seq AND ' +
                                'LEFT.ultID = RIGHT.ultID AND ' +
                                'LEFT.orgID = RIGHT.orgID AND ' +
                                'LEFT.seleID = RIGHT.seleID AND ' +
                                IF(useSIC, 'LEFT.sicCode = RIGHT.sicCode', 'LEFT.naicsCode = RIGHT.naicsCode');
                                
        LOCAL sortCondition := 'seq, ultID, orgID, seleID, ' +
                                IF(useSIC, 'sicCode, ', 'naicsCode, ') +
                                '-dateLastSeen';
                                
        LOCAL accountForSingletons := PROJECT(industryIn, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                                                    SELF.sicCode := IF(useSIC, LEFT.sicCode, '');
                                                                    SELF.naicsCode := IF(useSIC, '', LEFT.naicsCode);
                                                                    SELF := LEFT;));
        
        
        RETURN ROLLUP(SORT(accountForSingletons, #EXPAND(sortCondition)),
                      #EXPAND(rollCondition),
                      TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                SELF.dateFirstSeen := IF(LEFT.dateFirstSeen = 0 OR RIGHT.dateFirstSeen = 0, MAX(LEFT.dateFirstSeen, RIGHT.dateFirstSeen), MIN(LEFT.dateFirstSeen, RIGHT.dateFirstSeen));
                                SELF.dateLastSeen := MAX(LEFT.dateLastSeen, RIGHT.dateLastSeen);
                                SELF.isBest := LEFT.isBest OR RIGHT.isBest;
                                SELF := LEFT;));
                                                                      
    ENDMACRO;
    
    SHARED GetRiskiestIndustryLevel(STRING5 industry, STRING7 riskLevel) := FUNCTION
        
        //higher the number the riskier the industry code
        //these numbers are managed in the ENUM for add flexibility and futurability
        RETURN MAP(industry = DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_NON_RETAIL => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.CASH_INTENSE_NON_RETAIL,
                   industry = DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_RETAIL => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.CASH_INTENSE_RETAIL,
                   industry = DueDiligence.ConstantsIndustry.MONEY_SERVICE_BUSINESS => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.MSB,
                   industry = DueDiligence.ConstantsIndustry.NON_BANK_FINANCIAL_INSTITUTIONS => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.NON_BANK_FIN_INST,
                   industry = DueDiligence.ConstantsIndustry.CASINO_AND_GAMING => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.CASINO_GAMING,
                   industry = DueDiligence.ConstantsIndustry.LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.LEGAL_ACCT_TELEM_FLIGHT_TRAVEL,
                   industry = DueDiligence.ConstantsIndustry.AUTOMOTIVE => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.AUTOMOTIVE,
                   riskLevel = DueDiligence.ConstantsIndustry.RISK_LEVEL_HIGH => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.HIGH,
                   riskLevel = DueDiligence.ConstantsIndustry.RISK_LEVEL_MEDIUM => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.MEDIUM,
                   riskLevel = DueDiligence.ConstantsIndustry.RISK_LEVEL_LOW => DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.LOW,
                   DueDiligence.ConstantsIndustry.RISK_LEVEL_ENUM.UNKNOWN);
    END;
   
    
    
    EXPORT GetIndustryRisk(DATASET(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim) inData) := FUNCTION
        
        RETURN PROJECT(inData, TRANSFORM(DueDiligence.v3Layouts.InternalBusinessIndustry.IndustrySlim,
                                         
                                         sic := TRIM(LEFT.SICCode, ALL);
																				 lengthOfSic := LENGTH(sic);
                                         
                                         sicIndustry := MAP(sic = DueDiligence.Constants.EMPTY => sic,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_CIB_RETAIL => DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_RETAIL,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_CIB_NON_RETAIL => DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_NON_RETAIL,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_MSB => DueDiligence.ConstantsIndustry.MONEY_SERVICE_BUSINESS,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_NBFI => DueDiligence.ConstantsIndustry.NON_BANK_FINANCIAL_INSTITUTIONS,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_CASGAM => DueDiligence.ConstantsIndustry.CASINO_AND_GAMING,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_LEGTRAV => DueDiligence.ConstantsIndustry.LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
                                                            sic IN DueDiligence.ConstantsIndustry.SIC_AUTO => DueDiligence.ConstantsIndustry.AUTOMOTIVE,
                                                            DueDiligence.ConstantsIndustry.OTHER);
                                                                  
                                         sicRiskLevel := MAP(sic = DueDiligence.Constants.EMPTY => sic,
                                                              lengthOfSic = 2 AND sic IN DueDiligence.ConstantsIndustry.SIC_LENGTH_2_RISK_HIGH => DueDiligence.ConstantsIndustry.RISK_LEVEL_HIGH,
                                                              lengthOfSic = 4 AND (sic IN DueDiligence.ConstantsIndustry.SIC_LENGTH_4_RISK_HIGH OR 
                                                                                    sic[1..2] IN DueDiligence.ConstantsIndustry.SIC_FIRST_2_STAR_RISK_HIGH) => DueDiligence.ConstantsIndustry.RISK_LEVEL_HIGH,
                                                              lengthOfSic = 6 AND (sic IN DueDiligence.ConstantsIndustry.SIC_LENGTH_6_RISK_HIGH OR 
                                                                                    sic[1..2] IN DueDiligence.ConstantsIndustry.SIC_FIRST_2_STAR_RISK_HIGH OR
                                                                                    sic[1..4] IN DueDiligence.ConstantsIndustry.SIC_FIRST_4_STAR_RISK_HIGH) => DueDiligence.ConstantsIndustry.RISK_LEVEL_HIGH,
                                                              lengthOfSic = 8 AND (sic IN DueDiligence.ConstantsIndustry.SIC_LENGTH_8_RISK_HIGH OR
                                                                                    sic[1..2] IN DueDiligence.ConstantsIndustry.SIC_FIRST_2_STAR_RISK_HIGH OR
                                                                                    sic[1..4] IN DueDiligence.ConstantsIndustry.SIC_FIRST_4_STAR_RISK_HIGH OR
                                                                                    sic[1..6] IN DueDiligence.ConstantsIndustry.SIC_FIRST_6_STAR_RISK_HIGH) => DueDiligence.ConstantsIndustry.RISK_LEVEL_HIGH,
                                                              DueDiligence.ConstantsIndustry.RISK_LEVEL_LOW);
                                         
                                         
                                         
                                         naic := TRIM(LEFT.naicsCode, ALL);
																				 naic2 := naic[1..2];
                                         
                                         naicsIndustry := MAP(naic = DueDiligence.Constants.EMPTY => naic,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_CIB_RETAIL => DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_RETAIL,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_CIB_NON_RETAIL => DueDiligence.ConstantsIndustry.CASH_INTENSIVE_BUSINESS_NON_RETAIL,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_MSB => DueDiligence.ConstantsIndustry.MONEY_SERVICE_BUSINESS,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_NBFI => DueDiligence.ConstantsIndustry.NON_BANK_FINANCIAL_INSTITUTIONS,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_CASGAM => DueDiligence.ConstantsIndustry.CASINO_AND_GAMING,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_LEGTRAV => DueDiligence.ConstantsIndustry.LEGAL_ACCOUNTANT_TELEMARKETER_FLIGHT_TRAVEL,
                                                               naic IN DueDiligence.ConstantsIndustry.NAICS_AUTO => DueDiligence.ConstantsIndustry.AUTOMOTIVE,
                                                               DueDiligence.ConstantsIndustry.OTHER);
																																			
                                         naicsRiskLevel := MAP(naic = DueDiligence.Constants.EMPTY => naic,
                                                                naic2 IN DueDiligence.ConstantsIndustry.NAICS_RISK_HIGH OR
                                                                naic IN DueDiligence.ConstantsIndustry.NAICS_RISK_HIGH_EXCEP => DueDiligence.ConstantsIndustry.RISK_LEVEL_HIGH,
                                                                naic2 IN DueDiligence.ConstantsIndustry.NAICS_RISK_MED => DueDiligence.ConstantsIndustry.RISK_LEVEL_MEDIUM,
                                                                naic2 IN DueDiligence.ConstantsIndustry.NAICS_RISK_LOW => DueDiligence.ConstantsIndustry.RISK_LEVEL_LOW,
                                                                DueDiligence.ConstantsIndustry.RISK_LEVEL_UNKNOWN);
                                                                    
                                                                    
                                         SELF.sicIndustry := sicIndustry;
                                         SELF.sicRiskLevel := sicRiskLevel;
                                         SELF.naicsIndustry := naicsIndustry;
                                         SELF.naicsRiskLevel := naicsRiskLevel;
                                                                    
                                         
                                         SELF.riskiestOverallLevel := IF(sic = DueDiligence.Constants.EMPTY,
                                                                         GetRiskiestIndustryLevel(naicsIndustry, naicsRiskLevel),
                                                                         GetRiskiestIndustryLevel(sicIndustry, sicRiskLevel));
                                         
                                         SELF := LEFT;));
        
    END;   
END;