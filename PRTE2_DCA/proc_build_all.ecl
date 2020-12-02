IMPORT $,_control;

EXPORT proc_build_all(string version) := FUNCTION
#workunit('name', 'PRTE DCA Build - ' + version);

	run_fSpray			:= prte2_DCA.fspray;
	
	build_base_file	:=	PRTE2_DCA.proc_build_base(version);

	build_keys 			:=	PRTE2_DCA.proc_build_keys(version);
	
	run_build_orbit := PRTE2_DCA.Orbit_Build(version);

	return_val := 	sequential(run_fSpray,	
														 build_base_file, 
														 build_keys,
														 run_build_orbit
														 ): 
																Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'DCA Build Succeeded', workunit + ': Build completed.')),
																Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'DCA Build Failed', workunit + '\n' + FAILMESSAGE)
														);
														 

	return return_val;

END;