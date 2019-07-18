import ut,doxie,watchdog_v2,header,mdr,header_services, _Control,tools, Data_Services;

GlbNonblankLayout := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)}:=0;
end;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonblank;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT key_watchdog_glb_nonblank := PROJECT(FilterDS,TRANSFORM(GlbNonblankLayout,SELF :=LEFT));