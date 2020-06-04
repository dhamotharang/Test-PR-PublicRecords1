import Email_Data;

export Layout_Override_Email_Data := record
	//exclude new CCPA fields
	Email_Data.Layout_Email.Keys - [global_sid, record_sid];
	STRING20 flag_file_id;
end;