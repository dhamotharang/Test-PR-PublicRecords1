import data_services;

export key_PullSSN_LE := index(doxie.File_pullSSN_LE, 
                               {ssn}, 
                               {ssn},
                               data_services.data_location.prefix() + 'thor_data400::key::pullSSN_LE_' + doxie.Version_SuperKey);					  