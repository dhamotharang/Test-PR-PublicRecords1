export Proc_Build_All(string pDestinationIP 	= ''
					, string pDestinationVolume = ''
					, string pVersion 			=  Births.Version_Development
					, string pInFile	 		=  ''
					) := 
module

	export Spray_input	:= Births.SprayInput(pVersion,pInFile).all	: success(output('INPUT sprayed'));
	export Build_base	:= Births.Proc_Build_base(pVersion).all		: success(output('BASE built'));
	export Build_ROXIE	:= Births.Proc_Build_Keys(pVersion).all		: success(output('ROXIE built'));

	Births.Proc_build_stats(pVersion,zDoStatsReference);
	export Proc_build_stat		:= 	zDoStatsReference	: success(output('Stats created successfully'));
    export Sample_data			:=	Births.Sample_data	: success(output('Samples ready'));

	export All := 
	sequential(

		Spray_input
		,Build_base
		,Build_ROXIE
		,Proc_build_stat
		,Sample_data

	)  : success(Send_Email(pVersion).Build_Success), failure(Send_Email(pVersion).Build_Failure);

end;