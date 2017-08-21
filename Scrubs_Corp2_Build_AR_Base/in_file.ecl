import corp2, ut;

EXPORT In_File := dataset(ut.foreign_prod + 'thor_data400::base::corp2::20150709e::ar', Scrubs_Corp2_Build_AR_Base.layout_in_file,flat);
