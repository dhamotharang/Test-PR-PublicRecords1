import versioncontrol,_control,uspis_hotlist;

export Send_Email(
	
	 pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

):= module

	export notificationlist := if(VersionControl._Flags.IsDataland
																,_Control.myinfo.EmailAddressNotify
																,'Angela.Herzberg@LexisNexis.com;'  + _Control.myinfo.EmailAddressNotify
															);
							
	export build_success := fileservices.sendemail(
													notificationlist,
													'Email Data Build Succeeded ' + (string)pversion,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												notificationlist,
												'Email Data  '+(string) pversion+' Build FAILED',
												workunit + '\n' + failmessage);						


end;