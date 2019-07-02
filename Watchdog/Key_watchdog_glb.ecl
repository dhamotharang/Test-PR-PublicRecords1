import Watchdog_V2,doxie,Data_Services;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb;
END;

export Key_Watchdog_glb :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

