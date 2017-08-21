import ut;
export mod_email := module

	export emailList := 'Manish.Shah@LexisNexis.com' + 
											',Gavin.Witz@LexisNexis.com' +
											',Charles.Morton@LexisNexis.com' +
											',Jill.Luber@LexisNexis.com' +
											',Aleida.Lima@LexisNexis.com' +
											',InsDataOps@lexisnexis.com';
	 //export emailList := 'Manish.Shah@LexisNexis.com';
	// export emailList := 'Aleida.lima@lexisnexis.com';
	SHARED String COMPLETED_STATUS := 'COMPLETED';
	SHARED FAILED_STATUS := 'FAILED';

	SHARED saveToLogFile(String product, String subProduct, String date, String wu, String desc, String status) := FUNCTION

		STRING logFileName := '~thor400_log::insuranceheader::' + ut.GetDate + ut.getTime() + 
		if(subProduct <> '', '::'+ subproduct, '') + '::buildinfo';
		
		STRING superFileName := '~thor400_log::insuranceheader::buildinfo';
		
		logLayout := RECORD
			integer id; // Unique ID
			string user; // Person running a build - owner
			STRING TimeStamp;
			STRING Product;			
			STRING SubProduct; // Ex - HHID, Relative, ... (it is not currently available)
			STRING WorkunitName;
			STRING status; // COMPLETED, FAILED
			STRING Description;			
		END;
		
		oldData := dataset(superFileName, LogLayout, thor);
		nextseq := max(oldData, id) + 1;
		logData := oldData + dataset([{nextseq, thorlib.jobowner(), date, product, subProduct, wu, status, desc}], logLayout);
		output(logData,, logFileName, overwrite);
		 
		RETURN FileServices.PromoteSuperFileList([superFileName], logFileName, true);
	END;
	
	export SendSuccessEmail(string emailAddresses = emailList, string product, string msg = '', string subProduct = '') := FUNCTION
    STRING DateStr := ut.GetDate + '-' + ut.getTime();
		STRING WU			 := thorlib.wuid();
    STRING Subject := product + ' ' + subProduct + ' Build Completed - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;

    STRING Body := 
      'The ' + product +  ' ' + subProduct + ' build  completed successfully.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;
		 RETURN parallel( saveToLogFile( product, subProduct, datestr,  wu, msg, COMPLETED_STATUS), 
								FileServices.SendEmail(emailAddresses, Subject, Body));
  END;

  export SendFailureEmail(string emailAddresses = emailList, string product, string msg = '', String subProduct = '') := FUNCTION
    STRING DateStr := ut.GetDate + '-' +  ut.getTime();
		STRING WU			 := thorlib.wuid();
    STRING Subject := product + ' ' + subProduct + ' Build Failed. - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;
		
    STRING Body := 
      'The ' + product + ' ' + subProduct + ' build  Failed.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;
    RETURN parallel( saveToLogFile( product, subProduct, datestr,  wu, '', FAILED_STATUS), 
									FileServices.SendEmail(EmailAddresses, Subject, Body));							
							
  END;

end;