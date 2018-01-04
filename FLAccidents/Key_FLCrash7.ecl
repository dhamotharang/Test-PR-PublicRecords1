import doxie, data_services;

flc7 := basefile_flcrash7;

export key_flcrash7 := index(flc7,
                             {unsigned6 l_acc_nbr := (integer)accident_nbr},
                             {flc7},
                             data_services.data_location.prefix() + 'thor_data400::key::flcrash7_' + doxie.Version_SuperKey);