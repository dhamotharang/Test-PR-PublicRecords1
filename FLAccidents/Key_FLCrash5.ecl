import doxie, data_services;

flc5 := basefile_flcrash5;

export key_flcrash5 := index(flc5,
                             {unsigned6 l_acc_nbr := (integer)accident_nbr},
                             {flc5},
                             data_services.data_location.prefix() + 'thor_data400::key::flcrash5_' + doxie.Version_SuperKey);