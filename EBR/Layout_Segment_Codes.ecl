export Layout_Segment_Codes := 
record
	STRING4 	code;
	STRING30 	description;
	unsigned4 input_record_length := 0;
	unsigned4 base_record_length  := 0;
	STRING100 filename_in 		:= '';
	STRING100 filename_base 		:= '';
	STRING100 keyname_bdid 		:= '';
	STRING100 keyname_file_number := '';
end;
