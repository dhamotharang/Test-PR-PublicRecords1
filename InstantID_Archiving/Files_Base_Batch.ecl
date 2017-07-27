EXPORT Files_Base_Batch := module

EXPORT Processed_Files := DATASET('~thor_data400::out::instantid_archive::batch_processed_files', {string name{maxlength(256)}}, thor, __compressed__, opt);

EXPORT key_files := DATASET('~thor_data400::base::instantid_archive::key_batch_files', InstantID_Archiving.Layout_Base, thor, __compressed__, opt);

end;