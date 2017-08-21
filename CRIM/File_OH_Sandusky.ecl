import ut;

export File_OH_Sandusky := 
	dataset('~thor_data400::in::crim_court::oh_Sandusky_ff',
	Crim.Layout_OH_Sandusky,csv(heading(1),terminator('\n'), separator('|'), quote('')));