import Watchdog_V2,doxie,Data_Services,dx_BestRecords;


GlbLayout := RECORD
Watchdog.Layout_Key-[__filepos];
unsigned8 filepos;
END;



Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_Watchdog_glb := PROJECT(FilterDS,TRANSFORM(GlbLayout,SELF :=LEFT));

