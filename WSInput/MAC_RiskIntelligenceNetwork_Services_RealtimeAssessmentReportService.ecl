EXPORT MAC_RiskIntelligenceNetwork_Services_RealtimeAssessmentReportService := MACRO
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
    'IdentityReportRequest'
  ));	
ENDMACRO;