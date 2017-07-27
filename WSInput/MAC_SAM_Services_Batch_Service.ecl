EXPORT MAC_SAM_Services_Batch_Service := MACRO
	#WEBSERVICE(FIELDS(
			/*---- Compliance Fields ----*/	
			'Max_Results_Per_Acct',
			'DPPAPurpose',
			'GLBAPurpose',
			'DataRestrictionMask',
			'DataPermissionMask',
			'IndustryClass',
			/*---- Search Fields ----*/
			'Batch_In',
			'BIPFetchLevel'
			));
	
ENDMACRO;