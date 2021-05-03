import versioncontrol,_control,uspis_hotlist, std;

export Send_Email(
	
	 string pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

):= module

	export notificationlist := if(VersionControl._Flags.IsDataland
																,'Alan.Jaramillo@LexisNexisRisk.com; Christopher.Brodeur@lexisnexisrisk.com;'
																,'Alan.Jaramillo@LexisNexisRisk.com; Christopher.Brodeur@lexisnexisrisk.com;'
															);
							
	export build_success := STD.System.Email.sendemail(
													notificationlist,
													'crim_offense_cat Build Succeeded ' + pversion,
													'Sample records are in WUID:' + workunit);

	export build_failure := STD.System.Email.sendemail(
												notificationlist,
												'crim_offense_cat  '+ pversion+' Build FAILED',
												workunit + '\n' + failmessage);						


end;
