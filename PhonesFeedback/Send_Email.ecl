import ut,lib_fileservices,VersionControl, _control, PhonesFeedback;

export Send_Email(string rawfilenm,string clfilenm,string srctype = 'rozlin') :=

module

  shared run_dt := ut.GetTimeDate();
	shared SuccessSubject := 'Stats for job ' +Out_daily_stats(rawfilenm,clfilenm,srctype).JobName +'file: ' +Out_daily_stats(rawfilenm,clfilenm,srctype).RawInputfilename;
  string bodycontent :=        'Run Date             = '+Out_daily_stats(rawfilenm,clfilenm,srctype).run_date + '\n' +
															 
															 'Job ID               = ' + thorlib.WUID() + '\n' +
															 'Customer ID          = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).customerid + '\n' +
															 'Customer Name        = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).cust_name + '\n' +
															 'Jobname              = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).JobName + '\n' +
															 'Input Filename       = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).RawInputfilename + '\n' +
															 'Results Filename  #1 = ' + Out_daily_stats(rawfilenm,clfilenm,srctype).CleanInputfilename + '\n\n\n' + 

                               'Job Stats:'+	'\n' + 

                               'Total number of records in Input File     : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).reccount + '\n' +
                               'Customer Input                            : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).reccount + '\n' +
															 'Total Output Count                        : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).custcount + '\n' +
                               'Code 1 - Right Party Counts               : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).Valid_stat[1].count_ + '\n' +
                               'Code 2 - Relative or Associate Count      : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).Valid_stat[2].count_ + '\n' +
                               'Code 3 - Wrong Party Count                : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).Valid_stat[3].count_ + '\n' +
                               'Code 4 - Phone Disconnected Count         : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).Valid_stat[4].count_ + '\n' +
                               'Code 7 - Alternate Phone Provided Count   : '+ Out_daily_stats(rawfilenm,clfilenm,srctype).Valid_stat[5].count_ + '\n' +
                               'Code 8 - Other Information Provided Count : ' + Out_daily_stats(rawfilenm,clfilenm,srctype).Valid_stat[6].count_ + '\n' +
                               'Total Records filtered out                : '+Out_daily_stats(rawfilenm,clfilenm,srctype).countdiff;
 														
														
 //string  attachment := output(	bodycontent);
	
	shared SuccessBody		:= bodycontent;
	

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													SuccessSubject,
													SuccessBody);
	//													'Stats Complete - Please view attachment\n**File on thor expires in 7 days',
	//												'text/xml',
	//'attachment.txt') ;
												

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'PhonesFeedBack' +srctype+ 'Customer Stat Failed on '+ _Control.ThisEnvironment.Name,
													workunit +  failmessage);
													
end;