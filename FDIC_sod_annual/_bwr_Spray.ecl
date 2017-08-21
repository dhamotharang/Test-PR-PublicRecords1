
FDIC_sod_annual.Spray(

	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= 'edata10:/prod_data_build_13/eval_data/fdic'
	,pFilename		:= '*.csv'
	,pGroupName		:= FDIC_sod_annual._Constants().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= FDIC_sod_annual._Constants().Name + ' Spray Info'	

);
