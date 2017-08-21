import corp2, ut;

EXPORT In_File := dataset(ut.foreign_prod + 'thor_data400::base::corp2::20150709e::stock', Scrubs_Corp2_Build_Stock_Base.layout_in_file,flat);
