import ut, doxie,data_services;

export Key_FI_Module := module


shared fi := FI_Table;

export Key_FI_Geo11 := index(fi(geo11<>''),{geo11},{geo11, geo11_index, geo11_prop_count, geo11_fc_count},data_services.data_location.prefix() + 'thor_data400::key::foreclosure::'+doxie.Version_SuperKey+'::index_geo11');

export Key_FI_Geo12 := index(fi(geo12<>''),{geo12},{geo12, geo12_index, geo12_prop_count, geo12_fc_count},data_services.data_location.prefix() + 'thor_data400::key::foreclosure::'+doxie.Version_SuperKey+'::index_geo12');

export Key_FI_fips := index(fi(fips<>''),{fips},{fips, fips_index, fips_prop_count, fips_fc_count},data_services.data_location.prefix() + 'thor_data400::key::foreclosure::'+doxie.Version_SuperKey+'::index_fips');

end;

