import doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_inspection_cleaned_bid;

export Key_OSHAIR_inspection_BID := index(f_oshair
																					 ,{Activity_Number}
																					 ,{f_oshair}
																					 ,'~thor_data400::key::oshair::inspection_bid_'+doxie.Version_SuperKey);
