import doxie,ut, data_services;

flc4 := flc4_Keybuild;

export key_flcrash4 := index(flc4,
                             {unsigned6 l_acc_nbr := (integer)accident_nbr},
                             {flc4},
                             data_services.data_location.prefix() + 'thor_data400::key::flcrash4_'+doxie.Version_SuperKey);