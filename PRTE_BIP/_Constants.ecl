import _control, tools;

export _Constants( boolean	pUseOtherEnvironment	= false ) := module

	export Constants := tools.Constants(
																			pDatasetName					:= 'PRTE_BIP'
																		 ,pUseOtherEnvironment	:= pUseOtherEnvironment
																		 ,pGroupname						:= ''
																		 ,pMaxRecordSize				:= 4096
																		 ,pIsTesting						:= Tools._Constants.IsDataland
																		 );
				
	export unsigned6 BH_INIT_BDID 		:= 7777000000000;
	export unsigned6 BH_INIT_DID 			:= 8888000000000;
	export unsigned6 BH_INIT_DOTID 		:= 9999999999999;
	export unsigned6 BH_INIT_EMPID 		:= 9999999999999;
	export unsigned6 BH_INIT_POWID 		:= 9999999999999;
	export unsigned6 BH_INIT_PROXID 	:= 9999999999999;
	export unsigned6 BH_INIT_SELEID 	:= 9999999999999;
	export unsigned6 BH_INIT_LGID3 		:= 9999999999999;	
	export unsigned6 BH_INIT_ORGID 		:= 9999999999999;
	export unsigned6 BH_INIT_ULTID 		:= 9999999999999;
	export unsigned6 MAX_UNSIGNED6		:= 281474976710655;

	export sServerIP									:= _control.IPAddress.edata12;
	export sDirectory									:= '/data_999/tkirk/prte_extracts/';

end;