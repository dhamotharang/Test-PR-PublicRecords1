process_date := '20130125';
emailme := FileServices.sendemail('vanichikte@lexisnexis.com','DAILY APRRISS SAMPLES READY','at ' + thorlib.WUID());

sequential(ERO.Proc_build_facility_base(process_date),
           ERO.proc_build_all_keys(process_date)
	         ): success(emailme);
                                   