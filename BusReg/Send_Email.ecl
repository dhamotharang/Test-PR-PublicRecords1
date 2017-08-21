import VersionControl;
export Send_Email(
	
	 string		pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

) :=
module

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													_Dataset().Name + ' Build ' + pversion + ' Completed\n',
													workunit);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													_Dataset().Name + ' Build ' + pversion + ' Failed',
													workunit + '\n' + failmessage);
													
	export BasesFinished := fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													_Dataset().Name + ' Build Base Files Created ' + pversion,
													workunit);

	export Roxie :=
	function
		
		lpackage := keynames(pversion,pUseOtherEnvironment).roxie.dall_filenames;
		lemails	:= Email_Notification_Lists.Roxie;
		
		/////////////////////////////////////////////////////////////
		// -- Send 5 roxie emails
		/////////////////////////////////////////////////////////////
		return VersionControl.fCheckRoxiePackage(lemails,'BusinessRegKeys',lpackage,pversion,,pShouldUpdateRoxiePage,'N');

	end;
	
end;