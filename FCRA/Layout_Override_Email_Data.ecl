IMPORT Email_Data;

EXPORT Layout_Override_Email_Data := record
	//CCPA-1044 - include CCPA fields global_sid and record_sid
	Email_Data.Layout_Email.Keys;
	STRING20 flag_file_id;
END;