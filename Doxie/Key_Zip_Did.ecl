import header, data_services;

export Key_Zip_Did := index(header.File_Headers,
                            keytype_zip_did,
                            data_services.data_location.prefix() + 'thor_data400::key::zip_did_'+ version_superkey);