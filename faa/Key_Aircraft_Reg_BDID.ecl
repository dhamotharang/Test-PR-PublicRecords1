import doxie, data_services;

df := faa.searchFile(bdid_out != '');

export Key_Aircraft_Reg_BDID := index(df,
                                      {unsigned6 bd := (integer)bdid_out},
                                      {n_number,aircraft_id},
                                      data_services.data_location.prefix() + 'thor_data400::key::aircraft_reg_bdid_' + doxie.Version_SuperKey);