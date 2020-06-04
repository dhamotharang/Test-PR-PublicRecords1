import doxie,data_services,Watchdog_V2; 

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.marketing_preglb;
END;

export Key_Watchdog_marketing_V2 := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);



