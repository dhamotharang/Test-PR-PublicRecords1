import doxie, data_services;

layout_slim:=RECORD
 string10 	prim_range;
 string28 	prim_name;
 string5  	zip;
 UNSIGNED8 RecPtr {virtual(fileposition)};
 
END;

layout_slim tSlim(File_base_facility L):= TRANSFORM
SELf := L;
END;


df := dedup(sort(PROJECT(File_base_facility(prim_range <> '' or prim_name <> '' or zip <> ''),tSlim(LEFT)),record),record);

export Key_prep_address := 
 index(df,{prim_range,prim_name,zip,recptr},
         data_services.data_location.prefix() + 'thor_200::key::ERO::'+ doxie.Version_SuperKey+'::Facility_address' );