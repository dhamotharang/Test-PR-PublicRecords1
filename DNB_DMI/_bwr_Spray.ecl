import _control;

DNB_DMI.Spray(
	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_10/production_data/business_headers/dnb/test'
	,pFilename		:= 'DMI*'
	,pGroupName		:= DNB_DMI._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= DNB_DMI._Dataset().Name + ' Spray Info'	
);
