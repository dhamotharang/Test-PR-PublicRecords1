import ut;

export File_OH_Medina := 
	dataset('~thor_data400::in::crim_court::oh_Medina_ff',
	Crim.Layout_OH_Medina,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
	//