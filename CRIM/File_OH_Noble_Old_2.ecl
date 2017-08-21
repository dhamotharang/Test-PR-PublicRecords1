import ut;

export File_OH_Noble_Old_2 := 
	dataset('~thor_data400::in::crim_court::oh_noble_old_2',
	Crim.Layout_OH_Noble_Old_2,csv(heading(1),terminator('\n'), separator('|'), quote('')));