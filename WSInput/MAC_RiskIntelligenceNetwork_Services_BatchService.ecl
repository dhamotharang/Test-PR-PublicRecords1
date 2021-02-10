EXPORT MAC_RiskIntelligenceNetwork_Services_BatchService := MACRO
  #WEBSERVICE(FIELDS( 
    /*---- Compliance Fields .----*/
    'DataPermissionMask',
    'DataRestrictionMask',
    'DPPAPurpose',
    'GLBPurpose',
    'IndustryClass',
    'SSNMask',
    /*---- Fraudgov Fields .----*/
    'GlobalCompanyId',
    'IndustryTypeName',
    'ProductCode',    
    /*---- ESDL Request Field ----*/
    'batch_in'
  ));	
ENDMACRO;
