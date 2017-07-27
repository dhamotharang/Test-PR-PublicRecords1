import header, doxie;
export layout_records := record
	header.Layout_Header;
	boolean includedByHHID := false;
	typeof(doxie.Key_Header.county_name) county_name := '';
end;