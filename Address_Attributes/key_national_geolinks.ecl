import address_attributes, doxie, data_services;

geolinks := Address_Attributes.file_blockgroup.file_Census2000_geoblks;

export key_national_geolinks := index(geolinks, {geolink} , {geolinks}, data_services.data_location.prefix() + 'thor_data400::key::neighborhood::'+ doxie.Version_SuperKey+'::national_2000::geolink' );
