import ut;

export File_OH_Hancock_new := 
	dataset('~thor_data400::in::crim_court::oh_hancock_updt',
	Crim.Layout_OH_Hancock_New,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	