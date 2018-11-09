import _control, tools;

pversion := '20180111';    // Enter version date in CCYYMMDD formate

#workunit ('name', 'SPRAY - PRTE Business Header Input files - ' + pversion);

PRTE2_Business_Header.Spray(
	 pversion				:= pversion
	,pServerIP			:= _control.IPAddress.bctlpedata12
	,pDirectory			:= '/data/data_build_4/prct/BusinessHeader/'
	,pFilenameBH		:= '*prct__businessrecs__*'+pversion+'*txt'
	,pFilenameBC		:= '*prct___businessrecs__contacts_*'+pversion+'*txt'
	,pGroupName			:= tools.fun_Clustername_DFU()																
	,pIsTesting			:= false
	,pOverwrite			:= false
	,pExistSprayed	:= PRTE2_Business_Header._Flags.ExistCurrentSprayed
	,pNameOutput		:= PRTE2_Business_Header._Constants().Name + ' Spray Info'	
);