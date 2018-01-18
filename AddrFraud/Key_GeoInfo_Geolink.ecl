import doxie, ut, data_services;

i := File_GeoBlock_Info();

export Key_GeoInfo_Geolink := index( i, {string12 geolink := i.geolink}, {i}, data_services.data_location.prefix() + 'thor_data400::key::addrfraud::geoblk_info_geolink_'+ doxie.Version_SuperKey );