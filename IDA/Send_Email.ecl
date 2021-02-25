import IDA, _control,std;

export Send_Email(string pversion='',boolean pUseProd = false, boolean pDaily = true) := module
	


	shared SuccessSubject	:= if(IDA._Constants(pUseProd).IsValidversion(pversion)
															,IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Build ' + pversion + ' Completed on ' + IDA._Constants(pUseProd).enviroment
															,IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Build Skipped, No pversion parameter passed to build on ' +
																				IDA._Constants(pUseProd).enviroment );
	shared SuccessBody 		:= if(IDA._Constants(pUseProd).IsValidversion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a pversion date parameter to ' + IDA._Constants(pUseProd).DatasetName +
															'.Build_All and then resubmit through querybuilder.' +
                               '\nSee ' + IDA._Constants(pUseProd).DatasetName + '._BWR_Build attribute for more details.' );
   
	export BuildSuccess		:= fileservices.sendemail(
														IDA.Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														SuccessBody  );
	
	export BuildFailure		:= fileservices.sendemail(  
														IDA.Email_Notification_Lists.BuildFailure,
														IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Build ' + pversion + ' Failed on '+ IDA._Constants(pUseProd).enviroment,
														workunit + '\n' + failmessage  );
														
	export BuildSkipped		:= fileservices.sendemail(  
														IDA.Email_Notification_Lists.BuildFailure,
														IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Build ' + pversion + ' Skipped on '+ IDA._Constants(pUseProd).enviroment,
														workunit + '\n' + failmessage  );
														
end;
