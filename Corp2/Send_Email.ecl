import VersionControl;
export Send_Email :=
module

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													'Corp2 Build ' + versions.building + ' Completed',
													workunit);

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'Corp2 Build ' + versions.building + ' Failed',
													workunit + '\n' + failmessage);
	export Roxie :=
	module
	
		export QA := versioncontrol.fSendRoxieEmail( 
						 Email_Notification_Lists.roxie
						,Datasetname + ' Build completed ' + versions.building
						,keynames.dAll_superkeynames(regexfind('^(.*)::[qQ][aA]::(.*)$', name)));
		
		export Prod := versioncontrol.fSendRoxieEmail( 
						 Email_Notification_Lists.roxie
						,Datasetname + ' Build completed ' + versions.building
						,keynames.dAll_superkeynames(regexfind('^(.*)::[pP][rR][oO][dD]::(.*)$', name)));
	
	
	end;
end;
