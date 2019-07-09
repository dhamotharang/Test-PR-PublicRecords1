import ut,doxie,watchdog_V2,header,mdr,header_services,_Control, Data_Services;

GlbnonExperiannonblankLayout := RECORD
Watchdog.Layout_Key-[__filepos];
unsigned8 filepos;
END;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonen_nonblank;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_Watchdog_GLB_nonExperian_nonblank := PROJECT(FilterDS,TRANSFORM(GlbnonExperiannonblankLayout,SELF :=LEFT));


