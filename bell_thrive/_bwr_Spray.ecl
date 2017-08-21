import _control;
bell_thrive.Spray(
	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_10/production_data/business_headers/dnb/test'
	,pFilename		:= 'DMI*'
	,pGroupName		:= bell_thrive._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= bell_thrive._Dataset().Name + ' Spray Info'	
);
