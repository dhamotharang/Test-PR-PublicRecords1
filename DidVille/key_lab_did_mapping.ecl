import data_services;

export key_lab_did_mapping := index(file_lab_did_mapping, 
                                    {postlab_lexid}, 
                                    {file_lab_did_mapping},
                                    data_services.data_location.prefix() + 'thor::key::lab::QA::did_mapping');