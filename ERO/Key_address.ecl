import doxie,ut, Data_Services;

export Key_address := 
 index(dataset([],{string10 	prim_range, string28 	prim_name, string5  	zip, UNSIGNED8 RecPtr {virtual(fileposition)}}),
       {prim_range,prim_name,zip,recptr},
       Data_Services.Data_location.Prefix('ERO') +'thor_200::key::ERO::'+ doxie.Version_SuperKey+'::Facility_address' );

