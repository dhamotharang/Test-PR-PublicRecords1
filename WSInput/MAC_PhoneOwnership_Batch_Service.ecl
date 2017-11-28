EXPORT MAC_PhoneOwnership_Batch_Service := MACRO
	#WEBSERVICE(FIELDS(	
											/*---- Compliance Fields ----*/											
											'ApplicationType',
											'DataPermissionMask',
											'DataRestrictionMask',
											'dobMask',
											'DPPAPurpose',
											'GLBPurpose',
											'IndustryClass',
											'ssnMask',
											'blind',
											/*---- Gateways Fields ----*/
											'gateways',
											/*---- batch_in Fields .----*/
											'batch_in',
											/*---- PO Fields ----*/
											'contact_risk_flag',
											'MaxIdentityCount',
											'search_level',
											'return_current',											
											'reverse_phonescore_model',
											/*---- Zumigo Fields ----*/
											'use_case',
											'product_code',
											'billing_id',
											'AccountInfo',
											'CallHandlingInfo',
											'CarrierInfo',
											'NameAddressInfo',
											'NameAddressValidation',
											'DeviceHistory',
											'DeviceInfo',
											'OptInDuration',
											'OptInId',
											'OptInMethod',
											'OptInTimestamp',
											'OptInType',
											'OptInVersionid',
											
											/*---- Royalty Field ----*/
											'ReturnDetailedRoyalties')
							);								
ENDMACRO;