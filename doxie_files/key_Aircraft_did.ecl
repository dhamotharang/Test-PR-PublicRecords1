import faa,doxie, data_services;

df := faa.searchFile((integer)did_out > 0);

export key_aircraft_did := index(df,
                                 {unsigned6 did := (integer)df.did_out},
                                 {n_number, aircraft_id},
                                 data_services.data_location.prefix() + 'thor_data400::key::aircraft_reg_did_' + doxie.Version_SuperKey);