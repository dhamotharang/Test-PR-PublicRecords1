import VersionControl, _control, HMS_Medicaid_Common;

export Send_Email(String Medicaid_State,string pversion, boolean pUseProd = false) := module
	shared SuccessSubject	:= if(VersionControl.IsValidVersion(pversion)
															,HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + ' Build ' + pversion + ' Completed on ' + _Control.ThisEnvironment.Name
															,HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + ' Build Skipped, No version parameter passed to build on ' +
																				_Control.ThisEnvironment.Name );
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a version date parameter to ' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name +
															'.Build_All and then resubmit through querybuilder.' +
                               '\nSee ' + HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + '._BWR_Build_Test attribute for more details.' );
   
	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists(Medicaid_State,pversion).BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists(Medicaid_State,pversion).BuildFailure,
														HMS_Medicaid_Common._Dataset(Medicaid_State,pUseProd).name + ' Build ' + pversion + ' Failed on '+ _Control.ThisEnvironment.Name,
														workunit + '\n' + failmessage  );
end;
