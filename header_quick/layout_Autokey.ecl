import header;

Layout_Excluded:= header.Layout_Header - layout_header_exclusions;

export layout_Autokey := record
	Layout_Excluded -[global_sid,record_sid];
	integer1 zero1 := 0;
	integer1 zero2 := 0;
	string1 blank := '';
end;