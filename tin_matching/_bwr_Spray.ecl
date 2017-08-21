import _control;
tin_matching.Spray(
	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_10/production_data/business_headers/dnb/test'
	,pFilename		:= 'DMI*'
	,pGroupName		:= tin_matching._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= tin_matching._Dataset().Name + ' Spray Info'	
);
