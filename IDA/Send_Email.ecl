import IDA, _control,std;

export Send_Email(string pversion='',boolean pUseProd = false, boolean pDaily = true) := module
	

    //Build email
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

	//Despray email
	shared SuccessDespraySubject	:= if(IDA._Constants(pUseProd).IsValidversion(pversion)
															,IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Despray ' + pversion + ' Completed on ' + IDA._Constants(pUseProd).enviroment
															,IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Despray Skipped, No pversion parameter passed to build on ' +
															 IDA._Constants(pUseProd).enviroment );

	shared SuccessDesprayBody 		:= if(IDA._Constants(pUseProd).IsValidversion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a pversion date parameter to ' + IDA._Constants(pUseProd).DatasetName +
															'._BWR_Despray and then resubmit through querybuilder.' +
                               '\nSee ' + IDA._Constants(pUseProd).DatasetName + '._BWR_Despray attribute for more details.' );

	export DespraySuccess   := fileservices.sendemail(
														IDA.Email_Notification_Lists.BuildSuccess,
														SuccessDespraySubject,
														SuccessDesprayBody  );
	
	export DesprayFailure		:= fileservices.sendemail(  
														IDA.Email_Notification_Lists.BuildFailure,
														IDA._Constants(pUseProd).DatasetName + IF(pDaily,' Daily', ' Monthly') + ' Despray ' + pversion + ' Failed on '+ IDA._Constants(pUseProd).enviroment,
														workunit + '\n' + failmessage  );

	//Change email
	shared SuccessChangeSubject	:= if(IDA._Constants(pUseProd).IsValidversion(pversion)
									 ,IDA._Constants(pUseProd).DatasetName + ' Monthly' + ' Change ' + pversion + ' Completed on ' + IDA._Constants(pUseProd).enviroment
									 ,IDA._Constants(pUseProd).DatasetName + ' Monthly' + ' Change Skipped, No pversion parameter passed to build on ' +
									  IDA._Constants(pUseProd).enviroment );

	shared SuccessChangeyBody 		:= if(IDA._Constants(pUseProd).IsValidversion(pversion), 
															workunit, 
															workunit + '\nPlease pass in a pversion date parameter to ' + IDA._Constants(pUseProd).DatasetName +
															'._BWR_Consolidate_And_Did_Reappend and then resubmit through querybuilder.' +
                               '\nSee ' + IDA._Constants(pUseProd).DatasetName + '._BWR_Consolidate_And_Did_Reappend attribute for more details.' );

	export ChangeSuccess   := fileservices.sendemail(
														IDA.Email_Notification_Lists.BuildSuccess,
														SuccessDespraySubject,
														SuccessDesprayBody  );
	
	export ChangeFailure		:= fileservices.sendemail(  
														IDA.Email_Notification_Lists.BuildFailure,
														IDA._Constants(pUseProd).DatasetName +  ' Monthly' + ' Change ' + pversion + ' Failed on '+ IDA._Constants(pUseProd).enviroment,
														workunit + '\n' + failmessage  );
														
end;
