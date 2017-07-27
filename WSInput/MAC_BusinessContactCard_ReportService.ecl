// This service created to add #WEBSERVICE fields for BusinessContactCard.ReportService

EXPORT MAC_BusinessContactCard_ReportService := MACRO

    #WEBSERVICE(FIELDS(
		                    /*---- Compliance Fields ----*/
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
		                    'BCCReportRequest'
											)); 
		 
ENDMACRO;