Import address_attributes, doxie, ut;

ds := Address_Attributes.file_crime_geolink;

export key_crime_geolink := index(ds,
																	{geolink},
																	{ds},'~thor_data400::key::neighborhood::'+doxie.Version_SuperKey+'::crime::geolink');
