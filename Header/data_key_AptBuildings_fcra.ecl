IMPORT header;

//TODO: most likely this can be combined with data_key_AptBuildings
EXPORT data_key_AptBuildings_fcra (string filedate):= FUNCTION

df := header.fn_ApartmentBuildings(false,filedate);

// RETURN index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                //  data_services.Data_Location.prefix('Person_header') + 'thor_data400::key::fcra::header_0::hdr_apt_bldgs_' + doxie.Version_SuperKey);
RETURN df;

END;
