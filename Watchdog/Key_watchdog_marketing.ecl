import Data_Services, doxie,ut,_Control,Watchdog_V2;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.marketing;
END;

export Key_Watchdog_marketing := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);


