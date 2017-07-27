import emerges;

//contains concealed weapon,, hunter and voter.
export Layout_emerge_raw  := record
	emerges.layout_emerge_in;
	unsigned6 did;
	string10	gender_mapped := '';
	string10	race_mapped := '';
	string20	source_state_mapped := '';
	string20	home_state_name := '';
	string18  county_name := '';
end;
