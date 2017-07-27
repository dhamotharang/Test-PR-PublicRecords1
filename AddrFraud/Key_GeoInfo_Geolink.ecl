import doxie, ut;

i := File_GeoBlock_Info();

export Key_GeoInfo_Geolink := index( i, {string12 geolink := i.geolink}, {i}, '~thor_data400::key::addrfraud::geoblk_info_geolink_'+ doxie.Version_SuperKey );