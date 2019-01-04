import doxie, header, data_services;

df := header.fn_ApartmentBuildings(false,header.version_build);

export Key_FCRA_AptBuildings := index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                 data_services.Data_Location.prefix('Person_header') + 'thor_data400::key::fcra::hdr_apt_bldgs_' + doxie.Version_SuperKey);
