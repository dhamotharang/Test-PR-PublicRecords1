import PAW;

export Layout_Override_PAW := record
	PAW.layout.Employment_Out; //CCPA-1052 Add CCPA fields global_sid and record_sid to Override PAW key
	STRING20 flag_file_id;
end;