import Watchdog_V2,doxie,Data_Services,dx_BestRecords;

GlbLayout := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)}:=0;
end;



Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_Watchdog_glb := PROJECT(FilterDS,TRANSFORM(GlbLayout,SELF :=LEFT));

