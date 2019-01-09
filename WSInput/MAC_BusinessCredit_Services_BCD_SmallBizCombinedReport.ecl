// This service created to add Web Service fields
// for BusinessCredit_Services.BCD_SmallBizCombinedReport
// Capital One's Business Credit Decisioning (BCD) service

EXPORT MAC_BusinessCredit_Services_BCD_SmallBizCombinedReport := MACRO

    #WEBSERVICE(FIELDS(
      'BcdSmallBusinessCombinedReportRequest',
      'DPPAPurpose',
      'GLBPurpose',
      'DataRestrictionMask',
      'DataPermissionMask',
      'SSNMask',
      'DOBMask',
      'DLMask',
      'ApplicationType',
      'IndustryClass',
      'Gateways',
      'ReturnDetailedRoyalties',
      'HistoryDateYYYYMM',
      'HistoryDate',
      'Watchlists_Requested',
      'OFAC_Version',
      'LinkSearchLevel',
      'MarketingMode',
      'AllowedSources',
      'Global_Watchlist_Threshold',
      'OutcomeTrackingOptOut',
      'IncludeTargusGateway',
      'RunTargusGatewayAnywayForTesting',
      'TestDataEnabled',
      'TestDataTableName',	 
	 'SBFEContributorIds'
      ));

ENDMACRO;