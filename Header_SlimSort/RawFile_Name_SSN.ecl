import ut,data_services, header_slimsort;
boolean var1 := true : stored('production');
export RawFile_Name_SSN := 
dataset(data_services.Data_location.person_slimsorts +'base::HSS_Name_SSN' + if(var1,'_prod',''),
header_slimsort.layout_name_ssn,flat,opt);