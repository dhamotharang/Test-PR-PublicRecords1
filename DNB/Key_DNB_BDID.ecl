import doxie, data_services;

df0 := dnb.File_DNB_Base(bdid != 0);

df  := dedup(project(df0, {df0.bdid,df0.duns_number}), all);

// export key_DNB_BDID := index(df,{unsigned6 bd := df.bdid},{df.duns_number},ut.foreign_prod+'thor_data400::key::dnb_Bdid_' + doxie.Version_SuperKey);
// export key_DNB_BDID := index(df,{unsigned6 bd := df.bdid},{df.duns_number},'~thor_data400::key::dnb::Bdid_' + doxie.Version_SuperKey);
export key_DNB_BDID := index(df,
                             {unsigned6 bd := df.bdid},
                             {df.duns_number},
                             data_services.data_location.prefix() + 'thor_data400::key::dnb::'+ doxie.Version_SuperKey +'::Bdid');
