import Doxie_files;

export Layout_ccw_raw  := record
	doxie_files.file_ccw_keybase;
	unsigned6 did := (integer)doxie_files.file_ccw_keybase.did_out;  //old stuff
	string10	gender_mapped := '';
	string10	race_mapped := '';
	string20	source_state_mapped := '';
end;
