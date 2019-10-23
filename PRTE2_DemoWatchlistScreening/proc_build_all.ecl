IMPORT ut, roxiekeybuild, tools,PRTE2_DemoWatchlistScreening, _control, std;

EXPORT proc_build_all(string filedate, boolean skipDOPS = FALSE) := FUNCTION
#workunit('name','Demo WatchlistScreening PRTE Build'+ filedate);

  spray_file 			:= prte2_DemoWatchlistScreening.fSpray;
	build_base_file	:=	prte2_DemoWatchlistScreening.proc_build_base;
						
	build_keys 			:=	prte2_DemoWatchlistScreening.proc_build_keys(filedate,skipDOPS);
	
	send_email			:= STD.System.Email.SendEmail( _control.MyInfo.EmailAddressNormal, 'PRTE2 DEMO WATCHLIST SCEENING BUILD',
																																										 'PRTE DEMO WATCHLIST SCEENING\n' +
																																										 'VERSION: ' + filedate + '\n' +
																																										 'WORKUNIT: ' + WORKUNIT + '\n' +
																																										 'BUILD SUCCESSFUL \n'
																																										);

	return sequential(spray_file, build_base_file, build_keys, send_email);

END;
