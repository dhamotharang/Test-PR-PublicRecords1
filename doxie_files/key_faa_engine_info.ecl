import doxie,faa, data_services;

df := dataset('~thor_data400::base::faa_engine_info_BUILT',faa.layout_engine_info,flat);

export key_faa_engine_info := index(df,
                                    {string5 code := df.engine_mfr_model_code},
                                    {df},
                                    data_services.data_location.prefix() + 'thor_data400::key::faa_engine_info_' + doxie.Version_SuperKey);
