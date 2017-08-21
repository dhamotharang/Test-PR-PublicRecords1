import VersionControl, _Control;
export Send_Email(
	
	 string		pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

) :=
module

	shared SuccessSubject := if(VersionControl.IsValidVersion(pversion)
															,_dataset().name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,_dataset().name + ' Build Skipped, No version parameter passed to build on ' + _Control.ThisEnvironment.Name
														);
	shared SuccessBody		:= if(VersionControl.IsValidVersion(pversion)
															,workunit
															,workunit + '\nPlease pass in a version date parameter to ' + _dataset().name + '.Build_All and then resubmit through querybuilder.' +
															 '\nSee ' + _dataset().name + '._bwr_Build_All attribute for more details.'
														);
	

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													SuccessSubject,
													SuccessBody);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													_dataset().name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
													workunit + '\n' + failmessage);
/*
	export Roxie :=
	module
		
		shared superkeys := Keynames(pversion,pUseOtherEnvironment).dAll_filenames;
	
		export QA := VersionControl.fCheckRoxiePackage(
			 Email_Notification_Lists.roxie
			,'OneClickDataKeys'	
			,superkeys	
			,pversion
			,
			,pShouldUpdateRoxiePage
		);
		
		export Prod := VersionControl.fCheckRoxiePackage(
			 Email_Notification_Lists.roxie
			,'OneClickDataKeys'	
			,superkeys	
			,pversion
			,'prod'
			,pShouldUpdateRoxiePage
		);
	
	
	end;
	*/
end;
