import tools;

export _Dataset(

	boolean	pUseOtherEnvironment	= false

) :=
tools.Constants(

	 pDatasetName					:= 'FraudGov'
	,pUseOtherEnvironment	:= pUseOtherEnvironment
	,pGroupname						:= ''
	,pMaxRecordSize				:= 4096 * 9
	,pIsTesting						:= Tools._Constants.IsDataland
	,pAutokey_Skipset			:= []
	,pAutokey_typestr			:= 'AK'
);