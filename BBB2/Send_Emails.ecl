import VersionControl, _Control;
export Send_Emails(string pversion) :=
module

	export SprayCompletion(unsigned4 membercount, unsigned4 nonmembercount) := 
	function
		return fileservices.sendemail(Email_Notification_Lists.SprayCompletion,
					Dataset_Name + ': Files Sprayed',
					 membercount + ' Member file(s) sprayed and added to superfile: ' + Filenames().Input.Member.Sprayed + '\r\n' +
					 nonmembercount + ' NonMember file(s) sprayed and added to superfile: ' + Filenames().Input.NonMember.Sprayed + '\r\n' + 
					'workunit: ' + workunit);

	end;

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
	export Roxie :=
	module
		
		shared superkeys 		:= Keynames(pversion).dAll_filenames;
		shared packagename	:= _dataset().name + 'Keys';
		
		export QA := VersionControl.fCheckRoxiePackage( 
						 Email_Notification_Lists.RoxieKeybuild
						,packagename
						,superkeys
						,pversion
						,
						,
						,'N'
						);
		
		export Prod := VersionControl.fCheckRoxiePackage( 
						 Email_Notification_Lists.RoxieKeybuild
						,packagename
						,superkeys
						,pversion
						,'prod'
						);
	
	
	end;
end;