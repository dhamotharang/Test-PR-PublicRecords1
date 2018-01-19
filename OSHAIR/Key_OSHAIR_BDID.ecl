import doxie,Data_Services;

f_oshair := OSHAIR.file_out_inspection_cleaned;

slim_oshair := record
	f_oshair.BDID;
	f_oshair.Activity_Number;
end;

tbl_bdid := table (f_oshair (BDID<>0), slim_oshair);

export Key_OSHAIR_BDID := index(tbl_BDID
                              ,{bdid}
							  ,{Activity_Number}
							  ,Data_Services.Data_location.Prefix()+'thor_data400::key::oshair::Bdid_'+doxie.Version_SuperKey);


