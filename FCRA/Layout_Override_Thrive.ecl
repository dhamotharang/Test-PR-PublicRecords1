import Thrive;

export Layout_Override_Thrive := record
	recordof(thrive.keys().did_fcra.qa) - [global_sid, record_sid];  //*** Jira# CCPA-8, Not affecting the Override key at this time, so removing the new CCPA fields from this layout.
	STRING20 flag_file_id;
end;