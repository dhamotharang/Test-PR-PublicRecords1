import data_services;

export Key_PullSSN := index(doxie.File_pullSSN, 
                           {ssn}, 
													 {ssn},
													 data_services.data_location.prefix() + 'thor_data400::key::pullSSN_' + doxie.Version_SuperKey);