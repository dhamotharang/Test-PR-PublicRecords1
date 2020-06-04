export Layout_History_Legacy := record
	layout_bscurrent_raw;
	unsigned6 did;
	unsigned6 hhid;
	unsigned6	bdid;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string1 current_record_flag;  
	string8 deletion_date;
	unsigned2 disc_cnt6 := 0;
	unsigned2 disc_cnt12 := 0;
	unsigned2 disc_cnt18 := 0;
	//CCPA-22 CCPA new fields
	UNSIGNED4 global_sid := 0;
	UNSIGNED8 record_sid := 0;
end;