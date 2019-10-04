import Risk_Indicators;

export Layout_Override_SSN_Table := record
	recordof(Risk_indicators.Key_SSN_Table_v4_filtered_fcra) - [global_sid, record_sid];
	STRING20 flag_file_id;
end;