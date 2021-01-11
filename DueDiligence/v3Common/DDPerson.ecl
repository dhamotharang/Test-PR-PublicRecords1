IMPORT DueDiligence, STD;


EXPORT DDPerson := MODULE

    SHARED fn_normalizeRelationships(ds, dsNameFromInquired, relationshipToInquired) := FUNCTIONMACRO
            
            RETURN NORMALIZE(ds, LEFT.dsNameFromInquired, 
                              TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails,
                                        SELF.seq := LEFT.seq;
                                        SELF.inquiredDID := LEFT.inquiredDID;
                                        SELF.relationToInquired := relationshipToInquired;
                                        SELF.historyDate := LEFT.historyDate;
                                        SELF := RIGHT;
                                        SELF := [];));
    ENDMACRO;
    
    
    
    EXPORT GetRelationships(DATASET(DueDiligence.v3Layouts.Internal.PersonTemp) inquiredData, BOOLEAN unique, STRING3 relationshipToReturn) := FUNCTION
      
    
        parents := fn_normalizeRelationships(inquiredData, parents, DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT);
        spouses := fn_normalizeRelationships(inquiredData, spouses, DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE);
        associates := fn_normalizeRelationships(inquiredData, associations, DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION);
        subjects := PROJECT(inquiredData, TRANSFORM(DueDiligence.v3Layouts.InternalPerson.SlimPersonDetails,
                                                    SELF.seq := LEFT.seq;
                                                    SELF.inquiredDID := LEFT.inquiredDID;
                                                    SELF.relationToInquired := DueDiligence.Constants.INQUIRED_INDIVIDUAL;
                                                    SELF.historyDate := LEFT.historyDate;
                                                    SELF.lexID := LEFT.inquiredDID;
                                                    SELF := LEFT.inquired;
                                                    SELF := [];));
        
        
        
        trimRel := TRIM(relationshipToReturn);
        
        allInd := MAP(trimRel = 'ALL' =>  parents + spouses + associates + subjects,
                      trimRel = DueDiligence.Constants.INQUIRED_INDIVIDUAL_PARENT => parents,
                      trimRel = DueDiligence.Constants.INQUIRED_INDIVIDUAL_SPOUSE => spouses,
                      trimRel = DueDiligence.Constants.INQUIRED_INDIVIDUAL_OTHER_RELATION => associates,
                      trimRel = DueDiligence.Constants.INQUIRED_INDIVIDUAL => subjects,
                      parents + spouses + associates + subjects);                      


        //make sure we have unique persons so we do not have to make multiple calls for the same person    
        filtAll := DEDUP(SORT(allInd, lexID), lexID);
        
        relationships := IF(unique, filtAll, allInd);
        
        RETURN relationships;
    END;
    
        
    
    EXPORT IsRequestedModuleBeingRequested(STRING moduleName, DueDiligence.DDInterface.iDDv3PersonAttributes attributesRequested) := FUNCTION
        
        economicAttrs := attributesRequested.includeAssetOwnProperty OR attributesRequested.includeAssetOwnAircraft OR
                          attributesRequested.includeAssetOwnWatercraft OR attributesRequested.includeAssetOwnVehicle OR
                          attributesRequested.includeAccessToFundsIncome OR attributesRequested.includeAccessToFundsProperty;
                          
        geographicAttrs := attributesRequested.includeGeographic OR attributesRequested.includeMobility;
        
        legalAttrs := attributesRequested.includeStateLegalEvent OR attributesRequested.includeCivilLegalEvent OR 
                      attributesRequested.includeOffenseType OR attributesRequested.includeCivilLegalEventFilingAmount;
        
        identAttrs := attributesRequested.includeAgeRange OR attributesRequested.includeIdentityRisk OR  attributesRequested.includeUSResidency;
        networkAttrs := attributesRequested.includeAssociates OR attributesRequested.includeProfLicense OR attributesRequested.includeBusAssociations;
        
        
        modUpper := STD.Str.ToUpperCase(moduleName);
        
        RETURN MAP(modUpper = DueDiligence.ConstantsQuery.MODULE_ECONOMIC AND (attributesRequested.includeAll OR economicAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_GEOGRAPHIC AND (attributesRequested.includeAll OR geographicAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_IDENTITY AND (attributesRequested.includeAll OR identAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_LEGAL AND (attributesRequested.includeAll OR legalAttrs) => TRUE,
                   modUpper = DueDiligence.ConstantsQuery.MODULE_NETWORK AND (attributesRequested.includeAll OR networkAttrs) => TRUE,
                   FALSE);
    END;


END;