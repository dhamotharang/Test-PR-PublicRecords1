import data_services;

df := dataset('~thor_data400::base::faa_aircraft_info_building',layout_aircraft_info,flat);

export key_prep_aircraft_info := index(df,
                                       {code := df.aircraft_mfr_model_code},
                                       {df},
                                       data_services.data_location.prefix() + 'thor_data400::key::faa_aircraft_info' + thorlib.wuid());