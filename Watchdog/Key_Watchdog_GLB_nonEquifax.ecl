import lib_fileservices, ut, header_services, doxie,_Control,header,Data_Services,Watchdog_V2;

GlbNoneqLayout := record
	watchdog.Layout_Best;
    unsigned integer8 __filepos { virtual(fileposition)}:=0;
end;


Parms := Module(Watchdog_V2.UniversalKeyInterface)
EXPORT Permissions := Watchdog_V2.fn_UniversalKeySearch.PermissionsType.glb_noneq;
END;

FilterDS :=Watchdog_V2.fn_UniversalKeySearch.FetchRecords(Parms);

EXPORT Key_Watchdog_GLB_nonEquifax := PROJECT(FilterDS,TRANSFORM(GlbNoneqLayout,SELF :=LEFT));


