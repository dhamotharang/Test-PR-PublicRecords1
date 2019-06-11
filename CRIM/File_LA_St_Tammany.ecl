import data_services;


export File_LA_St_Tammany  := 
	dataset(data_services.foreign_prod+'thor_data400::in::crim_court::la_st_tammany_ff',
	Crim.Layout_LA_St_Tammany,csv(heading(1),terminator('\n'), separator('|'), quote('')));