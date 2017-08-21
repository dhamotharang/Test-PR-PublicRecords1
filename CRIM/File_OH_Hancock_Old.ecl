import ut;

export File_OH_Hancock_Old := 
	dataset('~thor_data400::in::crim_court::oh_hancock_updt_archive',
	Crim.Layout_OH_Hancock_Old,csv(heading(1),terminator('\n'), separator('|'), quote('')));