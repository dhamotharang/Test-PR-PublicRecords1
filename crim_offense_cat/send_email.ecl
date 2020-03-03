import versioncontrol,_control,uspis_hotlist, std;

export Send_Email(
	
	 string pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

):= module

	export notificationlist := if(VersionControl._Flags.IsDataland
																,_Control.myinfo.EmailAddressNotify
																,'Alan.Jaramillo@LexisNexisRisk.com; Charles.Pettola@lexisnexisrisk.com;'  + _Control.myinfo.EmailAddressNotify
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
