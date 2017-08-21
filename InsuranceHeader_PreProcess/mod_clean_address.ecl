export mod_clean_address(string prim_name, string sec_range) := module

// 5)	If sec_range is >3 chars and prim_name is trailing or leading part of sec range then strip from sec-range
// 7)	If prim-range is repeated in sec-range leading part then remove from sec range

	// Get prim name and sec range details.
	primName_len := length(prim_name);
	secRange_len := length(sec_range);
	
	primName_location := if(secRange_len > primName_len, stringlib.stringFind(sec_range, prim_name, 1), 0);
	
	// Update sec range
	export secRange := map(primname_location = 1 => sec_range[(primName_len+1)..secRange_len],
									primname_location > 1 and primname_location < secRange_len => sec_range[1..(primName_location - 1)],
									prim_Name[1..6] = sec_range[1..6] => sec_range[7..secRange_len],
									prim_Name[1..5] = sec_range[1..5] => sec_range[6..secRange_len],
									prim_Name[1..4] = sec_range[1..4] => sec_range[5..secRange_len],
									prim_Name[1..3] = sec_range[1..3] => sec_range[4..secRange_len],
									prim_Name[1..2] = sec_range[1..2] => sec_range[3..secRange_len],
									sec_range); 
end;