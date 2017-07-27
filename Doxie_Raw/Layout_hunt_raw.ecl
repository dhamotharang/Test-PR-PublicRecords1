import Doxie_files, codes, emerges;

export Layout_hunt_raw := record
	emerges.file_hunters_keybuild;
	unsigned6	did := (integer)emerges.file_hunters_keybuild.did_out;
	string20	home_state_name := '';
	string20	source_state_name := '';
	string10  gender_name := CODES.GENERAL.GENDER(emerges.file_hunters_keybuild.gender);
end;
