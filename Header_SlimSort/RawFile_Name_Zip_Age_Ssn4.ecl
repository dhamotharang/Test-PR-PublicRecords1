boolean var1 := true : stored('production');
import ut,data_services,header_slimsort;
export RawFile_Name_Zip_Age_Ssn4 :=

dataset(data_services.Data_location.person_slimsorts +'BASE::HSS_Name_Zip_Age_Ssn4' + if(var1,'_prod',''),
		header_slimsort.Layout_Name_Age_Zip_SSN4, flat);

//dataset('~thor_Data400::headerbuild_hss_name_zip_age_ssn4',header_slimsort.Layout_Name_Age_Zip_SSN4,flat);