import ut;

export File_TN_Hamilton :=  
	dataset('~thor_data400::in::crim_court::TN_Hamilton_ff',
	Crim.Layout_TN_Hamilton,csv(heading(1),terminator('\n'), separator('|'), quote('')));