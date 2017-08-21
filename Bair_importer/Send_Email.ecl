import VersionControl, _control,STD;

export Send_Email(	
					string pBuildName,
					string pFileVersion,
					string pLandingZone,
					string pFailMessage = ''
					) := module
					
	shared SuccessSubject	:= _Dataset().name + ' Prepped ' + pFileVersion + ' Completed on BAIR';
	shared FailureSubject	:= _Dataset().name + ' Prepped ' + pFileVersion + ' Failed on BAIR';

	shared BodySuccess 		:= '// Import has Finished at Workunit: ' + workunit+'\n\n';
			
	shared BodyFailure 		:= '// Import has Finished at Workunit: ' + workunit+'\n\n'
	+if(pFailMessage!='','Fail Message: ' + pFailMessage+'\n\n','')
	+'File Version := '+ pFileVersion + '\n'
	+'Agency := '+ STD.STR.SplitWords(pLandingZone,'/')[2]  + '\n\n'
	+'To reprocess use the following command: \n\n'
	+'Bair.Orbit_Update.SetOrbitBuildToReprocess(\''+pBuildName+'\',\''+pFileVersion+'\');\n';
   
	export BuildSuccess		:= fileservices.sendemail(
														Email_Notification_Lists.BuildSuccess,
														SuccessSubject,
														BodySuccess  );
	
	export BuildFailure		:= fileservices.sendemail(  
														Email_Notification_Lists.BuildFailure,
														FailureSubject,
														BodyFailure  );
end;
