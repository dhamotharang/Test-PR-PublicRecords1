import watchdog_V2,data_services,doxie;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.nonglb_noneq_nonblank;
END;

export key_watchdog_nonglb_nonblank_V2 := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);



