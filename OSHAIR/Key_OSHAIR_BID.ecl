import doxie_files, doxie,ut;

f_oshair := OSHAIR.file_out_inspection_cleaned_bid;

slim_oshair := record
	f_oshair.BDID;
	f_oshair.Activity_Number;
end;

tbl_bdid := table (f_oshair (BDID<>0), slim_oshair);

export Key_OSHAIR_BID := index(tbl_BDID
                              ,{bdid}
							  ,{Activity_Number}
							  ,'~thor_data400::key::oshair::Bid_'+doxie.Version_SuperKey);


