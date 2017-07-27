// This service created to add Web Service fields for AddressFeedback_Services.ReportService

EXPORT MAC_AddrFeedback_ReportService := MACRO

  #WEBSERVICE(FIELDS(	
										/*---- Compliance Fields ----*/
										'ApplicationType',
										'DataPermissionMask',
										'DataRestrictionMask',
										'DLMask',
										'dobMask',
										'DPPAPurpose',
										'GLBPurpose',
										'IndustryClass',
										'ssnMask',
										/*---- Other Fields ----*/
										'DID',
										'Addr',
                    'City',
                    'State',
                    'Zip',
										'AddressfeedbackReportRequest'
									));
ENDMACRO;	