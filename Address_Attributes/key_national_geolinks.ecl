import address_attributes, doxie, ut;

geolinks := Address_Attributes.file_blockgroup.file_Census2000_geoblks;

export key_national_geolinks := index(geolinks, {geolink} , {geolinks}, '~thor_data400::key::neighborhood::'+ doxie.Version_SuperKey+'::national_2000::geolink' );
