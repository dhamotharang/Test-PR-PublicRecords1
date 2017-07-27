// This service created to add Web Service fields for Business_Header.BH_SearchService

EXPORT MAC_BH_SearchService := MACRO

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
													/*---- Other Fields ----*/
												  'BDID',
                          'BDIDOnly',
											    'ExactOnly',
													/*---- ESDL Request Field ----*/
											    'BusinessSearchRequest'
		                     ));

ENDMACRO;