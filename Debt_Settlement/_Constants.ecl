import tools;
export _Constants(

	boolean	pUseOtherEnvironment	= false
	
) :=
tools.Constants(

	 pDatasetName					:= 'Debt_Settlement'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
	,pAutokey_Skipset     := ['C','F']  //Don't build person and skip FEIN for business
);