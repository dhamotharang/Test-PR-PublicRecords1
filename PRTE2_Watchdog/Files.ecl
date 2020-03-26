IMPORT Watchdog;
EXPORT Files := MODULE

        EXPORT file_best  := dataset(PRTE2_Watchdog.constants.prefix_base, watchdog.Layout_Best, thor);
				// EXPORT merged			:= PRTE2_Watchdog.fn_build_merged;														
END;