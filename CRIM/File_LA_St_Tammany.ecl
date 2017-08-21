import ut;

export File_LA_St_Tammany := 
	dataset('~thor_data400::in::crim_court::la_st_tammany_ff',
	Crim.Layout_LA_St_Tammany,csv(heading(1),terminator('\n'), separator('|'), quote('')));