import header, doxie;
export layout_records := record
	header.Layout_Header - [global_sid, record_sid];
	boolean includedByHHID := false;
	typeof(doxie.Key_Header.county_name) county_name := '';
end;