import VersionControl;
export SendEmail(
	
	 string		pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true
	,boolean	pShouldSendRoxieEmail		= true

) :=
module

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notificaton_Lists.BuildSuccess,
													'PAW Roxie Build Succeeded ' +pversion,
											'Sample records are in WUID: ' + workunit);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notificaton_Lists.BuildFailure,
													'PAW Build ' + pversion + ' Failed',
													workunit + '\n' + failmessage);
		
	shared lpackage 		:= keynames(pversion,pUseOtherEnvironment).dall_filenames;
	shared lfcrapackage := keynames(pversion,pUseOtherEnvironment).fcra.dall_filenames;
	shared lemails			:= Email_Notificaton_Lists.Roxie;
	
	export Roxie		:= if(pShouldSendRoxieEmail
												,sequential(
													 VersionControl.fCheckRoxiePackage(lemails,'PAWV2Keys'			,lpackage			,pversion,,pShouldUpdateRoxiePage,'N')
													,VersionControl.fCheckRoxiePackage(lemails,'FCRA_PAWV2Keys'	,lfcrapackage	,pversion,,pShouldUpdateRoxiePage,'F')
											));

end;
