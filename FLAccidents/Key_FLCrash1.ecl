import doxie, data_services;

flc1 := basefile_flcrash1;

export key_flcrash1 := index(flc1,
                             {unsigned6 l_acc_nbr := (integer)accident_nbr},
                             {flc1},
                             data_services.data_location.prefix() + 'thor_data400::key::flcrash1_' + doxie.Version_SuperKey);