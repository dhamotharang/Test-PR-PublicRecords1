IMPORT doxie,ut,_Control,Watchdog_V2,Data_Services;

GlbnonutilLayout := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)}:=0;
end;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonutil;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_watchdog_glb_nonutil := PROJECT(FilterDS,TRANSFORM(GlbnonutilLayout,SELF :=LEFT));

