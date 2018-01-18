import data_services;

df := faa.searchFile;

export key_prep_aircraft_did := index(df((integer)did_out != 0),
                                      {unsigned6 did := (integer)df.did_out},
                                      {n_number,aircraft_id},
                                      data_services.data_location.prefix() + 'thor_data400::key::aircraft_reg_did' + thorlib.wuid());