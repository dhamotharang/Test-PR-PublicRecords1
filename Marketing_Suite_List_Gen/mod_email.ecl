import ut,tools,_control,std;

export mod_email := module
											
	export emailList	:= if(tools._Constants.IsDataland,
														_control.myinfo.EmailAddressNotify,
                            if(_control.myinfo.EmailAddressNotify = 'nobody@seisint.com',
																	'',
																	_control.myinfo.EmailAddressNotify + ',')
                            +	'julianne.franzer@lexisnexis.com');
	 
	shared string COMPLETED_STATUS 	:= 'COMPLETED';
	shared string FAILED_STATUS 		:= 'FAILED';
	shared string DateStr 					:= Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%Y%m%d-%I%M%S');
	shared string WU			 					:= thorlib.wuid();

	export saveToLogFile(String JobId, String date, String wu, String desc, String status) := FUNCTION

		mydatetime := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%Y%m%d-%I%M%S') : independent;
		STRING logFileName := '~thor_data400::log::Marketing_Suite_List_Gen::' + mydatetime +  
		'::buildinfo' + if(JobId <> '', '::'+ JobId, '');
		
		STRING superFileName := '~thor_data400::Log::Marketing_Suite_List_Gen::Buildinfo';

		// oldData := dataset(superFileName, Marketing_Suite_List_Gen.Layouts.Layout_LogFile, thor,opt);
		// nextseq := max(oldData, id) + 1;
		logData := dataset([{thorlib.jobowner(), date, jobId, wu, status, desc}], Marketing_Suite_List_Gen.Layouts.Layout_LogFile);
		// logData_sorted := sort(logData, -id);
		outputFile := output(logData,, logFileName, overwrite);
		 
		return sequential(outputFile,FileServices.AddSuperFile(superFileName, logFileName));
	end;
	
	export SendSuccessEmail(string msg = '', string JobId = '') := FUNCTION

    string Subject := 'Marketing_Suite_List_Gen JobID:' + ' ' + JobID + ' Completed - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;

    string Body := 
      'The Marketing_Suite_List_Gen JobID: ' + JobID + ' completed successfully.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;

		return parallel(	saveToLogFile(JobId, datestr, wu, msg, COMPLETED_STATUS), 
											FileServices.SendEmail(emailList, Subject, Body));
  end;

  export SendFailureEmail(string msg = '', String JobId = '') := FUNCTION
    string Subject := 'Marketing_Suite_List_Gen JobID:' + ' ' + JobId + ' Failed. - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;
		
    string Body := 
      'The Marketing_Suite_List JobID:' + ' ' + jobID + ' Failed.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;

    return parallel(	saveToLogFile(jobId, datestr, wu, msg, FAILED_STATUS), 
											FileServices.SendEmail(emailList, Subject, Body));							
							
  end;

end;