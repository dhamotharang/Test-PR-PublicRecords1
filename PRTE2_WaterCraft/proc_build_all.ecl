import $, _control;
EXPORT proc_build_all (string version) := FUNCTION

	run_all := SEQUENTIAL(prte2_watercraft.fSpray, 
												prte2_watercraft.proc_build_base(version), 
												prte2_watercraft.proc_build_keys(version), 
												prte2_watercraft.orbit_builds(version)
												) :
												Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'Watercraft Build Succeeded', workunit + ': Build completed.')),
												Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'Watercraft Build Failed', workunit + '\n' + FAILMESSAGE)
												);
	
RETURN run_all;
END;