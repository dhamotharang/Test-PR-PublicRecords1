boolean var1 := true : stored('production');
export RawFile_Name_Phone := 
dataset('~thor_data400::base::HSS_Name_Phone' + if(var1,'_prod',''),
header_slimsort.layout_name_phone, flat,opt);