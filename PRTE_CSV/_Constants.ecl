import _control, tools;

export _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'PRTE_CSV'

) := module

	export constants := tools.Constants(
																			pDatasetName					:= pDatasetname
														 				 ,pUseOtherEnvironment	:= pUseOtherEnvironment
														 				 ,pGroupname						:= ''
														 				 ,pMaxRecordSize				:= 4096
																		 ,pIsTesting						:= Tools._Constants.IsDataland
																		 );

	export sServerIP									:= _control.IPAddress.edata12;
	//export sDirectory									:= '/data_999/tkirk/prte_extracts/';
	export sDirectory									:= '/data_999/prod/prte';

end;