import versioncontrol,_control,uspis_hotlist;

//TODO determine who s/b in fullEmailList

EXPORT Send_Build_Email_Notice( 
				 STRING pversion
				,boolean	pUseOtherEnvironment 		= false
				,boolean	pShouldUpdateRoxiePage	= true) 
:= MODULE

	export String currentUserEmail := _constants.BAP_TESTING_EMAIL;
	export String fullEmailList := 'Angela.Herzberg@LexisNexis.com; ' + currentUserEmail;
	export boolean runningInDataLand := VersionControl._Flags.IsDataland;	
	export notificationlist := if( runningInDataLand, currentUserEmail, fullEmailList );
							
	EXPORT build_success := fileservices.sendemail(
													notificationlist,
													'PRCT Email Data (' + (string) pversion+') Build Succeeded ',
													'Sample records OUTPUT in WUID:' + workunit);

	EXPORT build_failure := fileservices.sendemail(
												notificationlist,
												'PRCT Email Data  ('+(string) pversion+') Build FAILED',
												workunit + '\n' + failmessage);						


END;