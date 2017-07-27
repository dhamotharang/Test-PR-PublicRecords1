import BIPV2;

export Layout_Base := 
record
	BIPV2.IDlayouts.l_xlink_ids;
	unsigned6 bdid 				:= 0;
	string8 	date_first_seen 		:= '';
	string8 	date_last_seen 		:= '';
	unsigned4 process_date_first_seen	:= 0;
	unsigned4 process_date_last_seen	:= 0;
	string1 	record_type 			:= '';
end;