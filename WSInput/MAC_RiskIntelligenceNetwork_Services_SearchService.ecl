EXPORT MAC_RiskIntelligenceNetwork_Services_SearchService := MACRO
  #WEBSERVICE(FIELDS( 
    /*---- Compliance Fields .----*/
    'ApplicationType',
    'DataPermissionMask',
    'DataRestrictionMask',
    'DLMask',
    'DOBMask',
    'DPPAPurpose',
    'GLBPurpose',
    'IndustryClass',
    'SSNMask',
    /*---- ESDL Request Field ----*/
    'IdentitySearchRequest'
  ));	
ENDMACRO;