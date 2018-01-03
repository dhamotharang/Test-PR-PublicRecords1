import doxie, data_services;

export Key_Did_Rid := index(doxie.build_file_base_did_rid,
                            {rid},
                            {did,stable},
                            data_services.data_location.prefix() + 'thor_data400::key::rid_did_'+ version_superkey);