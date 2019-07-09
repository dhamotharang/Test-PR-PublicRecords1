IMPORT doxie,data_services,Watchdog_V2;

EXPORT GlbnonutilnonblankLayout := RECORD
Watchdog.Layout_Key-[__filepos];
unsigned8 filepos;
END;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonutil_nonblank;
END;

FilterDS := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_watchdog_GLB_nonutil_nonblank := PROJECT(FilterDS,TRANSFORM(GlbnonutilnonblankLayout,SELF :=LEFT));



