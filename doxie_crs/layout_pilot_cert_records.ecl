IMPORT FFD;
export layout_pilot_cert_records := record
	string7 uid;
	string8 date_first_seen;
	string8 date_last_seen;
	string1 current_flag;
	string1 letter;
	string7 unique_id;
	string2 rec_type;
	string1 cer_type;
	string20	cer_type_mapped;
	string1 cer_level;
	string45	cer_level_mapped;
	string8 cer_exp_date;
	string99 ratings;
	string79 filler;
	string2 lfcr;
	FFD.Layouts.CommonRawRecordElements;
end;