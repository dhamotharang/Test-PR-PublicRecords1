import _control, tools;

PRTE2_Business_Header.Spray(
	 pversion				:= '20170718'
	,pServerIP			:= _control.IPAddress.bctlpedata12
	,pDirectory			:= '/data/data_build_4/prct/BusinessHeader/'
	,pFilenameBH		:= '*prct__businessrecs___lnpr_20170718*txt'
	,pFilenameBC		:= '*prct__businessrecs__contacts_lnpr*20170712*txt'	
	,pGroupName			:= tools.fun_Clustername_DFU()																
	,pIsTesting			:= false
	,pOverwrite			:= false
	,pExistSprayed	:= PRTE2_Business_Header._Flags.ExistCurrentSprayed
	,pNameOutput		:= PRTE2_Business_Header._Constants().Name + ' Spray Info'	
);