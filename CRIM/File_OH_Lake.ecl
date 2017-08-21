import ut;

export File_OH_Lake := 
	dataset('~thor_data400::in::crim_court::oh_lake_ff',
	Crim.Layout_OH_Lake,csv(heading(1),terminator('\n'), separator('|'), quote('')));
