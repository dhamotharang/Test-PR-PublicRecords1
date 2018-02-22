import doxie, header, data_services;

df := header.fn_ApartmentBuildings(true);

export Key_FCRA_EN_AptBuildings := index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                 Data_Services.Data_location.person_header + 'thor_data400::key::fcra::en_hdr_apt_bldgs_' + doxie.Version_SuperKey);
