import ut,doxie,watchdog_v2,header,mdr,header_services, _Control,tools, Data_Services;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonblank;
END;

export key_watchdog_glb_nonblank :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

