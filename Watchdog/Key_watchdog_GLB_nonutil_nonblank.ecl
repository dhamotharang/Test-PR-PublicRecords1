IMPORT doxie,data_services,Watchdog_V2;

GlbnonutilnonblankLayout := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)}:=0;
end;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonutil_nonblank;
END;

FilterDS := Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_watchdog_GLB_nonutil_nonblank := PROJECT(FilterDS,TRANSFORM(GlbnonutilnonblankLayout,SELF :=LEFT));



