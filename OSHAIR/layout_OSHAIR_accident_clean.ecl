export layout_OSHAIR_accident_clean := record 
  unsigned4 dt_first_seen						 := 0;
	unsigned4 dt_last_seen						 := 0;
	unsigned4 dt_vendor_first_reported := 0;
	unsigned4 dt_vendor_last_reported	 := 0;
	big_endian unsigned4 Activity_Number;
	OSHAIR.layout_OSHAIR_clean.OSHAIR_accident_rec;
	//Added for Cloud Project ~ DF-28288
	unsigned8 record_sid := 0;
  unsigned4 global_sid := 0;
  unsigned4 dt_effective_first := 0;
  unsigned4 dt_effective_last := 0;
  unsigned1 delta_ind := 0; // 0 - main record, 1 - incremental  
end;