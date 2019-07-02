import lib_fileservices, ut, header_services, doxie,_Control,header,Data_Services,Watchdog_V2;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_noneq;
END;

export Key_Watchdog_GLB_nonEquifax :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

