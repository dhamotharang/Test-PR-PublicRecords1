import prte2;

EXPORT constants := module

    EXPORT prefix_base 							 := prte2.Constants.prefix + 'base::watchdog';
		EXPORT keyname_watchdog		 			 := prte2.Constants.prefix + 'key::watchdog::';
		EXPORT keyname_watchdog_best		 := prte2.Constants.prefix + 'key::watchdog_best::';

END;

