export layout_OSHAIR_optional_info_clean := record
  unsigned4 dt_first_seen						 := 0;
	unsigned4 dt_last_seen						 := 0;
	unsigned4 dt_vendor_first_reported := 0;
	unsigned4 dt_vendor_last_reported	 := 0;
	big_endian unsigned4 Activity_Number;
	OSHAIR.layout_OSHAIR_clean.OSHAIR_optional_info_rec;
end;