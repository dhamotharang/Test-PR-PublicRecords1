import doxie, header, data_services;

df := header.fn_ApartmentBuildings(false);

export Key_FCRA_AptBuildings := index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                 Data_Services.Data_location.person_header + 'thor_data400::key::fcra::hdr_apt_bldgs_' + doxie.Version_SuperKey);
