import doxie, data_services;

df := header.ApartmentBuildings;

export Key_AptBuildings := index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, data_services.data_location.prefix() + 'thor_data400::key::hdr_apt_bldgs_' + doxie.Version_SuperKey);
