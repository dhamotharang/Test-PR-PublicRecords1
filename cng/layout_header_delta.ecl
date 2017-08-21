import header;
export layout_header_delta := module

export adds := record
	header.Layout_Header_v2;
end;

export rems := record
	unsigned8 rid;
end;

export chgs := record
	unsigned8 rid;
	string20 changed_field;
	string changed_value;
end;

export combined := record
	recordof(header.File_Headers); 
	string2 delta_flag; 
	string changed_field; 
	string changed_value; 
end;

end;