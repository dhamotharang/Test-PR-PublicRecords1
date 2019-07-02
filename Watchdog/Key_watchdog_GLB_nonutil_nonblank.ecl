IMPORT doxie,data_services,Watchdog_V2;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonutil_nonblank;
END;

export Key_watchdog_GLB_nonutil_nonblank := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);


