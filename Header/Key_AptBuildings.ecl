import doxie;

df := header.ApartmentBuildings;

export Key_AptBuildings := index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, '~thor_data400::key::hdr_apt_bldgs_' + doxie.Version_SuperKey);
