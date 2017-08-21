export Proc_Build_All(string pLandingzone 	= ''
					, string pVersion 			
					
					) := 
module

	export Spray_input			:= FLAccidents.FLCrash_SprayInput(pVersion,,,pLandingzone)			: success(output('Input sprayed'));
	export Build_input			:= FLAccidents.Proc_build_input				: success(output('Input built'));
	export Build_basefiles		:= FLAccidents.FLCrash_BuildFile			: success(output('BASE Files created'));
	export Build_did_file		:= FLAccidents.FLCrash_BuildDidFile			: success(output('DID file built'));
  export Build_ss_file		:= FLAccidents.FLCrash_BuildSSFile			: success(output('Base SS file built'));
	export Build_ROXIE_keys		:= FLAccidents.FLCrash_BuildKeys			: success(output('ROXIE Keys built'));
//	export Build_MOXIE_keys		:= FLAccidents.Out_MOXIE_FLAccidents_Keys	: success(output('MOXIE keys created'));
	export Build_AUTOKEYS		:= FLAccidents.Proc_build_autokey	: success(output('AUTOKEYS keys created'));
//	export Despray_Dkc_All		:= FLAccidents.DKC_FLAccidents_Keys(pDestinationIP, pDestinationVolume)
																		//	: success(output('Despray/DKC finished'));
	FLAccidents.Proc_build_stats(pVersion,zDoStatsReference);
	export Proc_build_stat		:= 	zDoStatsReference						: success(output('Stats created successfully'));
    export Sample_data			:=	FLAccidents.Sample_data	                : success(output('Samples ready'));

	export All := 
	sequential(

				 Spray_input
				,Build_input
				,Build_basefiles
				,Build_did_file
			  ,Build_ss_file
			//	,Build_ROXIE_keys
			//	,Build_AUTOKEYS
				,Proc_build_stat
				,Sample_data

				)  : success(Send_Email(pVersion).Build_Success), failure(Send_Email(pVersion).Build_Failure);

end;