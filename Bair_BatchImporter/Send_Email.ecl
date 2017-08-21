import VersionControl, _control,STD, bair;

export Send_Email(
					string pVersion,
					string pFailMessage = '',
					string pDaliServer  = _control.IPAddress.bair_batchlz01,
					string pLandingZone = '/data/batchimport/ready/',
					string pThorServer  = 'thor40'
					) := module
					
	shared SuccessSubject	:= _Dataset().name + ' Prepped ' + pVersion + ' Completed on BAIR';
	shared FailureSubject	:= _Dataset().name + ' Prepped ' + pVersion + ' Failed on BAIR';

	shared BodySuccess 		:= '// Import has Finished at Workunit: ' + workunit+'\n\n';
			
	shared BodyFailure 		:= '// Import has Finished at Workunit: ' + workunit+'\n\n'
	+if(pFailMessage!='','Fail Message: ' + pFailMessage+'\n\n','')
	+'File Version := '+ pVersion + '\n';
   
	export BuildSuccess		:= fileservices.sendemail(
														bair.Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														BodySuccess  );
	
	export BuildFailure		:= fileservices.sendemail(  
														bair.Email_Notification_Lists.BuildFailure,
														FailureSubject,
														BodyFailure  );
end;
