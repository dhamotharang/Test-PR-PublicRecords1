import ut,doxie,watchdog_v2,header,mdr,header_services, _Control,tools, Data_Services;

EXPORT GlbNonblankLayout := RECORD
Watchdog.Layout_Key-[__filepos];
unsigned8 filepos;
END;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonblank;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT key_watchdog_glb_nonblank := PROJECT(FilterDS,TRANSFORM(GlbNonblankLayout,SELF :=LEFT));