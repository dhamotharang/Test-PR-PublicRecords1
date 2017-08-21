import ut;

export File_OH_Licking_Old2 := 
	dataset('~thor_data400::in::crim_court::20070116_20070625::oh_licking.txt',
	Crim.Layout_OH_Licking_Old2,csv(heading(1),terminator('\n'), separator('|'), quote('')));