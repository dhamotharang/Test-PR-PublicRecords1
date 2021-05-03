import $, _control;

EXPORT proc_build_all(string version) := FUNCTION
		
	return_val := sequential(
													 prte2_GlobalWatchlists.fspray,
												   prte2_GlobalWatchlists.proc_build_base(version),
													 prte2_GlobalWatchlists.proc_build_keys(version),
													 prte2_GlobalWatchlists.orbit_builds(version)
													 ): Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'GlobalWatchlists Build Succeeded', workunit + ': Build completed.')),
														  Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify, 'GlobalWatchlists Build Build Failed', workunit + '\n' + FAILMESSAGE))
															;
													

return return_val;

END;