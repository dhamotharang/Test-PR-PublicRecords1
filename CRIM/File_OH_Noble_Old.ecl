import ut;

export File_OH_Noble_Old := 
	dataset('~thor_data400::in::crim_court::oh_noble_old',
	Crim.Layout_OH_Noble_Old,csv(heading(1),terminator('\n'), separator('|'), quote('')));