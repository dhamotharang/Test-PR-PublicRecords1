//don't bother to distribute by temp_id -- the nature of the beast is such
// that whatever it is distributed by, temp_id is always local (because temp_id
// depends on the other fields)

export mac_dedup_uid_did(infile, did_field, outfile) := macro
	outfile := dedup(sort(infile, temp_id, did_field, -%did_score%, local), temp_id, did_field, local);
endmacro;