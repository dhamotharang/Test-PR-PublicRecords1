import dx_Header;

df := header.ApartmentBuildings;

export data_Key_AptBuildings := PROJECT (df, dx_Header.layouts.i_aptbuildings);

//index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
//  ut.Data_Location.Person_header + 'thor_data400::key::hdr_apt_bldgs_' + doxie.Version_SuperKey);
