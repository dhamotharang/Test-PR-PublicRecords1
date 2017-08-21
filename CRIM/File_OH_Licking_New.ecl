import ut;

export File_OH_Licking_New := 
	dataset('~thor_data400::in::crim_court::oh_licking_updt',
	Crim.Layout_OH_Licking_New,csv(heading(1),terminator('\n'), separator('|'), quote('')));
