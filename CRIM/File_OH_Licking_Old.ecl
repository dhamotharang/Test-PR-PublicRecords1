import ut;

export File_OH_Licking_Old := 
	dataset('~thor_data400::in::crim_court::20061103_20061218::oh_licking.txt',
	Crim.Layout_OH_Licking_Old,csv(heading(1),terminator('\n'), separator('|'), quote('')));