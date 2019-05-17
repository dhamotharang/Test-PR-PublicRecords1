import VersionControl, _control;

export Send_Email_BuildBase(string pversion, boolean pUseProd = false) := module



	shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion) 
															,_Dataset(pUseProd).name + ' Base and Key Files' + ' Build ' + pversion + '  Completed on ' + _Control.ThisEnvironment.Name
															,_Dataset(pUseProd).name + ' Base and Key Files' + ' Build ' + pversion + '  Failed on '    + _Control.ThisEnvironment.Name );
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion)
															,workunit  + '\n' + '\nSuccessfully created new base and key files!'
															,workunit  + '\n' + '\nFailed new base and key files creation!');

	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														_Dataset(pUseProd).name + ' Skipped Base and Key Files Build ' + pversion + ' on '+ _Control.ThisEnvironment.Name,
														workunit + '\n' + 
														'\n'+'Because Vendor_Src base file source_code_count does not matching previous version or the latest base and key files exist, skipping base and key files build!' + '\n' + failmessage  );
end;
