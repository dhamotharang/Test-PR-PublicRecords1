import doxie,_Control,Data_Services,Watchdog_V2;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.nonglb;
END;

export Key_Watchdog_nonglb := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);



