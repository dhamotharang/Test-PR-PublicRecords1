import ut;

export File_FL_Hernando := 
	dataset('~thor_data400::in::crim_court::fl_hernando_ff',
	Crim.Layout_FL_Hernando,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	
