import lib_fileservices, ut, header_services, doxie,_Control,header,Data_Services,Watchdog_V2;


GlbNoneqLayout := RECORD
Watchdog.Layout_Key-[__filepos];
unsigned8 filepos;
END;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_noneq;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_Watchdog_GLB_nonEquifax := PROJECT(FilterDS,TRANSFORM(GlbNoneqLayout,SELF :=LEFT));


