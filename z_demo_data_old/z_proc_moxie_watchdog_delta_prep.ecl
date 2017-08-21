import watchdog;
export proc_moxie_watchdog_delta_prep(string var1) := function

cng := proc_watchdog_delta(var1);

a := output(cng,,map(var1='nonglb'=>'~thor_data400::Delta::Watchdog_Delta_nonglb'+thorlib.WUID(),
			  var1='nonutility'=>'~thor_data400::Delta::Watchdog_Delta_nonutility'+thorlib.WUID(),
			  var1='nonglb_nonutility'=>'~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility'+thorlib.WUID(),
			  var1='marketing'=>'~thor_data400::Delta::Watchdog_Delta_marketing'+thorlib.WUID(),
			  '~thor_data400::Delta::Watchdog_Delta'+thorlib.WUID()),overwrite);

a2 := map(var1='nonglb'=>sequential(fileservices.clearsuperfile('~thor_data400::Delta::Watchdog_Delta_nonglb'),fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_nonglb','~thor_data400::Delta::Watchdog_Delta_nonglb'+thorlib.WUID())),
		 var1='nonutility'=>sequential(fileservices.clearsuperfile('~thor_data400::Delta::Watchdog_Delta_nonutility'),fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_nonutility','~thor_data400::Delta::Watchdog_Delta_nonutility'+thorlib.WUID())),
		 var1='nonglb_nonutility'=>sequential(fileservices.clearsuperfile('~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility'),fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility','~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility'+thorlib.WUID())),
		 var1='marketing'=>sequential(fileservices.clearsuperfile('~thor_data400::Delta::Watchdog_Delta_marketing'),fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_marketing','~thor_data400::Delta::Watchdog_Delta_marketing'+thorlib.WUID())),
		 sequential(fileservices.clearsuperfile('~thor_data400::Delta::Watchdog_Delta'),fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta','~thor_data400::Delta::Watchdog_Delta'+thorlib.WUID())));


a3 := output('finished delta file...') : success(a2);

//Run stats
b := output(watchdog.Stats1_fld_x_date((integer)run_date=max(watchdog.Stats1_fld_x_date,(integer)run_date)),named('Delta_Stats'),overwrite);

c := watchdog.proc_old_did;

result := sequential(a,a2,b);

return result;

end;