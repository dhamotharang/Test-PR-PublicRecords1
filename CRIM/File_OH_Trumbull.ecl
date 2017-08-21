import ut;

export File_OH_Trumbull := 
	dataset('~thor_data400::in::crim_court::oh_Trumbull_ff',
	Crim.Layout_OH_Trumbull,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
	//