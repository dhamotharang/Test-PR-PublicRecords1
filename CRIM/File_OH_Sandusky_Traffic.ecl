import ut;

export File_OH_Sandusky_Traffic := 
	dataset('~thor_data400::in::crim_court::oh_Sandusky_traffic_ff',
	Crim.Layout_OH_Sandusky_Traffic,csv(heading(1),terminator('\n'), separator('|'), quote('')));