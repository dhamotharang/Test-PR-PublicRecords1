import tools, _control;

export Build_Base(

	 string															pversion
	,string															pDirectory			= '/data/dl_data/drvlic/bin/isBuildRunning.lck'
	,string															pServerIP				= _control.IPAddress.bctlpedata10
) :=
function

	full_build :=
	sequential(DriversV2.Proc_Build_DL_Base(pversion)
						 , DriversV2.Proc_DL2_QA_Samples
						 , FileServices.DeleteExternalFile(pServerIP, pDirectory)
						);
	
	return
		if(tools.fun_IsValidVersion(pversion)
			,full_build
			,output('No Valid version parameter passed, skipping DriversV2.Build_Base')
		);

end;