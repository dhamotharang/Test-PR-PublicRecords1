import ut,data_services;

boolean var1 := true : stored('production');
export RawFile_Name_Source := 
dataset(data_services.Data_location.person_slimsorts + 'base::hss_name_source' + if(var1,'_prod',''),
header_slimsort.layout_name_source, flat);




