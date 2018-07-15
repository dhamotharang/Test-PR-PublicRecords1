IMPORT Tools;
EXPORT _Constants(

	BOOLEAN	pUseOtherEnvironment	= FALSE

) :=
Tools.Constants(

	 pDatasetName					:= 'Infutor_NARB'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096
	,pIsTesting						:= Tools._Constants.IsDataland
);
