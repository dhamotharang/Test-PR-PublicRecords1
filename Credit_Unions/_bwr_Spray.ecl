Credit_Unions.Spray(

	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.bctlpedata10
	,pDirectory		:= '/data_build_5_2/credit_union/data/'
	,pFilename		:= '*txt'
	,pGroupName		:= Credit_Unions._Constants().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= Credit_Unions._Constants().Name + ' Spray Info'	

);
