IMPORT _control,ut,wk_ut;

EXPORT check_alphaMonitorCopyFromBoca_isRunning := FUNCTION

		
		aesp := _control.IPAddress.aprod_thor_esp;
		w_s	:='W20150101-000000';
		w_e	:='W'+ut.date_math(workunit[2..9], 1)+'-000000';
		string  build_operator  := 'gabriel.marcan@lexisnexis.com'       :stored('build_operator');
		
		gwl(string str) := wk_ut.get_WorkunitList(w_s,w_e,pJobname :=str ,pesp :=  aesp);
		fList0 := gwl('Boca.PersonHeader - Monitor copy from Boca') :independent; 
		fList := fList0(state='wait');
		
		return when(count(fList)=1,
								sequential(
														output(fList0,named('alphaMonitorCopyFromBoca_wuidInfo'))
														,if(	 count(fList)<>1
																		,fileservices.sendemail(build_operator,'PersonHeader - Scheduled job MISSING!!!'
																					,'Boca.PersonHeader - Monitor copy from Boca is NOT RUNNING\n\nsee:'+workunit)
																)
								)
						);
		
	END;

//scheduled job: see BWR_scheduled_alpharetta_copy_hhid_from_boca // (run in alpharetta)
//#stored ('build_operator', _control.MyInfo.EmailAddressNotify ); 
//check_alphaMonitorCopyFromBoca_isRunning;