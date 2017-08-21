export Layout_Base := 
record
	unsigned6	bdid						:= 0;
	unsigned4	date_first_seen				:= 0;
	unsigned4	date_last_seen				:= 0;
	unsigned4	dt_vendor_first_reported	:= 0;
	unsigned4	dt_vendor_last_reported		:= 0;
	unsigned4	process_date_first_seen		:= 0;
	unsigned4	process_date_last_seen		:= 0;
	string1		record_type					:= '';
end;