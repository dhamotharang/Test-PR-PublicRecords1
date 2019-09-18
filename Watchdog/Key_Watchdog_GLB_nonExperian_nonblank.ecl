import ut,doxie,watchdog_V2,header,mdr,header_services,_Control, Data_Services;

GlbnonExperiannonblankLayout := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)}:=0;
end;

Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_nonen_nonblank;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_Watchdog_GLB_nonExperian_nonblank := PROJECT(FilterDS,TRANSFORM(GlbnonExperiannonblankLayout, SELF :=LEFT));

