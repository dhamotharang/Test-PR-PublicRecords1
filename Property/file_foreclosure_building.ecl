import ut;
//Updated to directly point to file attribute used rather than multiple imbedded attributes that eventually point to this file attribute
export file_foreclosure_building := property.File_Foreclosure_Base_v2(trim(deed_category)IN ['U','F','T','Q','G']): persist('~thor_data400::persist::file_foreclosure_building');
