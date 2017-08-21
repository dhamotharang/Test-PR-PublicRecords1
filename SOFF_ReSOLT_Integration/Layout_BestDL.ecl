export Layout_BestDL  := module

export Layout_Best_FileDL_DL_num_state := RECORD
			unsigned6 did;
			Files_used.DriversV2_layout_dl.orig_state; 
			STRING24  dl_number; 
			Files_used.DriversV2_layout_dl.dt_first_seen;
			Files_used.DriversV2_layout_dl.dt_last_seen;
			Files_used.DriversV2_layout_dl.history;
			Files_used.DriversV2_layout_dl.lic_issue_date;
			Files_used.DriversV2_layout_dl.expiration_date;
END;

export Layout_Best_Certegy_DL_num_state := RECORD
			unsigned6 did;
			Files_used.certegy_layout_base.orig_DL_State; 
			STRING24  orig_DL_Num; 
			Files_used.certegy_layout_base.date_vendor_first_reported;
			Files_used.certegy_layout_base.date_vendor_last_reported;
			Files_used.certegy_layout_base.orig_DL_Issue_Dte;
			Files_used.certegy_layout_base.orig_DL_Expire_Dte;
END;

end;