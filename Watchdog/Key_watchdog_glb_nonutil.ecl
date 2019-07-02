IMPORT doxie,ut,_Control,Watchdog_V2,Data_Services;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonutil;
END;

export Key_watchdog_glb_nonutil :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

