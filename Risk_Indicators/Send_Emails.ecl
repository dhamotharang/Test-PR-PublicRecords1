import VersionControl,ACA;
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
		
	shared lNonFCRA_HRIpackage	:= keynames(pversion,pUseOtherEnvironment).NonFCRA_dAll_filenames		;
	shared lFCRA_HRIpackage 		:= keynames(pversion,pUseOtherEnvironment).FCRA_dAll_filenames			;
	
	shared lemails	:= Email_Notificaton_Lists.Roxie;

	export FCRAAddressHRIEmail		:= if(pShouldSendRoxieEmail
																	,VersionControl.fCheckRoxiePackage(lemails,'FCRA_AddressHRIKeys'	,lFCRA_HRIpackage		,pversion,,pShouldUpdateRoxiePage)
																	,BuildSuccess
																);
	
	export NonFCRAAddressHRIEmail		:= if(pShouldSendRoxieEmail
																	,VersionControl.fCheckRoxiePackage(lemails,'AddressHRIKeys'				,lNonFCRA_HRIpackage,pversion,,pShouldUpdateRoxiePage)
																	,BuildSuccess
																);

	export Roxie		:= sequential(
													 ACA.Send_Emails(pversion,pUseOtherEnvironment,pShouldUpdateRoxiePage,pShouldSendRoxieEmail).Roxie			
													,FCRAAddressHRIEmail
													,NonFCRAAddressHRIEmail
										);

end;
