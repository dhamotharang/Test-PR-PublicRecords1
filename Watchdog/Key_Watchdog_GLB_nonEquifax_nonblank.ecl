import ut,doxie,watchdog_V2,header,mdr,header_services,_Control, Data_Services;
 
Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_noneq_nonblank;
END;

export Key_Watchdog_GLB_nonEquifax_nonblank :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

