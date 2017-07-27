import ut;

export File_PeopleWise := DATASET('~thor_data400::in::peoplewise_export_20110407', Suppress.Layout_New_Suppression , csv(terminator('\n'), separator(','), quote('\'')));