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
													,_Dataset().Name + ' Roxie Build Succeeded ' + pversion
													,workunit
												);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notificaton_Lists.BuildFailure,
													_Dataset().Name + ' Build ' + pversion + ' Failed',
													workunit + '\n' + failmessage);
		
	shared lpackage := keynames(pversion,pUseOtherEnvironment).dall_filenames;
	
	shared lemails	:= Email_Notificaton_Lists.Roxie;

	export ACAEmail	:= VersionControl.fCheckRoxiePackage(lemails,'ACAInstitutionsKeys'	,lpackage	,pversion,,pShouldUpdateRoxiePage,'N');
	
	export Roxie		:= if(pShouldSendRoxieEmail
												,ACAEmail
												,BuildSuccess
											);
end;
