import _control;
bell_thrive_LT.Spray(
	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_10/production_data/business_headers/dnb/test'
	,pFilename		:= 'DMI*'
	,pGroupName		:= bell_thrive_LT._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= bell_thrive_LT._Dataset().Name + ' Spray Info'	
);
