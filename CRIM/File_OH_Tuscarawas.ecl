import ut;

export File_OH_Tuscarawas := 
	dataset('~thor_data400::in::crim_court::oh_Tuscarawas_ff',
	Crim.Layout_OH_Tuscarawas,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
	//