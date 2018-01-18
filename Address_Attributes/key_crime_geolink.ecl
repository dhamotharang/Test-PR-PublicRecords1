Import address_attributes, doxie, data_services;

ds := Address_Attributes.file_crime_geolink;

export key_crime_geolink := index(ds,
																	{geolink},
																	{ds},data_services.data_location.prefix() + 'thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::crime::geolink');
