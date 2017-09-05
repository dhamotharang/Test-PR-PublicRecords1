EXPORT MAC_TaxRefundISv3_BatchService := MACRO
	#WEBSERVICE(FIELDS( 
											/*---- Compliance Fields .----*/
											'ApplicationType',
											'DataPermissionMask',
											'DataRestrictionMask',
											'DLMask',
											'dobMask',
											'DPPAPurpose',
											'GLBPurpose',
											'IndustryClass',
											'ssnMask',
											/*---- FDN Fields .----*/
											'GlobalCompanyId',
											'IndustryType',
											'ProductCode',
											/*---- Other Fields .----*/
											'AddressRiskHRICodes',
											'AllowNickNames',
											'BestNameScoreMin',
											'BestSSNScoreMin',
											'Creditor',
											'DIDScoreThreshold',
											'FilterRule',
											'GetSSNBest',
											'IdentityRiskHRICodes',
											'IncludeBlankDOD',
											'IncludeDependantID',
											'IncludeMinors',
											'InputState',
											'IPAddrExceedsRange',
											'ModelName',
											'PhoneticMatch',
											'RefundThreshold',
											'ReportOnlyHRICodes',
											'ReturnDetailedRoyalties',
											'ScoreCut',
											/*---- Batch_In Request Field .----*/
											'TaxRefund_batch_in'
										));	
ENDMACRO;