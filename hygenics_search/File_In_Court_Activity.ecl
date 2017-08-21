import data_services;

export File_In_Court_Activity := dataset(data_services.foreign_prod+'thor_data400::in::court_crim_activity_all',	Layout_In_Court_Activity, flat)(vendor in ['1B']);