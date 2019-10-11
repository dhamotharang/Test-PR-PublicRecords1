import Risk_Indicators;

export Layout_Override_SSN_Table := record
//DF-26284 exclude ccpa fields from Risk_indicators.Key_SSN_Table_v4_filtered_fcra 
	recordof(Risk_indicators.Key_SSN_Table_v4_filtered_fcra) - [global_sid, record_sid];
	UNSIGNED8 __internal_fpos__;
	STRING20 flag_file_id;
end;