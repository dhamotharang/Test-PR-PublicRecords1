import _control, tools;

EXPORT _Constants(

	 boolean	pUseOtherEnvironment	= false
	,string		pDatasetname					= 'PRTE'

) := module

	export constants := tools.Constants(
																			pDatasetName					:= pDatasetname
														 				 ,pUseOtherEnvironment	:= pUseOtherEnvironment
														 				 ,pGroupname						:= ''
														 				 ,pMaxRecordSize				:= 4096
																		 ,pIsTesting						:= Tools._Constants.IsDataland
																		 );

	export sServerIP									:= _control.IPAddress.bctlpedata12;
	export sDirectory									:= '/data/prct/infiles/dev_16/';  

end;