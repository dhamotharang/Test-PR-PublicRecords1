import ut;

export File_OH_Hamilton := 
	dataset('~thor_data400::in::crim_court::oh_hamilton_ff',
	Crim.Layout_OH_Hamilton,csv(heading(1),terminator('\n'), separator('|'), quote('')));