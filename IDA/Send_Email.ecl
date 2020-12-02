import VersionControl, _control,std;

export Send_Email(string pversion='', boolean pUseProd = false, boolean pDaily = true) := module

  shared version:=if(pversion='',(string8)std.date.today(),pversion):INDEPENDENT;

	shared SuccessSubject	:= if(VersionControl.IsValidVersion(version)
															,IDA._Constants(version,pUseProd).DatasetName + ' Build ' + pversion + ' Completed on ' + IDA._Constants(version,pUseProd).enviroment
															,IDA._Constants(version,pUseProd).DatasetName + ' Build ' + ' Build Skipped, No version parameter passed to build on ' +
																				IDA._Constants(version,pUseProd).enviroment );
	shared SuccessBody 		:= if(VersionControl.IsValidVersion(version), 
															workunit, 
															workunit + '\nPlease pass in a version date parameter to ' + IDA._Constants(version,pUseProd).DatasetName +
															'.Build_All and then resubmit through querybuilder.' +
                               '\nSee ' + IDA._Constants(version,pUseProd).DatasetName + '._BWR_Build attribute for more details.' );
   
	export BuildSuccess		:= fileservices.sendemail(
														IDA.Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														IDA.Email_Notification_Lists.BuildFailure,
														IDA._Constants(version,pUseProd).DatasetName + ' Build ' + pversion + ' Failed on '+ IDA._Constants(version,pUseProd).enviroment,
														workunit + '\n' + failmessage  );
														
	export BuildSkipped		:= fileservices.sendemail(  
														IDA.Email_Notification_Lists.BuildFailure,
														IDA._Constants(version,pUseProd).DatasetName + ' Build ' + pversion + ' Skipped on '+ IDA._Constants(version,pUseProd).enviroment,
														workunit + '\n' + failmessage  );
														
end;
