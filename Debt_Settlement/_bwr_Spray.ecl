Debt_Settlement.Spray(

	 pversion			:= ''
	,pServerIP		:= _control.IPAddress.edata10
	,pDirectory		:= '/prod_data_build_13/eval_data/debt_settlement/'
	,pFilename1		:= 'attroney_file_did_stats*.csv'
	,pFilename2		:= 'DebtSettlementCreditCounsel*.csv'
	,pGroupName		:= Debt_Settlement._Constants().groupname																		
	,pIsTesting		:= false
	,pOverwrite		:= false
	,pNameOutput	:= Debt_Settlement._Constants().Name + ' Spray Info'

);