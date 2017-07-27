boolean var1 := true : stored('production');
import ut,data_services,header_slimsort;
export RawFile_Name_Dayob := 
dataset(data_services.Data_location.person_slimsorts + 'base::hss_name_dayob' + if(var1,'_Prod',''),
header_slimsort.layout_name_dob_dayob,flat,opt);