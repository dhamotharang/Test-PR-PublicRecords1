import Doxie,data_services;

hri_base_file := File_HRI_Address_Sic_FCRA((integer)zip<>0);

export Key_HRI_Address_To_Sic_FCRA :=
index (hri_base_file, 
       {z5 := zip,prim_name, suffix := addr_suffix,predir, postdir,prim_range,sec_range,dt_first_seen},
       {sic_code, company_name, city, state},
//       data_services.data_location.prefix() + 'thor_data400::key::hri_address::fcra::sic_' + doxie.Version_SuperKey);
       data_services.data_location.prefix() + 'thor_data400::key::hri_address_to_sic_fcra_' + doxie.Version_SuperKey);			 
