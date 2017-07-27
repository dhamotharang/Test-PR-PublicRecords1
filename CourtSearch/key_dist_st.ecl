import ut,doxie, courtSearch;

base := courtSearch.File_district_courtsearch;

keys_base := base(st <> '' and fips_county <> '');

export key_dist_st := index(keys_base,{st,fips_county},{keys_base},
                  '~thor_data400::key::court_searchDistrict::'+doxie.Version_SuperKey+'::st');																												