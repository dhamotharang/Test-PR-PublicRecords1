import ut,doxie, courtSearch;

base := courtSearch.File_base_courtsearch;

keys_base := base(st <> '' and Jurisdiction <> '' and vendor <> '' and vendor = 'ACCURINT');

export key_jurisdiction := index(keys_base,{Jurisdiction,st,vendor},{keys_base},'~thor_data400::key::court_search::'+doxie.Version_SuperKey+'::jurisdiction');																												