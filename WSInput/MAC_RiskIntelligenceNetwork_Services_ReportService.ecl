EXPORT MAC_RiskIntelligenceNetwork_Services_ReportService := MACRO
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
    'IdentityRiskReportRequest'
  ));	
ENDMACRO;
