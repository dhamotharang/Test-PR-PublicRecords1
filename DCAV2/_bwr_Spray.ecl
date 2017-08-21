import _control;

DCAV2.Spray(
	 pversion				:= '20120917'
	,pServerIP			:= _control.IPAddress.edata10
	,pDirectory			:= '/prod_data_build_13/eval_data/dca/test/20120917'
	,pFilenameint		:= '*ddca*int*txt'
	,pFilenameprv		:= '*ddca*prv*txt'
	,pFilenamepub		:= '*ddca*pub*txt'
	,pFilenamepriv	:= '*privco*txt'
	,pFilenamePeop	:= '*corpaffilPeople*txt'
	,pFilenamePos		:= '*corpaffilPositions*txt'
	,pFilenameBoard	:= '*corpaffilBoards*txt'
	,pFilenameKill	:= '*KillReport*txt'
	,pFilenameMA		:= '*M_A_*txt'
	,pGroupName			:= dcav2._Constants().groupname																		
	,pIsTesting			:= false
	,pOverwrite			:= false
	,pExistSprayed	:= dcav2._Flags.ExistCurrentSprayed
	,pNameOutput		:= dcav2._Constants().Name + ' Spray Info'	
);
