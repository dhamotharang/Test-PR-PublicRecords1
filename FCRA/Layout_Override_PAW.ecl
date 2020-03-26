import PAW;

export Layout_Override_PAW := record
	paw.layout.Employment_Out - [global_sid, record_sid]; //*** Jira# CCPA-111, Not affecting the Override key at this time, so removing the new CCPA fields from this layout.
	STRING20 flag_file_id;
end;