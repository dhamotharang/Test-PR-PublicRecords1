string20 var1 := '' : stored('watchtype');

cng := watchdog.Delta;

a := output(cng,,map(var1='nonglb'=>'~thor_data400::Delta::Watchdog_Delta_nonglb'+thorlib.WUID(),
			  var1='nonutility'=>'~thor_data400::Delta::Watchdog_Delta_nonutility'+thorlib.WUID(),
			  var1='nonglb_nonutility'=>'~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility'+thorlib.WUID(),
			  '~thor_data400::Delta::Watchdog_Delta'+thorlib.WUID()),overwrite);

a2 := map(var1='nonglb'=>fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_nonglb','~thor_data400::Delta::Watchdog_Delta_nonglb'+thorlib.WUID()),
		 var1='nonutility'=>fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_nonutility','~thor_data400::Delta::Watchdog_Delta_nonutility'+thorlib.WUID()),
		 var1='nonglb_nonutility'=>fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility','~thor_data400::Delta::Watchdog_Delta_nonglb_nonutility'+thorlib.WUID()),
		 fileservices.addsuperfile('~thor_data400::Delta::Watchdog_Delta','~thor_data400::Delta::Watchdog_Delta'+thorlib.WUID()));


//Run stats
b := output(watchdog.Stats1_fld_x_date((integer)run_date=(integer)rundate_build),named('Delta_Stats'),overwrite);

c := proc_old_did;

export BWR_Delta := if(var1!='',sequential(a,a2,b),sequential(a,a2,b,c));