import VersionControl, _control, bair;

export Send_Email(string pversion, boolean pUseProd = false) := module
	shared SuccessSubject	:= Bair._Dataset(pUseProd).name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name;
	shared SuccessBody 		:= workunit+'\nBuild '+ pVersion +' completed successful.';
   
	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														_Dataset(pUseProd).name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
														workunit + '\n' + failmessage  );
end;
