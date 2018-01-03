import doxie, data_services;

flc2v := basefile_flcrash2v;

export key_flcrash2v := index(flc2v,
                              {unsigned6 l_acc_nbr := (integer)accident_nbr},
                              {flc2v},
                              data_services.data_location.prefix() + 'thor_data400::key::flcrash2v_' + doxie.Version_SuperKey);