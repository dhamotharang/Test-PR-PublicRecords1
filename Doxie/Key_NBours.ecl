import header, data_services;

export Key_NBours := index(header.file_nbrs,
                           {header.file_nbrs},
                           data_services.data_location.prefix() + 'thor_data400::key::nbrs_' + doxie.Version_SuperKey);