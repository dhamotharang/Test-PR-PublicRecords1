import doxie, data_services;

flc6 := basefile_flcrash6;

export key_flcrash6 := index(flc6,
                             {unsigned6 l_acc_nbr := (integer)accident_nbr},
                             {flc6},
                             data_services.data_location.prefix() + 'thor_data400::key::flcrash6_' + doxie.Version_SuperKey);