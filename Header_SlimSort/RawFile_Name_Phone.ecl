import ut,data_services;
boolean var1 := true : stored('production');
export RawFile_Name_Phone := 
dataset(data_services.Data_location.person_slimsorts+'base::HSS_Name_Phone' + if(var1,'_prod',''),
header_slimsort.layout_name_phone, flat,opt);