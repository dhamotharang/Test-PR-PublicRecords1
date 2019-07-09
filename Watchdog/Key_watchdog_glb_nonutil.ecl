IMPORT doxie,ut,_Control,Watchdog_V2,Data_Services;

EXPORT GlbnonutilLayout := RECORD
Watchdog.Layout_Key-[__filepos];
unsigned8 filepos;
END;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonutil;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_watchdog_glb_nonutil := PROJECT(FilterDS,TRANSFORM(GlbnonutilLayout,SELF :=LEFT));

