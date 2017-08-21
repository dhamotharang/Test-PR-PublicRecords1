SalesChannel.Spray(
	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/data_build_5_2/credit_union/data/'
	,pFilename		:= '*txt'
	,pGroupName		:= SalesChannel._Constants().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= SalesChannel._Constants().Name + ' Spray Info'	
);

