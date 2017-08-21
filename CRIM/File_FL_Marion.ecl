import ut;

export File_FL_Marion := 
	dataset('~thor_data400::in::crim_court::FL_Marion',
	Crim.Layout_FL_Marion,csv(heading(1),terminator('\n'), separator('|'), quote('')));
	