import VersionControl;
export Send_Emails(
	
	 string		pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true
	,boolean	pShouldSendRoxieEmail		= true

) :=
module

	export BuildSuccess	:= fileservices.sendemail(
													 Email_Notificaton_Lists.BuildSuccess
													,_Dataset().Name + '(Execs At Home) Roxie Build Succeeded ' + pversion
													,workunit
												);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notificaton_Lists.BuildFailure,
													_Dataset().Name + '(Execs At Home) Build ' + pversion + ' Failed',
													workunit + '\n' + failmessage);
		
	shared lpackage := keynames(pversion,pUseOtherEnvironment).dall_filenames		;
	
	shared lemails	:= Email_Notificaton_Lists.Roxie;

	export Roxie		:= if(pShouldSendRoxieEmail
												,VersionControl.fCheckRoxiePackage(lemails,'BusinessBestKeys'	,lpackage	,pversion,,pShouldUpdateRoxiePage,'N')
												,BuildSuccess
										);

end;
