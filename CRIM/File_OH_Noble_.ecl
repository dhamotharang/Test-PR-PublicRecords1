import ut;

export File_OH_Noble_ := 
	dataset('~thor_data400::in::crim_court::oh_noble',
	Crim.Layout_OH_Noble_,csv(heading(1),terminator('\n'), separator('|'), quote('')));