import doxie, courtSearch, data_services;

base := courtSearch.File_base_courtsearch;

keys_base := base(st <> '' and Jurisdiction <> '' and vendor <> '' and vendor = 'ACCURINT');

export key_vendor := index(keys_base,
                           {vendor,jurisdiction,st},
                           {keys_base},
                           data_services.data_location.prefix() + 'thor_data400::key::court_search::'+doxie.Version_SuperKey+'::vendor');																												