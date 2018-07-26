import ut,tools,_control,std;
export mod_email := module

	// export emailList := 'Charles.Morton@LexisNexis.com' +
											// ',Todd.Leonard@LexisNexis.com' +
											// ',Laverne.Bentley@LexisNexis.com' +
											// ',Aleida.Lima@LexisNexis.com' +
											// ',David.Wheelock@lexisnexis.com';
											
	export emailList := if(tools._Constants.IsDataland  ,_control.myinfo.EmailAddressNotify
                                                      ,   if(_control.myinfo.EmailAddressNotify = 'nobody@seisint.com'  ,'',_control.myinfo.EmailAddressNotify + ',')
                                                      +   'Charles.Morton@LexisNexis.com'
                                                      // +   ',Todd.Leonard@LexisNexis.com'
                                                      +   ',Laverne.Bentley@LexisNexis.com'
                                                      +   ',Aleida.Lima@LexisNexis.com'
                                                      +   ',Kevin.Wilmoth@lexisnexisrisk.com'
                                                      +   ',Janet.Anderson@lexisnexisrisk.com'
                                                      +   ',Paul.Wahbe@lexisnexis.com'
                                                      +   ',dustin.skaggs@lexisnexis.com'
                                                      +   ',Sudhir.Kasavajjala@lexisnexis.com'
                                                      +   ',Ayeesha.Kayttala@lexisnexis.com'
                                                      +   ',Robert.Pressel@lexisnexis.com'
                      );
	 
	SHARED String COMPLETED_STATUS 	:= 'COMPLETED';
	SHARED String FAILED_STATUS 		:= 'FAILED';
	SHARED String DateStr 					:= (string8)Std.Date.Today() + '-' +  Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S'); //ut.getTime();
	SHARED String WU			 					:= thorlib.wuid();

	export saveToLogFile(String product, String subProduct, String date, String wu, String desc, String status) := FUNCTION

    //mydate := ut.GetDate : independent;
		mydate := (string8)Std.Date.Today() : independent;
		
    //mytime := ut.getTime() : independent;
		mytime := Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S') : independent;
		STRING logFileName := '~thor400_log::bipv2::' + mydate + mytime + 
		if(subProduct <> '', '::'+ subproduct, '') + '::buildinfo';
		
		STRING superFileName := '~thor400_log::bipv2::buildinfo';
		
		logLayout := RECORD
			integer id; // Unique ID
			string user; // Person running a build - owner
			STRING TimeStamp;
			STRING Product;			
			STRING SubProduct; // Ex - DOTID, ProxID, Relative, xLink
			STRING WorkunitName;
			STRING status; // COMPLETED, FAILED
			STRING Description;			
		END;
		
		oldData := dataset(superFileName, LogLayout, thor,opt);
		nextseq := max(oldData, id) + 1;
		logData := oldData + dataset([{nextseq, thorlib.jobowner(), date, product, subProduct, wu, status, desc}], logLayout);
		logData_sorted := sort(logData, -id);
		outpufile := output(logData_sorted,, logFileName, overwrite);
		 
		RETURN sequential(outpufile,FileServices.PromoteSuperFileList([superFileName], logFileName, true));
	END;
	
	export SendSuccessEmail(string emailAddresses = emailList, string product = 'BIPv2', string msg = '', string subProduct = '') := FUNCTION

    STRING Subject := product + ' ' + subProduct + ' Build Completed - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;

    STRING Body := 
      'The ' + product +  ' ' + subProduct + ' build  completed successfully.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;

		 RETURN parallel( saveToLogFile( product, subProduct, datestr,  wu, msg, COMPLETED_STATUS), 
								FileServices.SendEmail(emailAddresses, Subject, Body));
  END;

  export SendFailureEmail(string emailAddresses = emailList, string product = 'BIPv2', string msg = '', String subProduct = '') := FUNCTION
    STRING Subject := product + ' ' + subProduct + ' Build Failed. - Workunit - ' + WU + ', DateTimeStamp - ' + DateStr;
		
    STRING Body := 
      'The ' + product + ' ' + subProduct + ' build  Failed.\n\n' +
			'This was WorkUnit ' + WU + '.\n\n' +
			msg;

    RETURN parallel( saveToLogFile( product, subProduct, datestr,  wu, '', FAILED_STATUS), 
									FileServices.SendEmail(EmailAddresses, Subject, Body));							
							
  END;

end;