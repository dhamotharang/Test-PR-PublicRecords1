import corp2, ut;

EXPORT In_File := dataset(ut.foreign_prod + 'thor_data400::base::corp2::20150709e::event', Scrubs_Corp2_Build_Event_Base.layout_in_file,flat);
