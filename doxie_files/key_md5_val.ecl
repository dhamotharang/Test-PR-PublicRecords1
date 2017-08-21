import doxie_files, header_services;

Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('ssnunsigned_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

kf := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

layout_md5_base := header_services.Supplemental_Data.layout_out;

export Key_md5_val := index(kf,
			{data16 s_hval := hval}, {kf}, '~thor_data400::key::md5::qa::ssn');

 