Judges.Spray(
	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_13/eval_data/judge_data/'
	,pFilename		:= '*txt'
	,pGroupName		:= Judges._dataset().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= Judges._Dataset().Name + ' Spray Info'	
);
