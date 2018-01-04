import doxie, courtSearch, data_services;

base := courtSearch.File_base_courtsearch;

keys_base := base(st <> '' and Jurisdiction <> '' AND vendor = 'ACCURINT');

export key_st := index(keys_base,
                       {st,Jurisdiction},
                       {keys_base},
                       data_services.data_location.prefix() + 'thor_data400::key::court_search::'+doxie.Version_SuperKey+'::st');																												