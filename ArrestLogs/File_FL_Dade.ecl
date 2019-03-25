IMPORT ArrestLogs,data_services;

EXPORT File_FL_Dade  := dataset(data_services.foreign_prod+'thor_data400::in::arrlog::fl::miami_dade',ArrestLogs.layout_FL_Dade.raw_in_new,CSV(SEPARATOR(','),heading(1),TERMINATOR('\n'), quote('"')));

