import faa,doxie, data_services;

df := dataset(data_services.data_location.prefix() + 'thor_data400::base::faa_aircraft_info_built',faa.layout_aircraft_info,flat);

export key_faa_aircraft_info := index(df,
                                      {string7 code := df.aircraft_mfr_model_code},
                                      {df},
                                      data_services.data_location.prefix() + 'thor_data400::key::faa_aircraft_info_' + doxie.Version_SuperKey);