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

	export saveToLogFile(String subProduct, String date, String wu, String desc, String status) := FUNCTION

		mydatetime := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%Y%m%d-%I%M%S') : independent;
		STRING logFileName := '~thor_data400::log::Marketing_Suite_List_Gen::' + mydatetime +  
		if(subProduct <> '', '::'+ subproduct, '') + '::buildinfo';
		
		STRING superFileName := '~thor_data400::Log::Marketing_Suite_List_Gen::Buildinfo';

		oldData := dataset(superFileName, Marketing_Suite_List_Gen.Layouts.Layout_LogFile, thor,opt);
		nextseq := max(oldData, id) + 1;
		logData := oldData + dataset([{nextseq, thorlib.jobowner(), date, subProduct, wu, status, desc}], Marketing_Suite_List_Gen.Layouts.Layout_LogFile);
		logData_sorted := sort(logData, -id);
		outputFile := output(logData_sorted,, logFileName, overwrite);
		 
		return sequential(outputFile,FileServices.PromoteSuperFileList([superFileName], logFileName, true));
	end;
	
	export SendSuccessEmail(string msg = '', string subProduct = '') := FUNCTION

    string Subject := 'Marketing_Suite_List_Gen' + ' ' + subProduct + ' Build Completed - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;

    string Body := 
      'The Marketing_Suite_List_Gen ' + subProduct + ' build  completed successfully.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;

		return parallel(	saveToLogFile(subProduct, datestr, wu, msg, COMPLETED_STATUS), 
											FileServices.SendEmail(emailList, Subject, Body));
  end;

  export SendFailureEmail(string msg = '', String subProduct = '') := FUNCTION
    string Subject := 'Marketing_Suite_List_Gen' + ' ' + subProduct + ' Build Failed. - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;
		
    string Body := 
      'The Marketing_Suite_List' + ' ' + subProduct + ' build  Failed.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;

    return parallel(	saveToLogFile(subProduct, datestr, wu, msg, FAILED_STATUS), 
											FileServices.SendEmail(emailList, Subject, Body));							
							
  end;

end;