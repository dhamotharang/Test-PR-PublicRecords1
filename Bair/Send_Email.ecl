import VersionControl, _control;

export Send_Email(string pversion, boolean pUseProd = false, boolean pDelta = false) := module
	shared EnvName :=
			CASE(_Control.ThisEnvironment.ThisDaliIp
					,_Control.IPAddress.bair_dataland_dali => 'Dataland_Thor'
					,_Control.IPAddress.bair_prod_dali1    => 'Prod_Thor'
					,_Control.IPAddress.bair_DR_dali1      => 'DR_Thor'
					,'ERROR: UNKNOWN DALI IP'
					);
					
	shared SuccessBody 		:= workunit+'\nBuild '+ pVersion +' completed successful.';
	shared FailedBody 		:= workunit + '\n' + failmessage;
	  
	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														_Dataset(pUseProd).name + ' Build PAYLOADS ' + if(pDelta, 'Delta ', 'Full ') + pversion + ' Completed on ' + EnvName,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														_Dataset(pUseProd).name + ' Build PAYLOADS ' + if(pDelta, 'Delta ', 'Full ') + pversion + ' Failed on '+ EnvName,
														FailedBody  );
	
	export BooleanBuildSuccess	:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														_Dataset(pUseProd).name + ' BOOLEAN ' + if(pDelta, 'Delta', 'Full') + ' Build and Deploy ' + pversion + ' Completed on '+ EnvName,
														SuccessBody  );
														
	export BooleanBuildFailure	:= fileservices.sendemail(
														Email_Notification_Lists.BuildFailure,
														_Dataset(pUseProd).name + ' BOOLEAN ' + if(pDelta, 'Delta', 'Full') + ' Build and Deploy ' + pversion + ' Failed on '+ EnvName,
														FailedBody  );
	
	export CompositeBuildSuccess	:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														_Dataset(pUseProd).name + ' COMPOSITE ' + if(pDelta, 'Delta', 'Full') + ' Build and Deploy ' + pversion + ' Completed on '+ EnvName,
														SuccessBody  );
														
	export CompositeBuildFailure	:= fileservices.sendemail(
														Email_Notification_Lists.BuildFailure,
														_Dataset(pUseProd).name + ' COMPOSITE ' + if(pDelta, 'Delta', 'Full') + ' Build and Deploy ' + pversion + ' Failed on '+ EnvName,
														FailedBody  );
end;
