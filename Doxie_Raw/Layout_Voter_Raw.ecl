import Doxie_files;

export Layout_Voter_Raw := record
	doxie_files.file_voters_keybase; //emerges.layout_voters_out
	unsigned6 did := (integer)doxie_files.file_voters_keybase.did_out;  //old stuff
	string10	gender_mapped := '';
	string10	race_mapped := '';
	string20	source_state_mapped := '';
end;
