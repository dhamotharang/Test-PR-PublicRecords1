import prte2_watchdog, data_services, doxie;

// New Key
	ds := PRTE2_Watchdog.fn_build_merged;
	export key_watchdog(integer data_category = 0) := INDEX(ds, {did}, {ds}, '~prte::key::watchdog::'+ doxie.Version_SuperKey + '::univesal');
	