IMPORT tools;

EXPORT _Dataset(
  string fraud_platform,
	boolean	pUseOtherEnvironment = false
) :=
  tools.Constants(

    pDatasetName					:= fraud_platform
    ,pUseOtherEnvironment	:= pUseOtherEnvironment
    ,pGroupname						:= ''
    ,pMaxRecordSize				:= 4096 * 9
    ,pIsTesting						:= Tools._Constants.IsDataland
    ,pAutokey_Skipset			:= []
    ,pAutokey_typestr			:= 'AK'
  );