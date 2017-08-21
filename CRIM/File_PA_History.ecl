import ut;

export File_PA_History := dataset('~thor_data400::in::crim_court::pa_historical_2000_2006.txt',
	Crim.Layout_PA_History,csv(heading(1),terminator('\n'), separator('|'), quote('')));