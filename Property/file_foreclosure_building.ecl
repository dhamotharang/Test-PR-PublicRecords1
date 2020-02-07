import ut;

export file_foreclosure_building := property.File_Foreclosure(trim(deed_category)IN ['U','F','T','Q','G']): persist('~thor_data400::persist::file_foreclosure_building');
