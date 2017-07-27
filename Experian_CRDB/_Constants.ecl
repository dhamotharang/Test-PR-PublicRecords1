import tools;
export _Constants(boolean	pUseOtherEnvironment = false) :=
			 tools.Constants( pDatasetName					:= 'Experian_CRDB'
												,pUseOtherEnvironment	:= pUseOtherEnvironment
												,pGroupname						:= ''
												,pMaxRecordSize				:= 4096
												,pIsTesting						:= Tools._Constants.IsDataland
											 );