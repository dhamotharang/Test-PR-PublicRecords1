import ut;
//Updated file attribute to directly point to file attribute used rather than a "middle man" attribute
export File_NOD_Building := property.File_Foreclosure_Base_v2(trim(deed_category)IN ['N','R','L']): persist('~thor_data400::persist::file_nod_building');