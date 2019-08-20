import doxie, data_services, watchdog;

EXPORT keys := module

    SHARED pwn := '~prte::key::watchdog::';
		SHARED pfn := '~prte::key::watchdog_best::fcra::';
    SHARED phn := '~prte::key::header::';
    

	export key_glb 										:= index(watchdog.Key_Prep_Watchdog_GLB(), pwn + doxie.Version_SuperKey +'::best.did');
  export key_glb_nonutil 						:= index(watchdog.Key_Prep_Watchdog_GLB(true), pwn + doxie.Version_SuperKey +'::best_nonutil.did');
	export key_nonglb                 := index(watchdog.Key_Prep_Watchdog_nonglb(false), pwn + doxie.Version_SuperKey +'::nonglb.did');
	export key_nonglb_nonblank        := index(Watchdog.key_Prep_Watchdog_nonglb_nonblank(false),pwn + doxie.Version_SuperKey +'::nonglb.did_nonblank');
	export key_nonglb_noneq           := index(watchdog.Key_Prep_Watchdog_nonglb(true), pwn + doxie.Version_SuperKey + '::nonglb_noneq.did');
	export key_nonglb_noneq_nonblank  := index(Watchdog.key_Prep_Watchdog_nonglb_nonblank(true),pwn + doxie.Version_SuperKey + '::nonglb_noneq.did_nonblank');
	export key_marketing							:= index(watchdog.Key_Prep_Watchdog_marketing(false),pwn + doxie.Version_SuperKey + '::marketing.did'); 
	export key_marketing_preglb				:= index(watchdog.Key_Prep_Watchdog_marketing(true),pwn + doxie.Version_SuperKey + '::marketing_noneq.did');		
	


end;	