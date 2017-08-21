import ut;

export File_CO_Denver := 
	dataset('~thor_data400::in::crim_court::co_denver_ff',
	Crim.Layout_CO_Denver,csv(heading(1),terminator('\n'), separator('|'), quote('')));