import doxie, ut;

df := header.ApartmentBuildings;

export Key_AptBuildings := index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                 ut.Data_Location.Person_header + 'thor_data400::key::hdr_apt_bldgs_' + doxie.Version_SuperKey);
