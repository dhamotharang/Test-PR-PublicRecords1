export Proc_Build_All(string pLandingzone = '', string pVersion) := module

	export Spray_input := FLCrash_SprayInput(pVersion, , , pLandingzone) : success(output('Input sprayed'));
	export Build_input := Proc_build_input : success(output('Input built'));
	export Build_basefiles := FLCrash_BuildFile : success(output('BASE Files created'));
	export Build_did_file := FLCrash_BuildDidFile : success(output('DID file built'));
  export Build_ss_file := FLCrash_BuildSSFile : success(output('Base SS file built'));
  export Build_consolidationBase_file	:= FLCrash_BuildConsolidatedBaseFile : success(output('Consolidation Base file built'));
	export Build_ROXIE_keys	:= FLCrash_BuildKeys : success(output('ROXIE Keys built'));
  // export Build_MOXIE_keys := Out_MOXIE_FLAccidents_Keys	: success(output('MOXIE keys created'));
	// export Build_AUTOKEYS := Proc_build_autokey	: success(output('AUTOKEYS keys created'));
  // export Despray_Dkc_All := DKC_FLAccidents_Keys(pDestinationIP, pDestinationVolume)
																		//	: success(output('Despray/DKC finished'));
	Proc_build_stats(pVersion,zDoStatsReference);
	export Proc_build_stat := 	zDoStatsReference : success(output('Stats created successfully'));
  export Sample_data :=	Sample_data : success(output('Samples ready'));

	export All := sequential(
										       fn_CreateSuperFiles_FLAccidents(),
										       Spray_input,
										       Build_input,
										       Build_basefiles,
										       Build_did_file,
										       Build_ss_file,
										       Build_consolidationBase_file,
										       // Build_ROXIE_keys,
										       // Build_AUTOKEYS,
										       Proc_build_stat,
										       Sample_data
										      ) : success(Send_Email(pVersion).Build_Success), failure(Send_Email(pVersion).Build_Failure);
end;