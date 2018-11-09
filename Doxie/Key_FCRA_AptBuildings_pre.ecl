import doxie, header, data_services;

export Key_FCRA_AptBuildings_pre(string filedate):= FUNCTION

df := header.fn_ApartmentBuildings(false,filedate);

return index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                 data_services.Data_Location.prefix('Person_header') + 'thor_data400::key::fcra::hdr_apt_bldgs_' + doxie.Version_SuperKey);

END;