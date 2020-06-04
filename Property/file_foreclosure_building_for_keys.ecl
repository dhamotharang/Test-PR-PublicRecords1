import ut;

export file_foreclosure_building_for_keys := property.File_Foreclosure_Base_for_Keys(trim(deed_category) IN ['U','F','T','Q','G']): persist('~thor_data400::persist::file_foreclosure_building_for_keys');
