import ut;

export File_GA_Cobb := 
	dataset('~thor_data400::in::crim_court::ga_cobb_ff',
	Crim.Layout_GA_Cobb,csv(heading(1),terminator('\n'), separator('|'), quote('')));
